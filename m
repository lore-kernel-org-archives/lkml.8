Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42448C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E222076A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VWHRwE6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgCZQJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:09:04 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:39207 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgCZQJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 12:09:03 -0400
Received: by mail-wr1-f42.google.com with SMTP id p10so8489570wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 09:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6pZtO6xc9Ub+dNzgEsbskEWr5UgKhTn4yKFMf+FrJ2k=;
        b=VWHRwE6eWFq4R42rHxzTR+6QgRdLxFu5T6V+gEVyCN08IQCK5J5Or7jp5+GBq2F+Li
         WoA+QAQe5okTYE6YSop/mrIL0z5DYifVJUnloXtD09xuqG0rw7+XazvhW80+peKcpIYI
         NdH4+I/xuzblyIdYHxEaJMYbo65J7qSTQ6oLWLK/6R8cx2VDdrfUAY3QGi75GqO0567G
         9ggonFzo2SX5dOOX2hN9TYKyAQYvmly7I9AEcuQFwn/O4Uo/vMkPUdg5ANwuZbH5h4Uv
         ci4AUM0hbokqDc7rVkbMOVwt5i6YBdd84x4OH7VatDPh9HtnBefjSII3SyxybCeTOUWM
         DXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6pZtO6xc9Ub+dNzgEsbskEWr5UgKhTn4yKFMf+FrJ2k=;
        b=lIz1fsJhH5DPjyiiBW4JSLW4m/bryOriGfZCEkl1LHxpMA3oxvkp98htbYwDqxAmm5
         S9BofDY2CnA6R+e2SeUxWlXZzHfMwrn5rYYgJpYPptJeZmmmRN8kLkGVi0RETMilEy8k
         GBY66fCcGJVInjhuTkEBYC7ZF+hYqvLvgEMI98OEJBJovRuYTDXpAw/KEg77N8szDhyq
         qSEdAq8VdTnOg08veUn/q2ypVcZ/ICCp29x5b32Nio1/3vyCr1Ho7O96xlZfJNK3VpOH
         y3E89PpzSzODQauSDg+KRIbWJJQ/RGPoiv2KjNH49IQ5auihcCT1pRiEJEjbmNsTmKy6
         1dcQ==
X-Gm-Message-State: ANhLgQ0qF893+BXHPeoVdeUEL1b0NL3UmYtPVr7FMlf4nhHNATmLV1M2
        +Ht1vuZdL4kT2xLPCyIcs4+goA==
X-Google-Smtp-Source: ADFU+vs9oSnFf7w8PXHfbPY+V9oo/HHkchpoIhj6Hkk+PDZgRu+V8yGfgjqVDQ1h0mUrOtzm5gK0Tg==
X-Received: by 2002:adf:a3db:: with SMTP id m27mr10361849wrb.350.1585238941470;
        Thu, 26 Mar 2020 09:09:01 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id z188sm4093511wme.46.2020.03.26.09.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 09:09:00 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/2] arm64: dts: meson-g12: usb DT fixes
Date:   Thu, 26 Mar 2020 17:08:55 +0100
Message-Id: <20200326160857.11929-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Misc USB DT fixes for G12A.

Neil Armstrong (2):
  arm64: dts: meson-g12b-ugoos-am6: fix usb vbus-supply
  arm64: dts: meson-g12-common: fix dwc2 clock names

 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi    | 2 +-
 arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.22.0

