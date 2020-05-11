Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51206C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3627C20736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbgEKSRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 14:17:12 -0400
Received: from mga03.intel.com ([134.134.136.65]:53698 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729678AbgEKSRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 14:17:11 -0400
IronPort-SDR: 9L4snjHpDpN67h0KhUNqufKvZo8GCBVf31NpAAW0RvOXEEXiVHoKkswqHNKCXFnQ9Fs20DuFfM
 +USTCitSbs/A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 11:17:11 -0700
IronPort-SDR: 38zTCriKg5Yq9VmhZtWaXyixpm+lKVTUX16kvRsUQbv+OUmVYmqVh259nwt+H8KjuKpm2g0qk4
 x3XR6ktGUvag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,380,1583222400"; 
   d="scan'208";a="306251281"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.1.152]) ([10.213.1.152])
  by FMSMGA003.fm.intel.com with ESMTP; 11 May 2020 11:17:09 -0700
Subject: Re: [PATCH RESEND] ASoC: Intel: Skylake: Replace zero-length array
 with flexible-array
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20200511174647.GA17318@embeddedor>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <d973f704-539e-eac8-122f-52f6b5d0e123@intel.com>
Date:   Mon, 11 May 2020 20:17:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200511174647.GA17318@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-11 7:46 PM, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>          int stuff;
>          struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in
> which the sizeof operator is being incorrectly/erroneously applied to
> zero-length arrays and the result is zero. Such instances may be hiding
> some bugs. So, this work (flexible-array member conversions) will also
> help to get completely rid of those sorts of issues.
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   sound/soc/intel/atom/sst-atom-controls.h |    2 +-
>   sound/soc/intel/skylake/skl-i2s.h        |    2 +-
>   sound/soc/intel/skylake/skl-topology.h   |    4 ++--
>   sound/soc/intel/skylake/skl.h            |    2 +-
>   4 files changed, 5 insertions(+), 5 deletions(-)
> 

Acked-by: Cezary Rojewski <cezary.rojewski@intel.com>

Thanks,
Czarek
