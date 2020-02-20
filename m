Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4D4C11D25
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3AC208CD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="F2UN2Hn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbgBTU5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 15:57:22 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34413 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728967AbgBTU5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 15:57:19 -0500
Received: by mail-wr1-f65.google.com with SMTP id n10so6219390wrm.1;
        Thu, 20 Feb 2020 12:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FXjFzy08xMuJRMEmwBB0yy8RCFRKvyZHt3R4Qv4p1O8=;
        b=F2UN2Hn7nmxIi+cFd7snrG33JIJjswMBS3DsHUuvSbqqi8E8OVJdnLegKa+tC6gccQ
         JKh/sbaLX1ZAeU+9UddHYLmfilbTGhARmYPRE7cSVKS26auV2A0KqWkdqV5tj9V0VYbQ
         UDfyG6axD3KDMa/QyksF8EUy0zlROK63PctIj5HC8i1eqmDJv5aOjZZ7fyero/KPUuDq
         wfOVVD/1bB99njYloSBusB4CVm9CWNj0SJE4q+N8v8QsGEqNz6UOdhXkNT/K4dzNfUVC
         PD45Jx76l0Ml6UrUYOnaGDtRs2MmDO+DvUYM9Bn9bxHJr7ped37CZg95RVU2w6NlmZlo
         d0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FXjFzy08xMuJRMEmwBB0yy8RCFRKvyZHt3R4Qv4p1O8=;
        b=VSOxU9gDsAv/qMF3KWWnoNHevPEPLi5t1JednUkXuL+TZJuO1bnoCYc+fYBolUh469
         tKUKV2a0a5yI6hF5ynFgDh/D3EHbiFZjwFJYafvoK7cqJ2F8KEEjZdWGqUqU178eLi9j
         CM3sa1fWkDEBith4VDGWexqDMWI3xcn5IOdUfAABqPt71nm9RluYKCpoQ28iVX0ztCVb
         t3HCjCk9tUQ+4dTGyHxNQg+Iyi5O2yb2Wc4SVlsTzmw8B3di50gxwtvt8IWl50won/CH
         uOD/vPU+5J3igpFQN/x7lQpZuE+qOJXsYFbLLng3/sRxD+OnPe8T0rDHFRjeB0YbyoiJ
         nLRw==
X-Gm-Message-State: APjAAAUDVJOPVpbjZFmanJxQRVgyx1c5bJSqXJbENQQD+46xRGT+/4VU
        jMvdhlwEWXIobjPuIddxb5A=
X-Google-Smtp-Source: APXvYqwTNBE8NHGbnW8Z3nYsC+iVU2OPITKzvQtdl8slWj3/kKZgD9q0JgDz86aIMPvz7Z2806fdUA==
X-Received: by 2002:adf:f3d0:: with SMTP id g16mr45704445wrp.2.1582232237793;
        Thu, 20 Feb 2020 12:57:17 -0800 (PST)
Received: from localhost.localdomain (p200300F1373A1900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:373a:1900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id a184sm695039wmf.29.2020.02.20.12.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 12:57:17 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jbrunet@baylibre.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/3] ASoC: meson: aiu: add Meson8 SoC family support
Date:   Thu, 20 Feb 2020 21:57:08 +0100
Message-Id: <20200220205711.77953-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the AIU audio controller found on the
32-bit Meson8 and Meson8b SoCs (both seem to use the same revision,
but for safety reasons we add two compatible strings).

The only known difference compared to the GX SoCs is the absence of
the I2S divider in the AIU_CLK_CTRL_MORE register. Instead we have
to use a less flexible divider.

I2S testing was done on an Odroid-C1+ with a PCM5102A stereo DAC
board connected (on the J7 header) like this:
Odroid-C1+  | DAC
------------------
pin #1 GND  | GND
pin #3 5V   | VIN
pin #4 MCLK | SCK (optional, DAC can operate without this)
pin #5 LRCK | LCK
pin #5 SCK  | BCK
pin #5 DATA | DIN

In 3-wire I2S the MCLK <-> SCK connection can be omitted. For my tests
I used mclk-fs = <64> in this case.
In 4-wire I2S the MCLK <-> SCK connection is required. For my tests I
used mclk-fs = <256> in this case.


Martin Blumenstingl (3):
  ASoC: meson: aiu: Document Meson8 and Meson8b support in the
    dt-bindings
  ASoC: meson: aiu: introduce a struct for platform specific information
  ASoC: meson: aiu: add support for the Meson8 and Meson8b SoC families

 .../bindings/sound/amlogic,aiu.yaml           |  2 +
 sound/soc/meson/Kconfig                       |  2 +-
 sound/soc/meson/aiu-encoder-i2s.c             | 92 ++++++++++++++-----
 sound/soc/meson/aiu.c                         | 28 +++++-
 sound/soc/meson/aiu.h                         |  6 ++
 5 files changed, 104 insertions(+), 26 deletions(-)

-- 
2.25.1

