Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AF3C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A5520721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="WMxnr3hl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgBCNah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 08:30:37 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39888 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgBCNae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 08:30:34 -0500
Received: by mail-wm1-f68.google.com with SMTP id c84so17079538wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 05:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fkFDQxZCGtJvMWzgeiZLBXi4rV3V0DscLDICyLa6gb8=;
        b=WMxnr3hliH7xsSmJQs31Wm1EwnsEB4wXvs70NjdbIQsbpXyUzmv3RXEwLv2P0FpP9r
         Q43faHFZ9r18pgqRxWLRryYOW0aULXFUCsE3yVebQPIlXMPGCa0ycpIJtcIwZPcjiXVI
         c7Vy261zT6XDDrnudN9lOJAzy1iQS+RrK/Yv+h+y1u64tGkURfOdm2t67OnB5kBL2TDq
         RkAr9U1Su1sh1ip5LgN/cz3YnX6vgTcbSGONur+niBD8+YnTfLaNZKTdSbhk0ns+svc7
         1KmsWE3GKLWB7x1Lji2qRNm6zqJMPySYf6uvgAlQqpt3vhtmFXOTbOeYwPvBC5yK5mz1
         pJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fkFDQxZCGtJvMWzgeiZLBXi4rV3V0DscLDICyLa6gb8=;
        b=Qk+FIOuhlC6jZz+1syjt1QF+afI5Fp9MXRfr1jNxzA0wdGsuBd6ogKMLex4BQ3Ic+Z
         afRGt4K0QfE5Wp5im+x5VxCghAYaLDWDfgiLNHCnvmb+dm7dUiyX4vtmRakYE7yynr9b
         FdzF8GV/rbzeZJdTBXlAtGfYOeDWMJq7nCOU1/A0UAcBBQivH4eR7H0R7I+XZ3/2CwHu
         lmEaDYl4GF0MJvzz4lIQhVBVJgjfyAwjp/lYcUhqQWqFll4+LuwjQsfeqB4xCOqsQT9e
         8HBgnHMYiaIlo/H5RWd1kO1VY/6XF4j+f3dyjkIzSt+TwwxC506jFge+S/8PP+qnPN7a
         rmGA==
X-Gm-Message-State: APjAAAXmelpp+4ENBIo5Oh891cYIBMdqYIlipNsRyqyA/3jOGoUoc5bA
        TQm6UDmdEx6Ptumnu6d1iFx/rA==
X-Google-Smtp-Source: APXvYqzn5qm82dgj5JBm0iOxgAssGQdutrj66VNZBEU6GDKHm91YhpdHpMfx5cHD2PlWa09RqDhJWw==
X-Received: by 2002:a05:600c:214f:: with SMTP id v15mr29957834wml.110.1580736630865;
        Mon, 03 Feb 2020 05:30:30 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-505-157.w90-116.abo.wanadoo.fr. [90.116.92.157])
        by smtp.gmail.com with ESMTPSA id l8sm7594540wmj.2.2020.02.03.05.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 05:30:30 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/3] gpiolib: fix a regression introduced by gpio_do_set_config()
Date:   Mon,  3 Feb 2020 14:30:23 +0100
Message-Id: <20200203133026.22930-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

These three patches fix a regression introduced by commit d90f36851d65
("gpiolib: have a single place of calling set_config()"). We first need
to revert patches that came on top of it, then apply the actual fix.

Bartosz Golaszewski (3):
  Revert "gpiolib: Remove duplicated function gpio_do_set_config()"
  Revert "gpiolib: remove set but not used variable 'config'"
  gpiolib: fix gpio_do_set_config()

 drivers/gpio/gpiolib.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

-- 
2.23.0

