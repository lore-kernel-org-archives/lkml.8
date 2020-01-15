Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210EAC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE5922522
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbgAOVtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:49:20 -0500
Received: from mga11.intel.com ([192.55.52.93]:33995 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729100AbgAOVtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 16:49:20 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 13:49:20 -0800
X-IronPort-AV: E=Sophos;i="5.70,323,1574150400"; 
   d="scan'208";a="257021421"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 13:49:19 -0800
Date:   Wed, 15 Jan 2020 13:49:18 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Neelima Krishnan <neelima.krishnan@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86/cpu: Update cached HLE state on write to
 TSX_CTRL_CPUID_CLEAR
Message-ID: <20200115214918.GA13375@agluck-desk2.amr.corp.intel.com>
References: <2529b99546294c893dfa1c89e2b3e46da3369a59.1578685425.git.pawan.kumar.gupta@linux.intel.com>
 <20200115211513.mxzembrm4hf44d6j@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115211513.mxzembrm4hf44d6j@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 03:15:13PM -0600, Josh Poimboeuf wrote:
> From the Intel TAA deep dive page [1], it says:
> 
>   "On processors that enumerate IA32_ARCH_CAPABILITIES[TSX_CTRL] (bit
>    7)=1, HLE prefix hints are always ignored."
> 
> So if the CPU has IA32_TSX_CTRL, HLE is implicitly disabled, so why
> would the HLE bit have been set in CPUID in the first place?
> 
> [1] https://software.intel.com/security-software-guidance/insights/deep-dive-intel-transactional-synchronization-extensions-intel-tsx-asynchronous-abort

IIRC some VMM folks asked to not make gratuitous to CPUID feature
enumeration because it complicates setting up pools of systems.

-Tony
