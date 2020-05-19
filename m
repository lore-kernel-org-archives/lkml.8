Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C53BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E334F207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbgESQI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 12:08:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:10688 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729055AbgESQI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 12:08:57 -0400
IronPort-SDR: ffiIhO6rtS8dacovgxJpm7/KnpMucyg8tkxEpRyFMIRkmOjLFSPK3QQ+C5va1j+k/Ci8Yg9L19
 Rrj5jeZc8A/w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 09:08:47 -0700
IronPort-SDR: y7eDh5PvvqyaF5gMVZbrF648sMaseofKEtk+zX50MtQQp11DtIx3fOzRwL2e2gp2tFQueVvF7J
 6xkk73sQttEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,410,1583222400"; 
   d="scan'208";a="289007917"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 19 May 2020 09:08:44 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1jb4nO-007g84-Ux; Tue, 19 May 2020 19:08:46 +0300
Date:   Tue, 19 May 2020 19:08:46 +0300
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
Message-ID: <20200519160846.GL1634618@smile.fi.intel.com>
References: <cover.1589844108.git.reinette.chatre@intel.com>
 <a953992d99a1930703cba1362a3005d517c4cb33.1589844108.git.reinette.chatre@intel.com>
 <CAHp75Vc_VA-2UNJh7epe+oQEiU3WBedomLbAVTD_L4_ocvt8Dw@mail.gmail.com>
 <4a9603b8-32fb-024a-e2f5-14e95b4e3763@intel.com>
 <20200519160710.GK1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519160710.GK1634618@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 07:07:10PM +0300, Andy Shevchenko wrote:
> On Tue, May 19, 2020 at 08:50:22AM -0700, Reinette Chatre wrote:
> > On 5/19/2020 1:28 AM, Andy Shevchenko wrote:
> > > On Tue, May 19, 2020 at 2:50 AM Reinette Chatre
> > > <reinette.chatre@intel.com> wrote:

...

> > > Can't we unify latter with a former like ...
> 
> > This would have been ideal if done from the start but currently "0" is
> > returned if the current mode is pseudo-locked and user attempts to
> > change the mode to pseudo-locked. Thus, to maintain the current user
> > interface the check if user wants to set pseudo-locked mode is moved
> > after the check if new mode is same as existing mode and thus not
> > unified because that will result in an error returned always when user
> > requests pseudo-locked mode.
> 
> Ah, I see now.
> 
> But we can then drop the check from sysfs_match_string() returned value, like
> 
> 	user_m = sysfs_match_string();

Yes, here some additional checks like

	if (user_m == mode)
		goto out;

> 	if (...) {
> 		...
> 	} else { // w/o even checking for the PSEUDO_LOCKED
> 		...
> 		goto out;
> 	}
> 
> Can we?

-- 
With Best Regards,
Andy Shevchenko


