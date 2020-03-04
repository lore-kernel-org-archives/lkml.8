Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94246C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 22:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB6520848
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 22:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583360068;
	bh=8YtaRovbocska2CoTH6bYQgSQtXxX7l0Lg3wK/KeTpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i2CmyYSBevIP0DQWhMiuZM6B0xvzOzlzEcx/bKOlmYqrgSlo3mj1PlEgdEZ26hUvE
	 V5KbgoHBkeLAcSBcz7UeoqguevWx2irnUBULltNSTBUQqFimZZPe81jQecedlfifA2
	 bwNsvdZqCE3ne1LfsM6UhJZ+Wjp/QwPfu/Xi4Oy0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388536AbgCDWO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 17:14:27 -0500
Received: from mail-il1-f177.google.com ([209.85.166.177]:34035 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388527AbgCDWOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 17:14:25 -0500
Received: by mail-il1-f177.google.com with SMTP id n11so3268514ild.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 14:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BNOtEzNwp4ie5FRfbU1U4EX7nRGPjUgtolRpVq/MBE4=;
        b=OjekLCqZXQTwkl6Q5+uW5RbrmRq1XHvjg72IzgF+tE8FYdmbprWuZXrMRaz2opWp96
         eogbo2K2F7+AuIYJXXRlnEbypRyif+rw8vKoVtGZtYDP7P/6XPjLzZGOvctKs/o8fNmS
         sPQwOLyx918g6f4J/GeVMND2UO72j7YBTftAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BNOtEzNwp4ie5FRfbU1U4EX7nRGPjUgtolRpVq/MBE4=;
        b=fVdJiIIbFyrJ41hyNEEBw9xUQ7yJxmC7lLNx4OCFbKu5NgxrP/PcFM2XA9z8d54v1a
         +iMYel8xNF6vAJ1nVfOXJRiexsd63liIQqLyUgq6smZ+ApzUZEpMrJ4/jx+KnnhP1WLz
         9fEYAzQJmjVps4ZdIho8mTyMyduYqS5w1sNePU3NOKQZkEunqZDJPhTZDFCE666QvM2Z
         b2jRTNBmZTPh3hbb8Q8yrc4SjywoIdTnEv2zWCiioHAxDk1SPLnXkMKHEltXH52ujsR1
         B5HShEaO5QxOp/Pz9LPznQ3PLiASghemwL63Mt6u+4cjlNioCDOgNuD0XCV7TgqL2b6a
         h4PA==
X-Gm-Message-State: ANhLgQ3umD+EUsxGt/5l6ANNeCVoR7NWHjTl3qtCt6xOfh6BTRLPJ4Db
        M4URYqo29gBDMjS8vL6DXZtfEw==
X-Google-Smtp-Source: ADFU+vsMyK+BNv06am40GT7NHnRVpySeoKNzTfsH6ZdL+TH4iiTcuGpNh3lpNJhPS8RjcOqAd+KcwQ==
X-Received: by 2002:a92:5b11:: with SMTP id p17mr4890257ilb.202.1583360064649;
        Wed, 04 Mar 2020 14:14:24 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g12sm6850409iom.5.2020.03.04.14.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 14:14:24 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, gregkh@linuxfoundation.org, tglx@linutronix.de
Cc:     Shuah Khan <skhan@linuxfoundation.org>, khilman@baylibre.com,
        mpe@ellerman.id.au, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] selftests: android: Fix custom install from skipping test progs
Date:   Wed,  4 Mar 2020 15:13:35 -0700
Message-Id: <738dd72fe6c4c277a39f1cab10b342c477e0464f.1583358715.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1583358715.git.skhan@linuxfoundation.org>
References: <cover.1583358715.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update custom install rule to install all generated test programs. This
fixes android/ion tests to be installed correctly.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/android/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/android/Makefile b/tools/testing/selftests/android/Makefile
index 7c462714b418..9258306cafe9 100644
--- a/tools/testing/selftests/android/Makefile
+++ b/tools/testing/selftests/android/Makefile
@@ -21,7 +21,7 @@ all:
 
 override define INSTALL_RULE
 	mkdir -p $(INSTALL_PATH)
-	install -t $(INSTALL_PATH) $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES)
+install -t $(INSTALL_PATH) $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES)  $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
 
 	@for SUBDIR in $(SUBDIRS); do \
 		BUILD_TARGET=$(OUTPUT)/$$SUBDIR;	\
-- 
2.20.1

