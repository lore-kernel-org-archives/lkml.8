Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A278C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35C220838
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5H461ug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbgCCPg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 10:36:26 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:54024 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgCCPgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 10:36:25 -0500
Received: by mail-wm1-f50.google.com with SMTP id g134so2403555wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 07:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aGKNXO2BWgeom0bCH2tYdg6tsQW8HHocMyiO5+IQE7c=;
        b=L5H461ugdYwSFJRxHcuVQMsbpFEnXWBbPxJ1lWWy9eOQXu/bu2Fx03AsSVVgIUFsbB
         S5PY17IO0kwVsMqlFH55Li3ZGS1liY9lgsAKrMSh5i+OXbA3Sdpb3/c4gpos/YZR24g8
         OpT/wzNKWyRgoYAzqtKJEbfLC/LgIdoeYwSeHXBsJ9NJhr4K3yxlF8jF9jESzPV67UnQ
         /PphD+CZ3JnCVn1v+oJK3x2vqxoRcN2WHz/aSeIPNxaIudk5KKnueU/jEjzVq9LSjoXh
         ZHipfECL86aK6bS7nvll+rAilFDV+Xx/ch7U/Clb94afbkQwLKGFsF9CYbrC4LeiQf+7
         OYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aGKNXO2BWgeom0bCH2tYdg6tsQW8HHocMyiO5+IQE7c=;
        b=tnZBv3p5jRZw6qVCs2h95Q8a2i7U8RJcp95VdnREc8wN7Mp5mhYbUR0PwwfoehuDsx
         huKYpVDk4gHabx/EUnSN0/7ouf3aiEimEd3oroC9K97YLV9NhZMuUhu/G1qhePvpYaDP
         YYOlztL7APXjB0hgaRsW/aG9rD6MpFNDHCV75KAKF+h0FFRyEXMtPCZmEDCsJmAcDRAG
         coljXBURirVNudLiOYgze1iDNYm9VA1TW/oGgPZKd0eMpGiqL+D+4IX5CJesx1dEpTI6
         GzcqTwYTGquZFrbNe78U9BI58DTEYuyr/0WBZakTkErGAE291CqJkOFlQY9JNE27J4NQ
         d3Kw==
X-Gm-Message-State: ANhLgQ37sNN2AURKYmPzyjmnPchfSnWVg0SA0zvcndmrtaRGKAD8gdQD
        kKAMXCx4/mkfdorMbkXOu8jVu2stzmY=
X-Google-Smtp-Source: ADFU+vs3tiVDakQ0yCrCRUzE8Q0TuKVQPnnaQ3CAWxWSdBWj+/DUQ1YVcM4sYB+2I3K9zqI7SCz2eQ==
X-Received: by 2002:a1c:e206:: with SMTP id z6mr4554361wmg.141.1583249783400;
        Tue, 03 Mar 2020 07:36:23 -0800 (PST)
Received: from cosmos.lan (84-114-134-91.cable.dynamic.surfer.at. [84.114.134.91])
        by smtp.gmail.com with ESMTPSA id n8sm32836331wrm.46.2020.03.03.07.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 07:36:22 -0800 (PST)
From:   Christian Lachner <gladiac@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, kailang@realtek.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Christian Lachner <gladiac@gmail.com>
Subject: [PATCH v2 0/1] Fix silent output on Gigabyte X570 Aorus Master
Date:   Tue,  3 Mar 2020 16:36:18 +0100
Message-Id: <20200303153619.24720-1-gladiac@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Gigabyte X570 Aorus Master motherboard with ALC1220 codec
requires a similar workaround for Clevo laptops to enforce the
DAC/mixer connection path. This patch sets up a quirk entry for
that. It was tested by myself on my own hardware for some time
and it works just fine. We should probably rename
ALC1220_FIXUP_CLEVO_P950 at some point as the amount of
non-Clevo hardware needing this workaround is growing.

Christian Lachner (1):
  ALSA: hda/realtek - Fix silent output on Gigabyte X570 Aorus Master

 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)


base-commit: 98d54f81e36ba3bf92172791eba5ca5bd813989b
-- 
2.25.1

