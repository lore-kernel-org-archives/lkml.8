Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBB8C38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B454A22202
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bojG319N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgDQSeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 14:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726054AbgDQSeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 14:34:06 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7BBC061A0C;
        Fri, 17 Apr 2020 11:34:05 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id u13so4190698wrp.3;
        Fri, 17 Apr 2020 11:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HscwK37cFKMub3BOfrP9Hc3SiCJrLqjZW3xZhk6qI2w=;
        b=bojG319NgtlkmTI7fGKzyA3aVCpaJ72KnmzPfwmdX98DNtqGu52+YZO0jEYJx14DUV
         0UdRwgovBE4uF3rYGkGa0veuWdTk0KtjapL6E/KH+XF45W2hOuuB/ZDdQyyoFUDpLmER
         rXUHhb7xW8cXpDW1mL6eng/NpL66M8c/0lNO3f69ju6HCLcVCOuKKQmXyNQeuMZ4WA63
         enPL2hlKsmIjp7gPiEdE1cCmttEnIkij5Z+v7gioM65U8o2hDS9BVzda80BZVAeRRGih
         gplpdez6CT5dyOG8KIBuMSYxst7NDLKViV4FewZrh4qA63JRfeezF0+BYto7AE8dGNBq
         CZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HscwK37cFKMub3BOfrP9Hc3SiCJrLqjZW3xZhk6qI2w=;
        b=OW/NoogrVUWoiMHMSAnK31GsK7d0RvueBTE1M8QkeT40lK+CqN4yFq6aExwchX9f/k
         kbnR3gCxIkjRzIzRq1Zx6exsTXXp3PgnItoaI3C5jxH/0a/tOA2dodpTg+ZIlQjY49Pa
         R2nDPCrFpdsfFt07tUbRCDmGUvc7nKtION8HB86wrIig4Ee/0FmCxcdBCP+WEFcOSRya
         AajAZWxrcCJSqYoboIckaZeEzVAvEj2r47rvH5f6qV3fw/zFZIvKhBjj8aknLBd+g7Jk
         YjJ9GvlQkPE6DTVdWEorqeLjc365Kb/D/DHIRcETrUECjp3RQdT+ihHbPpzdQQNgieYX
         9yGQ==
X-Gm-Message-State: AGi0PuZQVI7+Kpc3gvG9g21YnYF2xXnWWxHP/8A4wSBSYSwwzwwuamPs
        FmvFDQuleNEBxUcDUPnywp8=
X-Google-Smtp-Source: APiQypLijZgFjxv4x89tuM/h2XT9WSLRN+Fy5h09T4tZQq+JQ6uZXZRDgovMQuFHwHCvNlKO23KWTQ==
X-Received: by 2002:a5d:42c7:: with SMTP id t7mr3138328wrr.336.1587148443929;
        Fri, 17 Apr 2020 11:34:03 -0700 (PDT)
Received: from localhost.localdomain (p200300F137142E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3714:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id o7sm3074994wmh.46.2020.04.17.11.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 11:34:03 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jbrunet@baylibre.com, khilman@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RESEND v2 0/2] pinctrl-meson: two small improvements
Date:   Fri, 17 Apr 2020 20:33:47 +0200
Message-Id: <20200417183349.1283092-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While playing with audio output on Meson8b I found out that the
vendor kernel uses a custom version of the GPIO_PULL_UP flag. I
suspect that we will need this for audio support on Meson8b and/or
Meson8m2 but I don't see it hurt other platforms.

Also while comparing the register bits with the GPIO direction (of
GPIOs exported to sysfs) I sometimes had a mismatch. This also wires
up gpio_chip.get_direction to have sysfs and the actual registers in
sync.


Changes since v1 from [0]:
- re-send as non-"RFC" because I only got one comment in the past week
  for patch #2. Jerome pointed out an alternative way to GPIO_PULL_UP
  and GPIO_PULL_DOWN. However, this doesn't invalidate the patch, it
  just means that there are two ways to achieve the same goal.


[0] https://patchwork.kernel.org/cover/11484185/


Martin Blumenstingl (2):
  pinctrl: meson: implement the gpio_chip get_direction callback
  pinctrl: meson: wire up the gpio_chip's set_config callback

 drivers/pinctrl/meson/pinctrl-meson.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

-- 
2.26.1

