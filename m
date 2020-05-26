Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251A6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F17B82053B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520651;
	bh=GhCaJpooWSavZpBdhK6aphQyLv9d4skXugYJfXJu21A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h+7zzo/rNAGt4tdOKmnX/QkAI27oTYubkmnIkoLWgPcjK3KBTT2T2nQ6sHE0XYskC
	 1xXi5ZeeMmjBbqibbkV0S7K0t91pu9+IA//ajFTlGQX8D/b0XpX7akxZtXaEbd3aTA
	 cAemXBikFmD24gFEjRU84WmCFLJFO6nyXI0/ZkfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392179AbgEZTRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:17:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404049AbgEZTOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:14:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C610F20776;
        Tue, 26 May 2020 19:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520473;
        bh=GhCaJpooWSavZpBdhK6aphQyLv9d4skXugYJfXJu21A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZugkH7W1Pi+D0FYBhsTi/W1r3qLem3WapDoPclmUV1H/bZm6RVVz/dHzIdkyjx6H3
         qPUBw5CPL3d2R+60VrxdJ/oh3mZMEs1tqhKXVnPqMdPOq9vedtB/yX3LrrcANjKkYl
         WKzZhKVgWcY+nPZJ39cu+zvSXOEbKJkwYLwpSrCs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oscar Carter <oscar.carter@gmx.com>
Subject: [PATCH 5.6 093/126] staging: greybus: Fix uninitialized scalar variable
Date:   Tue, 26 May 2020 20:53:50 +0200
Message-Id: <20200526183945.702273669@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183937.471379031@linuxfoundation.org>
References: <20200526183937.471379031@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Carter <oscar.carter@gmx.com>

commit 34625c1931f8204c234c532b446b9f53c69f4b68 upstream.

In the "gb_tty_set_termios" function the "newline" variable is declared
but not initialized. So the "flow_control" member is not initialized and
the OR / AND operations with itself results in an undefined value in
this member.

The purpose of the code is to set the flow control type, so remove the
OR / AND self operator and set the value directly.

Addresses-Coverity-ID: 1374016 ("Uninitialized scalar variable")
Fixes: e55c25206d5c9 ("greybus: uart: Handle CRTSCTS flag in termios")
Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200510101426.23631-1-oscar.carter@gmx.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/greybus/uart.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -537,9 +537,9 @@ static void gb_tty_set_termios(struct tt
 	}
 
 	if (C_CRTSCTS(tty) && C_BAUD(tty) != B0)
-		newline.flow_control |= GB_SERIAL_AUTO_RTSCTS_EN;
+		newline.flow_control = GB_SERIAL_AUTO_RTSCTS_EN;
 	else
-		newline.flow_control &= ~GB_SERIAL_AUTO_RTSCTS_EN;
+		newline.flow_control = 0;
 
 	if (memcmp(&gb_tty->line_coding, &newline, sizeof(newline))) {
 		memcpy(&gb_tty->line_coding, &newline, sizeof(newline));


