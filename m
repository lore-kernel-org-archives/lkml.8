Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C741C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99BE208D6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585055617;
	bh=6OrOnoiINJv+m8teJLQrQHUPd38IaKQ8DMAFSfTiJIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BAB+rz8Kk2sZpaSTIvWLgDPssA8jXREE5gwrNsGL9v9z2G/kwkC3Lrz0ljJsMFWKP
	 8YoawGZ50C+RSxPwYP8wApiSJK4OBMLW3qra2t7Um+IBc0b5p2/RhxY0ND6SIRHIDH
	 TZ3KGLgG9i1f9C23jHNC/8RYuPTTqphLp3pRlR2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgCXNNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:13:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727891AbgCXNNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:13:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF58E20775;
        Tue, 24 Mar 2020 13:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585055612;
        bh=6OrOnoiINJv+m8teJLQrQHUPd38IaKQ8DMAFSfTiJIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BnHqFhYiXnKbJrdDHsOJTMPqPXTHnmiVLYbkbPolLI3CkYiTWBoR+Ir6Lm0SMWnFN
         /8QTxfp0qHjm6l1GNXC8Omn/TwFwRQa6HerFoZzSUuJMbJg1Zd0dPfbH+SmUizkUV6
         zSzX0Zq+tvh+zgp9NwQIBpVaQHXNndTInWJNwRXk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kirk Reiser <kirk@reisers.ca>,
        Janina Sajka <janina@rednote.net>,
        Alexandr Epaneshnikov <aarnaarn2@gmail.com>,
        Gregory Nowak <greg@gregn.net>,
        deedra waters <deedra@the-brannons.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Michael Taboada <michael@michaels.world>
Subject: [PATCH 4.19 39/65] staging/speakup: fix get_word non-space look-ahead
Date:   Tue, 24 Mar 2020 14:11:00 +0100
Message-Id: <20200324130802.127328483@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130756.679112147@linuxfoundation.org>
References: <20200324130756.679112147@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Thibault <samuel.thibault@ens-lyon.org>

commit 9d32c0cde4e2d1343dfb88a67b2ec6397705b32b upstream.

get_char was erroneously given the address of the pointer to the text
instead of the address of the text, thus leading to random crashes when
the user requests speaking a word while the current position is on a space
character and say_word_ctl is not enabled.

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
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200306003047.thijtmqrnayd3dmw@function
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/speakup/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/speakup/main.c
+++ b/drivers/staging/speakup/main.c
@@ -561,7 +561,7 @@ static u_long get_word(struct vc_data *v
 		return 0;
 	} else if (tmpx < vc->vc_cols - 2 &&
 		   (ch == SPACE || ch == 0 || (ch < 0x100 && IS_WDLM(ch))) &&
-		   get_char(vc, (u_short *)&tmp_pos + 1, &temp) > SPACE) {
+		   get_char(vc, (u_short *)tmp_pos + 1, &temp) > SPACE) {
 		tmp_pos += 2;
 		tmpx++;
 	} else {


