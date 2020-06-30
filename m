Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5351C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBADF208A7
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593538723;
	bh=1FGhp5sGfkpSiXhXgfH5nBXKN4fqT4jY7nbDIPuK7X4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x/kqmcD7TBAwKrEZefGgU9yhC58zXoxlc7uhswwnGa9DTOnkBFdsg/mCMyotNuJbz
	 sqGV2zI8dwrE2qdbNS9untkEWiGnnp6yw0mQsUE1J/Q29Vh2d+Z0N5yD+yR9bz8oo8
	 PQ3dOjV7KINuHYFJ2eoRP3LQidiwrHM5ocQxahLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390440AbgF3Rim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:38:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390427AbgF3Rij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:38:39 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCA8F207F9;
        Tue, 30 Jun 2020 17:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593538718;
        bh=1FGhp5sGfkpSiXhXgfH5nBXKN4fqT4jY7nbDIPuK7X4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bpLGiANhTDJLC7t5bWYwDrB2C0vByZC6qRCHBvONLGHbyWqUjDr91Fhnj0Qfj8ajH
         b6o2hJwvm0H/J4VMMeXmYx2lzjErEQ+y1AiAsdofaMJowGhiD1x/0r79lPQWnl0rpi
         KcoNDIgVtCvUFCTCs+tjhL7w1byxja9E2be1+JP4=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
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
Subject: [PATCH 13/18] checkpatch: Remove checks relating to [smp_]read_barrier_depends()
Date:   Tue, 30 Jun 2020 18:37:29 +0100
Message-Id: <20200630173734.14057-14-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200630173734.14057-1-will@kernel.org>
References: <20200630173734.14057-1-will@kernel.org>
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
2.27.0.212.ge8ba1cc988-goog

