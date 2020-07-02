Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4945AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2760C20899
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcDxMf0I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgGBXLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 19:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgGBXLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 19:11:16 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFDAC08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 16:11:15 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id n2so16733119edr.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 16:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3eElLZDK+73Sru8uMZkWstDbXOPX/1Q4jpihY7SIwDg=;
        b=lcDxMf0IacgbtirBv3TneTRSLmivWFZ8G0sKQ+zHbklLEfk9Tj5gzWoZUd00sezx5G
         7YDpuVsmpp5Hi292141ilwszaWWjST4UGX/xLHZybvkYVzqEjV0Je6inT+QQGxIGIIVk
         HcGTo8r3zubNe+E1PgIBsZydUpPjLKWlJE3JVoZhMv1pYfwNm+SekT67BtHpYZ4NEtLj
         7o5grDJv3YNmGXM8zMbrymN6OWvfrGOiFZX9X71nOqX1h/Z33a6+1BGp3h7EGno7qTMp
         up2hbfK6vvoXPXQ5zitOVrhJh8kkHoGpZS2c1ITR2lDHF7iYcdGUI2RivbxHsHOpzonL
         3ZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3eElLZDK+73Sru8uMZkWstDbXOPX/1Q4jpihY7SIwDg=;
        b=A94cYQeiUFPALex4kKwPvvr8+CWkslS7GkYCCP5Ij+WWHf43crk+s/Bc5r9CDAc10N
         zDNgTz2UVIyXy0uMynWNPv1Fbw/pA5V6IaQmb3aLBJynrwpQwtzweO1e4o6hQZVsqsRE
         fqTgCLht+VJWhroWUbcj/mCaiprbj/cHqswf7FolWetNVlZT37Wgu3g3MPsyc+yfuGVs
         A/m2+VusKZ9UA8MCN1JLwT7f04VpaFcLJBbo1OWql0i5i4e8GliNzAnBbfJ5ALjkpBkn
         0dxLYcc4Jil4K0BTZtQhxdVPTgHTJJ54aePicME+Qer1DN67cbKJwb30udmynmVZfTit
         P0Jg==
X-Gm-Message-State: AOAM533wjAWPUB6ldsdxi+q3b+DAXn7Cty9ah7cAcqNmkjDirT6gEfZa
        7XoLCXkIOr3gES2VIAqgC0+EnA8R
X-Google-Smtp-Source: ABdhPJz0agijvMKGzjnaeuIpe9wfK5n7UmFKFUMiW/9qR4SwUY8Yij4M99rIGesoyoDuXJyNY8uDaw==
X-Received: by 2002:a05:6402:318d:: with SMTP id di13mr26663466edb.172.1593731474444;
        Thu, 02 Jul 2020 16:11:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:bd38:c82d:5283:9f1])
        by smtp.gmail.com with ESMTPSA id x9sm8214031ejw.28.2020.07.02.16.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 16:11:13 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 10/15] options: add a small helper: handle_switch_finalize()
Date:   Fri,  3 Jul 2020 01:10:34 +0200
Message-Id: <20200702231039.55015-11-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702231039.55015-1-luc.vanoostenryck@gmail.com>
References: <20200702231039.55015-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just to isolate the details about which switch need an
extra 'finalization' in a separate function in preparation
to moving all the parsing code in a separate file.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib.c b/lib.c
index b3bacb180cac..a56efcaa64fd 100644
--- a/lib.c
+++ b/lib.c
@@ -1220,6 +1220,12 @@ static char **handle_switch(char *arg, char **next)
 	return next;
 }
 
+static void handle_switch_finalize(void)
+{
+	handle_switch_v_finalize();
+	handle_switch_W_finalize();
+}
+
 ////////////////////////////////////////////////////////////////////////////////
 // Predefines
 
@@ -1576,8 +1582,7 @@ struct symbol_list *sparse_initialize(int argc, char **argv, struct string_list
 		}
 		add_ptr_list(filelist, arg);
 	}
-	handle_switch_W_finalize();
-	handle_switch_v_finalize();
+	handle_switch_finalize();
 
 	// Redirect stdout if needed
 	if (dump_macro_defs || preprocess_only)
-- 
2.27.0

