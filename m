Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08DAC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 05:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2B52071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 05:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bpJV80uf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbgAXF6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 00:58:52 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37251 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgAXF6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 00:58:51 -0500
Received: by mail-pl1-f194.google.com with SMTP id c23so334578plz.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 21:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a6uGt5/N9+lkBCnaHaXxegw7D+NxchJWEDJPxPNM+Ws=;
        b=bpJV80uflahsoBYSzCZV7woKjV7EEae5grtsFejl51bziw23eVcwP37oK/jVBOZsGr
         6afg4vrUQZxcZOM0+dI2ayKU75cVnyZY4fh9ZdMlkOYBv4XA31moxhfVQesMgGXRbRfC
         oojUxTGf0aCFKnemYKIf3U4mgS9jSpvGW0mkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a6uGt5/N9+lkBCnaHaXxegw7D+NxchJWEDJPxPNM+Ws=;
        b=kih7nbU4sY2pp5+r7i7Gx4Ofm2uXcxE8Z/WYqb5axa87eM5KOMpkBeBB2bJOXbOTnS
         1xRh/hRiTs+m2z8O8Y88p6gMEw3JgZzXVqK4mc8XrZPAHkP7K/yorQBOl5jykPAmmf+5
         5gk+IkbChiCR0OdX8syLh81JmUFWDhervonLDqDtp6tpOxP+BlRdgbJvuytVg9TCy5uT
         DtmTRzr6eJEli50wRviYPNahcOnsSV2nKhuyuoCJQrPzcIj/dT6nk12HJYPzkfizlQwz
         ShupuAbUBdggeH9gnOjyWhdp9t7HQyLIF3tZS4eSB2Kyl2LY2VJE0Mz02rxoSsIH7ENy
         cvEg==
X-Gm-Message-State: APjAAAWts8eKwHZQ6iABbWYkuP9xxlBugX9PvwKdpbFcTz2FX/jwYL4A
        GhP6Nrsf6YxZIk3OI0qzAKwe5w==
X-Google-Smtp-Source: APXvYqw2E0qPgFwgyg+IzBHIV7Vp7IbyQOU47xL0MOeOApP/ZZ+sBAHc1UN85buZuYLCXg8zgmj3Cw==
X-Received: by 2002:a17:90a:c588:: with SMTP id l8mr1468890pjt.69.1579845530633;
        Thu, 23 Jan 2020 21:58:50 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c184sm4701457pfa.39.2020.01.23.21.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 21:58:50 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v3 0/4] Fix alarmtimer suspend failure
Date:   Thu, 23 Jan 2020 21:58:45 -0800
Message-Id: <20200124055849.154411-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We recently ran into a suspend problem where the alarmtimer platform
driver's suspend function fails because the RTC that it's trying
to program is already suspended. This patch series fixes that problem
by making the platform device a child of the RTC.

The last two patches are non-critical changes to how we do the wakeup
and some code cleanup.

Changes from v2:
 * Picked up review tags from Doug
 * Removed extra space between - and 1 on first patch
 * Split last patch into two

Changes from v1:
 * Dropped first patch that got picked up
 * Reworked second patch to autogenerate the device id and use IS_ERR()

Stephen Boyd (4):
  alarmtimer: Make alarmtimer platform device child of RTC device
  alarmtimer: Use wakeup source from alarmtimer platform device
  alarmtimer: Make alarmtimer_get_rtcdev() a stub when
    CONFIG_RTC_CLASS=n
  alarmtimer: Update alarmtimer_get_rtcdev() docs to reflect reality

 include/linux/alarmtimer.h |  4 ++++
 kernel/time/alarmtimer.c   | 40 +++++++++++++-------------------------
 2 files changed, 17 insertions(+), 27 deletions(-)


base-commit: bc80e6ad8ee12b0ee6c7d05faf1ebd3f2fb8f1e5
-- 
Sent by a computer, using git, on the internet

