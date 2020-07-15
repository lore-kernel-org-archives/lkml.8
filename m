Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBEEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 22:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F6F32067D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 22:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qKj4IWU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgGOWnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 18:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGOWna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 18:43:30 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719C6C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 15:43:30 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f139so7861726wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 15:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i9o/384l66MTrvWFtV9uTq7Mo/n8FiMV36XiAVH9gm8=;
        b=qKj4IWU5oCVZwjwjqLgQVeucO94cdzzmmFUrrkFHIHmtdIAp8oxJOekjS3mlJxtc0y
         o5+0vcoOW4oVbxFh6zclHCK3QRS+fcQkyjQn4dVCS8syJbNTJKC41bPaKtOgo/sv/njt
         TWUtGTzQ+UU/rARjI/b4TM0fmohLsJbMfzZaNSqK5c5EhMEcEWaIk7dZdA8JECtvqFSK
         zsEcbQMe9dUTM3UvbyI1nQN2nlh0Dz9qscEeCkIKB5Id/tVz6tIFXz8ZWKz8fyF9cDX1
         FPUz5+HFHqllJ0uZl/5E0Sp7aY1L8BZfk8HHXtvZ5Pa8GRgP94B7v5peKZSkdWOOZzvd
         53HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i9o/384l66MTrvWFtV9uTq7Mo/n8FiMV36XiAVH9gm8=;
        b=eSr5VQmXFVqzq1G06PYtFUzYfbEHw2SYej0Uok8OOiv7TiqM9fpvhie40I6KelY1Bz
         AxiO7cV4PfxKviDYZ9VSQ5KzFmcVgi50qbL4tL9EXiaNd8+s49/U0QFo1OKGnRSfjxyP
         pRe3F98G18hX9HxbRMTudFKToODcyhKyOgRTw3UJrWMog4CZBYq/kMiAuDAVlVg/IM9J
         QOPzM5BRHpXQsHSzQjZSs/5HblJwWOFLA/Qv0uNkbXyh9xgfATDtqGsnTOmJR+bscgKr
         7WwoLbZ2H1YCwHSgMncEipjB+Q811RMZoWpd9QITOnRTlcSkNnmv5eLbYexY3cbI71iQ
         6RYg==
X-Gm-Message-State: AOAM530/+/UU3crKXoa2eVSKQoxetQ8UJNqcBtkQ7CeTOdn203pc+VjW
        Zev7QQbb0+TfNRI2Uvw5zX7f4ACH
X-Google-Smtp-Source: ABdhPJyoKd/LvymeWNh2wfywlSPPy2avV6Ze/cSKPN6uDF2nbFtZR8U0RTnkX9pEOhwnWBl1FJR2AA==
X-Received: by 2002:a05:600c:21ca:: with SMTP id x10mr1667897wmj.63.1594853008678;
        Wed, 15 Jul 2020 15:43:28 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id b18sm5676558wrs.46.2020.07.15.15.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 15:43:27 -0700 (PDT)
Subject: Re: [PATCH] firmware: arm_scmi: Pass shmem address to SMCCC call
To:     Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Peng Fan <peng.fan@nxp.com>,
        "Paul J. Murphy" <paul.j.murphy@linux.intel.com>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        linux-kernel@vger.kernel.org
References: <20200715165518.57558-1-daniele.alessandrelli@linux.intel.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <5f74221b-aec7-7715-19d1-5cbb406f1bdc@gmail.com>
Date:   Wed, 15 Jul 2020 15:43:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200715165518.57558-1-daniele.alessandrelli@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/15/2020 9:55 AM, Daniele Alessandrelli wrote:
> From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> 
> Currently, when SMC/HVC is used as transport, the base address of the
> shared memory used for communication is not passed to the SMCCC call.
> This means that such an address must be hard-coded into the bootloader.
> 
> In order to increase flexibility and allow the memory layout to be
> changed without modifying the bootloader, this patch adds the shared
> memory base address to the a1 argument of the SMCCC call.
> 
> On the Secure Monitor side, the service call implementation can
> therefore read the a1 argument in order to know the location of the
> shared memory to use. This change is backward compatible to existing
> service call implementations as long as they don't check for a1 to be
> zero.

resource_size_t being defined after phys_addr_t, its size is different
between 32-bit, 32-bit with PAE and 64-bit so it would probably make
more sense to define an physical address alignment, or maybe an address
that is in multiple of 4KBytes so you can address up to 36-bits of
physical address even on a 32-bit only system?

What discovery mechanism does the OS have that the specified address
within the SMCCC call has been accepted by the firmware given the return
value of that SMCCC call does not appear to be used or checked? Do we
just expect a timeout initializing the SCMI subsystem?

Given that the kernel must somehow reserve this memory as a shared
memory area for obvious reasons, and the trusted firmware must also
ensure it treats this memory region with specific permissions in its
translation regime, does it really make sense to give that much flexibility?

If your boot loader has FDT patching capability, maybe it can also do a
SMC call to provide the address to your trusted firmware, prior to
loading the Linux kernel, and then they both agree, prior to boot about
the shared memory address?

> 
> Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> Signed-off-by: Paul J. Murphy <paul.j.murphy@intel.com>
> ---
>  drivers/firmware/arm_scmi/smc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
> index 49bc4b0e8428..aef3a58f8266 100644
> --- a/drivers/firmware/arm_scmi/smc.c
> +++ b/drivers/firmware/arm_scmi/smc.c
> @@ -21,12 +21,14 @@
>   *
>   * @cinfo: SCMI channel info
>   * @shmem: Transmit/Receive shared memory area
> + * @shmem_paddr: Physical address of shmem
>   * @func_id: smc/hvc call function id
>   */
>  
>  struct scmi_smc {
>  	struct scmi_chan_info *cinfo;
>  	struct scmi_shared_mem __iomem *shmem;
> +	resource_size_t shmem_paddr;
>  	struct mutex shmem_lock;
>  	u32 func_id;
>  };
> @@ -73,6 +75,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>  		dev_err(dev, "failed to ioremap SCMI Tx shared memory\n");
>  		return -EADDRNOTAVAIL;
>  	}
> +	scmi_info->shmem_paddr = res.start;
>  
>  	ret = of_property_read_u32(dev->of_node, "arm,smc-id", &func_id);
>  	if (ret < 0)
> @@ -109,7 +112,8 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
>  
>  	shmem_tx_prepare(scmi_info->shmem, xfer);
>  
> -	arm_smccc_1_1_invoke(scmi_info->func_id, 0, 0, 0, 0, 0, 0, 0, &res);
> +	arm_smccc_1_1_invoke(scmi_info->func_id, scmi_info->shmem_paddr, 0, 0,
> +			     0, 0, 0, 0, &res);
>  	scmi_rx_callback(scmi_info->cinfo, shmem_read_header(scmi_info->shmem));
>  
>  	mutex_unlock(&scmi_info->shmem_lock);
> 

-- 
Florian
