Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB70C2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91DCD20578
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LMxxjnWH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgC0KkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 06:40:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45058 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgC0KkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 06:40:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id t7so10743437wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 03:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hUy8CSxiwxtlSvFdhJfOQOxn+8kEeA3/QOE0g86x3DY=;
        b=LMxxjnWHsVPWoK+YealyJ9Y8VXYAU9t0UsEYeUXuUR6Kew3uePNv32seA9fjNqon+b
         uKpgsUP3PLmbQwwhR2nGysLvWXcqVaYGhAvXiI15N8rxlWciMQWG/KcpXGRlWQpXvMbD
         RVtEo241nEUUlqhor80ruIxUeVG3aaorxDTsvOsB9vIFYbqkiJl1Pqqd+D0Yy7eMMI9N
         Qg3fNLmNm7A/O55vwlpdITkGRbG7ojljbzonQ4My13PQK/K3+3D+YmKSL0S4/AbMzliq
         qioniwV77ZESN3EwdzImhbFexw5sbgGBNGrFPYs18SKLkJTQpHsVMFSvYh0qVZmZxkT5
         CIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hUy8CSxiwxtlSvFdhJfOQOxn+8kEeA3/QOE0g86x3DY=;
        b=EHcnRIKNwYKuK62GhTf1SduZhDLjxQa5X4a71pbfS6li76gmlM8S2DwEdtOvLfeR7G
         2YjkQEuvDLeOH8dl7G3/zX5lfS0g02Xr5OJcDZhqPF/N7f2HF9QmKs+C96iUwlLfJGbw
         nMH7bC3RblfCeYAO0IxjM/8t5dRnTSxnVU1j4aDazG29bcasezSWww+NTKNRCg0Pq5op
         K+t5/Rgo1wp2YqVEDBTp9WGGx9GYaLcICn9dJUHWpHSC7qzkvF1QZyrVOqptdh+37iLm
         DepXVmP2uVLZ3at7M2hJMlH1rdw/Niet+GOBWMB4Efkea1SYhYN4QxKitdBb5t9QeED1
         0j6w==
X-Gm-Message-State: ANhLgQ0cDnME0LUQ2XAAvZRtkW8/MRkw2nH8e4j6FfVSVoIP6pDBMk7a
        AuJqxDzGaEAM5RzGC3vft0wQ9Q==
X-Google-Smtp-Source: ADFU+vu2K+4IxFs7+VvXvZAHHpSGTr0Ruak97rimwwt4gOR55rJ8O0ACPtX5CuXxCIq/LRKi6XwULw==
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr14511489wro.415.1585305598986;
        Fri, 27 Mar 2020 03:39:58 -0700 (PDT)
Received: from dell ([95.149.164.95])
        by smtp.gmail.com with ESMTPSA id x206sm7522623wmg.17.2020.03.27.03.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 03:39:58 -0700 (PDT)
Date:   Fri, 27 Mar 2020 10:40:49 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        stefan@agner.ch, b.galvani@gmail.com, phh@phh.me,
        letux-kernel@openphoenux.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, jic23@kernel.org
Subject: [GIT PULL] Immutable branch between MFD, IIO and RTC due for the
 v5.7 merge window
Message-ID: <20200327104049.GB3383@dell>
References: <20200320081105.12026-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200320081105.12026-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-iio-rtc-5.7

for you to fetch changes up to 7858658cdcab7ca8057444b1d24c6a28ddaa8589:

  mfd: rn5t618: Cleanup i2c_device_id (2020-03-27 09:42:44 +0000)

----------------------------------------------------------------
Andreas Kemnade (7):
      dt-bindings: mfd: rn5t618: Document optional property interrupts
      mfd: rn5t618: Add IRQ support
      mfd: rn5t618: Add RTC related registers
      mfd: rn5t618: Add more subdevices
      rtc: rc5t619: Add Ricoh RC5T619 RTC driver
      iio: adc: rn5t618: Add ADC driver for RN5T618/RC5T619
      mfd: rn5t618: Cleanup i2c_device_id

 Documentation/devicetree/bindings/mfd/rn5t618.txt |   4 +
 drivers/iio/adc/Kconfig                           |  10 +
 drivers/iio/adc/Makefile                          |   1 +
 drivers/iio/adc/rn5t618-adc.c                     | 256 +++++++++++++
 drivers/mfd/Kconfig                               |   1 +
 drivers/mfd/rn5t618.c                             | 109 +++++-
 drivers/rtc/Kconfig                               |  10 +
 drivers/rtc/Makefile                              |   1 +
 drivers/rtc/rtc-rc5t619.c                         | 444 ++++++++++++++++++++++
 include/linux/mfd/rn5t618.h                       |  26 ++
 10 files changed, 851 insertions(+), 11 deletions(-)
 create mode 100644 drivers/iio/adc/rn5t618-adc.c
 create mode 100644 drivers/rtc/rtc-rc5t619.c

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
