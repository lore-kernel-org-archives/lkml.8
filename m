Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849A0C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 11:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DAB1207DF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 11:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgGSLmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 07:42:03 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:48322 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgGSLmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 07:42:02 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 277D0BC085;
        Sun, 19 Jul 2020 11:41:58 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH for v5.9] net: sched: Replace HTTP links with HTTPS ones
Date:   Sun, 19 Jul 2020 13:41:51 +0200
Message-Id: <20200719114151.58369-1-grandmaster@al2klimov.de>
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

 If there are any URLs to be removed completely
 or at least not (just) HTTPSified:
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


 net/sched/Kconfig   | 2 +-
 net/sched/sch_qfq.c | 2 +-
 net/sched/sch_sfb.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index 84badf00647e..e0509b4c39e4 100644
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -223,7 +223,7 @@ config NET_SCH_DSMARK
 	  Say Y if you want to schedule packets according to the
 	  Differentiated Services architecture proposed in RFC 2475.
 	  Technical information on this method, with pointers to associated
-	  RFCs, is available at <http://www.gta.ufrj.br/diffserv/>.
+	  RFCs, is available at <https://www.gta.ufrj.br/diffserv/>.
 
 	  To compile this code as a module, choose M here: the
 	  module will be called sch_dsmark.
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 0b05ac7c848e..191143c35de6 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -24,7 +24,7 @@
 
     [1] Paolo Valente,
     "Reducing the Execution Time of Fair-Queueing Schedulers."
-    http://algo.ing.unimo.it/people/paolo/agg-sched/agg-sched.pdf
+    https://algo.ing.unimo.it/people/paolo/agg-sched/agg-sched.pdf
 
     Sources for QFQ:
 
diff --git a/net/sched/sch_sfb.c b/net/sched/sch_sfb.c
index 4074c50ac3d7..f8fa648988bd 100644
--- a/net/sched/sch_sfb.c
+++ b/net/sched/sch_sfb.c
@@ -9,7 +9,7 @@
  * A New Class of Active Queue Management Algorithms.
  * U. Michigan CSE-TR-387-99, April 1999.
  *
- * http://www.thefengs.com/wuchang/blue/CSE-TR-387-99.pdf
+ * https://www.thefengs.com/wuchang/blue/CSE-TR-387-99.pdf
  */
 
 #include <linux/module.h>
-- 
2.27.0

