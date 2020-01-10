Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFEAC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 18:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D672082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 18:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VACd/K5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbgAJSuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 13:50:21 -0500
Received: from mail-wr1-f74.google.com ([209.85.221.74]:37576 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728959AbgAJSuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 13:50:20 -0500
Received: by mail-wr1-f74.google.com with SMTP id z14so1335497wrs.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 10:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=FKzriefzB+sFj+yanYF71dYfNewJn715ajVrF6hXaPc=;
        b=VACd/K5Nu5cG+wiPgp8G70D3txgJ6as16XJETV4f1dp1Hy5yjg0kQ9ngLhhHIUwhoM
         pzh8p508zag5fBT411FlwlZaRTYsuf/SeVRAE+2TViEpyFLBEuBtNu5JKzZoLR6vi3MB
         LMpa/o7hRjUSZeVBcirPG90njevurjfBQ3s3FzGIp+70nW2/H4h09CSRqMjN1UDM7QGT
         XZNzuZn3chMruJozrEMKIZPOBMHW1gttI8uRlN2Z34AIx06SDyzZwwZU5D5nMtDiWBV+
         aQwoPVv2jcQxiVSIf2VkM9tuF0D5u1rwusHwmEqmMVD1Cjdf+aVfQSm2OQP2iMAVNh/X
         dMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=FKzriefzB+sFj+yanYF71dYfNewJn715ajVrF6hXaPc=;
        b=PRzOgFH4Rlejhc+/mtX6+IENhKMvpKg270ZoC8EMCBtegOpSnQZWIi4xq0qw6vwzeW
         tJUXYdnQc30pmL2kWCOonPVHQlK3xsQO1XfBjANHWRU4luLamlwcGpVh5KB/yt0V52PJ
         QIg6pUHrQWn8DOVsI4scGzuL539rImPPGQ1ta1KZ0nPg59qIZKd+PEFUOWhnPd8D1i0N
         CVAq0TGSxToC/AQaEGmc/IUXa2cUrEIAKByNg1t79TKbUYUnQ3CK7PZtIJMX/laGA3lC
         MeSl0gIhI7Yjs1JCChZzkQGp52JGy/cdcE10AdKlgPKDBuDu0Ovw3qFd/avKx+8hOIl2
         2xsg==
X-Gm-Message-State: APjAAAUbXpJ1/EiZo2E8lYk1HE6VQ4HgF7Kg42npkTZMCWBLHZ/sM40H
        TlZZh3U2gabmagYh57k2zq3Mc0WLwA==
X-Google-Smtp-Source: APXvYqwz4O4dhhOP5mop94mtiXO0Vg+27x4HvHv3Tqj5pjl29jIbA+lNW0/EVfbmZi1p/ZOzim78Xpc1UA==
X-Received: by 2002:a5d:534b:: with SMTP id t11mr5061885wrv.120.1578682218808;
 Fri, 10 Jan 2020 10:50:18 -0800 (PST)
Date:   Fri, 10 Jan 2020 19:48:32 +0100
Message-Id: <20200110184834.192636-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH -rcu v2 0/2] kcsan: Improvements to reporting
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improvements to KCSAN data race reporting:
1. Show if access is marked (*_ONCE, atomic, etc.).
2. Rate limit reporting to avoid spamming console.

v2:
* Paul E. McKenney: commit message reword.
* Use jiffies instead of ktime -- we want to avoid calling into any
  further complex libraries, since KCSAN may also detect data races in
  them, and as a result potentially leading to observing corrupt state
  (e.g. here, observing corrupt ktime_t value).


Marco Elver (2):
  kcsan: Show full access type in report
  kcsan: Rate-limit reporting per data races

 kernel/kcsan/core.c   |  15 +++--
 kernel/kcsan/kcsan.h  |   2 +-
 kernel/kcsan/report.c | 151 +++++++++++++++++++++++++++++++++++-------
 lib/Kconfig.kcsan     |  10 +++
 4 files changed, 146 insertions(+), 32 deletions(-)

-- 
2.25.0.rc1.283.g88dfdc4193-goog

