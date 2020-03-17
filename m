Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96698C1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 18:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC9720735
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 18:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zAOgX/YW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgCQSFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 14:05:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34789 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgCQSFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 14:05:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id t3so12158045pgn.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 11:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZpBI1BoqE+w5cxYT1XTfEOOzyE5/sXCLbJVrVnxa0bU=;
        b=zAOgX/YW1JHp0BQ3g1QZOFrbUaFOok3bRVGL2Az4K2WsvGKX2Mnj9QAeyD/z9z8B4d
         2Sfd0+6dpprpH3SayPdbEBXyo2AXQ+X3Y39ejRGCTC9QtYFNzJaYWypBzaKpv5s+tPRa
         FCE/pJ7aqyhonBT+3b/WWWVuaYt9nN5/Oz4K4gAWl75u6VN2GfbzE+SLqOqMPonAw91Z
         ckCTOicVgUBRcWje7Ck4n9OGHOixomSAE0d+gsFTveVYDdwIwnmQWAcapwn9pbKGxawL
         xyutL+Qo+FV3++LGd1GwKNeJBwudPCISmNcTz9oVO0Eujt79A0YAODgCi8cJdwtOIspk
         V8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZpBI1BoqE+w5cxYT1XTfEOOzyE5/sXCLbJVrVnxa0bU=;
        b=YcN90RMkf3LphzjnHCi+xddx8iwtS4B086wUQQaqVR/0NamlucQmA7ClDyXZKSHMgf
         Kq6jD6gUGZRU37vx7+Wsmd1Xn8B5gJyU3PWsPUZ8QKWFZxY2ljalBjXixXwhRMfPZJs1
         MFyiuJVoxELaWxp+DBeDEHMKySYz/rkcKDo36lzQvhk097gyB9DIKuHrd6Vu+uLSxaGC
         oS6DhHgRyaplSJHrfBpozOACMG+x/9162xWgWJkI0BQeINolytmsuV3Y49h8fmQ1b0PW
         Get8e8ggue8ukUSy89iUxjTJo+x40bM6t4H4dSrmPXe/ThS3iSBpu+gYdcJTX725d3Ue
         5DFw==
X-Gm-Message-State: ANhLgQ0SS2DGroQmBpG+2jMyQneItz7PyrRn2RHT5pF98YaNfQNNo5RJ
        iZrU3hkmltsrjpIq81NejTii9w==
X-Google-Smtp-Source: ADFU+vts51DA0nU7yp+NqHXSRCSYWq8QTGf4keWNP2Ft8q88HfpgSeuOgtMPOWXDeaGAsy9WYUq6jA==
X-Received: by 2002:a63:3142:: with SMTP id x63mr458054pgx.138.1584468332497;
        Tue, 17 Mar 2020 11:05:32 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id 136sm3335134pgh.26.2020.03.17.11.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 11:05:31 -0700 (PDT)
Date:   Tue, 17 Mar 2020 12:05:30 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Tero Kristo <t-kristo@ti.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] remoteproc: Fix and restore the parenting hierarchy
 for vdev
Message-ID: <20200317180530.GA1801@xps15>
References: <20200305224108.21351-1-s-anna@ti.com>
 <20200305224108.21351-3-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305224108.21351-3-s-anna@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suman,

On Thu, Mar 05, 2020 at 04:41:08PM -0600, Suman Anna wrote:
> The commit 086d08725d34 ("remoteproc: create vdev subdevice with specific
> dma memory pool") has introduced a new vdev subdevice for each vdev
> declared in the firmware resource table and made it as the parent for the
> created virtio rpmsg devices instead of the previous remoteproc device.
> This changed the overall parenting hierarchy for the rpmsg devices, which
> were children of virtio devices, and does not allow the corresponding
> rpmsg drivers to retrieve the parent rproc device through the
> rproc_get_by_child() API.
> 
> Fix this by restoring the remoteproc device as the parent. The new vdev
> subdevice can continue to inherit the DMA attributes from the remoteproc's
> parent device (actual platform device).
> 
> Fixes: 086d08725d34 ("remoteproc: create vdev subdevice with specific dma memory pool")
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 097f33e4f1f3..ba18f32bd0c4 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -510,7 +510,7 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
>  
>  	/* Initialise vdev subdevice */
>  	snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
> -	rvdev->dev.parent = rproc->dev.parent;
> +	rvdev->dev.parent = &rproc->dev;

I can see how it would not be possible to retrieve the parent rproc device since
rvdev->dev.parent was set to be platform device...

I wonder how the original change didn't blow up sysmon_probe() and potentially
other out-of-tree users of rproc_get_by_child().  It would be nice to have
someone from the QCOM team test your patch.

>  	rvdev->dev.dma_pfn_offset = rproc->dev.parent->dma_pfn_offset;
>  	rvdev->dev.release = rproc_rvdev_release;
>  	dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev->dev.parent), name);

Be mindful there might be fallouts from applying this patch since it does change
the location of the vdev under /sys/device/platform/ .

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> -- 
> 2.23.0
> 
