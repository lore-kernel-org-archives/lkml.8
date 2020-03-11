Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C2CC0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B76520578
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cskmlpgv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbgCKTVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:21:31 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:54305 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730807AbgCKTVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:21:30 -0400
Received: by mail-pj1-f66.google.com with SMTP id np16so1434668pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 12:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=VEJi8Ua1KT556ICDNdI7F0+UTqFndAFbSPbblW/yU4g=;
        b=CskmlpgvnMkA+wCApbaonRYRAZxJC54spPJq8d7JehKzT58xoCzRO6Mve3c49n44zK
         PWaabpLQB2dYbC1TL0adRVYluFtMdH6VS6c57Nq+R2wCQ1fnEEBFcVQbzwH9RJ2dW0Gf
         YlkYkImwr4Pw4lwLfm270n07AFNPb1Mw2sLP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=VEJi8Ua1KT556ICDNdI7F0+UTqFndAFbSPbblW/yU4g=;
        b=qoChOHA2BYF9N3fkibWNVp387XE+GZd5mCbRvDnLzqFyLJh0vcGa4YNNtUfKalBpba
         lwvjD/L4h3saJ43benAFXSqgcTw/3Ry30pc1YGBfLnfE1rvYH0mgaBfU7su/QLOnmYdK
         U0DGYCxvvRVkjIr1dNkTkQrsxbOo3efqj0UAtfymRXIvQoKFOXeCEL6vQa7VLRNAXvJs
         A01Kg2ijOwp0F4PTdNRh/Oa8Mheu245JFQYhTOTCDkNu6f8NvnuuZl5ibS7P/t9SNFne
         pACiz99vW/wJ+ftxsGbyILu5HBWLLkrgflTNfyb9NvmRTq9k8HBBJWAmerTOpCYbklNS
         59PQ==
X-Gm-Message-State: ANhLgQ24VLRCwc9YishHEpHWNPlXxQRp2kUB9QmoZfPh9MB79KdM4Rcw
        GkH8iPOwzeMehdy0LUpSjnocEw==
X-Google-Smtp-Source: ADFU+vsktVXh9K4NFSSqaFcAbmhWXGfMzDHwE2OpVAMfq8OnBjo81CK/wXvkV7Zt9DyhUeVelrrm9w==
X-Received: by 2002:a17:902:bb82:: with SMTP id m2mr4510185pls.197.1583954489691;
        Wed, 11 Mar 2020 12:21:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k1sm48202611pgt.70.2020.03.11.12.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 12:21:28 -0700 (PDT)
Date:   Wed, 11 Mar 2020 12:21:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/seccomp: Adjust test fixture counts
Message-ID: <202003111220.2D3AD27460@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The seccomp selftest reported the wrong test counts since it was using
slightly the wrong API for defining text fixtures. Adjust the API usage.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index a9ad3bd8b2ad..89fb3e0b552e 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -913,7 +913,7 @@ TEST(ERRNO_order)
 	EXPECT_EQ(12, errno);
 }
 
-FIXTURE_DATA(TRAP) {
+FIXTURE(TRAP) {
 	struct sock_fprog prog;
 };
 
@@ -1024,7 +1024,7 @@ TEST_F(TRAP, handler)
 	EXPECT_NE(0, (unsigned long)sigsys->_call_addr);
 }
 
-FIXTURE_DATA(precedence) {
+FIXTURE(precedence) {
 	struct sock_fprog allow;
 	struct sock_fprog log;
 	struct sock_fprog trace;
@@ -1513,7 +1513,7 @@ void tracer_poke(struct __test_metadata *_metadata, pid_t tracee, int status,
 	EXPECT_EQ(0, ret);
 }
 
-FIXTURE_DATA(TRACE_poke) {
+FIXTURE(TRACE_poke) {
 	struct sock_fprog prog;
 	pid_t tracer;
 	long poked;
@@ -1821,7 +1821,7 @@ void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
 		change_syscall(_metadata, tracee, -1, -ESRCH);
 }
 
-FIXTURE_DATA(TRACE_syscall) {
+FIXTURE(TRACE_syscall) {
 	struct sock_fprog prog;
 	pid_t tracer, mytid, mypid, parent;
 };
@@ -2326,7 +2326,7 @@ struct tsync_sibling {
 		}							\
 	} while (0)
 
-FIXTURE_DATA(TSYNC) {
+FIXTURE(TSYNC) {
 	struct sock_fprog root_prog, apply_prog;
 	struct tsync_sibling sibling[TSYNC_SIBLINGS];
 	sem_t started;
-- 
2.20.1


-- 
Kees Cook
