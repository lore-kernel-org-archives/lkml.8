Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB8BC11D1B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 19:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2809E222C4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 19:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z70rwuoF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgBTTbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 14:31:08 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34236 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbgBTTbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 14:31:08 -0500
Received: by mail-pj1-f65.google.com with SMTP id f2so1428838pjq.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 11:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sXrvFoJPqvg02BUxIE3UTho5sV5nybX8qyPHpbQqr8E=;
        b=Z70rwuoFsDifWDdSPas8zJnF+Mg+i8+o1G2DC8mif0hkptJNC5ARTCELec1tul0u6Y
         yW3yPrYySlq+1gxFpLFMrXTbm/A3s0PUqIIgeJz2ykBzrTW8epYftwgCqTttoU8OK9rU
         hSdVAXqZQYqWTG83XN557bG6e1C0aHluhJeeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sXrvFoJPqvg02BUxIE3UTho5sV5nybX8qyPHpbQqr8E=;
        b=dtCaS32QMuP4X9KOak36oBoIPHaNwJbamJkFI5eiRHEyBYwxAxIMjcPdbz+H7XZkSe
         os2TvrIo5amSr5da6Lln5I+bzSKXg2A/nkbQTDMo+ZuW14GYYxVid/RgXp1KKP2VdoPx
         1gdeLfyZtPzxKo3KQ3Eb3uA0nCRiUcWtvMef25gVqXpUnUO2oJybG8+SxXyuq9iG3gpW
         vRVGke1xgDBof9k/ZgA1m0M1TTCgaRXXAONvi+RBQz+KSkiZcHObmzSmdtTBlz9moUxG
         Wh1oegmB4TiQ1aFSATYIS0Vm1PratE4i1CFnruKiMkoM05UlpYYQgt3yDXXjQbpnkDr0
         xyjQ==
X-Gm-Message-State: APjAAAU5MyjK67MBq7MZ/bEOtwtMZlzm1Dg1jpmPwAaMMZMIhG86xsis
        QNsWq8FZWwzc12mP1lsLMgcpQQ==
X-Google-Smtp-Source: APXvYqz9mp7EYWo84cTExZVyCFz4HlzngV4TM7788p/mvz2FPEMPzJOeDtaA6kvPL6z9ON/ddq4yjw==
X-Received: by 2002:a17:90a:ac0e:: with SMTP id o14mr5557795pjq.11.1582227066988;
        Thu, 20 Feb 2020 11:31:06 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id 199sm376209pfu.71.2020.02.20.11.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 11:31:06 -0800 (PST)
Date:   Thu, 20 Feb 2020 11:31:05 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     swboyd@chromium.org, evgreen@chromium.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org
Subject: Re: [PATCH v5 1/7] drivers: qcom: rpmh: fix macro to accept NULL
 argument
Message-ID: <20200220193105.GB24720@google.com>
References: <1582108810-21263-1-git-send-email-mkshah@codeaurora.org>
 <1582108810-21263-2-git-send-email-mkshah@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1582108810-21263-2-git-send-email-mkshah@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maulik,

this patch and '[v5,2/7] drivers: qcom: rpmh: remove rpmh_flush
export' already landed in the QCOM tree (in the branch 'drivers-for-5.7'):

d5e205079c34a drivers: qcom: rpmh: remove rpmh_flush export
aff9cc0847a58 drivers: qcom: rpmh: fix macro to accept NULL argument

Please rebase your working tree and stop sending these.

Thanks

Matthias

On Wed, Feb 19, 2020 at 04:10:04PM +0530, Maulik Shah wrote:
> Device argument matches with dev variable declared in RPMH message.
> Compiler reports error when the argument is NULL since the argument
> matches the name of the property. Rename dev argument to device to
> fix this.
> 
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/soc/qcom/rpmh.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> index 035091f..3a4579d 100644
> --- a/drivers/soc/qcom/rpmh.c
> +++ b/drivers/soc/qcom/rpmh.c
> @@ -23,7 +23,7 @@
>  
>  #define RPMH_TIMEOUT_MS			msecs_to_jiffies(10000)
>  
> -#define DEFINE_RPMH_MSG_ONSTACK(dev, s, q, name)	\
> +#define DEFINE_RPMH_MSG_ONSTACK(device, s, q, name)	\
>  	struct rpmh_request name = {			\
>  		.msg = {				\
>  			.state = s,			\
> @@ -33,7 +33,7 @@
>  		},					\
>  		.cmd = { { 0 } },			\
>  		.completion = q,			\
> -		.dev = dev,				\
> +		.dev = device,				\
>  		.needs_free = false,				\
>  	}
>  
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
