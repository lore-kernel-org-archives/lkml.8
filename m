Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A2BC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBDE621739
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrelZO51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgCCGwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 01:52:47 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37808 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgCCGwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 01:52:47 -0500
Received: by mail-pf1-f195.google.com with SMTP id p14so980265pfn.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 22:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UMVONrKR+b8jzI+5t7WeqTF89uT5m1carSgINXmScQg=;
        b=lrelZO51p6z5wWVvrMuWpeuVX0mrlYsvGCdmltMpxMdhfWVRHfCEuXJZzvJugN96rM
         x7szzUXmfYThPoGsWLOs25vTmvDHSlNUi+oE2wDR3NiV0VuHHPuTdT7d2ZYVPgV+sB3S
         awMWetqHxP7JgPJLME0tzEF/xGgko02k3koqiHDNOg1ihfMRHx1FW1j4PhFaPNnx/YlJ
         mBxgsbX7dGd2mlnsvrohxC9Y5gLutciE9i1VLept+dFpqQdyIk6KGj4oKj+abhtw89oZ
         ukQfU38NK6teNULcz2m0xWrD1Mm2R+dBheVliIKzYbFQ1pLYP37qgxSa5T3TqzRPY6J8
         WIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UMVONrKR+b8jzI+5t7WeqTF89uT5m1carSgINXmScQg=;
        b=cpuzaM8u/XWjLMpSqat++O3towi3+GMSGiCYO7I745vxcWOTwj6Xqn6d3PKY3dz0Nh
         XOzlYMDR0Q2KNlG3KWSkNjagQPBGu6vzlW9qWck6Q477IaYpWMAmRNywvQC38Ezu8pxX
         wRNSMW7IPDbQELvdCW7FlvDS/+ELb5I9U8INqFTDwEzpzzxhAZf5JQByKJ4HM8Z03//o
         DyGeo86ltyHCI2ZrTQ5VIQVup2//MZFtBQG1PBzzgObtNRzA0QauhACMNBRveodi29mo
         +5vDnZyV6gmpnP1tot7mxNetIPjNDNpipXB6fCPEapdI8BcgXvzMeeX5MBatScyFj5TF
         H5sg==
X-Gm-Message-State: ANhLgQ1lj0xA7E7RawDdxeC0d1LTST/CpmHJJRpMKocQj140ZjXuF+JG
        GVjxv2kgiWRwHeR2htt6iJvYszjJ
X-Google-Smtp-Source: ADFU+vuKG+YA083Dv/JMYpPm8AWpjQBFGxIDbaiXi31PIXKMO9/eVyS4Uf4FNI+gAdwkGxsAYo6NZA==
X-Received: by 2002:a63:ed14:: with SMTP id d20mr2631432pgi.267.1583218365926;
        Mon, 02 Mar 2020 22:52:45 -0800 (PST)
Received: from ZB-PF114XEA.360buyad.local ([103.90.76.242])
        by smtp.gmail.com with ESMTPSA id t11sm22780754pgi.15.2020.03.02.22.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 22:52:45 -0800 (PST)
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        zhenzhong.duan@gmail.com
Subject: [PATCH 0/2] Add -Wunused to x86 boot module and fix build warning
Date:   Tue,  3 Mar 2020 14:52:08 +0800
Message-Id: <20200303065210.1279-1-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 1/2] is based on previous discuss in link below
https://lore.kernel.org/patchwork/patch/1175001/#1379873

[PATCH 2/2] drop true/false change per Thomas suggestion.

This two patches is a series, the warning in patch2 will not trigger
without patch1 by default.

Zhenzhong Duan (2):
  x86/boot: Add -Wunused to KBUILD_CFLAGS
  x86/boot/KASLR: Fix unused variable warning

 arch/x86/boot/compressed/Makefile | 2 +-
 arch/x86/boot/compressed/kaslr.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.17.1

