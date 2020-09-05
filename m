Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EF1C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 13:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7570E2072D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 13:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3HBQ0vt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgIENU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 09:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbgIENUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 09:20:19 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4CEC061244
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 06:20:19 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id m8so463654pgi.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 06:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tgAiG+t/6nOuNKTWGQYGI/rg919QIvV2XBuVNxVNwks=;
        b=B3HBQ0vtDDhkmO9hI2gFrc5ihSgl4RE8pIlZNylCI+jJ78LSpRPD1N/hsIGSC4Z9hx
         FyUX2Tnm7ecf4OSJuYlbKnjMeIVZSAiLMQOUjzX/12hI5ym2lWdcqiGXClNje0udE2SW
         +USqph9cyAEhh0szf5iHyFtsG4DeuiWX6rZAb9bVDHjYYsq8iLUx1X0Hx3tzQNlht2aR
         u/pq7gSugJlBs2/41y2B2/NE2bELbZMWWhWJQSUcfr76FmkGYxMIiPscutQeaXWXQVlR
         Z//Ym80usq61rGHEk3C+XXJnzHlPDaXgwcK4QyHPKYG1L0Ww3sJmh4PN80i8JxVnFeRo
         p+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tgAiG+t/6nOuNKTWGQYGI/rg919QIvV2XBuVNxVNwks=;
        b=CU53EgOESnYxRQl3QLnrp9xBj9C5CxWdn82x0qZBGF9xsusLK6o+hflGzWtBWp7miN
         4gyhaP4G6McNu52IxW2B87jggpCMSI41RA2L/y4qLlanYHtru4EdlwsHuMwB8o+8JQwp
         aowEkC02GsODv2+BYXkdjqEw1PcIRlU/lS0zUGRUyi3rvQegaOCzDIK+JbF2Rj4gpQRO
         Wh/f8hPEFQahrt02QNhQ/+XAKZ7qEWWpA1a46Jyunf4VyCm+Kg1GkKcQMVyhwpELfHVb
         eqyEiOWlHTE46eOBq7xwXj5LpNsoX39pzYIbqALHxXykW0E4TiORMfwoevuQH6AYFChi
         p4GQ==
X-Gm-Message-State: AOAM530nP9UiHDR1ccTdScrWAr4HzWRqVLJaLyLYRXrkioGVny6u8Fn2
        npdlZ6S7UbyplIp3HbwwENxmSXcNceDnFg==
X-Google-Smtp-Source: ABdhPJyz9eayZr4GdKsD1jzVytjQzRRdwJXEuHPcbNjJeCN1T2CLwTUIILgICQPoIL7yLL4X5245Ow==
X-Received: by 2002:a62:7f8d:: with SMTP id a135mr12895171pfd.43.1599312017998;
        Sat, 05 Sep 2020 06:20:17 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id r144sm10512566pfc.63.2020.09.05.06.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 06:20:17 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        openrisc@lists.librecores.org
Subject: [PATCH v2 3/3] openrisc: Fix issue with get_user for 64-bit values
Date:   Sat,  5 Sep 2020 22:19:35 +0900
Message-Id: <20200905131935.972386-4-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200905131935.972386-1-shorne@gmail.com>
References: <20200905131935.972386-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A build failure was raised by kbuild with the following error.

    drivers/android/binder.c: Assembler messages:
    drivers/android/binder.c:3861: Error: unrecognized keyword/register name `l.lwz ?ap,4(r24)'
    drivers/android/binder.c:3866: Error: unrecognized keyword/register name `l.addi ?ap,r0,0'

The issue is with 64-bit get_user() calls on openrisc.  I traced this to
a problem where in the internally in the get_user macros there is a cast
to long __gu_val this causes GCC to think the get_user call is 32-bit.
This binder code is really long and GCC allocates register r30, which
triggers the issue. The 64-bit get_user asm tries to get the 64-bit pair
register, which for r30 overflows the general register names and returns
the dummy register ?ap.

The fix is to just remove the assignment to the 32-bit temporary
variable __gu_val.

Link: https://lore.kernel.org/lkml/202008200453.ohnhqkjQ%25lkp@intel.com/
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/uaccess.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/openrisc/include/asm/uaccess.h b/arch/openrisc/include/asm/uaccess.h
index f0390211236b..4a8976dda1a5 100644
--- a/arch/openrisc/include/asm/uaccess.h
+++ b/arch/openrisc/include/asm/uaccess.h
@@ -165,19 +165,19 @@ struct __large_struct {
 
 #define __get_user_nocheck(x, ptr, size)			\
 ({								\
-	long __gu_err, __gu_val;				\
-	__get_user_size(__gu_val, (ptr), (size), __gu_err);	\
-	(x) = (__force __typeof__(*(ptr)))__gu_val;		\
+	long __gu_err;						\
+	__get_user_size((x), (ptr), (size), __gu_err);		\
 	__gu_err;						\
 })
 
 #define __get_user_check(x, ptr, size)					\
 ({									\
-	long __gu_err = -EFAULT, __gu_val = 0;				\
+	long __gu_err = -EFAULT;					\
 	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
-	if (access_ok(__gu_addr, size))			\
-		__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
-	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
+	if (access_ok(__gu_addr, size))					\
+		__get_user_size((x), __gu_addr, (size), __gu_err);	\
+	else								\
+		(x) = 0;						\
 	__gu_err;							\
 })
 
@@ -191,7 +191,7 @@ do {									\
 	case 2: __get_user_asm(x, ptr, retval, "l.lhz"); break;		\
 	case 4: __get_user_asm(x, ptr, retval, "l.lwz"); break;		\
 	case 8: __get_user_asm2(x, ptr, retval); break;			\
-	default: (x) = __get_user_bad();				\
+	default: (x) = (__typeof__(x)) __get_user_bad();		\
 	}								\
 } while (0)
 
-- 
2.26.2

