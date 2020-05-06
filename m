Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94020C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7984220746
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgEFPBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:01:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:22725 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728428AbgEFPBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:01:39 -0400
IronPort-SDR: DR5nA1kYpGL7UYYUaylK6KXTWuPUtX5tROTOFSXwz2YVaNun/lsIQCJe0DFpGHYzXLzSziZMsl
 cdBGHb2NtQMQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 08:01:39 -0700
IronPort-SDR: 83FF/wLCCj8LUq67Br9wCT6CKVWsoJx5UCmlwXMm4+7QcIEMmpdPROkcJ6hPid5p+TuKIXL6VP
 1Qx1VQjNPA9Q==
X-IronPort-AV: E=Sophos;i="5.73,359,1583222400"; 
   d="scan'208";a="249790509"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 08:01:37 -0700
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 06A88636E;
        Wed,  6 May 2020 15:01:36 +0000 (UTC)
Date:   Wed, 6 May 2020 08:01:36 -0700
From:   mark gross <mgross@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] x86/cpu: Add a
 X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS() macro
Message-ID: <20200506150136.GB2961@mtg-dev.jf.intel.com>
Reply-To: mgross@linux.intel.com
References: <20200506071516.25445-1-bp@alien8.de>
 <20200506071516.25445-3-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506071516.25445-3-bp@alien8.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Mark Gross <mgross@linux.intel.com>


On Wed, May 06, 2020 at 09:15:15AM +0200, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> ... to match Intel family 6 CPUs with steppings.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/include/asm/cpu_device_id.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
> index 10426cd56dca..eb8fcede9e3b 100644
> --- a/arch/x86/include/asm/cpu_device_id.h
> +++ b/arch/x86/include/asm/cpu_device_id.h
> @@ -160,6 +160,10 @@
>  #define X86_MATCH_INTEL_FAM6_MODEL(model, data)				\
>  	X86_MATCH_VENDOR_FAM_MODEL(INTEL, 6, INTEL_FAM6_##model, data)
>  
> +#define X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(model, steppings, data)	\
> +	X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE(INTEL, 6, INTEL_FAM6_##model, \
> +						     steppings, X86_FEATURE_ANY, data)
> +
>  /*
>   * Match specific microcode revisions.
>   *
> -- 
> 2.21.0
> 
