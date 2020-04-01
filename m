Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493C5C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24962063A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758667;
	bh=zY/lpwFFc0E/HcNDB2+3mezhODwz8ye/Z4MUjJOMAgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XXXFuyPrW8O19nPZh9XHy74FX1pT8vWaAmpPybDAQBLsgCh/wy567un5Zb5rJZqNV
	 pxNYvew4akyfJLMB4VhOBWkz/nMPitkXcgFb0X4YZGQntXB4FR35vXLx8XrkCMhmzm
	 E3hl6ZXrjwGvzME0Jm9YDZywuQJyluK3LvorsSvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388172AbgDAQbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:31:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387728AbgDAQbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:31:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1441C20658;
        Wed,  1 Apr 2020 16:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758661;
        bh=zY/lpwFFc0E/HcNDB2+3mezhODwz8ye/Z4MUjJOMAgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PORJvEHTlc2Ne/Oc6a/BehK2Az7wP/cP+C5XBrBAuwK9+6Z529hlfFK0CxjowlSBc
         NA0oBqWYlgMWeCglypQxBfFXCHLq1WkN24+3IExh+Z8P6TEV6vKVEmB7lWdcs4ICvh
         TJSQkhpMwyKAXikEI2COxp1zdZtzr1zvl6GHAR6U=
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
Subject: [PATCH 4.4 19/91] staging/speakup: fix get_word non-space look-ahead
Date:   Wed,  1 Apr 2020 18:17:15 +0200
Message-Id: <20200401161519.933171668@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161512.917494101@linuxfoundation.org>
References: <20200401161512.917494101@linuxfoundation.org>
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
 drivers/staging/speakup/main.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/staging/speakup/main.c
+++ b/drivers/staging/speakup/main.c
@@ -562,8 +562,7 @@ static u_long get_word(struct vc_data *v
 		return 0;
 	} else if ((tmpx < vc->vc_cols - 2)
 		   && (ch == SPACE || ch == 0 || IS_WDLM(ch))
-		   && ((char)get_char(vc, (u_short *) &tmp_pos + 1, &temp) >
-		       SPACE)) {
+		   && ((char)get_char(vc, (u_short *)tmp_pos + 1, &temp) > SPACE)) {
 		tmp_pos += 2;
 		tmpx++;
 	} else


