Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1A1C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 17:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07C3A207F7
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 17:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388041AbgEWR21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 13:28:27 -0400
Received: from mailomta20-re.btinternet.com ([213.120.69.113]:15347 "EHLO
        re-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387507AbgEWR20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 13:28:26 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-048.btinternet.com with ESMTP
          id <20200523172824.MQWV4003.re-prd-fep-048.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Sat, 23 May 2020 18:28:24 +0100
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=j.oldman998@btinternet.com
X-Originating-IP: [31.53.141.224]
X-OWM-Source-IP: 31.53.141.224 (GB)
X-OWM-Env-Sender: j.oldman998@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduhedrudduhedguddufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofestddtredtredttdenucfhrhhomheplfhohhhnucfqlhgumhgrnhcuoehjohhhnhdrohhlughmrghnsehpohhlvghhihhllhdrtghordhukheqnecuggftrfgrthhtvghrnhepgeeftdfhfeeuiefhgfekfeethedutddtfeduteevleevfedvfefhjeeijefhgffgnecukfhppeefuddrheefrddugedurddvvdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghlohephhgvnhhrhidrhhhomhgvpdhinhgvthepfedurdehfedrudeguddrvddvgedpmhgrihhlfhhrohhmpeeojhhohhhnrdholhgumhgrnhesphholhgvhhhilhhlrdgtohdruhhkqedprhgtphhtthhopeeouggvvhgvlhesughrihhvvghruggvvhdrohhsuhhoshhlrdhorhhgqedprhgtphhtthhopeeoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqedprhgtphhtthhopeeojhhohhhnrdholhgumhgrnhesphholhgvhhhilhhlrdgtohdruhhkqedprhgtphhtthhopeeolhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from henry.home (31.53.141.224) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as j.oldman998@btinternet.com)
        id 5EC3CE9B00C78F15; Sat, 23 May 2020 18:28:24 +0100
From:   John Oldman <john.oldman@polehill.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        John Oldman <john.oldman@polehill.co.uk>
Subject: [PATCH] staging: rtl8192e: Using comparison to true is error prone
Date:   Sat, 23 May 2020 18:28:12 +0100
Message-Id: <20200523172812.16473-1-john.oldman@polehill.co.uk>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clear below issues reported by checkpatch.pl:

CHECK: Using comparison to false is error prone

Signed-off-by: John Oldman <john.oldman@polehill.co.uk>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index d83d72594312..8abc921ecb3e 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -371,7 +371,7 @@ void HTConstructInfoElement(struct rtllib_device *ieee, u8 *posHTInfo,
 	if ((ieee->iw_mode == IW_MODE_ADHOC) ||
 	    (ieee->iw_mode == IW_MODE_MASTER)) {
 		pHTInfoEle->ControlChl	= ieee->current_network.channel;
-		pHTInfoEle->ExtChlOffset = ((pHT->bRegBW40MHz == false) ?
+		pHTInfoEle->ExtChlOffset = ((!pHT->bRegBW40MHz) ?
 					    HT_EXTCHNL_OFFSET_NO_EXT :
 					    (ieee->current_network.channel <= 6)
 					    ? HT_EXTCHNL_OFFSET_UPPER :
@@ -526,7 +526,7 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 	static u8 EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};
 	static u8 EWC11NHTInfo[] = {0x00, 0x90, 0x4c, 0x34};
 
-	if (pHTInfo->bCurrentHTSupport == false) {
+	if (!pHTInfo->bCurrentHTSupport) {
 		netdev_warn(ieee->dev, "%s(): HT_DISABLE\n", __func__);
 		return;
 	}
@@ -873,7 +873,7 @@ void HTSetConnectBwMode(struct rtllib_device *ieee,
 {
 	struct rt_hi_throughput *pHTInfo = ieee->pHTInfo;
 
-	if (pHTInfo->bRegBW40MHz == false)
+	if (!pHTInfo->bRegBW40MHz)
 		return;
 
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
-- 
2.17.1

