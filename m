Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34647C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 02:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 126FA2173E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 02:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K7iPfpeN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgHFCTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 22:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgHFCTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 22:19:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF85C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 19:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=d/5tYSPx//jC7rHKuQ0NrtE7qKrw9QWpaF47ZBatM8M=; b=K7iPfpeNTS9MaFHtB8NSVvGfRa
        onCs1gncN4P/rxe+/QT4j1Uo5iwfFpySmBsgwiE/xRGgMmfJCio2CUAVu2llg35ftp2KfWFN4AYZy
        nQ45K0/hIjT7b4PLikl8n/ce8k/uzGXdDJ9/pwSh+C/BeLAmFgBe3IkpkmEMo8VTj3leq6oqyBPXX
        kugyLbn1z8vHYRFfMu6g7ZwKvML8LfBsqN1t2QXVV+EwQ34EQ4PZVO8NI70amI95+F9JXF29F4qfH
        kqJalyJ7gtsmVd1M8riAT9tRUTtLT+mkx+m3jaey0Ld+tu7Wi6qsiUsxCgekdtmZhV1kDnB6yJmUJ
        CaiORaug==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3VV1-0007tP-OS; Thu, 06 Aug 2020 02:19:21 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH] sound: isa: delete repeated words in comments
Date:   Wed,  5 Aug 2020 19:19:16 -0700
Message-Id: <20200806021916.32369-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop duplicated words in sound/isa/.
{be, bit}

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
---
 sound/isa/cs423x/cs4236_lib.c |    2 +-
 sound/isa/es18xx.c            |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200805.orig/sound/isa/cs423x/cs4236_lib.c
+++ linux-next-20200805/sound/isa/cs423x/cs4236_lib.c
@@ -39,7 +39,7 @@
  *     D7: consumer serial port enable (CS4237B,CS4238B)
  *     D6: channels status block reset (CS4237B,CS4238B)
  *     D5: user bit in sub-frame of digital audio data (CS4237B,CS4238B)
- *     D4: validity bit bit in sub-frame of digital audio data (CS4237B,CS4238B)
+ *     D4: validity bit in sub-frame of digital audio data (CS4237B,CS4238B)
  * 
  *  C5  lower channel status (digital serial data description) (CS4237B,CS4238B)
  *     D7-D6: first two bits of category code
--- linux-next-20200805.orig/sound/isa/es18xx.c
+++ linux-next-20200805/sound/isa/es18xx.c
@@ -955,7 +955,7 @@ static int snd_es18xx_info_mux(struct sn
 	case 0x1887:
 	case 0x1888:
 		return snd_ctl_enum_info(uinfo, 1, 5, texts5Source);
-	case 0x1869: /* DS somewhat contradictory for 1869: could be be 5 or 8 */
+	case 0x1869: /* DS somewhat contradictory for 1869: could be 5 or 8 */
 	case 0x1879:
 		return snd_ctl_enum_info(uinfo, 1, 8, texts8Source);
 	default:
