Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE923C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 00:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C76F20726
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 00:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgCFAav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 19:30:51 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:37088 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgCFAav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 19:30:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 9A4E83B0E;
        Fri,  6 Mar 2020 01:30:49 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uOTh074kySs1; Fri,  6 Mar 2020 01:30:48 +0100 (CET)
Received: from function (lfbn-bor-1-797-11.w86-234.abo.wanadoo.fr [86.234.239.11])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id BE5A93AC8;
        Fri,  6 Mar 2020 01:30:48 +0100 (CET)
Received: from samy by function with local (Exim 4.93)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1jA0t5-001u79-U1; Fri, 06 Mar 2020 01:30:47 +0100
Date:   Fri, 6 Mar 2020 01:30:47 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     akpm@linux-foundation.org
Cc:     speakup@braille.uwo.ca, linux-kernel@vger.kernel.org
Subject: [PATCH] staging/speakup: fix get_word non-space look-ahead
Message-ID: <20200306003047.thijtmqrnayd3dmw@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        akpm@linux-foundation.org, speakup@braille.uwo.ca,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_char was erroneously given the address of the pointer to the text
instead of the address of the text, thus leading to random crashes when
the user requests speaking a word while the current position is on a space
character and say_word_ctl is not enabled.

Cc: stable@vger.kernel.org
Reported-on: https://github.com/bytefire/speakup/issues/1
Reported-by: Kirk Reiser <kirk@reisers.ca>
Reported-by: Janina Sajka <janina@rednote.net>
Reported-by: Alexandr Epaneshnikov <aarnaarn2@gmail.com>
Reported-by: Gregory Nowak <greg@gregn.net>
Reported-by: deedra waters <deedra@the-brannons.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Tested-by: Alexandr Epaneshnikov <aarnaarn2@gmail.com>
Tested-by: Gregory Nowak <greg@gregn.net>
Tested-by: Michael Taboada <michael@michaels.world>
---
 drivers/staging/speakup/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/speakup/main.c b/drivers/staging/speakup/main.c
index 488f2539aa9a..81ecfd1a200d 100644
--- a/drivers/staging/speakup/main.c
+++ b/drivers/staging/speakup/main.c
@@ -561,7 +561,7 @@ static u_long get_word(struct vc_data *vc)
 		return 0;
 	} else if (tmpx < vc->vc_cols - 2 &&
 		   (ch == SPACE || ch == 0 || (ch < 0x100 && IS_WDLM(ch))) &&
-		   get_char(vc, (u_short *)&tmp_pos + 1, &temp) > SPACE) {
+		   get_char(vc, (u_short *)tmp_pos + 1, &temp) > SPACE) {
 		tmp_pos += 2;
 		tmpx++;
 	} else {
-- 
2.20.1

