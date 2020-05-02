Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32307C47247
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 22:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B4C92072E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 22:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kocurkovo.cz header.i=@kocurkovo.cz header.b="mH0Hzzoz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgEBWQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 18:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728530AbgEBWQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 18:16:48 -0400
Received: from mail.kocurkovo.cz (unknown [IPv6:2a02:2b88:2:1::5b29:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E966DC061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 15:16:47 -0700 (PDT)
Received: by mail.kocurkovo.cz (Postfix, from userid 1000)
        id B192612C2; Sun,  3 May 2020 00:16:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.kocurkovo.cz B192612C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kocurkovo.cz;
        s=mail; t=1588457803;
        bh=D1yVzfofhzgl2jyS+MzwMI9d59GdyX9BHALuoik3STQ=;
        h=From:To:Cc:Subject:Date:From;
        b=mH0HzzozQRISqFyg6F0oBk+M4cXj6maqRPhSb1QQ2JlzojRmC61ZROcAfKCkcWKy7
         a6Vqrt8K8G9fTKil4xr4miYZAtTfpp2P3xihoPZ2tc7k+19dywu7CGeDg/V55fQFl5
         wxkSV125aSLm9KkBHbJv6BpnXy5Tw4CCI9ljjZH4=
From:   Matej Dujava <mdujava@kocurkovo.cz>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Stefano Brivio <sbrivio@redhat.com>,
        Briana Oursler <briana.oursler@gmail.com>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        Matej Dujava <mdujava@kocurkovo.cz>
Subject: [PATCH 1/2] staging: vt6655: return early if not bNeedAck
Date:   Sun,  3 May 2020 00:16:33 +0200
Message-Id: <1588457794-31438-1-git-send-email-mdujava@kocurkovo.cz>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will check for bNeedAck before making bb_get_frame_time call, so
in case we dont need uAckTime, we can return early.

Signed-off-by: Matej Dujava <mdujava@kocurkovo.cz>
---
 drivers/staging/vt6655/rxtx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 2f9c2ead3cb8..dda578436e64 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -166,15 +166,16 @@ s_uGetTxRsvTime(
 	unsigned int uDataTime, uAckTime;
 
 	uDataTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, cbFrameLength, wRate);
+
+	if (!bNeedAck)
+		return uDataTime;
+
 	if (byPktType == PK_TYPE_11B) /* llb,CCK mode */
 		uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, (unsigned short)pDevice->byTopCCKBasicRate);
 	else /* 11g 2.4G OFDM mode & 11a 5G OFDM mode */
 		uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, (unsigned short)pDevice->byTopOFDMBasicRate);
 
-	if (bNeedAck)
-		return uDataTime + pDevice->uSIFS + uAckTime;
-	else
-		return uDataTime;
+	return uDataTime + pDevice->uSIFS + uAckTime;
 }
 
 static __le16 vnt_rxtx_rsvtime_le16(struct vnt_private *priv, u8 pkt_type,
-- 
2.26.2

