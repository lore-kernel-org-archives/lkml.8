Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC526C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 06:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A3424679
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 06:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgAVG5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 01:57:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36789 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgAVG5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 01:57:24 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iu9x1-00034r-Kq; Wed, 22 Jan 2020 07:57:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 565471C1A3B;
        Wed, 22 Jan 2020 07:57:19 +0100 (CET)
Date:   Wed, 22 Jan 2020 06:57:19 -0000
From:   "tip-bot2 for Olof Johansson" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] objtool: Silence build output
Cc:     Olof Johansson <olof@lixom.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <cb002857fafa8186cfb9c3e43fb62e4108a1bab9.1579543924.git.jpoimboe@redhat.com>
References: <cb002857fafa8186cfb9c3e43fb62e4108a1bab9.1579543924.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <157967623918.396.15730242469027669851.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     6ec14aa7a58a1c2fb303692f8cb1ff82d9abd10a
Gitweb:        https://git.kernel.org/tip/6ec14aa7a58a1c2fb303692f8cb1ff82d9abd10a
Author:        Olof Johansson <olof@lixom.net>
AuthorDate:    Mon, 20 Jan 2020 12:14:07 -06:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 22 Jan 2020 07:54:34 +01:00

objtool: Silence build output

The sync-check.sh script prints out the path due to a "cd -" at the end
of the script, even on silent builds. This isn't even needed, since the
script is executed in our build instead of sourced (so it won't change
the working directory of the surrounding build anyway).

Just remove the cd to make the build silent.

Fixes: 2ffd84ae973b ("objtool: Update sync-check.sh from perf's check-headers.sh")
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/cb002857fafa8186cfb9c3e43fb62e4108a1bab9.1579543924.git.jpoimboe@redhat.com
---
 tools/objtool/sync-check.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
index 9bd04bb..2a1261b 100755
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -48,5 +48,3 @@ check arch/x86/include/asm/inat.h     '-I "^#include [\"<]\(asm/\)*inat_types.h[
 check arch/x86/include/asm/insn.h     '-I "^#include [\"<]\(asm/\)*inat.h[\">]"'
 check arch/x86/lib/inat.c             '-I "^#include [\"<]\(../include/\)*asm/insn.h[\">]"'
 check arch/x86/lib/insn.c             '-I "^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]" -I "^#include [\"<]\(../include/\)*asm/emulate_prefix.h[\">]"'
-
-cd -
