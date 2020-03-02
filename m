Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05807C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D912B2166E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgCBN5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:57:43 -0500
Received: from mga03.intel.com ([134.134.136.65]:39949 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbgCBN5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 08:57:43 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 05:57:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,507,1574150400"; 
   d="scan'208";a="351545030"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 02 Mar 2020 05:57:39 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 02 Mar 2020 15:57:38 +0200
Date:   Mon, 2 Mar 2020 15:57:38 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, davidgow@google.com,
        Heidi Fahim <heidifahim@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v1] Revert "software node: Simplify
 software_node_release() function"
Message-ID: <20200302135738.GD22243@kuha.fi.intel.com>
References: <20200228000001.240428-1-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228000001.240428-1-brendanhiggins@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 04:00:01PM -0800, Brendan Higgins wrote:
> This reverts commit 3df85a1ae51f6b256982fe9d17c2dc5bfb4cc402.
> 
> The reverted commit says "It's possible to release the node ID
> immediately when fwnode_remove_software_node() is called, no need to
> wait for software_node_release() with that." However, releasing the node
> ID before waiting for software_node_release() to be called causes the
> node ID to be released before the kobject and the underlying sysfs
> entry; this means there is a period of time where a sysfs entry exists
> that is associated with an unallocated node ID.
> 
> Once consequence of this is that there is a race condition where it is
> possible to call fwnode_create_software_node() with no parent node
> specified (NULL) and have it fail with -EEXIST because the node ID that
> was assigned is still associated with a stale sysfs entry that hasn't
> been cleaned up yet.
> 
> Although it is difficult to reproduce this race condition under normal
> conditions, it can be deterministically reproduced with the following
> minconfig on UML:
> 
> CONFIG_KUNIT_DRIVER_PE_TEST=y
> CONFIG_DEBUG_KERNEL=y
> CONFIG_DEBUG_OBJECTS=y
> CONFIG_DEBUG_OBJECTS_TIMERS=y
> CONFIG_DEBUG_KOBJECT_RELEASE=y
> CONFIG_KUNIT=y
> 
> Running the tests with this configuration causes the following failure:
> 
> <snip>
> kobject: 'node0' ((____ptrval____)): kobject_release, parent (____ptrval____) (delayed 400)
> 	ok 1 - pe_test_uints
> sysfs: cannot create duplicate filename '/kernel/software_nodes/node0'
> CPU: 0 PID: 28 Comm: kunit_try_catch Not tainted 5.6.0-rc3-next-20200227 #14
> <snip>
> kobject_add_internal failed for node0 with -EEXIST, don't try to register things with the same name in the same directory.
> kobject: 'node0' ((____ptrval____)): kobject_release, parent (____ptrval____) (delayed 100)
> 	# pe_test_uint_arrays: ASSERTION FAILED at drivers/base/test/property-entry-test.c:123
> 	Expected node is not error, but is: -17
> 	not ok 2 - pe_test_uint_arrays
> <snip>
> 
> Reported-by: Heidi Fahim <heidifahim@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/base/swnode.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 0b081dee1e95c..de8d3543e8fe3 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -608,6 +608,13 @@ static void software_node_release(struct kobject *kobj)
>  {
>  	struct swnode *swnode = kobj_to_swnode(kobj);
>  
> +	if (swnode->parent) {
> +		ida_simple_remove(&swnode->parent->child_ids, swnode->id);
> +		list_del(&swnode->entry);
> +	} else {
> +		ida_simple_remove(&swnode_root_ids, swnode->id);
> +	}
> +
>  	if (swnode->allocated) {
>  		property_entries_free(swnode->node->properties);
>  		kfree(swnode->node);
> @@ -773,13 +780,6 @@ void fwnode_remove_software_node(struct fwnode_handle *fwnode)
>  	if (!swnode)
>  		return;
>  
> -	if (swnode->parent) {
> -		ida_simple_remove(&swnode->parent->child_ids, swnode->id);
> -		list_del(&swnode->entry);
> -	} else {
> -		ida_simple_remove(&swnode_root_ids, swnode->id);
> -	}
> -
>  	kobject_put(&swnode->kobj);
>  }
>  EXPORT_SYMBOL_GPL(fwnode_remove_software_node);
> -- 
> 2.25.1.481.gfbce0eb801-goog

thanks,

-- 
heikki
