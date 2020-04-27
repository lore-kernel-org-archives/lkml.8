Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4408C54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B82502078C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="K3QM6nur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgD0Tyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:54:33 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58946 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgD0Tyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:54:32 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03RJsDMO007386;
        Mon, 27 Apr 2020 14:54:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588017253;
        bh=dwly5aN+uAHdquqvnejrhvQPF5JgoVydz5AkBpeUbCI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=K3QM6nurhmKSBibvGWCs0BBJ8FGXQGmtn2TASc56KnQTAqVf0IG5ni6P6f52VSRzM
         gZZIdiWq1bmYtxQG0MkSjgY5f4x8b777rx/bpX4Y4Tg+RnYbla+LWoCd4aizR16aQO
         fBugqJ99DU6sWe/if/S3ljKYaNfit6OM5ZRjsVB4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03RJsDBm005665;
        Mon, 27 Apr 2020 14:54:13 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 27
 Apr 2020 14:54:12 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 27 Apr 2020 14:54:12 -0500
Received: from [10.250.48.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03RJsBYI080761;
        Mon, 27 Apr 2020 14:54:11 -0500
Subject: Re: [PATCH 4/4] remoteproc/k3-dsp: Add support for C71x DSPs
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Clement Leger <cleger@kalray.eu>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200325204701.16862-1-s-anna@ti.com>
 <20200325204701.16862-5-s-anna@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <59ac4e15-205a-7205-d013-da91b7426688@ti.com>
Date:   Mon, 27 Apr 2020 14:54:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200325204701.16862-5-s-anna@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/20 3:47 PM, Suman Anna wrote:
> The Texas Instrument's K3 J721E SoCs have a newer next-generation
> C71x DSP Subsystem in the MAIN voltage domain in addition to the
> previous generation C66x DSP subsystems. The C71x DSP subsystem is
> based on the TMS320C71x DSP CorePac module. The C71x CPU is a true
> 64-bit machine including 64-bit memory addressing and single-cycle
> 64-bit base arithmetic operations and supports vector signal processing
> providing a significant lift in DSP processing power over C66x DSPs.
> J721E SoCs use a C711 (a one-core 512-bit vector width CPU core) DSP
> that is cache coherent with the A72 Arm cores.
> 
> Each subsystem has one or more Fixed/Floating-Point DSP CPUs, with 32 KB
> of L1P Cache, 48 KB of L1D SRAM that can be configured and partitioned as
> either RAM and/or Cache, and 512 KB of L2 SRAM configurable as either RAM
> and/or Cache. The CorePac also includes a Matrix Multiplication Accelerator
> (MMA), a Stream Engine (SE) and a C71x Memory Management Unit (CMMU), an
> Interrupt Controller (INTC) and a Powerdown Management Unit (PMU) modules.
> 
> Update the existing K3 DSP remoteproc driver to add support for this C71x
> DSP subsystem. The firmware loading support is provided by using the newly
> added 64-bit ELF loader support, and is limited to images using only
> external DDR memory at the moment. The L1D and L2 SRAMs are used as scratch
> memory when using as RAMs, and cannot be used for loadable segments. The
> CMMU is also not supported to begin with, and the driver is designed to
> treat the MMU as if it is in bypass mode.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>   drivers/remoteproc/ti_k3_dsp_remoteproc.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> index 7b712ef74611..48d26f7d5f48 100644
> --- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> @@ -649,6 +649,9 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
>   
>   	rproc->has_iommu = false;
>   	rproc->recovery_disabled = true;
> +	/* C71x is a 64-bit processor, so plug in generic .sanity_check ops */
> +	rproc->ops->sanity_check = rproc_elf_sanity_check;
> +

Will drop this on the next version, this is no longer needed after 
commit e29ff72b7794 ("remoteproc: remove rproc_elf32_sanity_check") 
currently on rproc-next.

regards
Suman


>   	kproc = rproc->priv;
>   	kproc->rproc = rproc;
>   	kproc->dev = dev;
> @@ -789,6 +792,12 @@ static const struct k3_dsp_mem_data c66_mems[] = {
>   	{ .name = "l1dram", .dev_addr = 0xf00000 },
>   };
>   
> +/* C71x cores only have a L1P Cache, there are no L1P SRAMs */
> +static const struct k3_dsp_mem_data c71_mems[] = {
> +	{ .name = "l2sram", .dev_addr = 0x800000 },
> +	{ .name = "l1dram", .dev_addr = 0xe00000 },
> +};
> +
>   static const struct k3_dsp_dev_data c66_data = {
>   	.mems = c66_mems,
>   	.num_mems = ARRAY_SIZE(c66_mems),
> @@ -796,8 +805,16 @@ static const struct k3_dsp_dev_data c66_data = {
>   	.uses_lreset = true,
>   };
>   
> +static const struct k3_dsp_dev_data c71_data = {
> +	.mems = c71_mems,
> +	.num_mems = ARRAY_SIZE(c71_mems),
> +	.boot_align_addr = SZ_2M,
> +	.uses_lreset = false,
> +};
> +
>   static const struct of_device_id k3_dsp_of_match[] = {
>   	{ .compatible = "ti,j721e-c66-dsp", .data = &c66_data, },
> +	{ .compatible = "ti,j721e-c71-dsp", .data = &c71_data, },
>   	{ /* sentinel */ },
>   };
>   MODULE_DEVICE_TABLE(of, k3_dsp_of_match);
> 

