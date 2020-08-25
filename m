Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9618C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E4F120782
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgHYOyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:54:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:63609 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbgHYOyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 10:54:18 -0400
IronPort-SDR: 2uPOK6Kz59X4r9HTeukA7BPxfxbNyFuPpntVTH6vhi1CtDwNKasbfmNB3opr5dxW3R+1nDTM0A
 wuw3XvOkVdZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="217674981"
X-IronPort-AV: E=Sophos;i="5.76,352,1592895600"; 
   d="scan'208";a="217674981"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 07:54:18 -0700
IronPort-SDR: YnM7/S/YO9a/PbNP++wcwbHz6gAwYJqx5NfvOqlphkRklJMfYZWFdW5gOvaH+nnUupHZsVduVR
 GrPCXA9pV1KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,352,1592895600"; 
   d="scan'208";a="328886554"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 25 Aug 2020 07:54:16 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kAa8L-00BLTi-Dm; Tue, 25 Aug 2020 17:41:09 +0300
Date:   Tue, 25 Aug 2020 17:41:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2] kobject: Restore old behaviour of kobject_del(NULL)
Message-ID: <20200825144109.GN1891694@smile.fi.intel.com>
References: <20200803082706.65347-1-andriy.shevchenko@linux.intel.com>
 <20200803094659.GB635660@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803094659.GB635660@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 11:46:59AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Aug 03, 2020 at 11:27:06AM +0300, Andy Shevchenko wrote:
> > The commit 079ad2fb4bf9 ("kobject: Avoid premature parent object freeing in
> > kobject_cleanup()") inadvertently dropped a possibility to call kobject_del()
> > with NULL pointer. Restore the old behaviour.
> > 
> > Fixes: 079ad2fb4bf9 ("kobject: Avoid premature parent object freeing in kobject_cleanup()")
> > Reported-by: Qu Wenruo <quwenruo.btrfs@gmx.com>
> > Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > v2: replaced ?: with plain conditional (Greg)
> >  lib/kobject.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> Thanks, much better, will queue up after -rc1 is out.

Shouldn't be this taken care of?

-- 
With Best Regards,
Andy Shevchenko


