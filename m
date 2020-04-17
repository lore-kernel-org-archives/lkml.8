Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13563C38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEBBE206B9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LMjWtbcz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbgDQTin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730336AbgDQTim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:38:42 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39733C061A0F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 12:38:42 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o185so1048693pgo.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 12:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L/KLniOfteFVMXQ71u7R1TBbbpgcRHaxIa69jNoCo+g=;
        b=LMjWtbczjWK9xz25YpLOrWyVCpnAir+NmVNcSR8nqO5CYI6biyNRsEnQ6aVoBTtP91
         /F5RQL0ngIcntGeQPodiL6reiF4Qp10P7ocREihvTve9R5doGnLaKhLAsMAkZ4vVHvCC
         GQYmPzJK2tPnXdFllItkdEo+5Ky8Owl4qWbDJvYkJ6z1Wd+N4m4Y68cJSEL8RXFbdDtJ
         ONNtyeDMX9inYr6A4BNsWHXIfh8XNLV+eEHOYIqdliD2gePqY7RrdJ/FpDYK2qONyozn
         NDcLSjMlien/eI3eXb2aAiGv+0nadT/GsSm9Pb+vo2KYmZHuuMcR3sQQQfpGDbP/jFbs
         GRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L/KLniOfteFVMXQ71u7R1TBbbpgcRHaxIa69jNoCo+g=;
        b=FCEEFxxC3FF5CjxBEEqysdvdAzuKg3WVcPZdiPswRBjT6K7+fppA8U93dmNk+3+ra2
         Aawr83YCSrAFa2ziDB9uJ8mZBjIM5BCYIWMC3OWErM7tvfTdzilSmqSQLVfzhWqgJnqb
         5u/SDjW6LqITc83Cs9ULCcXVX/SeCHUQKxTRmB/e3fUIgI3noSJjRgUWT0kW7iNRJZuO
         fibGFhDdrMSBARZcW+CK4kXfF72tbITC5QgL1nmyR9BI4owt36EwqyomnNnPI93uk6gL
         zhu/Gw0Z17K4TTlyWEK7NF3TSy2ueIdKgXgU1qC6DGv8o0ErBEM5+MY1Yf8WVMrpQ2iS
         MXZg==
X-Gm-Message-State: AGi0PuaPuCHF3MJhdjbXGCG1NXL3cl1nYdXe2Hu98VVHLKUCvOJi7IFb
        BsTDAKEy6eUo3tOD6r2nbNfjzg==
X-Google-Smtp-Source: APiQypJOFDs95tWlt5OLSyjmZ2cFoGxRUCQJ62lFfPsxeWdusfOdDR/sAiJSgmQw7WF3uCywu/mX8Q==
X-Received: by 2002:a63:40f:: with SMTP id 15mr4627154pge.57.1587152321367;
        Fri, 17 Apr 2020 12:38:41 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c1sm2723546pfc.94.2020.04.17.12.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 12:38:39 -0700 (PDT)
Date:   Fri, 17 Apr 2020 13:38:37 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Clement Leger <cleger@kalray.eu>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] remoteproc: add rproc_coredump_set_elf_info
Message-ID: <20200417193837.GB6797@xps15>
References: <20200410102433.2672-1-cleger@kalray.eu>
 <20200410102433.2672-2-cleger@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410102433.2672-2-cleger@kalray.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 12:24:32PM +0200, Clement Leger wrote:
> This function allows drivers to correctly setup the coredump output
> elf information.
> 
> Signed-off-by: Clement Leger <cleger@kalray.eu>
> ---
>  drivers/remoteproc/remoteproc_core.c       | 32 ++++++++++++++++++++--
>  drivers/remoteproc/remoteproc_elf_loader.c |  3 --
>  include/linux/remoteproc.h                 |  2 ++
>  3 files changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index a9ac1d01e09b..382443bab583 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1562,6 +1562,28 @@ int rproc_coredump_add_custom_segment(struct rproc *rproc,
>  }
>  EXPORT_SYMBOL(rproc_coredump_add_custom_segment);
>  
> +/**
> + * rproc_coredump_set_elf_info() - set coredump elf information
> + * @rproc:	handle of a remote processor
> + * @class:	elf class for coredump elf file
> + * @size:	elf machine for coredump elf file
> + *
> + * Set elf information which will be used for coredump elf file.
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +int rproc_coredump_set_elf_info(struct rproc *rproc, u8 class, u16 machine)
> +{
> +	if (class != ELFCLASS64 && class != ELFCLASS32)
> +		return -EINVAL;
> +
> +	rproc->elf_class = class;
> +	rproc->elf_machine = machine;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(rproc_coredump_set_elf_info);
> +
>  /**
>   * rproc_coredump() - perform coredump
>   * @rproc:	rproc handle
> @@ -1584,6 +1606,11 @@ static void rproc_coredump(struct rproc *rproc)
>  	if (list_empty(&rproc->dump_segments))
>  		return;
>  
> +	if (class == ELFCLASSNONE) {
> +		dev_err(&rproc->dev, "Elf class is not set\n");
> +		return;
> +	}
> +
>  	data_size = elf_size_of_hdr(class);
>  	list_for_each_entry(segment, &rproc->dump_segments, node) {
>  		data_size += elf_size_of_phdr(class) + segment->size;
> @@ -1602,7 +1629,7 @@ static void rproc_coredump(struct rproc *rproc)
>  	elf_hdr_init_ident(ehdr, class);
>  
>  	elf_hdr_set_e_type(class, ehdr, ET_CORE);
> -	elf_hdr_set_e_machine(class, ehdr, EM_NONE);
> +	elf_hdr_set_e_machine(class, ehdr, rproc->elf_machine);
>  	elf_hdr_set_e_version(class, ehdr, EV_CURRENT);
>  	elf_hdr_set_e_entry(class, ehdr, rproc->bootaddr);
>  	elf_hdr_set_e_phoff(class, ehdr, elf_size_of_hdr(class));
> @@ -2043,7 +2070,8 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>  	rproc->name = name;
>  	rproc->priv = &rproc[1];
>  	rproc->auto_boot = true;
> -	rproc->elf_class = ELFCLASS32;
> +	rproc->elf_class = ELFCLASSNONE;
> +	rproc->elf_machine = EM_NONE;
>  
>  	device_initialize(&rproc->dev);
>  	rproc->dev.parent = dev;
> diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
> index 16e2c496fd45..4869fb7d8fe4 100644
> --- a/drivers/remoteproc/remoteproc_elf_loader.c
> +++ b/drivers/remoteproc/remoteproc_elf_loader.c
> @@ -248,9 +248,6 @@ int rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
>  			memset(ptr + filesz, 0, memsz - filesz);
>  	}
>  
> -	if (ret == 0)
> -		rproc->elf_class = class;
> -
>  	return ret;
>  }
>  EXPORT_SYMBOL(rproc_elf_load_segments);
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index ed127b2d35ca..d67eb5a40476 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -515,6 +515,7 @@ struct rproc {
>  	struct list_head dump_segments;
>  	int nb_vdev;
>  	u8 elf_class;
> +	u16 elf_machine;
>  };

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  
>  /**
> @@ -619,6 +620,7 @@ int rproc_coredump_add_custom_segment(struct rproc *rproc,
>  						     struct rproc_dump_segment *segment,
>  						     void *dest),
>  				      void *priv);
> +int rproc_coredump_set_elf_info(struct rproc *rproc, u8 class, u16 machine);
>  
>  static inline struct rproc_vdev *vdev_to_rvdev(struct virtio_device *vdev)
>  {
> -- 
> 2.17.1
> 
