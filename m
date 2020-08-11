Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001C3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBD0120781
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aAf8vbUl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgHKGhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 02:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbgHKGhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 02:37:23 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB177C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 23:37:22 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c19so1446095wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 23:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=goH7JSZMWyIR+HDIVljDARSAieBgluozz9Jxq+R5Hyg=;
        b=aAf8vbUl+EWEbaY/2D3jfMw6IpePyjwma7LZ4Y7IB5uHpZD0WRrNqeMvJHS0eUziK7
         xHj13IzFM/CeVFgZ0igTTezoxtpBYOsgLzzd4Vh5aGu7sYbk+nPSx1P8+dcWLL9kAC3n
         QtHKScoG+HSB6DjOKgeXV3W3NbmGuQ/Quw5U2+vXKeIIhbBAFaPS2rbFOIoBhocxEaSk
         haPP9WXOwbboXdrMV/8I820lZ0XKHFtfDc9o6u92x0IEDEs9XymYUi9id3r7Aj/TcDcZ
         gkOJWP3AaMOF0PJdm1347rwOPw321OLw1LgZ9yPoLxAtBAERzvcwWku9kgPc9vaIJ1Lq
         YTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=goH7JSZMWyIR+HDIVljDARSAieBgluozz9Jxq+R5Hyg=;
        b=dcBoTffGLJhzdMuO7/tkYqQNNVzbUU9ZSZZhF3mlf59tRfCDFDDiWSISh3vQDkAwKW
         0A4F76S3smJM9KDT6ytoKN+cX8aL2+jedgSD4Fv2n9vnZfeeh6DNNGwzOi1BnU/wDPT4
         +BN74DgQyAg+PpRqtMfvN462xNOzODrKX5izCv2X2VP/gsjxo3DcIYual3hNMDVqMKmr
         e1LgW4+L1VkgM7DzSycjG/TDg49YUUJW6tvDrTOK7LDO0AIJcPj/sVtzNRO6OGWpEupW
         JfMihuCPhMmSZVoFvXjjsk85LRtBSoYv2j/jAiR0dtAxK0rPzN8QK8lhdMcemgvWut6x
         5uKQ==
X-Gm-Message-State: AOAM530ByMSMvO6jrUBlRB+BBwM2U9GXX/gdhLoqtK37ChFUWlLMwZIP
        Zo3b4spXsoRl0vVPPIoKG2EpmA==
X-Google-Smtp-Source: ABdhPJziQM61tOvsBU1Mv6uzsIeOjhClg7+w8OsOUPwy2fUKCOtj3b2Eo7HDAi0a/rrehsfuWr1lbw==
X-Received: by 2002:a1c:9a06:: with SMTP id c6mr2420473wme.23.1597127841580;
        Mon, 10 Aug 2020 23:37:21 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id i14sm28266124wrc.19.2020.08.10.23.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 23:37:21 -0700 (PDT)
Date:   Tue, 11 Aug 2020 07:37:19 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 2/3] pwm: imx27: Use dev_err_probe() to simplify error
 handling
Message-ID: <20200811063719.GE4411@dell>
References: <1597127072-26365-1-git-send-email-Anson.Huang@nxp.com>
 <1597127072-26365-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1597127072-26365-2-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Aug 2020, Anson Huang wrote:

> dev_err_probe() can reduce code size, uniform error handling and record the
> defer probe reason etc., use it to simplify the code.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> changes since V1:
> 	- remove redundant return value print.
> ---
>  drivers/pwm/pwm-imx27.c | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
