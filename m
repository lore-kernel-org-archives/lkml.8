Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02AAC3E8C6
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 040DB22D02
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgHFJ5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 05:57:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:36335 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729309AbgHFJ4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 05:56:33 -0400
IronPort-SDR: TFmqPj/5L3oQCQKn0GONb70CPzx1JOA/uw20qMR7ZJ51mXSvTuq1QNRAZcVNRnF1Gfz6tAFRav
 kWiRpscLg47Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="132314944"
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="132314944"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 02:56:22 -0700
IronPort-SDR: KRJJOdTHLW4LCOOg0j60Q7V6RSiN7LHzSWm0xALuAxSdjXHQAY7kms6SdqznoyrqbgpuTKjvAk
 kWyW3H0TmAYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="437486241"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 06 Aug 2020 02:56:18 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k3cdG-006ow6-7n; Thu, 06 Aug 2020 12:56:18 +0300
Date:   Thu, 6 Aug 2020 12:56:18 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] auxdisplay: charlcd: Reuse hex_to_bin() instead of
 custom code
Message-ID: <20200806095618.GA1625681@smile.fi.intel.com>
References: <20200518193617.74548-1-andriy.shevchenko@linux.intel.com>
 <CANiq72nJgGJJoUoJMxD5LTa-A7Rn1UPnr16nf8DbY9HOy7ZKEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72nJgGJJoUoJMxD5LTa-A7Rn1UPnr16nf8DbY9HOy7ZKEA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 11:48:53PM +0200, Miguel Ojeda wrote:
> Hi Andy,
> 
> On Mon, May 18, 2020 at 9:36 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > hex_to_bin() may be used to convert hexdecimal digit to its binary
> > representation.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> 
> Looks fine to me and the logic is simpler for the `esc` increase too.
> Thanks for the cleanup! Were you able to test it, by any chance? I
> will queue it up for -rc1.

May I ask which version did you have in mind? Now it's merge window for
v5.9-rc1 and patch is still not there...

>  (Sidenote: it would be nice if `git patch` allowed for a full-to-full
> comparison for patches like this since the unified format is harder to
> read; I couldn't find the option from a quick look...).
> 
> Cheers,
> Miguel

-- 
With Best Regards,
Andy Shevchenko


