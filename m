Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0849CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAFF2207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgESQHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 12:07:13 -0400
Received: from mga07.intel.com ([134.134.136.100]:35299 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729163AbgESQHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 12:07:12 -0400
IronPort-SDR: ZlzsSj4r6qNyZvDH82VV2Vnk5O/FJ25tW6CZ1clMmmz83R4F2g/xXYa5LyaAOdaFeroleBCBHa
 D5RBl+2bQBFg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 09:07:10 -0700
IronPort-SDR: VlKkK3daLDIlq6QVXRViMYsT7nUGhrqA9YqgwgXRQ27g2cEvwvgGbVvFKOVTaanqCukq7/qv/t
 bGmpaL47aBKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,410,1583222400"; 
   d="scan'208";a="411684759"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 19 May 2020 09:07:07 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1jb4lq-007g71-KH; Tue, 19 May 2020 19:07:10 +0300
Date:   Tue, 19 May 2020 19:07:10 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>, kuo-lang.tseng@intel.com,
        ravi.v.shankar@intel.com, Ingo Molnar <mingo@redhat.com>,
        Babu Moger <babu.moger@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 4/4] x86/resctrl: Use appropriate API for strings
 terminated by newline
Message-ID: <20200519160710.GK1634618@smile.fi.intel.com>
References: <cover.1589844108.git.reinette.chatre@intel.com>
 <a953992d99a1930703cba1362a3005d517c4cb33.1589844108.git.reinette.chatre@intel.com>
 <CAHp75Vc_VA-2UNJh7epe+oQEiU3WBedomLbAVTD_L4_ocvt8Dw@mail.gmail.com>
 <4a9603b8-32fb-024a-e2f5-14e95b4e3763@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a9603b8-32fb-024a-e2f5-14e95b4e3763@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 08:50:22AM -0700, Reinette Chatre wrote:
> On 5/19/2020 1:28 AM, Andy Shevchenko wrote:
> > On Tue, May 19, 2020 at 2:50 AM Reinette Chatre
> > <reinette.chatre@intel.com> wrote:

...

> >> +       ret = sysfs_match_string(rdt_mode_str, buf);
> >> +       if (ret < 0) {
> >> +               rdt_last_cmd_puts("Unknown or unsupported mode\n");
> >> +               ret = -EINVAL;
> >> +               goto out;
> >> +       }
> 
> From your previous email ...
> 
> >> +       ret = sysfs_match_string(rdt_mode_str, buf);
> >> +       if (ret < 0) {
> >> +               rdt_last_cmd_puts("Unknown or unsupported mode\n");
> >
> >> +               ret = -EINVAL;
> >
> > This is redundant.
> 
> I understand that shadowing an error code is generally of concern. In
> this case the error code is set to -EINVAL to ensure that it is the same
> error code that was returned to user space originally and will continue
> to be so no matter what changes may come to sysfs_match_string().

It returns -EINVAL and if that will be ever changed this driver would be one of
hundreds who suffers.

...

> > Can't we unify latter with a former like ...

> This would have been ideal if done from the start but currently "0" is
> returned if the current mode is pseudo-locked and user attempts to
> change the mode to pseudo-locked. Thus, to maintain the current user
> interface the check if user wants to set pseudo-locked mode is moved
> after the check if new mode is same as existing mode and thus not
> unified because that will result in an error returned always when user
> requests pseudo-locked mode.

Ah, I see now.

But we can then drop the check from sysfs_match_string() returned value, like

	user_m = sysfs_match_string();
	if (...) {
		...
	} else { // w/o even checking for the PSEUDO_LOCKED
		...
		goto out;
	}

Can we?

-- 
With Best Regards,
Andy Shevchenko


