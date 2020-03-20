Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495AFC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 20:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1317C20775
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 20:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vY+bwhQo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgCTU4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 16:56:19 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39497 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgCTU4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 16:56:17 -0400
Received: by mail-lf1-f67.google.com with SMTP id j15so5647061lfk.6;
        Fri, 20 Mar 2020 13:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KxFdW9v6W+mUSjXzjhOErZqVKviF3hnRVIcHD83c/Zk=;
        b=vY+bwhQolKHP/YjRpTOkMg1e6CoOyk67/iB6jpyUgrJCPci7UOwuh+sKhreTuHQTCv
         c38CESG7MX4X45BHD0eL/p+NFlCsXM1SX61hZO71M02CiRJlceCXqDpfcAd5SwaKz0PU
         4PfeoLJonCrD/eVWKOoFpW8fW/qNDK5+S7ovPE22wqQXkcl5efMOTtAN6QrM6eH1Yri/
         M3OlY6nQt3vDHzzKScafmPyMaj8D0+ISuqD/JOuZ2ivxGBADIAtPVTLxKIGpiB7TMA2e
         jYjH/aZUApEEqtSb5OS9N+jFZ+48la0aiKHP3NDTZbFUNj7YdCAEu04pyzCmbEreh3Pf
         qZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KxFdW9v6W+mUSjXzjhOErZqVKviF3hnRVIcHD83c/Zk=;
        b=VNB9kB5z4TDva94gxDJE+ctftJbQCWgMN6NR/+JZb9Cl3VV/BT3wyuWgRJo0PthViO
         WIPMTKr6qwpSnDQTin2WriyssSdqLPLbeis67y3M+VqDHMtk5ghVkSusWSxwbZqGa4R7
         NIQCdVvyADqS6XsRRes7zjjHRWoeywrPZ36YerAyGauGkxwo4Z1ROfo69X2/+BzsvCad
         JQeNvpO1FKgRqHzKrvXqCNjamsXdZcKdv2jd6K5Nk8Qh7/RqsoUhyGw6hud0TGZiGiVs
         RB4DzPW1VBtOL2GcnZnNJ/D90Xx2sm6qkdbhJ4t9ePqAGaeOmHE8Hnve1DzkfPL9S3qN
         Veqw==
X-Gm-Message-State: ANhLgQ1ihgfnhPOBflUlOMrWulQftXKYxAGqwaQb58f7gVfwxV5j5Y8p
        2DNseoKG9nU0rz9aFoat8h8=
X-Google-Smtp-Source: ADFU+vv3bRJa6nnY4LiRKhr6qR2D1OtfWKdszUzJ8w497f3yhm9cYDRehnMPg0u2rUV4MVq8hoR0gw==
X-Received: by 2002:ac2:5203:: with SMTP id a3mr6492154lfl.152.1584737774394;
        Fri, 20 Mar 2020 13:56:14 -0700 (PDT)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id 1sm3873356lft.47.2020.03.20.13.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 13:56:13 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Support built-in Mic on Tegra boards that use WM8903
Date:   Fri, 20 Mar 2020 23:55:02 +0300
Message-Id: <20200320205504.30466-1-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This small series adds audio route for built-in microphone on NVIDIA Tegra
boards that use WM8903 CODEC. In particular this is needed in order to unmute
internal microphone on Acer A500 tablet device. I'm planning to send out the
device tree for the A500 for 5.8, so will be nice to get the microphone
sorted out. Please review and apply, thanks in advance.

Dmitry Osipenko (2):
  dt-bindings: sound: tegra-wm8903: Document built-in microphone audio
    source
  ASoC: tegra: tegra_wm8903: Support DAPM events for built-in microphone

 .../sound/nvidia,tegra-audio-wm8903.txt        |  1 +
 sound/soc/tegra/tegra_wm8903.c                 | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

-- 
2.25.1

