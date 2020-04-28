Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457ABC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E4862082E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgD1RPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 13:15:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:28237 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgD1RPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 13:15:16 -0400
IronPort-SDR: 40N+oO8S/YCSoqSqxK64CAbBFwlUP7iyhjkGoHR4Sg8rYxQYJE67TqogmUphQ9soxPpMS50R0m
 /D4zwpDVMmXw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 10:15:16 -0700
IronPort-SDR: RVaP+BjdZg3L05vlNa65kzF0WA73qlGPEQMRAmYsJueS6dW2ZpdyQSyYGX8x7AGPOHKFog39bo
 L2FRWnLSy7GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; 
   d="scan'208";a="249222663"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga008.fm.intel.com with ESMTP; 28 Apr 2020 10:15:16 -0700
Message-ID: <cdc503a023d38b688a254b08d40fe58016d739eb.camel@intel.com>
Subject: Re: [PATCH v3 01/10] x86/fpu/xstate: Rename
 validate_xstate_header() to validate_user_xstate_header()
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@suse.de>
Date:   Tue, 28 Apr 2020 10:15:18 -0700
In-Reply-To: <20200428171107.GC11272@zn.tnic>
References: <20200328164307.17497-1-yu-cheng.yu@intel.com>
         <20200328164307.17497-2-yu-cheng.yu@intel.com>
         <20200428171107.GC11272@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-04-28 at 19:11 +0200, Borislav Petkov wrote:
> On Sat, Mar 28, 2020 at 09:42:58AM -0700, Yu-cheng Yu wrote:
> > From: Fenghua Yu <fenghua.yu@intel.com>
> > 
> > The function validate_xstate_header() validates an xstate header coming
> > from userspace (PTRACE or sigreturn).  To make it clear, rename it to
> > validate_user_xstate_header().
> 
> For the next time: patch version history like this here:
> 
> > v3:
> > - Change validate_xstate_header_from_user() to validate_user_xstate_header().
> 
> ... goes ...
> 
> > Suggested-by: Dave Hansen <dave.hansen@intel.com>
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> > Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > Reviewed-by: Borislav Petkov <bp@suse.de>
> > ---
> 
> <--- ... here so that, when someone applies the patch, the version
> history doesn't become part of the commit message.
> 

Yes, I will do that the next time.  Thanks!

