Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048DAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 14:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCAEF20720
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 14:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="IlrH0EMh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgA0Oh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 09:37:58 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32843 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgA0Oh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 09:37:57 -0500
Received: by mail-wr1-f66.google.com with SMTP id b6so11622027wrq.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 06:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZHyXRET7oJsuqnVX/GurjyjcgNsoz/aIPSbvMyTMHuA=;
        b=IlrH0EMhFqQkHjVQl0CbCFKoqWp4As+HQYJBDbqACq8SFqMx0ZP8tZ2mky2ub72I0p
         tGg67QyZM99HayQpHJWGoJmITpKGdJbX/xMmy7/wErd9YVsYw1M0O0QA6q3Opt6WHQn+
         qj16erT0Z9aeqOZdDAJQid2LNVwkrV/AFyx1q5/cFvzpCC9qfbgxZitmc8cjvBQMutog
         HhHpIlHU5A5h+y3v9UhKhBnVgaS+7X8JJX3zl4oMuaaPsEo7uiCEhpjxSQA+uAVAkZ8r
         MCHAqRspBsekh6AYQgan/5CkDygPux8pjOmKZ5eH3PJfjYMSdjoWXCMPZ+IMaYoSZo5I
         NuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZHyXRET7oJsuqnVX/GurjyjcgNsoz/aIPSbvMyTMHuA=;
        b=fkSV75eRWaGNrWWmZcQolEsmbEv9GDZFGKknJLUooROiTe1r9W3Luad8JqBPZpySeZ
         4bdmtcQAJWcPRssbMr/JBHNaK1Z0nK+iz1lCjVkz3u0Lqs1XvF/nmP/l5MkAkL/ND2w6
         fjl39sY87F+yizspw153igyNTUeGOLee+wkvi6NRhRYqOkjrcS6e4hDkzcfWZIuwW9/v
         DpWZIJ3Vq1p/flRZ8QZGIIYyISpGTFTqBBhVKlxDaNLmOVg5oMH1iB3MJdn3IkkUzqIB
         LhvtdHuuA4aRK5o9uzfEAyl0BwWk7pj3NH8Z7fQGpoEfgpfr+5F6TS4BemrqqxQiVTXv
         bkWQ==
X-Gm-Message-State: APjAAAX87T3ZaB+eeO+VlbM586x/X0uHRODDAM03WOypfJKgwjK7FxHu
        cSOOj+ou4XK/3JPCcSyHWVKdlESdgig=
X-Google-Smtp-Source: APXvYqwrfiyewFrvJ/hBbEuXFQIJQ4Tv3b97ecGooiZyZLNExz3odYJzwGXRbWmBvKrJHCE92Wx7XQ==
X-Received: by 2002:a5d:6652:: with SMTP id f18mr22900611wrw.246.1580135875619;
        Mon, 27 Jan 2020 06:37:55 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s65sm19721659wmf.48.2020.01.27.06.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 06:37:54 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH-next] MAINTERNERS: Correct path to timens source
Date:   Mon, 27 Jan 2020 14:37:48 +0000
Message-Id: <20200127143748.268515-1-dima@arista.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to reviews, Time Namespace source was moved
kernel/time_namespace.c => kernel/time/namespace.c
between patchset versions, while the path in MAINTERNERS file wasn't
adjusted properly.

Correct it, so get_maintainer.pl produces a correct emails list once
again.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5ea787e0da0e..d2a297f28b96 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13353,7 +13353,7 @@ S:	Maintained
 F:	fs/timerfd.c
 F:	include/linux/timer*
 F:	include/linux/time_namespace.h
-F:	kernel/time_namespace.c
+F:	kernel/time/namespace.c
 F:	kernel/time/*timer*
 
 POWER MANAGEMENT CORE
-- 
2.25.0

