Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EC9C2D0F0
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8B220733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ABb6LM8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbgC3Xpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 19:45:50 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:44736 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbgC3Xpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:45:49 -0400
Received: by mail-wr1-f46.google.com with SMTP id m17so23722912wrw.11;
        Mon, 30 Mar 2020 16:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GDnGHW3qNkgvLRDgu5vu6hawny2amkhzRWQ0FmPc35g=;
        b=ABb6LM8ToMRg6Yrah5JleJW/rhbs3rC5+MnLM5ss4L9Xfh1nULPqhBYzglKJ13bYnM
         GeMRq2+Nae3IN7gnVkDxuLoCOSqaXmP3MXm2UxG5mWjL36W+Ya2eqTCk4NFSwP0k2SYN
         WxuwWXZV1tzZ0bydrILV8rQTb4H1n7CLzuxE1H0slY4VXo+0N8gIVUNCsGhMgxSQ9euT
         k6aFpVUbFO3hYCImRqCGFZOWn8Ua52XZPtsPRe2hRh1FcsqWqJf1lcdnDgyDnU5XjZVz
         7f9PE5gLJi+8GIpORxYMWz6v3qCnGsJZLirxmsBijnz7AqnYcccjMG3WmJDP/+FkHeYi
         ocOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GDnGHW3qNkgvLRDgu5vu6hawny2amkhzRWQ0FmPc35g=;
        b=WUl4lWyd5zoGRFptE/XMXHJlSAii31xUHyrO/lop7KzhF0/bjX/MNEWZgZKsHprbeO
         i5C0o5yQAlGYMPb3rqgcYAZXJ2ZAJLT1c4YDTVk/h5HaNNtxvJsy8iX53LAqTlDWUIex
         DZWo/GAzAjvvAwE7rJysSAMY/0pLnycEvQbPx6dL8AeWUKvfd5FCaYcgh0pODeV9qXww
         yeWN5rOo/G40c6tUfms/PmH7uUDiJoENrWiVafA6mQSitMjpz3UCBgD0a5lfcIMjIsvr
         ZC0z++62nv2iwAFJHHLaZjYEaxtP2Y622pGSzj7Ofuznqspcy5/i5AAWe4OiFnt4ywAK
         xGKw==
X-Gm-Message-State: ANhLgQ1xRIaU//3pyhnr2OVmFMiAwcJdjE6sdFMKotylfDv0995QMaXb
        EjYdatlVPeO+wWTBm1Mza6s=
X-Google-Smtp-Source: ADFU+vsRAJpOrFH+eER9+kJfJgrHjQ2G/YBnZW8feggG/5Lyp88bIurZ3HekKzw9sQpYyAPLoBJuvA==
X-Received: by 2002:a5d:60ca:: with SMTP id x10mr11321086wrt.372.1585611947798;
        Mon, 30 Mar 2020 16:45:47 -0700 (PDT)
Received: from localhost.localdomain (p200300F13710ED00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3710:ed00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id v186sm1392953wme.24.2020.03.30.16.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 16:45:47 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, jbrunet@baylibre.com,
        narmstrong@baylibre.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/2] clk: meson8b: allow the HDMI driver to manage "hdmi_sys"
Date:   Tue, 31 Mar 2020 01:45:33 +0200
Message-Id: <20200330234535.3327513-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "hdmi_sys" clock is driving the HDMI TX controller. The
controller's IP seems to use this clock for example to derived the DDC
clock.

Testing has shown that we can disable this clock without locking up the
system (as long as we don't read the HDMI TX registers while this clock
is disabled - this can't happen as we don't have a driver yet and once
we have one that driver will enable this clock).


Martin Blumenstingl (2):
  clk: meson8b: export the HDMI system clock
  clk: meson: meson8b: make the hdmi_sys clock tree mutable

 drivers/clk/meson/meson8b.c              | 6 +++---
 drivers/clk/meson/meson8b.h              | 1 -
 include/dt-bindings/clock/meson8b-clkc.h | 1 +
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.26.0

