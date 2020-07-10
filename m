Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030FAC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D87FE2078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgGJLbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:31:25 -0400
Received: from mailomta10-sa.btinternet.com ([213.120.69.16]:49431 "EHLO
        sa-prd-fep-045.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727901AbgGJLbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 07:31:25 -0400
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
          by sa-prd-fep-045.btinternet.com with ESMTP
          id <20200710113121.LAUG4112.sa-prd-fep-045.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
          Fri, 10 Jul 2020 12:31:21 +0100
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=j.oldman998@btinternet.com
X-Originating-IP: [31.53.71.41]
X-OWM-Source-IP: 31.53.71.41 (GB)
X-OWM-Env-Sender: j.oldman998@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrvddugdeggecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofestddtredtredttdenucfhrhhomheplfhohhhnucfqlhgumhgrnhcuoehjohhhnhdrohhlughmrghnsehpohhlvghhihhllhdrtghordhukheqnecuggftrfgrthhtvghrnhepgeeftdfhfeeuiefhgfekfeethedutddtfeduteevleevfedvfefhjeeijefhgffgnecukfhppeefuddrheefrdejuddrgedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghlohephhgvnhhrhidrhhhomhgvpdhinhgvthepfedurdehfedrjedurdeguddpmhgrihhlfhhrohhmpeeojhhohhhnrdholhgumhgrnhesphholhgvhhhilhhlrdgtohdruhhkqedprhgtphhtthhopeeonfgrrhhrhidrhfhinhhgvghrsehlfihfihhnghgvrhdrnhgvtheqpdhrtghpthhtohepoeguvghvvghlsegurhhivhgvrhguvghvrdhoshhuohhslhdrohhrgheqpdhrtghpthhtohepoehflhhorhhirghnrdgtrdhstghhihhlhhgrsggvlhesghhoohhglhgvmhgrihhlrdgtohhmqedprhgtphhtthhopeeoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqedprhgtphhtthhopeeojhhohhhnrdholhgumhgrnhesphholhgvhhhilhhlrdgtohdruhhkqedprhgt
        phhtthhopeeolhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from henry.home (31.53.71.41) by sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as j.oldman998@btinternet.com)
        id 5ED9B66106110673; Fri, 10 Jul 2020 12:31:21 +0100
From:   John Oldman <john.oldman@polehill.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        John Oldman <john.oldman@polehill.co.uk>
Subject: [PATCH] staging: rtl8712/: Using comparison to true is error prone
Date:   Fri, 10 Jul 2020 12:31:13 +0100
Message-Id: <20200710113113.1648-1-john.oldman@polehill.co.uk>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clear below issues reported by checkpatch.pl:

CHECK: Using comparison to true is error prone
CHECK: Comparison to NULL should be written "!oldest"

Signed-off-by: John Oldman <john.oldman@polehill.co.uk>
---
 drivers/staging/rtl8712/rtl871x_mlme.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
index 9ee1bfac0763..2ccd49032206 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -264,13 +264,13 @@ struct	wlan_network *r8712_get_oldest_wlan_network(
 	phead = &scanned_queue->queue;
 	plist = phead->next;
 	while (1) {
-		if (end_of_queue_search(phead, plist) ==  true)
+		if (end_of_queue_search(phead, plist))
 			break;
 		pwlan = container_of(plist, struct wlan_network, list);
-		if (pwlan->fixed != true) {
-			if (oldest == NULL ||
+		if (!pwlan->fixed) {
+			if (!oldest ||
 			    time_after((unsigned long)oldest->last_scanned,
-			    (unsigned long)pwlan->last_scanned))
+				       (unsigned long)pwlan->last_scanned))
 				oldest = pwlan;
 		}
 		plist = plist->next;
--
2.17.1

