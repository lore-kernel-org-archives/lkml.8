Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAEAC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 23:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE9E2467E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 23:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ydM6de29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgCBXIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 18:08:20 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50782 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgCBXIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 18:08:20 -0500
Received: by mail-pj1-f66.google.com with SMTP id nm6so46092pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 15:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bHCVavkwu6zfqNW43fiKG14XiAueMcaZslslsOZ/218=;
        b=ydM6de292BVaEG4QIuyq3YDVMoEUXf/csuA62Efwp3SSERMdRa78DTYxPii0GhrquH
         ISL5cY5PnKvvgsRwpvwPaI7vfbfzJRRffct/nD7NxWwzR5+nM5zXinq7KnqGZ6IXRQ0a
         oc6KW7Dm8G/R+weAy54bB+Jxgl2/2PE2CimSIockQWJAFk6q7ZWhhb2y9G0cGsaZQBON
         jzosmItoJcleMLSIQDULAkmSSKVBi4F1legP3yobRaXw6QIUtUx8/QLvUzOBvdLuhxec
         JlIVk7m0qsebia9QlP3xo1u+DZYQyvO4TS9/u4XLRK2D0zuABuQfYiyrBrjveBgHGgoz
         CgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bHCVavkwu6zfqNW43fiKG14XiAueMcaZslslsOZ/218=;
        b=DPFCiC+fSzHGOENHdDOmgFrl+Ok0aofI3x1DkhVEFxOr4aWXR4hzb2ACq+V/Ly9wbd
         30fyP49MEaNpjHan40ZtvMhYWTdLuDsv3QLfVUKky3URkcAWl1hK4X6DOGYXkVFbXn7n
         SWjTJUnLZivKP+W8BgFDCv8bkOJGyfW7EbXmNkciQd6/BvaEhbOMbqxvrMBcPaoupXkm
         KMQzN+DZt99CbiIDugyOf0ZJH1+dxpY7eFwGfc8lmHforgtFh/mL9wp0ug/OJXbUUuoQ
         Qp9mX4kwUZdmoXRZXFHMn7y5hIrqW81Y0xAiTgqArwaIL6w3jFyXpsrtmhbI8kxTQ6Q9
         mG2g==
X-Gm-Message-State: ANhLgQ0Dhh4HD2/KQq/nUFCTBESgFs/USiLwXE8XJCy/OajjL7sSzjDb
        ejLNsIRdLMcu1z18SexcHPgpbA==
X-Google-Smtp-Source: ADFU+vu5Fn9LjuEv0zkVceFz7t9zzw21FhNfEeY+oO2Z6PSUfUEvK0xhiSdQzKkCOH96zHvBaDxllg==
X-Received: by 2002:a17:902:b7ca:: with SMTP id v10mr1336548plz.308.1583190497213;
        Mon, 02 Mar 2020 15:08:17 -0800 (PST)
Received: from yoga (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id t11sm256202pjo.21.2020.03.02.15.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 15:08:16 -0800 (PST)
Date:   Mon, 2 Mar 2020 15:08:14 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Clement Leger <cleger@kalray.eu>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, Jonathan Corbet <corbet@lwn.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-remoteproc@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Loic PALLARDY <loic.pallardy@st.com>, s-anna <s-anna@ti.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v5 3/8] remoteproc: Use u64 type for boot_addr
Message-ID: <20200302230814.GC262924@yoga>
References: <20200210162209.23149-1-cleger@kalray.eu>
 <20200302093902.27849-1-cleger@kalray.eu>
 <20200302093902.27849-4-cleger@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302093902.27849-4-cleger@kalray.eu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02 Mar 01:38 PST 2020, Clement Leger wrote:

> elf64 entry is defined as a u64. Since boot_addr is used to store the
> elf entry point, change boot_addr type to u64 to support both elf32
> and elf64. In the same time, fix users that were using this variable.
> 
> Signed-off-by: Clement Leger <cleger@kalray.eu>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/remoteproc/remoteproc_elf_loader.c | 2 +-
>  drivers/remoteproc/remoteproc_internal.h   | 2 +-
>  drivers/remoteproc/st_remoteproc.c         | 2 +-
>  include/linux/remoteproc.h                 | 4 ++--
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
> index 606aae166eba..c2a9783cfb9a 100644
> --- a/drivers/remoteproc/remoteproc_elf_loader.c
> +++ b/drivers/remoteproc/remoteproc_elf_loader.c
> @@ -102,7 +102,7 @@ EXPORT_SYMBOL(rproc_elf_sanity_check);
>   * Note that the boot address is not a configurable property of all remote
>   * processors. Some will always boot at a specific hard-coded address.
>   */
> -u32 rproc_elf_get_boot_addr(struct rproc *rproc, const struct firmware *fw)
> +u64 rproc_elf_get_boot_addr(struct rproc *rproc, const struct firmware *fw)
>  {
>  	struct elf32_hdr *ehdr  = (struct elf32_hdr *)fw->data;
>  
> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> index 58580210575c..0deae5f237b8 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -55,7 +55,7 @@ phys_addr_t rproc_va_to_pa(void *cpu_addr);
>  int rproc_trigger_recovery(struct rproc *rproc);
>  
>  int rproc_elf_sanity_check(struct rproc *rproc, const struct firmware *fw);
> -u32 rproc_elf_get_boot_addr(struct rproc *rproc, const struct firmware *fw);
> +u64 rproc_elf_get_boot_addr(struct rproc *rproc, const struct firmware *fw);
>  int rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw);
>  int rproc_elf_load_rsc_table(struct rproc *rproc, const struct firmware *fw);
>  struct resource_table *rproc_elf_find_loaded_rsc_table(struct rproc *rproc,
> diff --git a/drivers/remoteproc/st_remoteproc.c b/drivers/remoteproc/st_remoteproc.c
> index ee13d23b43a9..a3268d95a50e 100644
> --- a/drivers/remoteproc/st_remoteproc.c
> +++ b/drivers/remoteproc/st_remoteproc.c
> @@ -190,7 +190,7 @@ static int st_rproc_start(struct rproc *rproc)
>  		}
>  	}
>  
> -	dev_info(&rproc->dev, "Started from 0x%x\n", rproc->bootaddr);
> +	dev_info(&rproc->dev, "Started from 0x%llx\n", rproc->bootaddr);
>  
>  	return 0;
>  
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index bee559330204..1683d6c386a6 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -382,7 +382,7 @@ struct rproc_ops {
>  				struct rproc *rproc, const struct firmware *fw);
>  	int (*load)(struct rproc *rproc, const struct firmware *fw);
>  	int (*sanity_check)(struct rproc *rproc, const struct firmware *fw);
> -	u32 (*get_boot_addr)(struct rproc *rproc, const struct firmware *fw);
> +	u64 (*get_boot_addr)(struct rproc *rproc, const struct firmware *fw);
>  };
>  
>  /**
> @@ -498,7 +498,7 @@ struct rproc {
>  	int num_traces;
>  	struct list_head carveouts;
>  	struct list_head mappings;
> -	u32 bootaddr;
> +	u64 bootaddr;
>  	struct list_head rvdevs;
>  	struct list_head subdevs;
>  	struct idr notifyids;
> -- 
> 2.15.0.276.g89ea799
> 
