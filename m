Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F317C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ADBE207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgESSDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:03:21 -0400
Received: from mga14.intel.com ([192.55.52.115]:23486 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726862AbgESSDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:03:21 -0400
IronPort-SDR: xlDlN05K73PKpq5zXL56/NGm+v5wZkBX3wZINE6LPh//zCiPJAuMor4IGAcH0YQjcjIp94U1+H
 slrhNPyfrLcA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 11:03:19 -0700
IronPort-SDR: dKi5+Nj2bqkZBYiOcfduRQyoPqa9cHZ4TSOKSwHs4uMNJ6APS9la/Xuq0V8bvp3z4pWyiACCB0
 lndvrjWehp3w==
X-IronPort-AV: E=Sophos;i="5.73,410,1583222400"; 
   d="scan'208";a="439708568"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.255.229.46]) ([10.255.229.46])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 11:03:15 -0700
Subject: Re: [PATCH v3 07/10] x86/resctrl: Add arch_needs_linear to explain
 AMD/Intel MBA difference
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>
References: <20200518131924.7741-1-james.morse@arm.com>
 <20200518131924.7741-8-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <ff095b21-023c-a3c6-2f6c-89c0e3d02eb3@intel.com>
Date:   Tue, 19 May 2020 11:03:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200518131924.7741-8-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 5/18/2020 6:19 AM, James Morse wrote:
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index dd51e23e346b..0b288b6fefd9 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -370,6 +370,7 @@ struct rdt_cache {
>   * struct rdt_membw - Memory bandwidth allocation related data
>   * @min_bw:		Minimum memory bandwidth percentage user can request
>   * @bw_gran:		Granularity at which the memory bandwidth is allocated
> + * @arch_needs_linear:	True if we can't configure non-linear resources
>   * @delay_linear:	True if memory B/W delay is in linear scale
>   * @mba_sc:		True if MBA software controller(mba_sc) is enabled
>   * @mb_map:		Mapping of memory B/W percentage to memory B/W delay
> @@ -378,6 +379,7 @@ struct rdt_membw {
>  	u32		min_bw;
>  	u32		bw_gran;
>  	u32		delay_linear;
> +	bool		arch_needs_linear;
>  	bool		mba_sc;
>  	u32		*mb_map;
>  };
> 

Sorry, I just noticed this while rebasing our respective changes to this
area ... could the comments be in the same order as the fields in the
struct?

Reinette
