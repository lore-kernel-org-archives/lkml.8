Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F43BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04B8B20656
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gCn6sUrc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbgFVSRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730298AbgFVSQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 14:16:58 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7965DC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:16:58 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id cm23so173990pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gmWEkUNicDeCM4kFpW02gLeTggGe1CX/sAbQL0lp4ok=;
        b=gCn6sUrcglxjrNfNk1b4t8uFQEW2ivCw6IGFERgd2ucag2WSZ8dDQVZj+vjoeZkv4W
         5XzU1emOkx+4It3oK9atoQRugJQPMIyYZeW5I20TMGNQLCuuFGM2zrbLRHheiDGuUbET
         wCPTcPVHrrk2VgUkAhMgytOiH4Im0X2QdI3oA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gmWEkUNicDeCM4kFpW02gLeTggGe1CX/sAbQL0lp4ok=;
        b=gDTEQBfMQ51QG2TpHd1IGdzTiL0PcphFjA4ygfUi2WzfWiMtj1TGmJ/Yo+wJxbKS/A
         YHv9ASU05TXHDUuWvUNbhNHTQOLRG31Onxd1N1DwykugmEE0Sk2ywIVy5Svv5A4Lgi59
         5+WPi9dseHtaa0SRqveKG+mrrb0+7TBEAUsVLmXAkwTCPsrzulM4+h8MnumpXEIEovmn
         3wU8A73HBL7epps46bi2GwvCFd0KW1S1qURn4xPQjnHdipdQlsqH6uAyITaT2sDQkynN
         vqPVtrCBa900ydppoVMr4B0l5YgEI1NfKPSOstTfp/CkLpYqk/hGfcEuaMydwJ7iawmQ
         qShQ==
X-Gm-Message-State: AOAM5305aCEyP/NGFXRmDY7QOUQxPh8FcJoFWDeUwrRIcgwxebNn//AH
        z0xXBuA2B/r5Fkp3Pf9ODI3K2g==
X-Google-Smtp-Source: ABdhPJyjnPW8KKOQGeoi/F2bXOPpiEJeT6vo2t99kS7iITrMKDcamCLyXSzQuGqFiPic8NSEaNumwg==
X-Received: by 2002:a17:90a:30e1:: with SMTP id h88mr18277609pjb.43.1592849818071;
        Mon, 22 Jun 2020 11:16:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h17sm14314190pfo.168.2020.06.22.11.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 11:16:55 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Brauner <christian@brauner.io>,
        David Gow <davidgow@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] selftests/clone3: Reorder reporting output
Date:   Mon, 22 Jun 2020 11:16:44 -0700
Message-Id: <20200622181651.2795217-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622181651.2795217-1-keescook@chromium.org>
References: <20200622181651.2795217-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Selftest output reporting was happening before the TAP headers and plan
had been emitted. Move the first test reports later.

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/clone3/clone3.c               | 2 +-
 tools/testing/selftests/clone3/clone3_clear_sighand.c | 3 +--
 tools/testing/selftests/clone3/clone3_set_tid.c       | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index f14c269a5a18..b7e6dec36173 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -131,9 +131,9 @@ int main(int argc, char *argv[])
 
 	uid_t uid = getuid();
 
-	test_clone3_supported();
 	ksft_print_header();
 	ksft_set_plan(17);
+	test_clone3_supported();
 
 	/* Just a simple clone3() should return 0.*/
 	test_clone3(0, 0, 0, CLONE3_ARGS_NO_TEST);
diff --git a/tools/testing/selftests/clone3/clone3_clear_sighand.c b/tools/testing/selftests/clone3/clone3_clear_sighand.c
index 9e1af8aa7698..db5fc9c5edcf 100644
--- a/tools/testing/selftests/clone3/clone3_clear_sighand.c
+++ b/tools/testing/selftests/clone3/clone3_clear_sighand.c
@@ -119,9 +119,8 @@ static void test_clone3_clear_sighand(void)
 int main(int argc, char **argv)
 {
 	ksft_print_header();
-	test_clone3_supported();
-
 	ksft_set_plan(1);
+	test_clone3_supported();
 
 	test_clone3_clear_sighand();
 
diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
index 25beb22f35b5..5831c1082d6d 100644
--- a/tools/testing/selftests/clone3/clone3_set_tid.c
+++ b/tools/testing/selftests/clone3/clone3_set_tid.c
@@ -157,8 +157,8 @@ int main(int argc, char *argv[])
 	pid_t set_tid[MAX_PID_NS_LEVEL * 2];
 
 	ksft_print_header();
-	test_clone3_supported();
 	ksft_set_plan(29);
+	test_clone3_supported();
 
 	if (pipe(pipe_1) < 0 || pipe(pipe_2) < 0)
 		ksft_exit_fail_msg("pipe() failed\n");
-- 
2.25.1

