Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188ACC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 11:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F30D320714
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 11:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgGZL5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 07:57:48 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:55818 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgGZL5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 07:57:48 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 492B16F63B;
        Sun, 26 Jul 2020 11:57:45 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] [media] get_dvb_firmware: Replace HTTP links with HTTPS ones
Date:   Sun, 26 Jul 2020 13:57:39 +0200
Message-Id: <20200726115739.16691-1-grandmaster@al2klimov.de>
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


 scripts/get_dvb_firmware | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/get_dvb_firmware b/scripts/get_dvb_firmware
index 1a90802410bc..d3d05bdde08c 100755
--- a/scripts/get_dvb_firmware
+++ b/scripts/get_dvb_firmware
@@ -553,7 +553,7 @@ sub af9015 {
 }
 
 sub ngene {
-    my $url = "http://www.digitaldevices.de/download/";
+    my $url = "https://www.digitaldevices.de/download/";
     my $file1 = "ngene_15.fw";
     my $hash1 = "d798d5a757121174f0dbc5f2833c0c85";
     my $file2 = "ngene_17.fw";
-- 
2.27.0

