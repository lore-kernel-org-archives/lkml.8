Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D3CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99865206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbgGMNuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 09:50:32 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:60922 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729873AbgGMNu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:50:29 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 732A1BC0E4;
        Mon, 13 Jul 2020 13:50:26 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     keescook@chromium.org, re.emese@gmail.com,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] gcc-plugins: Replace HTTP links with HTTPS ones
Date:   Mon, 13 Jul 2020 15:50:18 +0200
Message-Id: <20200713135018.34708-1-grandmaster@al2klimov.de>
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

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely or at least not just HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.

 Sorry again to all maintainers who complained about subject lines.
 Now I realized that you want an actually perfect prefixes,
 not just subsystem ones.
 I tried my best...
 And yes, *I could* (at least half-)automate it.
 Impossible is nothing! :)


 scripts/gcc-plugins/cyc_complexity_plugin.c | 2 +-
 scripts/gcc-plugins/sancov_plugin.c         | 2 +-
 scripts/gcc-plugins/structleak_plugin.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/gcc-plugins/cyc_complexity_plugin.c b/scripts/gcc-plugins/cyc_complexity_plugin.c
index 1909ec617431..73124c2b3edd 100644
--- a/scripts/gcc-plugins/cyc_complexity_plugin.c
+++ b/scripts/gcc-plugins/cyc_complexity_plugin.c
@@ -5,7 +5,7 @@
  * Homepage:
  * https://github.com/ephox-gcc-plugins/cyclomatic_complexity
  *
- * http://en.wikipedia.org/wiki/Cyclomatic_complexity
+ * https://en.wikipedia.org/wiki/Cyclomatic_complexity
  * The complexity M is then defined as:
  * M = E - N + 2P
  * where
diff --git a/scripts/gcc-plugins/sancov_plugin.c b/scripts/gcc-plugins/sancov_plugin.c
index 0f98634c20a0..caff4a6c7e9a 100644
--- a/scripts/gcc-plugins/sancov_plugin.c
+++ b/scripts/gcc-plugins/sancov_plugin.c
@@ -11,7 +11,7 @@
  *
  * You can read about it more here:
  *  https://gcc.gnu.org/viewcvs/gcc?limit_changes=0&view=revision&revision=231296
- *  http://lwn.net/Articles/674854/
+ *  https://lwn.net/Articles/674854/
  *  https://github.com/google/syzkaller
  *  https://lwn.net/Articles/677764/
  *
diff --git a/scripts/gcc-plugins/structleak_plugin.c b/scripts/gcc-plugins/structleak_plugin.c
index e89be8f5c859..b9ef2e162107 100644
--- a/scripts/gcc-plugins/structleak_plugin.c
+++ b/scripts/gcc-plugins/structleak_plugin.c
@@ -11,7 +11,7 @@
  * otherwise leak kernel stack to userland if they aren't properly initialized
  * by later code
  *
- * Homepage: http://pax.grsecurity.net/
+ * Homepage: https://pax.grsecurity.net/
  *
  * Options:
  * -fplugin-arg-structleak_plugin-disable
-- 
2.27.0

