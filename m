Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E01C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62420206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579216849;
	bh=XektWf3zW37nk1kOtAVdPkyILWCRcHRLoANlMME9h1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NfuLb4COnXUtLnMkAAaPE8LHLBenrQPUNV1ESf+DA5C8zIrKwpX1k/aKmsXdY3FLW
	 J96Ohp94qokzTIb9mW6LcoolxkLWp1NVvxB/1suDrwUmOxza5OSW7wdFRghe/xUkNB
	 q3Ot922Qz0XFZNk7GCLC5EwhXYGhJozH2LolwYHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390594AbgAPXUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:20:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:47456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390714AbgAPXUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:20:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19BCC206D9;
        Thu, 16 Jan 2020 23:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579216843;
        bh=XektWf3zW37nk1kOtAVdPkyILWCRcHRLoANlMME9h1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XFbAoCiwxDG+ynl1E2s2PP4aXhC1WDV2xlSYcQ4cPhdGY78F+SjzlNVVIo/tPFq6W
         J4ICB9/R86958arqwo6x1SNhPn7/eljsdMnRWtwF+BEj5wgdYCa5ADgQxCdo8ZwrNQ
         usZ85rZd3O9DIKMrg24hEdQ3Wv1RiZJsu9qKNTgg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.4 042/203] can: j1939: fix address claim code example
Date:   Fri, 17 Jan 2020 00:15:59 +0100
Message-Id: <20200116231747.702107970@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>

commit 8ac9d71d601374222a230804e419cd40c4492e1c upstream.

During development the define J1939_PGN_ADDRESS_REQUEST was renamed to
J1939_PGN_REQUEST. It was forgotten to adjust the documentation
accordingly.

This patch fixes the name of the symbol.

Reported-by: https://github.com/linux-can/can-utils/issues/159#issuecomment-556538798
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/networking/j1939.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Documentation/networking/j1939.rst
+++ b/Documentation/networking/j1939.rst
@@ -339,7 +339,7 @@ To claim an address following code examp
 			.pgn = J1939_PGN_ADDRESS_CLAIMED,
 			.pgn_mask = J1939_PGN_PDU1_MAX,
 		}, {
-			.pgn = J1939_PGN_ADDRESS_REQUEST,
+			.pgn = J1939_PGN_REQUEST,
 			.pgn_mask = J1939_PGN_PDU1_MAX,
 		}, {
 			.pgn = J1939_PGN_ADDRESS_COMMANDED,


