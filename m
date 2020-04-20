Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E14C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11B1B20724
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="toP4RMhU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgDTLpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725886AbgDTLpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:45:18 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4099DC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 04:45:17 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s10so2585694wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 04:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Js3BwZvrnmv59gBsa8L+RXAHWUzXe67eM8n2qWb5Mz8=;
        b=toP4RMhURcT2XtJ5IfaNiVVMaFbXgEXTIWryVnnOFRVg4W/3f6KveFzVXcfoRSd5tE
         tjtgT3qVz9O3YuNnumTHRASWh6a2tMStFb8/5gCqfCdviE8Z92aaKzbQpS3Sb4WiZY5j
         C1KhJp5Uc9oXuf1TGfX5IgjKJexw5kJo+0AXQTmVhZXj7CR9DxqqrkJksDCLz9B/gw1P
         uEUguP8XlxstZnBCY5q8YKX2pH2jUsDWz7/J6ynIhVzrRwI57CgiQ0hIkx5PCDhFhdfb
         eyy26zW5jTJqloK1P0aW4HEnvaPrqCPA/FsGry4AsYG+X02Qb4H0ArRuZN0CYSm0Iace
         L0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Js3BwZvrnmv59gBsa8L+RXAHWUzXe67eM8n2qWb5Mz8=;
        b=gKlNSqaeSv1QmehbagTVunEqSD1w24ITYbVKbQ7a97dY+sZ0l1otKoejO9FZ2Bn7TU
         OmNxHh5oOohvFBGyftssZklNvDdJtXT6O8XhDg9S7x0JPW6O61EP+vNXQ2c7+ja8FUCU
         XU14Yize5DyFj7b0HPm1vDFQPehzIryceKalLgK44Low3fl5s+doOt5aaGZkcSkTY0ku
         Ujk70Ms3sm6eUPHqxdRhlBRJ6T0xSYggJZDc06pVn1JVdyaAwDZZt6Dw/c0WHwRUbvcb
         lMjJRyIBRg9zZamW8uSfSS6HZKOjClP0aLJbJiF6P5RDpRbREp8epfcNmKf9vuI5eaBA
         hwdA==
X-Gm-Message-State: AGi0PubDXPk7PSRA+gyJ77Ux/KgODf7QhtPlT/UjFOCzukOgHlwLsC3O
        MgL1H+emJL4iMEje9Cd1+XHItw==
X-Google-Smtp-Source: APiQypKI1KRjPuhgF6AbUXwJ9ryl2ikHEYgGv5Bk7mnI4calt5WkvXgxuOL8mEH2qlqfsPZCsMLQFg==
X-Received: by 2002:a5d:574b:: with SMTP id q11mr18765094wrw.324.1587383115925;
        Mon, 20 Apr 2020 04:45:15 -0700 (PDT)
Received: from starbuck.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id k6sm1079182wma.19.2020.04.20.04.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 04:45:14 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 0/2] ASoC: meson: fix codec-to-codec link setup
Date:   Mon, 20 Apr 2020 13:45:09 +0200
Message-Id: <20200420114511.450560-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes the problem reported by Marc in this thread [0]
The problem was due to an error in the meson card drivers which had
the "no_pcm" dai_link property set on codec-to-codec links

[0]: https://lore.kernel.org/r/20200417122732.GC5315@sirena.org.uk

Jerome Brunet (2):
  ASoC: meson: axg-card: fix codec-to-codec link setup
  ASoC: meson: gx-card: fix codec-to-codec link setup

 sound/soc/meson/axg-card.c | 4 +++-
 sound/soc/meson/gx-card.c  | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.25.2

