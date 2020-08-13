Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B59C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 21:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5356220715
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 21:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pi5Iglis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgHMVAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 17:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgHMVAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 17:00:05 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2DBC061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 14:00:04 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y206so3427800pfb.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 14:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UoqEFQFA+F2osxU/9euekhAQaDalb1swCejrkv3klN8=;
        b=pi5IglisWWNCVXf4cCgnmoGQBiskzf1aYbQ0rxrmGz2yJGuQ/SI5lIAFLPEKT0t3uO
         TjUBXgpbbAJmuFxr+EFWIN/uOp7LcgkL7D+PgwrD3R4B+snypEOYUbirw3RiD7UeWY/9
         w86xtDvCNFUqh+sF7o2dJU7iodtUtPu0EL+cQlIpCyvEMEqYuSyZAFhpCgoYaqvwQkcO
         HEo7FnebR/FkrKD+2/vq6Q+drp+7/c6BD07wSUo5RE1O/9kBSKcLD2GYySsjzGaXspck
         TKGozWfVOFqgqzfvgR9aREUIidixDyvOOlYWPno6VNSBVkMuQ8+HxuFFrJNQ7ZQT6E8i
         WAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UoqEFQFA+F2osxU/9euekhAQaDalb1swCejrkv3klN8=;
        b=Dvglvc5jZtUwUvAmpR7yF/mV+glI5jHWAbXuxJ7eBELd/iBGqIRak4YTsioIH4rjaR
         MB9PYOrBE+OJkv1d4p+4sscVr1VSSF6IPxHxz8HhkBoNzHyiDpjDM2bUO8zNAvKzOBYu
         gCEiWyBpyp8SW07jFmEuvxbwx83U7wM/Vj7PEBCmzH8CrY4AAYxh+NbunfEu/6i/J/39
         Lu1wV2vH/gn/8RMe1lszizsjFL0vsmtyfZEVMWG0/IWmwQf4nKZHm6WBb2Wb8XXpVNjk
         VF29qn2ffFv9+z0qs2KB0S7ZKm8cbNEdXCdwSoDKlSNKVP4ypHbgzGeuunVMkoe5Ts/o
         MiCQ==
X-Gm-Message-State: AOAM532TThEaCRI5V1Ht09/2kyTBeyJcFEwzcndHE5pDE7fz/gq5sDAc
        Gbp8BcUA1MVIjKDQjio0sYH+qw==
X-Google-Smtp-Source: ABdhPJyful70oodpga5zr1qvGs774nq0cEJpOpB8JP7Fu7pSipQq6C+Yol3ZyBVODGjyvDn9q8ubgA==
X-Received: by 2002:a62:7acb:: with SMTP id v194mr5865361pfc.302.1597352403601;
        Thu, 13 Aug 2020 14:00:03 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f18sm6963800pfj.35.2020.08.13.14.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 14:00:02 -0700 (PDT)
Date:   Thu, 13 Aug 2020 15:00:00 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     gregkh@linuxfoundation.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH v2] coresight: etm4x: Add Support for HiSilicon ETM device
Message-ID: <20200813210000.GO3393195@xps15>
References: <1597323562-3706-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597323562-3706-1-git-send-email-liuqi115@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 08:59:22PM +0800, Qi Liu wrote:
> Add ETMv4 periperhal ID for HiSilicon Hip08 and Hip09 platform. Hip08
> contains ETMv4.2 device and Hip09 contains ETMv4.5 device.
> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>

I have applied your patch to my local branch - it will be published on Monday
with the release of the v5.9-rc1 kernel.

Thanks,
Mathieu

> ---
>  drivers/hwtracing/coresight/coresight-etm4x.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 6d7d216..7797a57 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -1587,6 +1587,8 @@ static const struct amba_id etm4_ids[] = {
>  	CS_AMBA_UCI_ID(0x000bb805, uci_id_etm4),/* Qualcomm Kryo 4XX Cortex-A55 */
>  	CS_AMBA_UCI_ID(0x000bb804, uci_id_etm4),/* Qualcomm Kryo 4XX Cortex-A76 */
>  	CS_AMBA_UCI_ID(0x000cc0af, uci_id_etm4),/* Marvell ThunderX2 */
> +	CS_AMBA_UCI_ID(0x000b6d01, uci_id_etm4),/* HiSilicon-Hip08 */
> +	CS_AMBA_UCI_ID(0x000b6d02, uci_id_etm4),/* HiSilicon-Hip09 */
>  	{},
>  };
> 
> --
> 2.8.1
> 
