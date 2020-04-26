Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8789FC55194
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 21:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BB7E2071C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 21:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="LZWsCG8h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgDZVOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 17:14:38 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:48700 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbgDZVOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 17:14:38 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 4C88E6A8;
        Sun, 26 Apr 2020 23:14:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:message-id:date:date
        :subject:subject:from:from:received:received:received; s=
        dkim20160331; t=1587935673; x=1589750074; bh=PUbdbUVGrBs4ZElJBZl
        Vmlmv/2PeGf9jWHZAjk18zDo=; b=LZWsCG8hFeH0X8aLtbsR4eSiq7WOvT6u7ys
        yNe0dfOW2XWL7ZSqpFeQYy5feTwdDS0kPd+gNvKj3ahxk1nl0bG9WPMkkarYCsSz
        BypXnkq3MzTvEOLdrSZNA0iCxLZ8j10nDbuT/70DOYSf0Z4z3/AyPpUYKu8P/h0l
        pvQhX9M0Ukm96Y+/4T2uimf8T02OZY5bBPBZGx4DDhqXP/BtDVICUDWXX/oVaeDB
        wUGqZcF0nsl9opz1bhvVhpMH/UP+uK8+COZDSv0H5sQy16X67AczEEY5L+Lkq+Sa
        LeYHL/aVg5Hftr0QMcGEZmMPYX3Jyl69N/s3YicYdZv2h7+CAMCBL8+z1taMsW4a
        4NhoiN0SMLxRW5O9TjfGBMaHsdZadfu0ingMlhm3JWs/cZ+tBGAiprrpboX0ChY6
        ySAaLbjVic2Js2N8aoCPtaXMgyh/hqfE0D5D8yuPGQB+8ss550jWEvrE3OmjA94X
        6g6fQuY49QZTE5aGwcOy9UK1t4J3E9xgAKT8VJH75iiSv8VXSnl56gjR0S8803E8
        6/wCE9gSoWudemjcdcbjLUqU5BUgg7zoxz5jdqIp/OGYIhDm/+Y95rfeVuA6tC+R
        YIduwxKxEUJEUZn5szg/kz44ofNL60pZw1vRdz9AUxRW5Nu6qkFkszUy7sLfBSSI
        nRbIjBK8=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zna_Bt9pMEqd; Sun, 26 Apr 2020 23:14:33 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 98E90489;
        Sun, 26 Apr 2020 23:14:33 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 2D1CB1ED1;
        Sun, 26 Apr 2020 23:14:33 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH] doc:locking: remove info about old behavior of locktorture
Date:   Sun, 26 Apr 2020 23:14:29 +0200
Message-Id: <20200426211429.29133-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not useful to know what was the default at some point in the
past: remove the information.

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/locking/locktorture.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/locking/locktorture.rst b/Documentation/locking/locktorture.rst
index 5bcb99ba7bd9..8012a74555e7 100644
--- a/Documentation/locking/locktorture.rst
+++ b/Documentation/locking/locktorture.rst
@@ -110,7 +110,7 @@ stutter
 		  same period of time.  Defaults to "stutter=5", so as
 		  to run and pause for (roughly) five-second intervals.
 		  Specifying "stutter=0" causes the test to run continuously
-		  without pausing, which is the old default behavior.
+		  without pausing.
 
 shuffle_interval
 		  The number of seconds to keep the test threads affinitied
-- 
2.25.4

