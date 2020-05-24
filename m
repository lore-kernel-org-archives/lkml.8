Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99224C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 12:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7343620823
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 12:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590325052;
	bh=dwTSrAbUCgX4YBr4LsehmVjh9zpHVu7tTZE2teD/vfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c0gXOI+JogdpWa+B7ARjpAPpGURA6miID4TRQwRiAyaTKt1cCEFWKQNrYsMHons0J
	 tUpZBniVPhkncFHE6+yOQDGDfmK3cAB5Tz4KNn00ydFgKDqXNehvQX7O9A50k49jz4
	 QgGdq3APsxdjk7WD7i4Ri+9z46SjpjnA4pKEb7Xo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387600AbgEXM5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 08:57:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgEXM5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 08:57:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 070EC20776;
        Sun, 24 May 2020 12:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590325050;
        bh=dwTSrAbUCgX4YBr4LsehmVjh9zpHVu7tTZE2teD/vfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SehOJISYgXvTWashVdp+g/gGC6yjGrTffmL2naP33hTAZS/eyn/JhmfTChbWMyw83
         +iEv3HE0Abfml1RysVIfnWbYKDjm+i5PwLwhwLPDqwmj8cOVZl8VyrnROHnFRkQ6vy
         QOq9GIMcbo8bQ/nom5yz/xaB28fYgcU13sidY8gA=
Date:   Sun, 24 May 2020 14:57:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] kobject: Make sure the parent does not get released
 before its children
Message-ID: <20200524125727.GA2430@kroah.com>
References: <20200513151840.36400-1-heikki.krogerus@linux.intel.com>
 <20200523153643.GA226270@kroah.com>
 <7a5e4740-8099-ef70-776f-0d92ce84ab3d@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a5e4740-8099-ef70-776f-0d92ce84ab3d@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 08:44:06AM -0700, Randy Dunlap wrote:
> On 5/23/20 8:36 AM, Greg Kroah-Hartman wrote:
> > On Wed, May 13, 2020 at 06:18:40PM +0300, Heikki Krogerus wrote:
> >> In the function kobject_cleanup(), kobject_del(kobj) is
> >> called before the kobj->release(). That makes it possible to
> >> release the parent of the kobject before the kobject itself.
> >>
> >> To fix that, adding function __kboject_del() that does
> >> everything that kobject_del() does except release the parent
> >> reference. kobject_cleanup() then calls __kobject_del()
> >> instead of kobject_del(), and separately decrements the
> >> reference count of the parent kobject after kobj->release()
> >> has been called.
> >>
> >> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> >> Reported-by: kernel test robot <rong.a.chen@intel.com>
> >> Fixes: 7589238a8cf3 ("Revert "software node: Simplify software_node_release() function"")
> >> Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
> >> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> >> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> >> Tested-by: Brendan Higgins <brendanhiggins@google.com>
> >> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> >> ---
> >>  lib/kobject.c | 30 ++++++++++++++++++++----------
> >>  1 file changed, 20 insertions(+), 10 deletions(-)
> > 
> > Stepping back, now that it turns out this patch causes more problems
> > than it fixes, how is everyone reproducing the original crash here?
> 
> Just load lib/test_printf.ko and boom!

Thanks, that helps.

Ok, in messing around with the kobject core more, originally we thought
this was an issue of the kobject uevent happening for the parent pointer
(when the parent was invalid).  so, moving things around some more, and
now I'm crashing in software_node_release() when we are trying to access
swnode->parent->child_ids as parent is invalid there.

So I feel like this is a swnode bug, or a use of swnode in a way it
shouldn't be that the testing framework is exposing somehow.

Let me dig deeper...

greg k-h
