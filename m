Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEBEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 20:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7057E20659
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 20:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iaIq54Ld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgEMU7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 16:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgEMU7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 16:59:19 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D1AC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 13:59:19 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id f23so286297pgj.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 13:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uaj9L7wTibe3Srb7QlLrRgpbwAw3iewpnn7RnSIv5I8=;
        b=iaIq54LdYnfPTNfS44OsJ+ciGZe6w3yPt6q6lA1tXrAsYK9YE3h+ZMZ2MShZcqd1WF
         0yg0sCdohed5MqX/R4az4SG9BeXS/cOarDzLr0T2pBx+eZi4H83eTchxqrAimPQJy6ol
         d38765yeX+WRXcFd/xLsQJgmRKB7W3AYs2VX4pdEbeU9qXjLysjwL8iXyCy4nBPnWQYg
         CcQdTmN5omQ+B3G91l8U0++jnVGbyGAQO2NP5YGRMVVFG7iN9GIQkVi98K0eI2OxlxMV
         56qWjpQjEPoaiZROFEsmtUdGJmda4a+mgBHaK67gMAealXCnzQpPBP34CmKM1PX57GQ4
         perg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uaj9L7wTibe3Srb7QlLrRgpbwAw3iewpnn7RnSIv5I8=;
        b=tKV8u1Yy3vw1dkXkG4zzrsk6fkET3aLbsyhjIu0Jvl4acIx+4PJlFYOlwQpabkzTwX
         SqZgH7+D7KUl4zV0F7qUFkshvOtpu3cs/0iP+p9PnyqxZ8wIHF64EiAcUKzufzsoaQZR
         kG3n+eWhFQmA3nzVdT9DcFlRvHP43aHbKxxS9JqigQnCbNEFAhYzrH+tmUhthHLO/prE
         d8ezwr3KNLdrliM7hHsbUxGCP4dlIn6+mh+XaDH85sJKDDo9IynNVJeFNuEtI/ElH4Zn
         GD5el84WXu7RSaxcm3hetO4IQAvENh9Fc7krAPQXS/76jN1lpeh6MoS8++BJMN2+5Dvl
         Sy5w==
X-Gm-Message-State: AOAM532xI4eEVa7EjwA/xUIZVnuCVSGOYEFM9fKnUFeyZFfpQrV/M45J
        50BDyW+MclqolUP1vgLM1s/Brg==
X-Google-Smtp-Source: ABdhPJxHSTEOa5EHFLJiF8h8WzUgD8o6B/nx5qEh/Al8PX7Jdx3ub10Y6XacwkN56goCHSv+A+Jt7A==
X-Received: by 2002:a62:1d48:: with SMTP id d69mr1102657pfd.102.1589403558913;
        Wed, 13 May 2020 13:59:18 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id e21sm501052pga.71.2020.05.13.13.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 13:59:18 -0700 (PDT)
Date:   Wed, 13 May 2020 14:59:15 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arun Kumar Neelakantam <aneela@codeaurora.org>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, clew@codeaurora.org,
        sricharan@codeaurora.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH V5 1/5] rpmsg: glink: Use complete_all for open states
Message-ID: <20200513205915.GA8328@xps15>
References: <1589346606-15046-1-git-send-email-aneela@codeaurora.org>
 <1589346606-15046-2-git-send-email-aneela@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589346606-15046-2-git-send-email-aneela@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arun,

On Wed, May 13, 2020 at 10:40:02AM +0530, Arun Kumar Neelakantam wrote:
> From: Chris Lew <clew@codeaurora.org>
> 
> The open_req and open_ack completion variables are the state variables
> to represet a remote channel as open. Use complete_all so there are no

s/represet/represent

> races with waiters and using completion_done.
> 
> Signed-off-by: Chris Lew <clew@codeaurora.org>
> Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
> ---
>  drivers/rpmsg/qcom_glink_native.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index 1995f5b..604f11f 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -970,7 +970,7 @@ static int qcom_glink_rx_open_ack(struct qcom_glink *glink, unsigned int lcid)
>  		return -EINVAL;
>  	}
>  
> -	complete(&channel->open_ack);
> +	complete_all(&channel->open_ack);

If you do this and as per the note in the comment section above
completion_done(), there shouldn't be a need to call completion_done() in
qcom_glink_announce_create().

Thanks,
Mathieu 

>  
>  	return 0;
>  }
> @@ -1413,7 +1413,7 @@ static int qcom_glink_rx_open(struct qcom_glink *glink, unsigned int rcid,
>  	channel->rcid = ret;
>  	spin_unlock_irqrestore(&glink->idr_lock, flags);
>  
> -	complete(&channel->open_req);
> +	complete_all(&channel->open_req);
>  
>  	if (create_device) {
>  		rpdev = kzalloc(sizeof(*rpdev), GFP_KERNEL);
> -- 
> 2.7.4
