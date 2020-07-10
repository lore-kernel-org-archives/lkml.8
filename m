Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8E2C433F7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20D032080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594399995;
	bh=AUmUx4jDYDFe7kBfdk4n6kJ/q5/JaalkQXKY688hDBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XX0kiTZkVI4ei3hWGN0Y5Fn5JtrpEBT/CN8J6pbG+TinZ8tRk9fldP7gFMEvTFmpG
	 uF8CNyRFw3o4kVQQAhr3+FNYKvOmvQV/8pl6zgVDE4j0u0v2ONaWPBuxNX5dmstJBG
	 FEFQqXMWavI/6Pwuksnl/yzt+2UQDQwJ+Bbdzu2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgGJQxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:53:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728550AbgGJQxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:53:09 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47AC2207FB;
        Fri, 10 Jul 2020 16:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594399988;
        bh=AUmUx4jDYDFe7kBfdk4n6kJ/q5/JaalkQXKY688hDBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ymUpiylykQCuP3maUjCTO0X59gWtqVcqw84V0Zzo2znKmrw0yvIc3EKU+4bcrFtKS
         smg2iPWSLrgBNzLTN9WA84Nw7M0RNRlr+Urj8BqxosdEWug58hGKsA7PlW7v88h3Iu
         c4BPnndUOf7eM104Q1+fs41Pt0HYqW1ln0uHLAX0=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Joel Fernandes <joelaf@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kernel-team@android.com
Subject: [PATCH v3 14/19] checkpatch: Remove checks relating to [smp_]read_barrier_depends()
Date:   Fri, 10 Jul 2020 17:51:58 +0100
Message-Id: <20200710165203.31284-15-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200710165203.31284-1-will@kernel.org>
References: <20200710165203.31284-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The [smp_]read_barrier_depends() macros no longer exist, so we don't
need to deal with them in the checkpatch script.

Acked-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 scripts/checkpatch.pl | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4c820607540b..8032f80c5bc7 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5903,8 +5903,7 @@ sub process {
 		my $barriers = qr{
 			mb|
 			rmb|
-			wmb|
-			read_barrier_depends
+			wmb
 		}x;
 		my $barrier_stems = qr{
 			mb__before_atomic|
@@ -5953,12 +5952,6 @@ sub process {
 			}
 		}
 
-# check for smp_read_barrier_depends and read_barrier_depends
-		if (!$file && $line =~ /\b(smp_|)read_barrier_depends\s*\(/) {
-			WARN("READ_BARRIER_DEPENDS",
-			     "$1read_barrier_depends should only be used in READ_ONCE or DEC Alpha code\n" . $herecurr);
-		}
-
 # check of hardware specific defines
 		if ($line =~ m@^.\s*\#\s*if.*\b(__i386__|__powerpc64__|__sun__|__s390x__)\b@ && $realfile !~ m@include/asm-@) {
 			CHK("ARCH_DEFINES",
-- 
2.27.0.383.g050319c2ae-goog

