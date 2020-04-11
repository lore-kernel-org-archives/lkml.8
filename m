Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5F6C2D0EC
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 00:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B1C20936
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 00:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9YsHLT9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgDKAUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 20:20:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34484 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgDKAUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 20:20:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id 65so4092185wrl.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 17:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sRH3JFUeptItyC/byHDQ4iblgMkc70TZ02v71lNx8bU=;
        b=h9YsHLT94sq1B7Gd2m9vfQjDDjwuRywJ6stYTd2AoaMifIgbj8aPHmg3MZc3BoP9P/
         /7aTVdr0M1eFeFPMZPgzkCLcaU3Af5Qk0i3U8sfgF+Jz1nc9aOALSLSTJ5z4cDSX4dq1
         pJwUO/LPz8t8NcEQHLC7LwmlHKHxASvXLrfG3w0nXVEujoAuWmD6VFQdANXtkTlx9Ryr
         08WOcyi/i/5aXV6mT6jV7xD4XhcsMidJAkhTEO4LxHRqeko6zaIS54HUyhxC72JRV0l2
         mz8FwRIXLGvWNpBqpPXVK0BYzsWmkRKct0qN8QKv/C09UbSBe0cwC3mFxwmuvhmYqlKS
         igwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sRH3JFUeptItyC/byHDQ4iblgMkc70TZ02v71lNx8bU=;
        b=lc2zfP9meT1Oi6eEJOIqEgXppTobe1U0UVfntzB7EDkfzbLLczpFB1Uc8UmLDIGBRk
         19nMkioj9q19uu+fO1lbRYKy8MF7DVZyz0tWhT0V9W/EZERZicr5hZVlPMxvf/fJnw6d
         Trp9DTtOhdHzpQWM7leZIj5xuFERPmCx4hBeWQQ+353CI2rJPbN/8qQmf8hJ8BgBwO+X
         NxYb0knDjAM3jGSkiicEPMFXvf9XpoxaQwlGltYqqTqqjK488giku737vxlr9HSzn9yZ
         pqFMwIfC6V0LgsibkibSWTRq+wy/xgzepf7oxn6/fTR0839D02OibvXZnx6gmUCJ44qL
         4SrA==
X-Gm-Message-State: AGi0PuYDBlsZW+bXIWtSJpV65dnwIhqwciCX6WP7r6IJnaY2nNcdv2gv
        N1PoIL4iutfp2f4uPd6A9cMAADMz1Q==
X-Google-Smtp-Source: APiQypJv/An5qeP9XsEFImZSPQ2G5er0IpFLyFLLqbKFf4+MQFDstxbiXVJ03iqQxAJ7vjr2p8J8og==
X-Received: by 2002:a5d:49c7:: with SMTP id t7mr6744639wrs.22.1586564406327;
        Fri, 10 Apr 2020 17:20:06 -0700 (PDT)
Received: from ninjahost.lan (host-2-102-14-153.as13285.net. [2.102.14.153])
        by smtp.gmail.com with ESMTPSA id b191sm5091594wmd.39.2020.04.10.17.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 17:20:05 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH 0/9] Lock warning cleanups
Date:   Sat, 11 Apr 2020 01:19:24 +0100
Message-Id: <20200411001933.10072-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <0/9>
References: <0/9>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds missing annotations to various functions,
that register warnings of context imbalance when built with Sparse tool.
The adds fix the warnings, improve on readability of the code
and give better insight or directive on what the functions are actually
doing.

Jules Irenge (9):
  dm snapshot: Add missing annotation for dm_exception_table_lock() and
    dm_exception_table_unlock()
  mt76: remove unnecessary annotations
  hostap: Add missing annotations for prism2_bss_list_proc_start() and
    prism2_bss_list_proc_stop
  mac80211: Add missing annotation for brcms_rfkill_set_hw_state()
  mac80211: Add missing annotation for brcms_down()
  scsi: libsas: Add missing annotation for sas_ata_qc_issue()
  scsi: bnx2fc: Add missing annotation for bnx2fc_abts_cleanup()
  power: wakeup: Add missing annotation for
    wakeup_sources_stats_seq_start() and wakeup_sources_stats_seq_stop()
  power: wakeup: Add missing annotation for wakeup_sources_read_lock()
    and wakeup_sources_read_unlock()

 drivers/base/power/wakeup.c                                   | 4 ++++
 drivers/md/dm-snap.c                                          | 4 ++++
 .../net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c    | 2 ++
 drivers/net/wireless/intersil/hostap/hostap_proc.c            | 2 ++
 drivers/net/wireless/mediatek/mt76/tx.c                       | 4 +---
 drivers/scsi/bnx2fc/bnx2fc_io.c                               | 1 +
 drivers/scsi/libsas/sas_ata.c                                 | 1 +
 7 files changed, 15 insertions(+), 3 deletions(-)

-- 
2.24.1

