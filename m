Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66D5C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94985208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lIOc/kwk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgH1JOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 05:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbgH1JOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 05:14:40 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B514AC061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 02:14:39 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w2so273863wmi.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 02:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+hChkKN1HckAnSSwUAMdVpF1WRU/euEadm0RXnOq7TU=;
        b=lIOc/kwkevDQBYSfkwNnkHpp9DP6te0aE4qmANWjrGSn68BbykLwjRhIFtE+gtvR+A
         dRJKWPZipfm892hgm43Jzbjo/72RiZsF3OvDoghkRCSQSs3dRgsMk3xAJnKFuoMIb/Th
         9j4YnKKdQr/hkfZT/SAV1U8yyLQ36tHrf4SPvGf3cZU3t/UVi0bdHhEIAKACEIpJybkx
         DQBcHFa9dZ2lUwR+OrLiBv1U35dOsuvcIBjn+HoRsqOCeE8JoGcx94SDAfXCNVBr2F7B
         J9cLrFfMyDHaaNxS0VQ3KcphyVqK3XYXzdRLi8oHTsOWXjFX4nef4fVjnaGTurr7rxJ5
         B2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+hChkKN1HckAnSSwUAMdVpF1WRU/euEadm0RXnOq7TU=;
        b=im1dnRXrBbKKe7hGYgJcTaku0Yo0LfB+AkWjRRzAUM1zeEgv2rffKAjJJDpVRne40k
         vXpRZ+oN60GLaoug1SUKv3WnFTu6e0Tkw90jQ2HvRbkibztCC1btXOAo052v+fMewfcp
         TY5UIfwyXJ1RLtzlflmnCJdL/HxhBdeWx513QahtlsRj35kRIowzvZaRiYaRfAPDnrwZ
         ivwTSBD8e2jx2HbZ5PLfk/LqeFhgIaGMayGufhmCmgEq5qamVLb86lJtFmvaMmxNpL4V
         qC8d1gXEx2Q6tgTgBcJ3V3TdjP/TffFTeMKsf5LFGKY7HK+jQ6Uh0JFmBDiWcZQLYcyF
         /N0g==
X-Gm-Message-State: AOAM5334u7gsyZh39jGTarB1nLaVUD0jfYbGKNtfKmbVPRjynwM3QSUt
        FsAf6YhqgJLKXlAoi3kPmuNQrzLzkp4MOQ==
X-Google-Smtp-Source: ABdhPJx6IH9BCn7CwR6KY5pfFbbHFmN5psEf3AvfmdsNp48w8VWlYk0fVM5KuYJfzdVrZp6a8ukhQw==
X-Received: by 2002:a1c:cc0c:: with SMTP id h12mr627896wmb.57.1598606078432;
        Fri, 28 Aug 2020 02:14:38 -0700 (PDT)
Received: from dell ([91.110.221.141])
        by smtp.gmail.com with ESMTPSA id g16sm958502wrs.88.2020.08.28.02.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 02:14:37 -0700 (PDT)
Date:   Fri, 28 Aug 2020 10:14:36 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 1/2] dt-bindings: mfd: Add ENE KB3930 Embedded
 Controller binding
Message-ID: <20200828091436.GB1826686@dell>
References: <20200709231228.11564-1-lkundrak@v3.sk>
 <20200709231228.11564-2-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200709231228.11564-2-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jul 2020, Lubomir Rintel wrote:

> Add binding document for the ENE KB3930 Embedded Controller.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> ---
> Changes since v5:
> - s/a I2C bus/an I2C bus/
> 
> Changes since v4:
> - Collected Rob's Reviewed-by
> 
> Changes since v1:
> - Addressed binding validation failure
> ---
>  .../devicetree/bindings/mfd/ene-kb3930.yaml   | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ene-kb3930.yaml

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
