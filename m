Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51565C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 01:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B73120789
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 01:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgHBBok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 21:44:40 -0400
Received: from smtprelay0215.hostedemail.com ([216.40.44.215]:56280 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726545AbgHBBok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 21:44:40 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 3E3BE12EC;
        Sun,  2 Aug 2020 01:44:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pail64_3c16b0526f91
X-Filterd-Recvd-Size: 6029
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sun,  2 Aug 2020 01:44:38 +0000 (UTC)
Message-ID: <f8dd21b5000d4def1de9e79f32433f22da5b33d7.camel@perches.com>
Subject: Re: [PATCH] staging: rts5208: clear alignment style issues
From:   Joe Perches <joe@perches.com>
To:     Tomer Samara <tomersamara98@gmail.com>, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Sat, 01 Aug 2020 18:44:37 -0700
In-Reply-To: <20200801210056.GA305272@tsnow>
References: <20200801210056.GA305272@tsnow>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-08-02 at 00:00 +0300, Tomer Samara wrote:
>   Clear checkpatch alignment style issues in rtsx_transport.c.
>   CHECK: Alignment should match open parenthesis
[]
> diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
[]
> @@ -678,7 +678,7 @@ static int rtsx_transfer_buf(struct rtsx_chip *chip, u8 card, void *buf,
>  
>  	/* Wait for TRANS_OK_INT */
>  	timeleft = wait_for_completion_interruptible_timeout(&trans_done,
> -			msecs_to_jiffies(timeout));
> +							     msecs_to_jiffies(timeout));
>  	if (timeleft <= 0) {
>  		dev_dbg(rtsx_dev(chip), "Timeout (%s %d)\n",
>  			__func__, __LINE__);

Always try to improve the code rather than just
shut up checkpatch warnings.

Perhaps it's more sensible to centralize the uses of
wait_for_completion_interruptible_timeout.

Something like:
---
 drivers/staging/rts5208/rtsx_transport.c | 36 +++++++++++++-------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index 5f1eefe80f1e..269ff1be7cba 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -222,12 +222,18 @@ void rtsx_send_cmd_no_wait(struct rtsx_chip *chip)
 	rtsx_writel(chip, RTSX_HCBCTLR, val);
 }
 
+static inline bool rtsx_wait(struct completion *comp, int timeout)
+{
+	unsigned long t = msecs_to_jiffies(timeout);
+
+	return wait_for_completion_interruptible_timeout(comp, t) > 0;
+}
+
 int rtsx_send_cmd(struct rtsx_chip *chip, u8 card, int timeout)
 {
 	struct rtsx_dev *rtsx = chip->rtsx;
 	struct completion trans_done;
 	u32 val = BIT(31);
-	long timeleft;
 	int err = 0;
 
 	if (card == SD_CARD)
@@ -257,9 +263,8 @@ int rtsx_send_cmd(struct rtsx_chip *chip, u8 card, int timeout)
 	spin_unlock_irq(&rtsx->reg_lock);
 
 	/* Wait for TRANS_OK_INT */
-	timeleft = wait_for_completion_interruptible_timeout(
-		&trans_done, msecs_to_jiffies(timeout));
-	if (timeleft <= 0) {
+
+	if (!rtsx_wait(&trans_done, timeout)) {
 		dev_dbg(rtsx_dev(chip), "chip->int_reg = 0x%x\n",
 			chip->int_reg);
 		err = -ETIMEDOUT;
@@ -322,7 +327,6 @@ static int rtsx_transfer_sglist_adma_partial(struct rtsx_chip *chip, u8 card,
 	u8 dir;
 	int sg_cnt, i, resid;
 	int err = 0;
-	long timeleft;
 	struct scatterlist *sg_ptr;
 	u32 val = TRIG_DMA;
 
@@ -419,9 +423,7 @@ static int rtsx_transfer_sglist_adma_partial(struct rtsx_chip *chip, u8 card,
 
 	spin_unlock_irq(&rtsx->reg_lock);
 
-	timeleft = wait_for_completion_interruptible_timeout(
-		&trans_done, msecs_to_jiffies(timeout));
-	if (timeleft <= 0) {
+	if (!rtsx_wait(&trans_done, timeout)) {
 		dev_dbg(rtsx_dev(chip), "Timeout (%s %d)\n",
 			__func__, __LINE__);
 		dev_dbg(rtsx_dev(chip), "chip->int_reg = 0x%x\n",
@@ -443,9 +445,7 @@ static int rtsx_transfer_sglist_adma_partial(struct rtsx_chip *chip, u8 card,
 	if (rtsx->trans_result == TRANS_NOT_READY) {
 		init_completion(&trans_done);
 		spin_unlock_irq(&rtsx->reg_lock);
-		timeleft = wait_for_completion_interruptible_timeout(
-			&trans_done, msecs_to_jiffies(timeout));
-		if (timeleft <= 0) {
+		if (!rtsx_wait(&trans_done, timeout)) {
 			dev_dbg(rtsx_dev(chip), "Timeout (%s %d)\n",
 				__func__, __LINE__);
 			dev_dbg(rtsx_dev(chip), "chip->int_reg = 0x%x\n",
@@ -486,7 +486,6 @@ static int rtsx_transfer_sglist_adma(struct rtsx_chip *chip, u8 card,
 	u8 dir;
 	int buf_cnt, i;
 	int err = 0;
-	long timeleft;
 	struct scatterlist *sg_ptr;
 
 	if (!sg || (num_sg <= 0))
@@ -563,9 +562,7 @@ static int rtsx_transfer_sglist_adma(struct rtsx_chip *chip, u8 card,
 
 		spin_unlock_irq(&rtsx->reg_lock);
 
-		timeleft = wait_for_completion_interruptible_timeout(
-			&trans_done, msecs_to_jiffies(timeout));
-		if (timeleft <= 0) {
+		if (!rtsx_wait(&trans_done, timeout)) {
 			dev_dbg(rtsx_dev(chip), "Timeout (%s %d)\n",
 				__func__, __LINE__);
 			dev_dbg(rtsx_dev(chip), "chip->int_reg = 0x%x\n",
@@ -590,9 +587,7 @@ static int rtsx_transfer_sglist_adma(struct rtsx_chip *chip, u8 card,
 	if (rtsx->trans_result == TRANS_NOT_READY) {
 		init_completion(&trans_done);
 		spin_unlock_irq(&rtsx->reg_lock);
-		timeleft = wait_for_completion_interruptible_timeout(
-			&trans_done, msecs_to_jiffies(timeout));
-		if (timeleft <= 0) {
+		if (!rtsx_wait(&trans_done, timeout)) {
 			dev_dbg(rtsx_dev(chip), "Timeout (%s %d)\n",
 				__func__, __LINE__);
 			dev_dbg(rtsx_dev(chip), "chip->int_reg = 0x%x\n",
@@ -633,7 +628,6 @@ static int rtsx_transfer_buf(struct rtsx_chip *chip, u8 card, void *buf,
 	u8 dir;
 	int err = 0;
 	u32 val = BIT(31);
-	long timeleft;
 
 	if (!buf || (len <= 0))
 		return -EIO;
@@ -677,9 +671,7 @@ static int rtsx_transfer_buf(struct rtsx_chip *chip, u8 card, void *buf,
 	spin_unlock_irq(&rtsx->reg_lock);
 
 	/* Wait for TRANS_OK_INT */
-	timeleft = wait_for_completion_interruptible_timeout(&trans_done,
-			msecs_to_jiffies(timeout));
-	if (timeleft <= 0) {
+	if (!rtsx_wait(&trans_done, timeout)) {
 		dev_dbg(rtsx_dev(chip), "Timeout (%s %d)\n",
 			__func__, __LINE__);
 		dev_dbg(rtsx_dev(chip), "chip->int_reg = 0x%x\n",


