Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E961C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 11:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40E6D2065C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 11:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgGZLLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 07:11:43 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:45766 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgGZLLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 07:11:42 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id B239C6F648;
        Sun, 26 Jul 2020 11:11:37 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     torvalds@linux-foundation.org, masahiroy@kernel.org,
        mhiramat@kernel.org, rostedt@goodmis.org, jeyu@kernel.org,
        will@kernel.org, krzk@kernel.org, patrick.bellasi@arm.com,
        dhowells@redhat.com, ebiederm@xmission.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] init/Kconfig: Replace HTTP links with HTTPS ones
Date:   Sun, 26 Jul 2020 13:11:31 +0200
Message-Id: <20200726111131.16414-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5 with unmaintained stuff according to:
 perl scripts/get_maintainer.pl --nogit{,-fallback} --nol

 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely
 or at least not (just) HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.


 init/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 0498af567f70..bf72068f3b6a 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -332,12 +332,12 @@ config SYSVIPC
 	  exchange information. It is generally considered to be a good thing,
 	  and some programs won't run unless you say Y here. In particular, if
 	  you want to run the DOS emulator dosemu under Linux (read the
-	  DOSEMU-HOWTO, available from <http://www.tldp.org/docs.html#howto>),
+	  DOSEMU-HOWTO, available from <https://www.tldp.org/docs.html#howto>),
 	  you'll need to say Y here.
 
 	  You can find documentation about IPC with "info ipc" and also in
 	  section 6.4 of the Linux Programmer's Guide, available from
-	  <http://www.tldp.org/guides.html>.
+	  <https://www.tldp.org/guides.html>.
 
 config SYSVIPC_SYSCTL
 	bool
@@ -519,7 +519,7 @@ config BSD_PROCESS_ACCT_V3
 	  process and its parent. Note that this file format is incompatible
 	  with previous v0/v1/v2 file formats, so you will need updated tools
 	  for processing it. A preliminary version of these tools is available
-	  at <http://www.gnu.org/software/acct/>.
+	  at <https://www.gnu.org/software/acct/>.
 
 config TASKSTATS
 	bool "Export task/process statistics through netlink"
-- 
2.27.0

