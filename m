Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1D7C2D0EE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E8220732
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpq7LsqJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbgC3QJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 12:09:54 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]:40058 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbgC3QJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 12:09:53 -0400
Received: by mail-qk1-f182.google.com with SMTP id l25so19567434qki.7;
        Mon, 30 Mar 2020 09:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UtnZua9sH2Iz7Lmw4x/rdjkPSeBWQLU1aJEbCn/TIY4=;
        b=bpq7LsqJ6UNpk2gk9z/Tl5PrVf64JY3bOJ3Di3Vg97FIDygLrz9nK6Re0fdMXazZ/F
         /Beo8zSsS2BXoyBYZNu7q7BPgBTyt50DWidVdeYzEcDjuOm3vY1+2e2yn4Fz4pDvOkL3
         qFy+kqIEqFDzZ3UY6tNcSpKKAdMgHGShtno8lRa1Aon8joF8bE4L8U/jWa87OopMVxMB
         s1BY0r5hOMQNlZYVEyFIRYunxexRpqrPzvrcTal6T+FcFEQkcVRfac1hZV7VaKXzVItQ
         hTNT24N/FOcfA2USXvDPc3RAlHF5UnoClWLLgWHSlPgs3bE0zInO6J8ieXT/867NfS2t
         hPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UtnZua9sH2Iz7Lmw4x/rdjkPSeBWQLU1aJEbCn/TIY4=;
        b=kQdaC5u3V6p0UShiBqgAkBSQ3safHT26i/FkHk2F8+q5e6uKInuvqxzzuZa0RYARk2
         3cnHR+HgyObhgVq6aL41MipRRzxMUAn4taRz46ml3nWVtO790G6wrnucy3L4+QrmImh3
         XVORHFYOZVEV48mdXT0iMVTzlZD6c1FYyVGv7ObQb2vWbFW3r5KaxHDLJvsNyJr/uoI+
         7n9CBMSYYkZ83jp7R8PPq39o4rI2CHGF6WlT+7qN1vU5fO6e654LGURjOtadAx1eKo7J
         zfQuckC3icbzLjTKi9G1jqGfO0gNcav+7IogX0Z4bhqZfRuf1hQSnqfTWCtR4es8IxO/
         eJeg==
X-Gm-Message-State: ANhLgQ02+tD/JvVznnZsVE9z3CXYz8tD49Bia+EZMh5Q0+tv1A1sZOJl
        UvJafW+9wGtydzSdrhS2bHxrAMysBr386Q==
X-Google-Smtp-Source: ADFU+vsIf6Rq8zIGRIGqrFGZj1stu4iXXpPIMDoOLgUuA+FCsvZIsHP9TqFltRu78UbXw6AiHhneeg==
X-Received: by 2002:a37:8044:: with SMTP id b65mr727931qkd.238.1585584592639;
        Mon, 30 Mar 2020 09:09:52 -0700 (PDT)
Received: from stingray.lan (pool-173-76-255-234.bstnma.fios.verizon.net. [173.76.255.234])
        by smtp.gmail.com with ESMTPSA id z18sm11789091qtz.77.2020.03.30.09.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 09:09:52 -0700 (PDT)
From:   Thomas Hebb <tommyhebb@gmail.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Thomas Hebb <tommyhebb@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hui Wang <hui.wang@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Sergey Bostandzhyan <jin@mediatomb.cc>,
        Takashi Iwai <tiwai@suse.com>,
        Tomas Espeleta <tomas.espeleta@gmail.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 0/3] Properly fix headphone noise on the XPS 13 and other ALC256 devices
Date:   Mon, 30 Mar 2020 12:09:36 -0400
Message-Id: <cover.1585584498.git.tommyhebb@gmail.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The root cause of various pervasive audio problems on the XPS 13
9350/9360, mostly relating to the headphone jack, turns out to be an
undocumented feature of the ALC256 and similar codecs that routes audio
along paths not exposed in the HDA node graph. The best we've had so far
to configure this feature is magic numbers provided by Realtek, none of
which have fully fixed all issues.

This series documents the "PC Beep Hidden Register", which controls the
feature and which I've reverse engineered using black box techniques,
and uses my findings to hopefully fix the headphone issues on my XPS 13
once and for all.

Changes in v2:
- Change fixed value from 0x4727 to 0x5757, which should behave
  identically, on advice from Kailang.

Thomas Hebb (3):
  ALSA: doc: Document PC Beep Hidden Register on Realtek ALC256
  ALSA: hda/realtek - Set principled PC Beep configuration for ALC256
  ALSA: hda/realtek - Remove now-unnecessary XPS 13 headphone noise
    fixups

 Documentation/sound/hd-audio/index.rst        |   1 +
 Documentation/sound/hd-audio/models.rst       |   2 -
 .../sound/hd-audio/realtek-pc-beep.rst        | 129 ++++++++++++++++++
 sound/pci/hda/patch_realtek.c                 |  49 ++-----
 4 files changed, 139 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/sound/hd-audio/realtek-pc-beep.rst

-- 
2.25.2

