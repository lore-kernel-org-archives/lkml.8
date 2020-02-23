Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3037C35675
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 23:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CB0208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 23:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Inl8ZX2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbgBWXSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 18:18:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41873 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbgBWXSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 18:18:20 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so8237478wrw.8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 15:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kaCoWQQpn+j8uvyw/vMo9mENl0qa9cM1FVrK9Szu/ak=;
        b=Inl8ZX2efCpl7XykDudwdLzRAkPHwpBAP9HwzNvbyVid8ien2HR5e1oaE1p4rqeRdN
         Ynz6W1yd+IPHshnCWe7Q50DiM4PojZ/yPaJJmz9Cn7ioupC9BdgF76X0TWwf7bYTxlh1
         BH0Q2uAxGM5HThpQ6qiOOI64RgHbSh2+nxDssDHXkPeJ9CgnhBEIJbqoGc6QpHCBerhD
         0UpsQe6owWz7Q0cOi4eYAzZ3Ql5HaV+uMtbbYWbvqNEPnizsOECdveDl3bQZZkmDHsJq
         Iqo865UwApuiAr5s9Eu1AwoTJDjCy8m/bjwhS88K3430nZrzwuji31FibCqM38a2/pwR
         lF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kaCoWQQpn+j8uvyw/vMo9mENl0qa9cM1FVrK9Szu/ak=;
        b=mT8VlnODqpTCaCxAGDeJ0GjoFAlFbmiXxtnk841r+KZmcfkOTv+IOAzrTIupmqoGaN
         MPLB806BM9AoNRoIp/VYICSBDPYiRvkHX5PJxN/oxyjL8s9BcNLhI/vg4jaisiG9KhJg
         DkaTPH+v/4megG2zPmfmn84hiAzX2ZorXwei1DZzncC93o8gx6e3eKQSUYwjTin9mDPF
         rY0wRPcq9c3VOliHIhEeyI2wJWrLe7BKqqHoD36fQtXoFxkGv7Up3EW5utNEWOX8TZKg
         VHG0bscCIENWcKmPlX+GK1l1JRjA93bFaL8ffRTTkLcVEpqxEN8E8gpzbK9QVjoDr4ex
         ldMw==
X-Gm-Message-State: APjAAAXQ7RxEq1fxcxYipu41miTOx6ktQb4lP/FDNn1FTfoGixVNTdI4
        oiv9p7Xr0mVEy42HbZEkT8V+L+WpUo+u
X-Google-Smtp-Source: APXvYqwNSt+N5xMjtT90GyK1JRD7pbBkhl07kRUByi6TwKYIa4Taet7pmM4ZyKhQWWf8Y1ljJCfOCw==
X-Received: by 2002:adf:f9cb:: with SMTP id w11mr9021833wrr.383.1582499898333;
        Sun, 23 Feb 2020 15:18:18 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id q6sm8968203wrf.67.2020.02.23.15.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 15:18:17 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     jbi.octave@gmail.com, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org (open list:ZSMALLOC COMPRESSED SLAB MEMORY ALLOCATOR)
Subject: [PATCH 20/30] mm/zsmalloc: Add missing annotation for migrate_write_unlock()
Date:   Sun, 23 Feb 2020 23:17:01 +0000
Message-Id: <20200223231711.157699-21-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200223231711.157699-1-jbi.octave@gmail.com>
References: <0/30>
 <20200223231711.157699-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at migrate_write_unlock()
warning: context imbalance in migrate_write_unlock() - unexpected unlock
The root cause is the missing annotation at migrate_write_unlock()
Add the missing __releases(&zspage->lock)

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 mm/zsmalloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 7ec69a1140cf..cb5541d06823 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1852,6 +1852,7 @@ static void migrate_write_lock(struct zspage *zspage)
 }
 
 static void migrate_write_unlock(struct zspage *zspage)
+	__releases(&zspage->lock)
 {
 	write_unlock(&zspage->lock);
 }
-- 
2.24.1

