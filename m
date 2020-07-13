Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2749C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6F422068F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgGMJyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 05:54:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:55716 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbgGMJyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 05:54:47 -0400
IronPort-SDR: FQtNr3/iWGHaZVWsMygCAbJfGYs9r9idZuEsAQcTLcR3G7DNni2TqZJmStVAa+mFLpdfRQzDLP
 VxxjNj9jMF9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="147701281"
X-IronPort-AV: E=Sophos;i="5.75,347,1589266800"; 
   d="scan'208";a="147701281"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 02:54:46 -0700
IronPort-SDR: HNOCqn0wxEYs3QwZ2tL2Fj+aEnrK+2DGU0ucdJ4fIB95RYsMmoq1VpbSh1kkAnOg0xlJQewLbs
 CUQePnkXnLbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,347,1589266800"; 
   d="scan'208";a="281347156"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by orsmga003.jf.intel.com with ESMTP; 13 Jul 2020 02:54:43 -0700
Date:   Mon, 13 Jul 2020 17:54:43 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Rong Chen <rong.a.chen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>
Subject: Re: [LKP] Re: [bpf] af7ec13833: will-it-scale.per_process_ops -2.5%
 regression
Message-ID: <20200713095443.GD85993@shbuild999.sh.intel.com>
References: <20200628085032.GT5535@shao2-debian>
 <cb4cab43-8f13-dd2a-5c58-855d93c6e790@fb.com>
 <1d98d1f0-fe84-6df7-f5bd-f4cb2cdb7f45@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d98d1f0-fe84-6df7-f5bd-f4cb2cdb7f45@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 01:54:39PM +0800, Rong Chen wrote:
> > This commit should not cause regression.
> >
> > Probably the variation of performance is caused by test environment 
> > which you may want to investigate further to reduce false alarming.
> > Thanks!
> 
> Hi Yonghong,
> 
> It's a function align issue, the commit effects the align of functions 
> which causes a little regression,
> we force to set -falign-functions=32 in KBUILD_CFLAGS and the regression 
> is gone:
> 
> diff --git a/Makefile b/Makefile
> index 70def4907036c..9746afa4edc21 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -476,7 +476,7 @@ LINUXINCLUDE牋? := \
>  牋牋牋牋牋牋牋? $(USERINCLUDE)
> 
>  燢BUILD_AFLAGS牋 := -D__ASSEMBLY__ -fno-PIE
> -KBUILD_CFLAGS牋 := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \
> +KBUILD_CFLAGS牋 := -Wall -Wundef -falign-functions=32 
> -Werror=strict-prototypes -Wno-trigraphs \
>  牋牋牋牋牋牋牋牋牋 -fno-strict-aliasing -fno-common -fshort-wchar 
> -fno-PIE \
>  牋牋牋牋牋牋牋牋牋 -Werror=implicit-function-declaration 
> -Werror=implicit-int \
>  牋牋牋牋牋牋牋牋牋 -Wno-format-security \
 
For these strange performance change cases caused by a seemingly
unrelated commit, we have used this function alignment patch to
explain some of them to be caused by re-arrange of text code
alignment [1][2]

So one bold thought is can we merge this option into mainline under
a kernel config option in 'kernel hacking' category, with which both
developers and 0day can filter out some cases to be related with text
alignment change more easily?

[1] [LKP][mm] fd4d9c7d0c: stress-ng.switch.ops_per_sec -30.5% regression
    https://lore.kernel.org/lkml/20200330011254.GA14393@feng-iot/ 
[2] [mm/hugetlb] c77c0a8ac4: will-it-scale.per_process_ops 15.9% improvement
    https://lore.kernel.org/lkml/20200114085637.GA29297@shao2-debian/
    (this patch is not used in the discussion, but we later used
    this patch to confirm it's a text alignment case)

Thanks,
Feng

