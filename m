Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85799C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6364B2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgHYE6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 00:58:46 -0400
Received: from smtprelay0180.hostedemail.com ([216.40.44.180]:33390 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728533AbgHYE5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:57:20 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id DA32C181D337B;
        Tue, 25 Aug 2020 04:57:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: low63_3a0323c27059
X-Filterd-Recvd-Size: 1653
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Aug 2020 04:57:16 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH 19/29] s390/tty3270: Avoid comma separated statements
Date:   Mon, 24 Aug 2020 21:56:16 -0700
Message-Id: <9988babd9cca4ac841961d9f0bbf5e49caa87659.1598331149.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1598331148.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use semicolons and braces.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/s390/char/tty3270.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
index aec996de44d9..6acce975df26 100644
--- a/drivers/s390/char/tty3270.c
+++ b/drivers/s390/char/tty3270.c
@@ -424,8 +424,10 @@ tty3270_update(struct timer_list *t)
 			 * last output position matches the start address
 			 * of this line.
 			 */
-			if (s->string[1] == sba[0] && s->string[2] == sba[1])
-				str += 3, len -= 3;
+			if (s->string[1] == sba[0] && s->string[2] == sba[1]) {
+				str += 3;
+				len -= 3;
+			}
 			if (raw3270_request_add_data(wrq, str, len) != 0)
 				break;
 			list_del_init(&s->update);
-- 
2.26.0

