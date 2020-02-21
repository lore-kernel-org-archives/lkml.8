Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFECC35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 18:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3407C208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 18:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hCV5wWMM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbgBUSmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 13:42:42 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40824 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgBUSml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 13:42:41 -0500
Received: by mail-pg1-f194.google.com with SMTP id z7so1407176pgk.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 10:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/zFjPXs4Y0NII72nGSRDk19t/a2aSWdxIBmz8i14jj8=;
        b=hCV5wWMM4cj4NHSEYugwASyRMDbDo8/O1XzigZpry9yvw78/0/WW0Zb/+PByjS+dnS
         t39vasXj+xV1yHSE5KV+Xg0cfO2Sh4INtkPkmpucjn6/cXEqrtlimCp6n6sEJ9UD9HQK
         9+RCkL9Bk6a166KPk86lHBeTL5ZnN6W+l3Lt/VmwoKdM/Amn8yACwR6D3ArLlzj+wceT
         8RX1nmyINH2kFfdrrhn3gBMqlirmWfIpji+GYK7I3GEelOiJ/2fb6BMG+Uu/h/5WFl7z
         EMJ60wbsOd5mb5AqH/XDNafeGkYZ9BZP9EMQTkCX3JZvQDa4Yx0MXubWmu/hWJ6pIhLu
         1Vjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/zFjPXs4Y0NII72nGSRDk19t/a2aSWdxIBmz8i14jj8=;
        b=qvdfUQuVZmP/BYwIbcZZT3WeTkmSbUZ98RNcKLWVNh1DD+GIeFH3j/dBdBi1oqeC5V
         uDXwQk6NR/TKoBj8LtnwwHkKogZCvq8WgjPgdEsdC/qJnPc6Y8mxfwldbYkry6L2gQFJ
         z7LcGBH0f+6ouGoY4CSWzdrySq6hObMSBSkl3EBUzDWfAUuYli5PjhXDYQSGeyoqlLMp
         uRgGia+QtsX7YQgxoJ8f/gh46K+3ux9oqeczaEcTBGnagk3quz+jYxOGmeZJjLSwYc9g
         ZMQqgmy7p+e74KaI8Vhf7tpu+w4YOUE3D22uAb8u5Qus9w1fFaZlcsOrd3f/8jhowSyJ
         XICw==
X-Gm-Message-State: APjAAAXPVWgii0B6agVAYZawl0gEU+aUQ0Piwe81uQiW9orMSlsTKvjw
        7ra0qkmoQyH/WctWkhSnyDvZKw==
X-Google-Smtp-Source: APXvYqwFclKSbXXs14coB+cqHxC3U5IbNr0OkYond0+G3XM8i02Nr2HaYjczAmI5EBskNHRghc+wiQ==
X-Received: by 2002:a63:fe4d:: with SMTP id x13mr38950714pgj.147.1582310559562;
        Fri, 21 Feb 2020 10:42:39 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id x28sm3181371pgc.83.2020.02.21.10.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 10:42:38 -0800 (PST)
Date:   Fri, 21 Feb 2020 11:42:36 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     peng.fan@nxp.com
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] remoteproc: add support to skip firmware load when
 recovery
Message-ID: <20200221184236.GA10368@xps15>
References: <1582097265-20170-1-git-send-email-peng.fan@nxp.com>
 <1582097265-20170-4-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582097265-20170-4-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Wed, Feb 19, 2020 at 03:27:39PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Remote processor such as M4 inside i.MX8QXP is not handled by Linux
> when it is configured to run inside its own hardware partition by
> system control unit(SCU). So even remote processor crash reset, it is
> handled by SCU, not linux. To such case, firmware load should be
> ignored, So introduce skip_fw_load_recovery and platform driver
> should set it if needed.

For now I will not comment on the code - I just need clarifications on the
scenario.

In the specific case you are trying to address here, I understand that when the
M4 crashes, the SCU will recognize that and reload the MCU firmware. Does the
SCU also start the MCU or is that left to the remoteproc subsystem?

Thanks,
Mathieu

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 19 +++++++++++--------
>  include/linux/remoteproc.h           |  1 +
>  2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 876b5420a32b..ca310e3582bf 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1678,20 +1678,23 @@ int rproc_trigger_recovery(struct rproc *rproc)
>  	if (ret)
>  		goto unlock_mutex;
>  
> -	/* generate coredump */
> -	rproc_coredump(rproc);
> +	if (!rproc->skip_fw_load_recovery) {
> +		/* generate coredump */
> +		rproc_coredump(rproc);
>  
> -	/* load firmware */
> -	ret = request_firmware(&firmware_p, rproc->firmware, dev);
> -	if (ret < 0) {
> -		dev_err(dev, "request_firmware failed: %d\n", ret);
> -		goto unlock_mutex;
> +		/* load firmware */
> +		ret = request_firmware(&firmware_p, rproc->firmware, dev);
> +		if (ret < 0) {
> +			dev_err(dev, "request_firmware failed: %d\n", ret);
> +			goto unlock_mutex;
> +		}
>  	}
>  
>  	/* boot the remote processor up again */
>  	ret = rproc_start(rproc, firmware_p);
>  
> -	release_firmware(firmware_p);
> +	if (!rproc->skip_fw_load_recovery)
> +		release_firmware(firmware_p);
>  
>  unlock_mutex:
>  	mutex_unlock(&rproc->lock);
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 4fd5bedab4fa..fe6ee253b385 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -514,6 +514,7 @@ struct rproc {
>  	bool has_iommu;
>  	bool auto_boot;
>  	bool skip_fw_load;
> +	bool skip_fw_load_recovery;
>  	struct list_head dump_segments;
>  	int nb_vdev;
>  };
> -- 
> 2.16.4
> 
