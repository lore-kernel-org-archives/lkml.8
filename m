Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DC2C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAC1720773
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595262461;
	bh=ygbT07fEEpy7yNsw6HTbFoqbdxvS9+HLSl4J/2X+rKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qDBMZxOoQixs+bViGdZYg15bLQSSaBYXfUnM15mf7Qr+RgyFmyk6hCN72q0f7CVpD
	 tBTMhGN6VxwTvZzUF0/kFuC+UE6b3aoazDd/tkVzTVxeOyqsaDEtT2RmT8baa1xC+6
	 N6hvAvvZBnVvQfcCFQXXP6WRCSBxMc0PVMRKk+bU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388756AbgGTQ1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:27:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:60540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732279AbgGTP7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:59:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90D0E20773;
        Mon, 20 Jul 2020 15:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260780;
        bh=ygbT07fEEpy7yNsw6HTbFoqbdxvS9+HLSl4J/2X+rKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qGO4gIrxV/a7YelbbaqRrhn6jm9vtE3K20yR/PY41/4PDfY/98AZD/225C67f9tgz
         D+iiKoOp8kdJ3NrlE3fIlgQhyLg4pVoOMfudDvoZhPHMVpiPh2jsMmqFWCvjUanlih
         xS8lXQ0UAGFcLJOS3zPABR2P89sQW6ovqat4fx4o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoffer Nielsen <cn@obviux.dk>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 092/215] ALSA: usb-audio: Add registration quirk for Kingston HyperX Cloud Flight S
Date:   Mon, 20 Jul 2020 17:36:14 +0200
Message-Id: <20200720152824.584071352@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152820.122442056@linuxfoundation.org>
References: <20200720152820.122442056@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoffer Nielsen <cn@obviux.dk>

[ Upstream commit 73094608b8e214952444fb104651704c98a37aeb ]

Similar to the Kingston HyperX AMP, the Kingston HyperX Cloud
Alpha S (0951:0x16ea) uses two interfaces, but only the second
interface contains the capture stream. This patch delays the
registration until the second interface appears.

Signed-off-by: Christoffer Nielsen <cn@obviux.dk>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/CAOtG2YHOM3zy+ed9KS-J4HkZo_QGzcUG9MigSp4e4_-13r6B=Q@mail.gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index e2b0de0473103..a8bb953cc4681 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1815,6 +1815,7 @@ struct registration_quirk {
 static const struct registration_quirk registration_quirks[] = {
 	REG_QUIRK_ENTRY(0x0951, 0x16d8, 2),	/* Kingston HyperX AMP */
 	REG_QUIRK_ENTRY(0x0951, 0x16ed, 2),	/* Kingston HyperX Cloud Alpha S */
+	REG_QUIRK_ENTRY(0x0951, 0x16ea, 2),	/* Kingston HyperX Cloud Flight S */
 	{ 0 }					/* terminator */
 };
 
-- 
2.25.1



