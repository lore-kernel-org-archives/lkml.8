Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8482AC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5114424649
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bhg9/ibe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388857AbgBNTOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:14:53 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40182 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388250AbgBNTOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:14:53 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so11844371wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 11:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=3/uupSJ5RdwyA7ehfydikl3HpiFLgfBAqG7GerpJi7c=;
        b=bhg9/ibeciuu4Ehv/+5VnxzdhVR6BHlImtjOZ+pPpe4yBnv3DYy5GkYmSdTQ0lf3wI
         ulBkqUncQAxNdUqMhsIWhWlhC88PGD1o+rW4i8a3nBi1xj65vzIjPEKwHZnAs/fwBE2x
         cDbmW6ayWu9v5S3BLzcVxXkdcDiFgbNaR86dZ7S1c2aEWE68cE49eX1Z9GHikMH9M2tY
         DkjeV5xIBEucE8volM/K6bNCmnRL7Pg2raIr8DOxI0/2n/JvPlxmFrco1AByyKR/eM0m
         xxR2PIOVmDxUK2hAFYs8kAf4X11yxS/8Edi2bzzIxpxNW5Hwr19KuARUlkbAIzYXFO5S
         KxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=3/uupSJ5RdwyA7ehfydikl3HpiFLgfBAqG7GerpJi7c=;
        b=bPuJFqIRrb4IWxwbpqypv4ntnYa7Tw2HoN1I5KUsyB7UCpyTmYSNkgTW6XObZWxEHH
         e3c06igt7FU29i0yaKxtraT29R5ugB6pnpwnLhW+NJA1jP9xoRXZgrmovXJzNuGohHXw
         O+N8s0yx16AKxD4Y2Jy/I+kAeBC7zcXTecCX99sNnTH6qzn+CWedtrlDn1q9lZWTyQ6H
         /F4QJFrgV1FsgsxyJXaCnMKoIf4e6O7WCpBJiPgzRvyKAmjvd88EWM6tWtoSEkyCa8E+
         sTTe+Xx9Dw7KmZLZTMK933jpP0wKyuP9+2I2VMv29yCNOgz5ON313cq/dFk0GlJkg+Cp
         K0Ow==
X-Gm-Message-State: APjAAAXEyZ0B5mCWOrLPP/88YF44M4wmsbwz/kVoT4Kw3nRM+K2N+nRc
        IoLXk8vxKYVo8SwE9z+he1G3fQ==
X-Google-Smtp-Source: APXvYqwOROtwg8ZpOG1fo2gk0W+2Y4A+QNx4Yrvyeo3f6izuFJXQ4Xs25CzIa4xAOjzg1uSQfJHE/A==
X-Received: by 2002:a1c:5441:: with SMTP id p1mr6420025wmi.161.1581707690024;
        Fri, 14 Feb 2020 11:14:50 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id x21sm7922966wmi.30.2020.02.14.11.14.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Feb 2020 11:14:49 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-amlogic@lists.infradead.org
Cc:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
Subject: Re: [PATCH v6 0/4] arm64: meson: add support for A1 Power Domains
In-Reply-To: <1579087831-94965-1-git-send-email-jianxin.pan@amlogic.com>
References: <1579087831-94965-1-git-send-email-jianxin.pan@amlogic.com>
Date:   Fri, 14 Feb 2020 11:14:46 -0800
Message-ID: <7hd0ahasm1.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jianxin Pan <jianxin.pan@amlogic.com> writes:

> This patchset introduces a "Secure Power Doamin Controller". In A1/C1, power
> controller registers such as PWRCTRL_FOCRSTN, PWRCTRL_PWR_OFF, PWRCTRL_MEM_PD
> and PWRCTRL_ISO_EN, are in the secure domain, and should be accessed from ATF
> by smc.

Series queued for v5.7 with Rob's ack on the DT bindings.

Thanks,

Kevin
