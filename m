Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6547AC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4493F20775
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587550166;
	bh=N+GGMNKW/JFvjmBMb+4QP9mEOUrcme01ULE5WsNGBmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KpJKSIyK0zwUasXf8bq0xCEwAY+p9fPtzPsmtUZ0IVw7KWxX7naQEYKpxineswW3j
	 jGAroxM+lpyz61+atA97mMz9l8wZxsc98CQ9SUID1Reiyru1P85ehNEx1uoM7aAwCi
	 SfH5fvjUNiacqh8xjMYRi0husDGyE7XoBhtgUQII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgDVKJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:09:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728857AbgDVKJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:09:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D15E620780;
        Wed, 22 Apr 2020 10:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550160;
        bh=N+GGMNKW/JFvjmBMb+4QP9mEOUrcme01ULE5WsNGBmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O6OnNFn4dkjNEmU/+XRNV5g3mZ/Gxf+PpqG19SKcqDsmz5RE7oCPvKSSKpvDBm0CS
         1SA/S/4YJAWS9Tm9lF/nrKf4SbQQoJlh0fSxDtI7V4w7h9MXnRD/aI5Pt5qyAfzPFk
         njkTUBSVBcbBaQ9DWSIOIV0A9iadsc1ZQXwm2Cmc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gyeongtaek Lee <gt82.lee@samsung.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 033/199] ASoC: dapm: connect virtual mux with default value
Date:   Wed, 22 Apr 2020 11:55:59 +0200
Message-Id: <20200422095101.374764409@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095057.806111593@linuxfoundation.org>
References: <20200422095057.806111593@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: 이경택 <gt82.lee@samsung.com>

commit 3bbbb7728fc853d71dbce4073fef9f281fbfb4dd upstream.

Since a virtual mixer has no backing registers
to decide which path to connect,
it will try to match with initial state.
This is to ensure that the default mixer choice will be
correctly powered up during initialization.
Invert flag is used to select initial state of the virtual switch.
Since actual hardware can't be disconnected by virtual switch,
connected is better choice as initial state in many cases.

Signed-off-by: Gyeongtaek Lee <gt82.lee@samsung.com>
Link: https://lore.kernel.org/r/01a301d60731$b724ea10$256ebe30$@samsung.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/soc-dapm.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -799,7 +799,13 @@ static void dapm_set_mixer_path_status(s
 			val = max - val;
 		p->connect = !!val;
 	} else {
-		p->connect = 0;
+		/* since a virtual mixer has no backing registers to
+		 * decide which path to connect, it will try to match
+		 * with initial state.  This is to ensure
+		 * that the default mixer choice will be
+		 * correctly powered up during initialization.
+		 */
+		p->connect = invert;
 	}
 }
 


