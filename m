Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3888C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C976C2465A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="2Spclnwq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgAVKE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 05:04:57 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:34190 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgAVKE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:04:56 -0500
Received: by mail-wm1-f44.google.com with SMTP id s144so1213465wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 02:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xr55sisUQJBKj6Q4LrYEYaq2XUN1tVNpifr1uUk54Rc=;
        b=2SpclnwqwF+ZtOGLn5/Pzqi457wTIzOMugjwrvqe2e6PJR797j6ImTx5WFNp7pJf+D
         0oCYEuyjwuXAOyrBfb48iDlGtYXJ9iOcGW5YYffBgwRYC3gqYgczwyagZCk8Du3/RZRe
         sVU4/NdlRN4MU59vussJBc4x1Wxp+5eXR12w1xgIxs+sZbBjapfCxeJOd659ECntnogA
         u8/25V+tAYwHIh2eXheHPeMrHlgoEqotUdWOHcpexUj1fjvxMfVZXxE0C6H+AXpm4AWf
         83HNZuCMrZVH9ziWGen75wPXIo5Zg+UUTeq6R7TbJBbiJ4BcYL5FzY3amnjSAs80R+iQ
         ONPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xr55sisUQJBKj6Q4LrYEYaq2XUN1tVNpifr1uUk54Rc=;
        b=epsrImrmFbN+pwzN3hq631VubUYu+8AT8eYlNyuGjOh+4FinZU+U1hCLgCzZryjSKy
         Z7J9SmweVYB1vt4blf4cirMmlQf5fPkQZqWJKehbI7FzpGgt6Xojafrcn+he7GR9B693
         qrk+/26nWsnpjQIpz7sgFVGcaONsAt9/S3xljxfWEGN+34z/v0QQg5h0ZcYSHOxv+/bO
         lT8K0kXhrSMO0l8L7Ung0xEe3NT1EjqFRJ4xWSEdZqwuwEAra9TujrQyeQk3k+ovJKou
         gYQ0038pNbkgfMFz9BjfbpwPF4vgmqVlIRBoMgwDGInfEaTulkDv9WhCv9u1k1+ZxHGl
         r7fg==
X-Gm-Message-State: APjAAAVsaVNBav4VPLeC++TVknXfEQmbtLhC+4qe9QgsFOKm6XuDzsB3
        n/xZBrmNqIFQoqal4KkMpZOLQQ==
X-Google-Smtp-Source: APXvYqxz2tZXmYV+E9Ld+AOXUw6DT+T8VYNXacbGMy0FhKPCjM0ksmIp44lJOlHnO0vFIuRXZGibVg==
X-Received: by 2002:a1c:3b0a:: with SMTP id i10mr2197195wma.177.1579687494505;
        Wed, 22 Jan 2020 02:04:54 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id l3sm52237648wrt.29.2020.01.22.02.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 02:04:53 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, linux-clk@vger.kernel.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] clk: meson: gxbb: audio clock updates
Date:   Wed, 22 Jan 2020 11:04:48 +0100
Message-Id: <20200122100451.2443153-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patcheset provides updates related to the audio peripheral clocks
It adds the peripheral clock required by the internal audio dac
and reorganize the AIU clocks into a hierarchy to better reflect the
behavior of the SoC.

Jerome Brunet (3):
  dt-bindings: clk: meson: add the gxl internal dac gate
  clk: meson: gxbb: add the gxl internal dac gate
  clk: meson: gxbb: set audio output clock hierarchy

 drivers/clk/meson/gxbb.c              | 21 +++++++++++++--------
 drivers/clk/meson/gxbb.h              |  2 +-
 include/dt-bindings/clock/gxbb-clkc.h |  1 +
 3 files changed, 15 insertions(+), 9 deletions(-)

-- 
2.24.1

