Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2B9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 570BB206DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbgGFQCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 12:02:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:51642 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729293AbgGFQC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 12:02:29 -0400
IronPort-SDR: yP/sMIWlhMHneBzJudBDK3GWYiOcbQdcDd4Bi5TnRRKCyqkGpe46A7QiXvglvhEyD/uL/oBVev
 03hXVPml9q1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="232293668"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="232293668"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 09:02:29 -0700
IronPort-SDR: wQhXjhFShJ+pJppDzF9xsnuYuAXcXUNaYt2NI4llKRvNsapbDBGQA/AKuj6Hn+QgwPCIe0MVtT
 vhMC/+D1+I1g==
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="388232162"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 09:02:29 -0700
Date:   Mon, 6 Jul 2020 09:02:28 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, pawan.kumar.gupta@linux.intel.com,
        jpoimboe@redhat.com, peterz@infradead.org, thellstrom@vmware.com,
        mgross@linux.intel.com, kim.phillips@amd.com,
        linux-kernel@vger.kernel.org, DavidWang@zhaoxin.com,
        CooperYan@zhaoxin.com, QiyuanWang@zhaoxin.com,
        HerryYang@zhaoxin.com, CobeChen@zhaoxin.com
Subject: Re: [PATCH] x86/cpufeatures: Add new Zhaoxin CPU features
Message-ID: <20200706160228.GA4663@agluck-desk2.amr.corp.intel.com>
References: <1593429689-25131-1-git-send-email-TonyWWang-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593429689-25131-1-git-send-email-TonyWWang-oc@zhaoxin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 07:21:29PM +0800, Tony W Wang-oc wrote:
> Add new Zhaoxin CPU features for enumeration in /proc/cpuinfo:
> SM2, SM2_EN, SM3, SM4, SM3_EN, SM4_EN, PARALLAX, PARALLAX_EN,
> TM3, TM3_EN, RNG2, RNG2_EN, PHE2, PHE2_EN, RSA, RSA_EN.
> 
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 0]  SM2
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 1]  SM2_EN
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 4]  SM3 SM4
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 5]  SM3_EN SM4_EN
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 16] PARALLAX
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 17] PARALLAX_EN
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 20] TM3
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 21] TM3_EN
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 22] RNG2
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 23] RNG2_EN
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 25] PHE2
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 26] PHE2_EN
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 27] RSA
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 28] RSA_EN
> 
> SM2, SM3, SM4 are Chinese Cipher Security algorithm.
> PARALLAX is a feature that automatically adjusts processors's voltage
> as a function of temperature.
> TM3 is Zhaoxin CPU Thermal Monitor v3.
> RNG2 is Zhaoxin Random Number Generation v2.
> PHE2 is Zhaoxin Padlock Hash Engine v2.
> RSA is Zhaoxin hardware support for RSA algorithm.

Boris is on vacation, so I'll ask the question that he would ask
if he were here ... "Are there some follow-up patches that use all
of these feature bits?"

Just adding bits to /proc/cpuinfo is of limited use.

-Tony
