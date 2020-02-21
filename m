Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FABFC35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1629720722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jFRFDwIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgBUKlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 05:41:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40619 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbgBUKlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 05:41:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id t3so1434569wru.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 02:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=nC38uQjZDz3wMRzUDRjp52c9Hy5uCnGBGkiYQn+GewE=;
        b=jFRFDwIWQUOtcfddu0setQkrtBAAsg+QM4SFFjMIfs1t2qtIm0uY7i8crq9De6BNzc
         Dtmli57wfgiv+8hXV/TFGnq9teiaSzgi8MwR1QQlhBXnc+XRDK0+UQ4NT5WD1X+CDrV+
         sJBDa7KYxgxHPFHz4VxYS/x5pJK+EguZ4u447bTGH5MPg5CdBX3mmARRiypZ7ZyZPr2e
         FKJTapXALLySo1mmmxFw0kI+65Y+YiqMiLgxJ67v6SZEA35vfk0WbL1/9p0xWJ6+W3pn
         BizqQ5sktYD0I+kUvccg9I9+ICSSgWYFz/5SmlbSxoi1InaZoRSpRNS//odmTCwExi2r
         spEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=nC38uQjZDz3wMRzUDRjp52c9Hy5uCnGBGkiYQn+GewE=;
        b=P8DV3S1P7kOtbM4DsucWBie4WmW1G8iIWljBRevHuWTE/PaQcpjbHjxjZsx0a/VwI+
         ThQydsb+SdVvyjxqxhFr8isspNXMZozhej7fio6fNDUVuKJ9mDyL7CVxyM90dwCZVMYz
         D2Gw725Q6tU45wpbxu0IaBvLXOxCw0ji+mO+JrqIc+1SHokAeAP/N/w+DIbn49eXjEKN
         FUU59GgMWgoGcnmVWnEyYdfa/BeR0SDG5IP9JJFISD7N1knj7YQ7zUATMO1wVfGEjl1v
         38Tx4uU9EMwkuxNT37DVqZPy6nRPZu8XyWztkHg9W+jCbEMOFMa8Wj6VkBczZ532pEiy
         SH/g==
X-Gm-Message-State: APjAAAWJVpdWDwj/OUYct138Fh9AXo8HoPQLv9pqB1dsbuasRcaWNwX6
        +/7CBqxbldu64hBrxmIRYWGaeA==
X-Google-Smtp-Source: APXvYqy2Z7KXJqoiyg14kzMzg6EQiEnMDyNve9Bd9jHVjubhjmti6d9+RBVLDiLaHEsRbCPSAAbbmw==
X-Received: by 2002:adf:a453:: with SMTP id e19mr45872540wra.48.1582281671269;
        Fri, 21 Feb 2020 02:41:11 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q9sm3437231wrx.18.2020.02.21.02.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 02:41:10 -0800 (PST)
References: <20200220205711.77953-1-martin.blumenstingl@googlemail.com> <20200220205711.77953-2-martin.blumenstingl@googlemail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] ASoC: meson: aiu: Document Meson8 and Meson8b support in the dt-bindings
In-reply-to: <20200220205711.77953-2-martin.blumenstingl@googlemail.com>
Date:   Fri, 21 Feb 2020 11:41:09 +0100
Message-ID: <1jtv3k2pfe.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 20 Feb 2020 at 21:57, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> The AIU audio output controller on the Meson8 and Meson8b SoC families
> is compatible with the one found in the GXBB family. Document the
> compatible string for these two older SoCs.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

> ---
>  Documentation/devicetree/bindings/sound/amlogic,aiu.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/sound/amlogic,aiu.yaml b/Documentation/devicetree/bindings/sound/amlogic,aiu.yaml
> index 3ef7632dcb59..a61bccf915d8 100644
> --- a/Documentation/devicetree/bindings/sound/amlogic,aiu.yaml
> +++ b/Documentation/devicetree/bindings/sound/amlogic,aiu.yaml
> @@ -21,6 +21,8 @@ properties:
>        - enum:
>          - amlogic,aiu-gxbb
>          - amlogic,aiu-gxl
> +        - amlogic,aiu-meson8
> +        - amlogic,aiu-meson8b
>        - const:
>            amlogic,aiu

