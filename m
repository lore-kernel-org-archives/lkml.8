Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B2BC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8ED2073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579199866;
	bh=xx4UqIPmLrHNwKKlrrKlY0jHmf6xvRxEm1FuQb0g0a0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gN7mEmO+lI0/6lQugQ65n8/KG2DbbdRMr6dVAF/3nfYb1KyCDzp0iJ8OlY9iyehKY
	 i8rkKNwf24KcQ85pyDfnSufNJ7g5L7PqZeIlGVLaQKU0XG3zSK/5UB2tZEycvICFVS
	 pMTAVfYUfOiiY+lTBE1NkBGrp5432TvvP8cal6rc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407177AbgAPShp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:37:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:56150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729030AbgAPRMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:12:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DC6D246A7;
        Thu, 16 Jan 2020 17:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194766;
        bh=xx4UqIPmLrHNwKKlrrKlY0jHmf6xvRxEm1FuQb0g0a0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HW4guIKaH0BKB4VDIGCF7dZlt5e98mhj/7yWJrpIWxhLnbbKr7XEeQ9EpQTx/acoo
         +5O6CYSoXJ+lWqVnEN7V3iskbihpo1bfwYCUzGK9W1oVhTSXMhc130PWXNr3rIiAC6
         /TgFqfE749P2vpifUSzazdZgNUth3MDv2cgrEw60=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexandra Winter <wintera@linux.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 586/671] s390/qeth: Fix error handling during VNICC initialization
Date:   Thu, 16 Jan 2020 12:03:44 -0500
Message-Id: <20200116170509.12787-323-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandra Winter <wintera@linux.ibm.com>

[ Upstream commit b528965bcc827dad32a8d21745feaacfc76c9703 ]

Smatch discovered the use of uninitialized variable sup_cmds
in error paths.

Fixes: caa1f0b10d18 ("s390/qeth: add VNICC enable/disable support")
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_l2_main.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 95669d47c389..cf3b15ebcf75 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -2331,10 +2331,10 @@ static bool qeth_l2_vnicc_recover_char(struct qeth_card *card, u32 vnicc,
 static void qeth_l2_vnicc_init(struct qeth_card *card)
 {
 	u32 *timeout = &card->options.vnicc.learning_timeout;
+	bool enable, error = false;
 	unsigned int chars_len, i;
 	unsigned long chars_tmp;
 	u32 sup_cmds, vnicc;
-	bool enable, error;
 
 	QETH_CARD_TEXT(card, 2, "vniccini");
 	/* reset rx_bcast */
@@ -2355,7 +2355,10 @@ static void qeth_l2_vnicc_init(struct qeth_card *card)
 	chars_len = sizeof(card->options.vnicc.sup_chars) * BITS_PER_BYTE;
 	for_each_set_bit(i, &chars_tmp, chars_len) {
 		vnicc = BIT(i);
-		qeth_l2_vnicc_query_cmds(card, vnicc, &sup_cmds);
+		if (qeth_l2_vnicc_query_cmds(card, vnicc, &sup_cmds)) {
+			sup_cmds = 0;
+			error = true;
+		}
 		if (!(sup_cmds & IPA_VNICC_SET_TIMEOUT) ||
 		    !(sup_cmds & IPA_VNICC_GET_TIMEOUT))
 			card->options.vnicc.getset_timeout_sup &= ~vnicc;
@@ -2364,8 +2367,8 @@ static void qeth_l2_vnicc_init(struct qeth_card *card)
 			card->options.vnicc.set_char_sup &= ~vnicc;
 	}
 	/* enforce assumed default values and recover settings, if changed  */
-	error = qeth_l2_vnicc_recover_timeout(card, QETH_VNICC_LEARNING,
-					      timeout);
+	error |= qeth_l2_vnicc_recover_timeout(card, QETH_VNICC_LEARNING,
+					       timeout);
 	chars_tmp = card->options.vnicc.wanted_chars ^ QETH_VNICC_DEFAULT;
 	chars_tmp |= QETH_VNICC_BRIDGE_INVISIBLE;
 	chars_len = sizeof(card->options.vnicc.wanted_chars) * BITS_PER_BYTE;
-- 
2.20.1

