Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45011C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09005206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="aSNejnAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgCQI3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 04:29:03 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46048 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgCQI3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 04:29:02 -0400
Received: by mail-pl1-f195.google.com with SMTP id b22so9290023pls.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 01:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wp49eG+mgt94Sf8OotuurBq01cQ7kmd6Td3YpYWcZnY=;
        b=aSNejnASf5mtNy+7z5yy1Ul5UP6XqQ246NFpAeHvn9PFhcUV8DSwR3FwPahRoqPBMN
         eikDVrHtDyogY6R0VE2RhdQA+Sm6dBjaWmYgJi6XoQg6J3KL25J9Aqxn8b+tyW33efEO
         zM7EXFptBn3W6f9T6t1m/Gcr+ZsMiuLjchNm6PX9FSBGroSdP3NratVkmfl9s78vbUUE
         Rhbgtt0KHQUxFBxccGfIoP3TPvOQVbx3Xh6MHiqHL60CcEqocAvSlJ3Ygy19BpnvTNn+
         WYJ0CdGKX3QUtsoZEeMB51yALEal8/Vuozt17JHdCOom4s8aVqbW3MKnyWXxq72Y9pQe
         cg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wp49eG+mgt94Sf8OotuurBq01cQ7kmd6Td3YpYWcZnY=;
        b=PjOKR0BSmD4EvAqPEFOzGsFKH7thidmhKPzMQMh2dANvzR6cf8jGrH5TmxTL4tu0Ue
         UpXVIL4sBXmjtc0cLD8DQiS4AIGlNZVBXH8eUeDyz3685CH3BJOas+uIiP40U7gzis8L
         nvr2yMgz+XvmqGG3Sn4RcDLqPFfMkm0gGOQ1namuGGhUaFvSgIfU03DG1dbf1ekrGTuH
         fgTT7uUjPyMK8zp2RR+e7mapW75ETN13099+HH9ZZvuep5ab9hfI2G/MmWAif0GGv51z
         8dCWCMZx7C5fFUwuz82zRUpMODdbLEYd3wF+6Nfu12pVqMqUs40oKtYeHaDYtG6JgLc7
         Mnxw==
X-Gm-Message-State: ANhLgQ1FJvhnhmlCOf4AOcidAGGILsy/LkEZSm1KaaH9h8WBw7I82IL6
        humC61LocmtqglKWRHg7a8Rp0w==
X-Google-Smtp-Source: ADFU+vuyGkQvDdcATxD0OMwlD0qwZwgEt45StAjnv6dNA1hgaFMp3uWeOX/5JY4BV3CS1ecWSQo/xQ==
X-Received: by 2002:a17:90a:2503:: with SMTP id j3mr4205128pje.83.1584433739386;
        Tue, 17 Mar 2020 01:28:59 -0700 (PDT)
Received: from starnight.local ([150.116.255.181])
        by smtp.googlemail.com with ESMTPSA id m68sm21095679pjb.0.2020.03.17.01.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 01:28:58 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH 0/2] ALSA: hda/realtek: Enable headset for Acer desktops with ALC662
Date:   Tue, 17 Mar 2020 16:28:05 +0800
Message-Id: <20200317082806.73194-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables the headset on Acer X2660G and N50-600 desktops with
ALC662.

Jian-Hong Pan (2):
  ALSA: hda/realtek - Enable headset mic of Acer X2660G with ALC662
  ALSA: hda/realtek - Enable the headset of Acer N50-600 with ALC662

 sound/pci/hda/patch_realtek.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

-- 
2.25.1

