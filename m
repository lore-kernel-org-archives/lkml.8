Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B681FC433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 18:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A440206F5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 18:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgGMSZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 14:25:45 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:40476 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbgGMSZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 14:25:42 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 04ED9BC0FB;
        Mon, 13 Jul 2020 18:25:39 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     sudipm.mukherjee@gmail.com, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] parport: Replace HTTP links with HTTPS ones
Date:   Mon, 13 Jul 2020 20:25:33 +0200
Message-Id: <20200713182533.36879-1-grandmaster@al2klimov.de>
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


 drivers/parport/BUGS-parport | 2 +-
 drivers/parport/TODO-parport | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/parport/BUGS-parport b/drivers/parport/BUGS-parport
index 622ca3cc7fa0..25274fe1206a 100644
--- a/drivers/parport/BUGS-parport
+++ b/drivers/parport/BUGS-parport
@@ -6,4 +6,4 @@ o lp doesn't allow you to read status while printing is in progress (is
 o parport_pc_ecp_read_block_pio() is broken.  parport will revert to the
   software-driven mode in ieee1284_ops.c
 
-See <URL:http://people.redhat.com/twaugh/parport/>.
+See <URL:https://people.redhat.com/twaugh/parport/>.
diff --git a/drivers/parport/TODO-parport b/drivers/parport/TODO-parport
index 089b14ee446f..c5e9855a3284 100644
--- a/drivers/parport/TODO-parport
+++ b/drivers/parport/TODO-parport
@@ -17,4 +17,4 @@ Things to be done.
 
 4. A better PLIP (make use of bidirectional/ECP/EPP ports).
 
-See <URL:http://people.redhat.com/twaugh/parport/>.
+See <URL:https://people.redhat.com/twaugh/parport/>.
-- 
2.27.0

