Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C554C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4F5F208A7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="r4XgU/IH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391223AbgEZUaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 16:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389367AbgEZUaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 16:30:09 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38227C061A0F;
        Tue, 26 May 2020 13:30:08 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id y13so3318501eju.2;
        Tue, 26 May 2020 13:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BS3gmgrNZrm2hux2kw4Gbzw+57Hl3YkxBqJ2R++uXCI=;
        b=r4XgU/IHeIoBI5OZ3olD5EbIcyRjAdqgO/+YRdPtOaCBv4j6Gxd2LwK5NJDWEcB9K6
         vRJ9Eupq+UblOGSrPMH9XyH60cEtJegWSpZE0bcGRFfIU4sIWX/aIW7ZilHW+aahd81Q
         N7C7FGEp7o8RzXe01Lj372FSwt6O7bpBFkItV1AB/o7VN5NHQMfKDId1oKpnxNLO5Qbd
         whV5DLqWTuhIbjDiN9HkKYDqxghk3V4w+q6G2r9Oz6exuMv5njdsDraYR6EilKiL7m1G
         /lN49juqSg8mij/VsmISVxlaHeonpyhTUGc9LLFuKUplPBC+WVsGVbzXXdbZA2d+cpba
         j9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BS3gmgrNZrm2hux2kw4Gbzw+57Hl3YkxBqJ2R++uXCI=;
        b=huYbWrYseTr0plzdXk6vQy2A2ATmVqATO6hLtKpqupv2A8jPKQ7rScmaX7J0isz8bZ
         /AjBMNOjL0Nt+XgHdfW6vCfqVIXaSWdz11WrKEv4UMsrWnZv8G3DqF6C6vHp/X+QU4GF
         6XyH1i7ch8jvKP1QLJlUDfP59+9fLmC69p9lk2pskLxBoTUCLX8ADxwdhYOXY062flOF
         WTUWNGhqmxbDmPu2oGrFcMQbMCKlE2bc4uR58FKWG8py3DWcEtksp6oxRLx8kME5lns6
         DfNJPiwB5xWhchW+Uoj2hkm0eAyq3zF2jvgyvcz3Ucz4NVQ+G4eft1xHAmGklSfyEEGW
         6sSw==
X-Gm-Message-State: AOAM533PpqTIWQnkNPNIP+ow2UXq25+ICoxrd12ZGgNoEb/oZzV/CedC
        +y1w8vPVwY/6SwYabRUo8Ic=
X-Google-Smtp-Source: ABdhPJwesYpdqbXffVEfuArKTeB8fbq82Mn88IJ+AIOM3WfF0QObdfPu/3ksWvttav2D8RnkKlaSfQ==
X-Received: by 2002:a17:906:1f09:: with SMTP id w9mr2655211ejj.486.1590525007118;
        Tue, 26 May 2020 13:30:07 -0700 (PDT)
Received: from localhost.localdomain (p200300f137189200428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3718:9200:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id ce16sm735517ejb.76.2020.05.26.13.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 13:30:06 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org,
        narmstrong@baylibre.com
Cc:     hanjie.lin@amlogic.com, yue.wang@amlogic.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH for-5.8 0/2] dwc3: meson-g12a: two fixes for v5.8
Date:   Tue, 26 May 2020 22:29:41 +0200
Message-Id: <20200526202943.715220-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I discovered the problem addressed by the first patch while I was
investigating a Kernel CI regression: [0]
It is unrelated to that regression but should still be fixed.

The second patch adresses the actual regression. Testing was focussed
on GXL and GXM for the previous patches. Unfortunately one of them
regresses USB on G12A, G12B, SM1 and A1 SoCs.

Please queue these for v5.8 so we don't end up with broken USB on
some boards.


[0] https://lore.kernel.org/linux-usb/ffe2c64c-62ed-9b59-3754-7ede0f0203be@collabora.com/T/#u


Martin Blumenstingl (2):
  usb: dwc3: meson-g12a: fix error path when fetching the reset line
    fails
  usb: dwc3: meson-g12a: fix USB2 PHY initialization on G12A and A1 SoCs

 drivers/usb/dwc3/dwc3-meson-g12a.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.26.2

