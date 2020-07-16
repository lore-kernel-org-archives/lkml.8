Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B119C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 18:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 316262076A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 18:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbgGPSdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 14:33:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:48476 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbgGPSdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 14:33:16 -0400
IronPort-SDR: +Hf42S45CR1VfpyVZSZ23YAgi+YPMLnpJp+Ja/TcEkRWdIQkr/sTHZYTcIp7/npi9y0YM3duZp
 T3eIWXNdYItQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="148630603"
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="148630603"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 11:33:07 -0700
IronPort-SDR: TKPL0jLmulRarJNwiLFsU8S2XJGod/eu8rC4R3h0fBHAhNUlcpet1hBrclfdf7HAOoJY7ZsfvL
 7rtok1GMWLEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="486199143"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 16 Jul 2020 11:33:05 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jw8gs-002Cwp-9C; Thu, 16 Jul 2020 21:33:06 +0300
Date:   Thu, 16 Jul 2020 21:33:06 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        sakari.ailus@linux.intel.com, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Subject: Re: kernel oops in 'typec_ucsi' due to commit 'drivers property:
 When no children in primary, try secondary'
Message-ID: <20200716183306.GU3703480@smile.fi.intel.com>
References: <7affdd923186c5ce8c7dcf7cbe7b826eaa3ac8b2.camel@redhat.com>
 <20200716154721.GO3703480@smile.fi.intel.com>
 <43148a2ebe546fde67028d99fd7365acce1311b2.camel@redhat.com>
 <20200716182120.GS3703480@smile.fi.intel.com>
 <64a1ba836139b028936e24705eab06a032d598cf.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64a1ba836139b028936e24705eab06a032d598cf.camel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 09:22:11PM +0300, Maxim Levitsky wrote:
> On Thu, 2020-07-16 at 21:21 +0300, Andy Shevchenko wrote:
> > On Thu, Jul 16, 2020 at 09:00:00PM +0300, Maxim Levitsky wrote:
> > > On Thu, 2020-07-16 at 18:47 +0300, Andy Shevchenko wrote:

...

> > > It works (no more oops)
> > 
> > Thanks for testing. I'm about to send formal patch, can you give your Tested-by tag there then?
> 
> Of course.
> 
> Tested-by: Maxim Levitsky <mlevitsk@redhat.com>

Thanks, I meant there [1] :-)

[1]: https://lore.kernel.org/lkml/20200716182747.54929-1-andriy.shevchenko@linux.intel.com/T/#u

-- 
With Best Regards,
Andy Shevchenko


