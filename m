Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8AAC2D0EB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 07:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21482073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 07:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/okOLdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbgC3Hak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 03:30:40 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]:41739 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbgC3Hak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 03:30:40 -0400
Received: by mail-qk1-f179.google.com with SMTP id q188so17934891qke.8;
        Mon, 30 Mar 2020 00:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KgOVarC5Gb1tAd5I3fGYDa2zpN7MJ6Uuz52KOLYGanQ=;
        b=L/okOLdH86baVZyZ0NOr+A4oqr/SPdXBmtulKV97oshRvL1hxv4SP7BtkYpmFWi5T9
         pytvP+qG2XqPxzyXXhRmbb0IjvZwy8vdBAHJ0Udb7vGbkCb+R40R18sJepqSElxnMw0W
         daoMppxVRNM84Ngj/sljn4j/IIMjWw6WNdA+0jiByGexLvcEqpAitq98Sf0oP+KjI2/f
         usySMgc6wYvubeQpoAuRgAV0Jkdl7/nPnofoZuEGP+5cVIFDg8f4PnNLppe0oKTIGhlX
         DlDfWfecVsmSjBgDR12yQxwBkA+9KJ/JFG2gPR6lvUra1l4Gyf6C8vt/Pyn3PI5pU41f
         0HwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KgOVarC5Gb1tAd5I3fGYDa2zpN7MJ6Uuz52KOLYGanQ=;
        b=mXZLoeR/+eJTk3Rsl1ndAHdtxRQIyhjuvsexp1azZfqwfesJSQPMh16dAndflX7vLG
         GdiSncMLdHLKeRsI++/TWL/oPaG5+dTBAhHKEMRupnfCBzF58146LRJ45R712CxWCaIy
         9edTAJLYpSPogatT74vxHumm5g4Imlb6vmDUDp1FsFLvI3xcVEZokzYJOMQUivEAIR52
         6fAplZ12a5i/8n6orRdfPmlKyvpUzEJlhMvQQJFZhKf08FDcNDTFKC4JFNPmchMdM0Dg
         PXim9q75skZANDoEkXuQqRbR+ZtddKMt7QaR9kia8qqrLocQomfYGITCV1HAXO85L8iT
         QHGQ==
X-Gm-Message-State: ANhLgQ17+3A7zuGvZoHcIMaGiT+WBJk2x6rUtg8YrjSefS8r9ZHX4UuR
        1AoQPYhli/09yYifwVVjLsY=
X-Google-Smtp-Source: ADFU+vssqFPLcGdnO2Q89jK3dr/TohKRvbQBzjgTN5nI6NDUSGI7SDZRmc1O+sT+H7rwonU+43a19A==
X-Received: by 2002:a37:79c6:: with SMTP id u189mr10225793qkc.96.1585553438353;
        Mon, 30 Mar 2020 00:30:38 -0700 (PDT)
Received: from stingray.lan (pool-173-76-255-234.bstnma.fios.verizon.net. [173.76.255.234])
        by smtp.gmail.com with ESMTPSA id n63sm10078499qka.80.2020.03.30.00.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 00:30:37 -0700 (PDT)
From:   Thomas Hebb <tommyhebb@gmail.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.or
Cc:     Kailang Yang <kailang@realtek.com>,
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Properly fix headphone noise on the XPS 13 and other ALC256 devices
Date:   Mon, 30 Mar 2020 03:30:29 -0400
Message-Id: <cover.1585553414.git.tommyhebb@gmail.com>
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

