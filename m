Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE5EC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D09422B3A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbgGNTjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:39:54 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:40542 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729829AbgGNTjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:39:53 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 003CBBC0CA;
        Tue, 14 Jul 2020 19:39:50 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     torvalds@linux-foundation.org, corbet@lwn.net,
        tsbogend@alpha.franken.de, f4bug@amsat.org,
        luis.f.correia@gmail.com, cyphar@cyphar.com, ribalda@kernel.org,
        davej@codemonkey.org.uk, mchehab+samsung@kernel.org,
        martink@posteo.de, paulburton@kernel.org, geert+renesas@glider.be,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] CREDITS: remove link http://www.mathematik.uni-stuttgart.de/~floeff
Date:   Tue, 14 Jul 2020 21:39:45 +0200
Message-Id: <20200714193945.49915-1-grandmaster@al2klimov.de>
In-Reply-To: <20200714175528.46712-1-grandmaster@al2klimov.de>
References: <20200714175528.46712-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:
The way it redirects looks like a fallback from a dead URL to a generic one.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Yes, I noted that some of the links removed by these "CREDITS: remove link:"
 patches have email addresses with the same domain nearby.

 Don't worry, I'll take care of them together with all other
 dead email addresses - but not right now.


 CREDITS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index 0787b5872906..151083e4245d 100644
--- a/CREDITS
+++ b/CREDITS
@@ -2241,7 +2241,6 @@ S: France
 
 N: Siegfried "Frieder" Loeffler (dg1sek)
 E: floeff@tunix.mathematik.uni-stuttgart.de, fl@LF.net
-W: http://www.mathematik.uni-stuttgart.de/~floeff
 D: Busmaster driver for HP 10/100 Mbit Network Adapters
 S: University of Stuttgart, Germany and
 S: Ecole Nationale Superieure des Telecommunications, Paris
-- 
2.27.0

