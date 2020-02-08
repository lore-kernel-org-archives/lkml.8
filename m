Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9CFC35250
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 14:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2634217BA
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 14:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsJZtNGd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgBHOKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 09:10:37 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:32991 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbgBHOKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 09:10:36 -0500
Received: by mail-oi1-f195.google.com with SMTP id q81so4970723oig.0;
        Sat, 08 Feb 2020 06:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vng+4h19JerkC+XuBG4vryvn9zwYhKsMZJpIzjBBzWI=;
        b=XsJZtNGdbeT0FFKAI9CoH+sIrwoJH77B3Bi2G9MrC75ezGFzphFzWpJB8l7fto+jkY
         ti4aH8mN3ph5duwYi8ZXLZgrOcEwEm/pnpvcVNM2oIHIN4GoR+MseI1Z43MS5A90wvYk
         WhmjM1LTtbqfPWomThgFDV2Xk/6iY6pZtqJ6d2/nAbDKZC/le1ttd2XFjhaoGfr4hSnG
         q6tRGv3D5zgaCxGDBX+ILbPZ6Sv1KJ+4JqY1H2Vfy/2ZMgy4xmMrG6UfEMG5d5K7RsSt
         j1pD1oYt3dMUo0T1qtVSO604Isak18LSXjreMLwtYsdNfntFfyrFxSF6z6OsbKYTSHRd
         duSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vng+4h19JerkC+XuBG4vryvn9zwYhKsMZJpIzjBBzWI=;
        b=Hucy0JBatTF+HdQbnwF2KkS1JMQFAm/iTB+s6oiNF36hMAKc5V38FeUWeTJyy++6zb
         jbL5aYoDFpsn61PYYuxVobKUYX0Q22H9rcctA00nDjNSxXjaLOhWAVosv4Hrb31FDWEX
         OsQcSylN5DhPrijN3KRdlVeAJ9xoYmou16yjcV0FZfYNQdK0/57Avvuq1lK2JNqMMs7Z
         WFPeHKRWs9F9kDPDhRGR0E1uvex8Ngr5jhGUevQhir0ASOfOoB7KJCeehYGOpB2gw/Ex
         T0icy7XMzQ4iN46LoRVdYDTHdugaOB+HKik25l12JRk1hJwAzFbDDiXSsYtAKCfQi6mW
         gslQ==
X-Gm-Message-State: APjAAAUvrpbUQmfJwFgiGLrpphSPemzgw2zX5k+U4o43S0Fy+2fn1Qg3
        C2P6WAyYNasz1JqTGuEM4Do=
X-Google-Smtp-Source: APXvYqxYW/YPl5x9TCiP4KFN2AFyyxyvirZjqYX7m03AvaL4o+d3P9wjLlptvi9wpja+YZsjuAY07A==
X-Received: by 2002:aca:1a10:: with SMTP id a16mr5591118oia.9.1581171035472;
        Sat, 08 Feb 2020 06:10:35 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id k201sm353074oih.43.2020.02.08.06.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2020 06:10:35 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] s390/time: Fix clk type in get_tod_clock
Date:   Sat,  8 Feb 2020 07:08:59 -0700
Message-Id: <20200208140858.47970-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

In file included from ../arch/s390/boot/startup.c:3:
In file included from ../include/linux/elf.h:5:
In file included from ../arch/s390/include/asm/elf.h:132:
In file included from ../include/linux/compat.h:10:
In file included from ../include/linux/time.h:74:
In file included from ../include/linux/time32.h:13:
In file included from ../include/linux/timex.h:65:
../arch/s390/include/asm/timex.h:160:20: warning: passing 'unsigned char
[16]' to parameter of type 'char *' converts between pointers to integer
types with different sign [-Wpointer-sign]
        get_tod_clock_ext(clk);
                          ^~~
../arch/s390/include/asm/timex.h:149:44: note: passing argument to
parameter 'clk' here
static inline void get_tod_clock_ext(char *clk)
                                           ^

Change clk's type to just be char so that it matches what happens in
get_tod_clock_ext.

Fixes: 57b28f66316d ("[S390] s390_hypfs: Add new attributes")
Link: https://github.com/ClangBuiltLinux/linux/issues/861
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

Alternatively, changing the clk type in get_tod_clock_ext to unsigned
which is what it was in the early 2000s.

 arch/s390/include/asm/timex.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/timex.h b/arch/s390/include/asm/timex.h
index 670f14a228e5..6bf3a45ccfec 100644
--- a/arch/s390/include/asm/timex.h
+++ b/arch/s390/include/asm/timex.h
@@ -155,7 +155,7 @@ static inline void get_tod_clock_ext(char *clk)
 
 static inline unsigned long long get_tod_clock(void)
 {
-	unsigned char clk[STORE_CLOCK_EXT_SIZE];
+	char clk[STORE_CLOCK_EXT_SIZE];
 
 	get_tod_clock_ext(clk);
 	return *((unsigned long long *)&clk[1]);
-- 
2.25.0

