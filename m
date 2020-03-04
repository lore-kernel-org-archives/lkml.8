Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0564C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 22:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E2720848
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 22:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583360062;
	bh=sg+lRT6T+2CFS1Dw0JSEHqIxXO8uMRbU2SWPKjpkK4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fLyuzft2eO8WndJ1AcM6OsI6v4tfAbQYGPs5LD0RvXtUvc1YUAlLeWlwKjkDTq6N7
	 1kj0c761pPx5rg+CrzYyxSOUp/PKu/HJ2yCUmXnmHG2MDHa/t1vRBxeNTZUJtPPbY7
	 LSuO70UyUArqOmdjZsNElS1TGfMWwZ3R+NuABwzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388480AbgCDWOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 17:14:14 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:38041 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388389AbgCDWON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 17:14:13 -0500
Received: by mail-io1-f65.google.com with SMTP id s24so4213161iog.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 14:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+9gZ3FjUdWgi81CXN9D2iQAnH+lo6JPqrg04R4qEP/8=;
        b=gZXX9JmFv2DJctPsp75DNG3g9p5eWyxIrIAFUCbjj3XGgwnMcqZvgFvkYd7Xd9sfeI
         zZEQWmhYX3g7EGtLUCtQBUuPzHEkzgpNKBYXKTAwk0TH8EBhCHvC9IlWnCXxm2mILo4G
         uqEGWEe60u9mIN2p34S1eJ2s6E8iJvEzG2zy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+9gZ3FjUdWgi81CXN9D2iQAnH+lo6JPqrg04R4qEP/8=;
        b=E4FC6RYXet6en/vSZZrYM4yIc93s/g9Y1N4wSxQpMkaeaKV6lt6x0rQwELb5er0f4N
         FVeDd4OAvH6Ka4B1ZkhHvREwMLc7yRFKEs5uVSk0b361FISs/m2nmZRt1a1et6m4+h35
         WPVMVHB1sclIf2zvz/4IsUJmetAyRZiwgHPf373+GV9TydqBrjl/PV6Cm5T9aNe4GaBK
         LLmTyIGR3w4qrYfVr8O6ugHliknzZlPaY9qXy7PLXiy1QqvM0OtvwdDR3z14QUUjTgEh
         pXUTIIYZ58yTmxtPVDN5M1KlUr6LFIY0uNA2C18R0mtFyQ3ORfLBQPv3CR1PBHUtppWN
         evrQ==
X-Gm-Message-State: ANhLgQ3+rydEg0qToOigykdnlkiWidXA87Rmuo6xalItRzHITZCH/c4G
        pCb88Uqnrxc65LBec1nSDldeqA==
X-Google-Smtp-Source: ADFU+vvGc+yswzBxxepbZQqv/WGJj2Qwy8fRbC0QftbuZTZFLG36VzQ2QAbYELI6s/iSwvWfdmZTyg==
X-Received: by 2002:a6b:660d:: with SMTP id a13mr3690456ioc.18.1583360049769;
        Wed, 04 Mar 2020 14:14:09 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g12sm6850409iom.5.2020.03.04.14.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 14:14:09 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, khilman@baylibre.com,
        mpe@ellerman.id.au, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] selftests: Fix kselftest O=objdir build from cluttering top level objdir
Date:   Wed,  4 Mar 2020 15:13:32 -0700
Message-Id: <58d954867391c90fe0792d87e09a82bda26ba4fc.1583358715.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1583358715.git.skhan@linuxfoundation.org>
References: <cover.1583358715.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make kselftest-all O=objdir builds create generated objects in objdir.
This clutters the top level directory with kselftest objects. Fix it
to create sub-directory under objdir for kselftest objects.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 6ec503912bea..cd77df3e6bb8 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -91,7 +91,7 @@ override LDFLAGS =
 override MAKEFLAGS =
 endif
 
-# Append kselftest to KBUILD_OUTPUT to avoid cluttering
+# Append kselftest to KBUILD_OUTPUT and O to avoid cluttering
 # KBUILD_OUTPUT with selftest objects and headers installed
 # by selftests Makefile or lib.mk.
 ifdef building_out_of_srctree
@@ -99,7 +99,7 @@ override LDFLAGS =
 endif
 
 ifneq ($(O),)
-	BUILD := $(O)
+	BUILD := $(O)/kselftest
 else
 	ifneq ($(KBUILD_OUTPUT),)
 		BUILD := $(KBUILD_OUTPUT)/kselftest
-- 
2.20.1

