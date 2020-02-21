Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BFCC35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 687012073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lzzPLOpa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbgBUPgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:36:17 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33704 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgBUPgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:36:16 -0500
Received: by mail-wm1-f68.google.com with SMTP id m10so5439340wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 07:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UNHEwFigMTNc7YIRkUZl+5v4Xtz4VgLarV7EC/Mxw3I=;
        b=lzzPLOpa00IdY058idG1naAWzavEyCoj9ZAwXmLXwzaop7ZYtD6FCA7/Tf+u9wizE2
         +QxpIzWLnPu+dVn5KZNt1nAGYXhZ4ztaqy8mL/My88k0srIG6rRqr0alTBwdFVXMNmuH
         vEwKcvHsq8xwJTW5yyOZ+9QZ58aW+16RkHwKPgNUTU+oMh3S9hjGqkcB+mV1w6Cv3BZT
         8vT8pg8d6Y2vduJCtbT3ZWNlw5adXT1EyCNVG9oXVLxSmlsgFSnrfR5KWSK92AtNmzEn
         qIo4lSIdYXBLXURdlh6n41O0Q8QD8BPrtCNl/3BW0RmY9seoAerFYelvoS3oFAfpFOa+
         Rk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UNHEwFigMTNc7YIRkUZl+5v4Xtz4VgLarV7EC/Mxw3I=;
        b=LRdLWDttdCqDhBH9jrLYQ6LEItppPBF29G0+4rSYLqBDSmQDWpcvCRF56hxMyXs/5n
         WRxQWFcH5DAJI0gCXWOrCQM9vGIKilukvhZMxePcfOmOC9vRsmhP8vY0EqQIJnKuwwXv
         ef90izSMjaYex480cxf9oP2PuuWFkbZ6s+1taujByunWs4Ls3IJ4N4leIVTs3Skgu+7q
         Q1da6V7cCByTPRvxth9PomywDqr8mWZbRp/24sihca5n3JYg1XwLmrwVylSsHWBD7Mrx
         L7I6cBrxCM8Gv4ZeZVhED4a63uZA1eHknPygRGoQLQY8ryCXFg6jZETrX8ELN/DFahP8
         KNTA==
X-Gm-Message-State: APjAAAUdLQpwyyLE9KCFwbN6sEnyoMce1zpbTw4KsTzhwPOH7RhVDwG8
        BypT8sugZ5cFm16cn3IlGSYD7Q==
X-Google-Smtp-Source: APXvYqyCqkZR3zDNG4VAxXvdw9Zekulra1RORCfv3lpKLj9dzld+yh6yJQE1+skfazo6TA4dUBZmJQ==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr4286552wmi.45.1582299374128;
        Fri, 21 Feb 2020 07:36:14 -0800 (PST)
Received: from localhost.localdomain (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id z25sm4198782wmf.14.2020.02.21.07.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 07:36:13 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v2 0/3] ASoC: meson: g12a: add internal audio DAC support
Date:   Fri, 21 Feb 2020 16:36:04 +0100
Message-Id: <20200221153607.1585499-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like the gxl, the Amlogic g12a and sm1 SoC families have a t9015 internal
audio DAC. On these more recent SoCs, any of the 3 TDM outputs can be
routed to the internal DAC. This routing is done by a small glue device
called 'toacodec'. This patchset adds support for it.

This was tested on the amlogic reference design g12a-u200.

Changes since v1 [0]:
 * Fixup patch 2 which was left in an intermediate state
   after rebasing, missing part of the changes.
   Thanks to Sergey Bolshakov for reporting it.

[0]: https://lore.kernel.org/r/20200221122242.1500093-1-jbrunet@baylibre.com

Jerome Brunet (3):
  ASoC: meson: g12a: add toacodec dt-binding documentation
  ASoC: meson: g12a: add internal DAC glue driver
  ASoC: meson: axg-card: add toacodec support

 .../bindings/sound/amlogic,g12a-toacodec.yaml |  51 ++++
 .../dt-bindings/sound/meson-g12a-toacodec.h   |  10 +
 sound/soc/meson/Kconfig                       |   9 +
 sound/soc/meson/Makefile                      |   2 +
 sound/soc/meson/axg-card.c                    |   3 +-
 sound/soc/meson/g12a-toacodec.c               | 252 ++++++++++++++++++
 6 files changed, 326 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml
 create mode 100644 include/dt-bindings/sound/meson-g12a-toacodec.h
 create mode 100644 sound/soc/meson/g12a-toacodec.c

-- 
2.24.1

