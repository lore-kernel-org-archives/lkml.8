Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983E5C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 740C1206BF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgD0NxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 09:53:01 -0400
Received: from mailomta26-re.btinternet.com ([213.120.69.119]:61953 "EHLO
        re-prd-fep-047.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727782AbgD0NxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 09:53:01 -0400
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
          by re-prd-fep-047.btinternet.com with ESMTP
          id <20200427135259.OJNJ11726.re-prd-fep-047.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>;
          Mon, 27 Apr 2020 14:52:59 +0100
Authentication-Results: btinternet.com; none
X-Originating-IP: [31.51.225.56]
X-OWM-Source-IP: 31.51.225.56 (GB)
X-OWM-Env-Sender: j.oldman998@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduhedrheelgdeijecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhestddtredtredttdenucfhrhhomheplfhohhhnucfqlhgumhgrnhcuoehjohhhnhdrohhlughmrghnsehpohhlvghhihhllhdrtghordhukheqnecukfhppeefuddrhedurddvvdehrdehieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehhvghnrhihrdhhohhmvgdpihhnvghtpeefuddrhedurddvvdehrdehiedpmhgrihhlfhhrohhmpeeojhhohhhnrdholhgumhgrnhesphholhgvhhhilhhlrdgtohdruhhkqedprhgtphhtthhopeeouggvvhgvlhesughrihhvvghruggvvhdrohhsuhhoshhlrdhorhhgqedprhgtphhtthhopeeoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqedprhgtphhtthhopeeohhhslhgvshhtvghrleeisehgmhgrihhlrdgtohhmqedprhgtphhtthhopeeojhhohhhnrdholhgumhgrnhesphholhgvhhhilhhlrdgtohdruhhkqedprhgtphhtthhopeeolhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from henry.home (31.51.225.56) by re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as j.oldman998@btinternet.com)
        id 5E3A181A0D612D88; Mon, 27 Apr 2020 14:52:59 +0100
From:   John Oldman <john.oldman@polehill.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     hslester96@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        John Oldman <john.oldman@polehill.co.uk>
Subject: [PATCH 2/2] drivers: staging: rts5208: rtsx.c fix Unbalanced braces around else statement issue
Date:   Mon, 27 Apr 2020 14:52:12 +0100
Message-Id: <20200427135212.26285-2-john.oldman@polehill.co.uk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427135212.26285-1-john.oldman@polehill.co.uk>
References: <20200427135212.26285-1-john.oldman@polehill.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make a better job of fixing coding style issues, this time fixing 
all blocks as per Joe Perches' comment.

Signed-off-by: John Oldman <john.oldman@polehill.co.uk>
---
 drivers/staging/rts5208/rtsx.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
index ca836ca2ee81..e16a7b9c3203 100644
--- a/drivers/staging/rts5208/rtsx.c
+++ b/drivers/staging/rts5208/rtsx.c
@@ -402,19 +402,15 @@ static int rtsx_control_thread(void *__dev)
 		if (chip->srb->sc_data_direction == DMA_BIDIRECTIONAL) {
 			dev_err(&dev->pci->dev, "UNKNOWN data direction\n");
 			chip->srb->result = DID_ERROR << 16;
-		}
-
-		/* reject if target != 0 or if LUN is higher than
-		 * the maximum known LUN
-		 */
-		else if (chip->srb->device->id) {
+		} else if (chip->srb->device->id) {
+			/* reject if target != 0 or if LUN is higher than
+			 * the maximum known LUN
+			 */
 			dev_err(&dev->pci->dev, "Bad target number (%d:%d)\n",
 				chip->srb->device->id,
 				(u8)chip->srb->device->lun);
 			chip->srb->result = DID_BAD_TARGET << 16;
-		}
-
-		else if (chip->srb->device->lun > chip->max_lun) {
+		} else if (chip->srb->device->lun > chip->max_lun) {
 			dev_err(&dev->pci->dev, "Bad LUN (%d:%d)\n",
 				chip->srb->device->id,
 				(u8)chip->srb->device->lun);
-- 
2.17.1

