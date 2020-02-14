Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F09C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DDF5222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jvdm696K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389852AbgBNUuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:50:23 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32889 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388189AbgBNUss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:48:48 -0500
Received: by mail-wr1-f68.google.com with SMTP id u6so12513514wrt.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 12:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pbmn+SUdppaytTIm55Vu3EoB2HaBMzvMhJbMSUXtTKU=;
        b=Jvdm696Kke8OXidCOhjDEIxvqAYzTvoeVdU5F9EPjjOBjQTFD0qSiYJH7zf2qB6l8x
         yjYCrTj+Y14x36O8wRTZZ7iogsFwgOm4kpe8vyZ9yZ8tYX/2JuwyKDHpuEXPTlsO79cs
         vKitgdyzQ4snP4qUV/BAgMm6TBhaftNOwnxTnopiH2LxCACTGyVKWFsClowkpsVosdRm
         wd6m3IHT21HsWtVCtrt0HDBQRdVxUAflsp2AJuIJYyT65+tra3UYLLM9auiw8SohFLw7
         zgyzuv98NVUNz8M2P08tuSIXOzLGWCRt7qwl7XGJT9fELHb44rzUiHUkI8+lXZ7mrYvb
         q1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pbmn+SUdppaytTIm55Vu3EoB2HaBMzvMhJbMSUXtTKU=;
        b=qxpD2rNrkxv8uzHQkm3lPXwzElqGTQFHSC+s6OQT1T/ANohbJIG2sdlPRB7kPLeEBi
         OnGT1ch7et8QfXxpIOPMRZYYoMdF1XV9CfIBGa0QElZa1x20AqpnbZ9NvpXMp5tg3ugH
         XpSoQgd64rwOHAZpTgUwg9gf0wrzr4PDvLbRATpR3Xc60g6Pq0zAYeWmARed4/qhsXCx
         9hYQVxj8mud1o/IqN1sKqEcqUsX4323BwJgsblD5EdEEvx3TMSOtklcIrbxwL6182/Ti
         UYApYcXy0usaBELX/YK/Y17jcHBmKJChobAwSBy1jd2KWK6XbvvdHOm8zuBW4Mp3X89W
         SU9A==
X-Gm-Message-State: APjAAAXOERTZXL1rRppFjW12sW0FCsK01HDrmgH6SexcmCB96ycZ73jO
        c2Z4RmRpHmI6NC/B9W/K+alQPUt7otyx
X-Google-Smtp-Source: APXvYqxuzBGsxX/sbOY73BuXd0ktrDqUCD7D2xLl8JYsjTvv/RYU3gKukayEk3szWm99ao6+hHiGXA==
X-Received: by 2002:adf:df0f:: with SMTP id y15mr5737224wrl.26.1581713325249;
        Fri, 14 Feb 2020 12:48:45 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id y12sm8660782wmj.6.2020.02.14.12.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 12:48:44 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Jules Irenge <jbi.octave@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org (open list:ZSMALLOC COMPRESSED SLAB MEMORY ALLOCATOR)
Subject: [PATCH 10/30] mm/zsmalloc: Add missing annotation for migrate_read_lock()
Date:   Fri, 14 Feb 2020 20:47:21 +0000
Message-Id: <20200214204741.94112-11-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214204741.94112-1-jbi.octave@gmail.com>
References: <0/30>
 <20200214204741.94112-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at migrate_read_lock()()

 warning: context imbalance in migrate_read_lock() - wrong count at exit

The root cause is the missing annotation at migrate_read_lock()
Add the missing __acquires(&zspage->lock) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 mm/zsmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 22d17ecfe7df..da70817b4ed8 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1833,7 +1833,7 @@ static void migrate_lock_init(struct zspage *zspage)
 	rwlock_init(&zspage->lock);
 }
 
-static void migrate_read_lock(struct zspage *zspage)
+static void migrate_read_lock(struct zspage *zspage) __acquires(&zspage->lock)
 {
 	read_lock(&zspage->lock);
 }
-- 
2.24.1

