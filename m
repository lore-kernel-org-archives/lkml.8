Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F61C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C018B206D8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="btWkfvp0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgG2UuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgG2Ut7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 16:49:59 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBBCC0619D6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 13:49:58 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id z5so15086719pgb.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 13:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZCFo51SeNUkOi0joTAI0GNw0Kvqf2JKQKS+2k/u6bwE=;
        b=btWkfvp0JkQdCpC7uMqhXszwJqeXh1l5pSFL8aj+MwGVvWN4n0+PxZBiq5CjPaKB1b
         3ruNPSm8qEV8W5hLyYr0it8cgH1lIt3QvxvFMRPPSCcS1ITuBJyfTzrlGr/sNz+CgrdW
         uqZS2dCFzNCuRJmNpqgUBe8PKtVkAWi2/QYj0XNDb9uKf0SW24RtEmORwfhlqLdhtrtu
         YFh1YD9vKn9Ky3B+kwhtXYlekEYn+iWaOznXeQw0qq6Gb7u1JedGsOlUX8G7EdeK/YmK
         48E4/CPcMv64caVasW3t78Lq3ZnGm2IMu84DgPgWiw2MFDQZcjxpNM0f/F3xhBBl8RsX
         cTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZCFo51SeNUkOi0joTAI0GNw0Kvqf2JKQKS+2k/u6bwE=;
        b=kVefhJ2jdLHL6eJa95IlQloKzCALscNFNqr8iv48Fthu5s2WvUJ3JHTkSNnJ034NX4
         G0H4IP2qcfxm5Zpee12HJ6rf6eC9mu66oBg/+rsX/G1amQdAkQks2LuCR6MQ7GHF6AZa
         KUE78be1gMYCT+cSCSeWNB2A9ibuoDTWSns41jXBt/oEBiEijG+g3KcxuVGLfE4Ws/ZE
         tk+pzJhq2DaqQHnaymyKFIUw7SjBP3dJKy1q0i/6zy2rNZfZ3M/8IoACuDsfo3wVSTI8
         6y4tZABfI3P9fTITRPo3EbSPdFuS3N70htrFb7ff/1Nj73aqWAderAAVGTxGzvzaMFh/
         ZdPg==
X-Gm-Message-State: AOAM533WZzh/T4oX140HDs0fFhQ5VNqIhM7HQbHU9tRsNux0z5j8HAA/
        XLddWxRMJ3szIZCr4W/cNXmzUw==
X-Google-Smtp-Source: ABdhPJx7ckWZ845NwYLBsMDvRn/h2HR2lmuehBnFT2QcLP6PH+H6EGe1o5XMMXAGcMF9VcygBTZ9DA==
X-Received: by 2002:a65:43c1:: with SMTP id n1mr30164858pgp.67.1596055797739;
        Wed, 29 Jul 2020 13:49:57 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a26sm3025188pgm.20.2020.07.29.13.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 13:49:57 -0700 (PDT)
Date:   Wed, 29 Jul 2020 13:46:28 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/2] soc: qcom: smd-rpm: Fix kerneldoc
Message-ID: <20200729204628.GL229995@builder.lan>
References: <20200729074415.28393-1-krzk@kernel.org>
 <20200729074415.28393-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729074415.28393-2-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29 Jul 00:44 PDT 2020, Krzysztof Kozlowski wrote:

> Fix W=1 compile warnings (invalid kerneldoc):
> 
>     drivers/soc/qcom/smd-rpm.c:35: warning: Function parameter or member 'dev' not described in 'qcom_smd_rpm'
>     drivers/soc/qcom/smd-rpm.c:99: warning: Function parameter or member 'state' not described in 'qcom_rpm_smd_write'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks for spotting these, applied.

PS. This doesn't have any relationship with the Mediatek patch, the two
goes through different maintainer trees and my manual mailbox filter
almost discarded the series. So please send patches like this
individually in the future.

Thanks,
Bjorn

> ---
>  drivers/soc/qcom/smd-rpm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
> index 877b13850730..1d4eb46b417a 100644
> --- a/drivers/soc/qcom/smd-rpm.c
> +++ b/drivers/soc/qcom/smd-rpm.c
> @@ -20,6 +20,7 @@
>   * struct qcom_smd_rpm - state of the rpm device driver
>   * @rpm_channel:	reference to the smd channel
>   * @icc:		interconnect proxy device
> + * @dev:		rpm device
>   * @ack:		completion for acks
>   * @lock:		mutual exclusion around the send/complete pair
>   * @ack_status:		result of the rpm request
> @@ -86,6 +87,7 @@ struct qcom_rpm_message {
>  /**
>   * qcom_rpm_smd_write - write @buf to @type:@id
>   * @rpm:	rpm handle
> + * @state:	active/sleep state flags
>   * @type:	resource type
>   * @id:		resource identifier
>   * @buf:	the data to be written
> -- 
> 2.17.1
> 
