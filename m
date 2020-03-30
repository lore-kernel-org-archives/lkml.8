Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3835C2D0F1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAEB20733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWPGpeeD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbgC3Umq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 16:42:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35614 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbgC3Ump (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 16:42:45 -0400
Received: by mail-lj1-f193.google.com with SMTP id k21so19678365ljh.2;
        Mon, 30 Mar 2020 13:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gmG6Nw2gJlFbmNF3ZrYh4WCs9X24BSpQSwGXaDwojEM=;
        b=EWPGpeeD9xPPFMNqQ6vW4zN9xym3eTWIch0s0QCJ2Cy+B1Py/5kXTZOs8CKstvZVGr
         Lzg3JkHf1lrq+CYKHi7QPBwRA4glrwK2KWK4c97VpHc/U8Y3osFvCxn6O+0If0LU0FmM
         /wcHvHhNxpY7g9jWsLg5OGhrQKREZ8ZSgGIUscqLU2yHGiQ+MYa9II4CHdnp4tOxspKh
         mg5Kz/w1Zx7HLaPBDJHf+PMYCKapObCs1GP/IfvzRlN5KViWBgGYiY1WQ9hyC2P4gmnp
         OPz6KVVReN7P6QL5g8NeYzB2YAXMvei9IE3tI2n4yWmMk0yLLM1cHql10O+bjuAJlocy
         lsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gmG6Nw2gJlFbmNF3ZrYh4WCs9X24BSpQSwGXaDwojEM=;
        b=GdbhjVMxaf8hbSxjstmjZnO6mCrH9yFuPXvzCQHveSqoInHa1G5wgo3p+YHSe2bxNg
         20ACIWFJ+bGhICMy17yi0be1jnAAR5Qs4Ve7ZfccIRsdz9bRtxtM9Foq+4rDLyzEksTV
         Z9c6r95hEPenUzz6BdfEpH5oXR6tgc+Zz4BoPZ7XgcikaW5envRGs0XiQgTt7+Mt4O0N
         kKTHIeWvrWrreb+yYs1WZPDc0VdBmWmLyNA1MMgV7T6OUvSUVzJn8+uAUvBhvJz7XVBp
         aq2t6q0Cz4bH7mYWok+mGNRYzELDAK6nL4sZ6eHG1BL2ynYwL4FEh6KvjHD6O+NwLVxc
         KXMQ==
X-Gm-Message-State: AGi0PubTuV6cHTA8Od+L8QjIY1P9O3mD6MYIgzHZhA4TFnB946aiX5CR
        Oa85Z8jSeCbMksERJmlpgBM=
X-Google-Smtp-Source: APiQypJxE6SfhjbuHfxqVIzERON0sXL7oImWTuEjhb77hQureETdjO+AJJ/LqtZPpIH8am9utoTy5A==
X-Received: by 2002:a2e:804a:: with SMTP id p10mr5966662ljg.289.1585600963256;
        Mon, 30 Mar 2020 13:42:43 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id v22sm7287988ljj.67.2020.03.30.13.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 13:42:42 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Support headset on Tegra boards that use WM8903
Date:   Mon, 30 Mar 2020 23:40:09 +0300
Message-Id: <20200330204011.18465-1-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Some devices have a 4-pin jack instead of a 3-pin and currently the
WM8903 configuration is hardcoded to the case of 3-pin jack in the
Tegra's ASoC driver. A new device-tree property is required in order
to convey that hardware has a 4-pin jack, and thus, microphone's
detection needs to be done in a different way.

In particular this is needed for Acer A500 tablet device that has
a 4-pin headset jack, otherwise userspace sees headset instead of
headphones and internal microphone isn't enabled by ALSA UCM rule
when it should be. Please review and apply, thanks in advance.

Dmitry Osipenko (2):
  dt-bindings: sound: tegra-wm8903: Document new nvidia,headset property
  ASoC: tegra: tegra_wm8903: Support nvidia,headset property

 .../devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt | 1 +
 sound/soc/tegra/tegra_wm8903.c                              | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.25.1

