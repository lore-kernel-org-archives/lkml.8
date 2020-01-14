Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C9CC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB7D2467A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996779;
	bh=5HIOlXodj6KSKqOwuWlEHpU/UGJ5CaP6WiWWcZyXtGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xN1FJP9EclUr+NFhO8cI4z/2K2PbVShyAyinITjXlE2StjZGEPrPVZ46HOJDgvA/6
	 XkaBjCShv7pm2tF88GEcMkDOA/cN7lJqQ9ZwFBDumNZw1zslxFSshW9Bykx+rr5esC
	 8p9AHSvoN8paXFyNRjhwhsHq8S0YzhvDRDnmZGoY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732381AbgANKM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:12:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:49772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732871AbgANKM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:12:56 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9D1920678;
        Tue, 14 Jan 2020 10:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996776;
        bh=5HIOlXodj6KSKqOwuWlEHpU/UGJ5CaP6WiWWcZyXtGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F39plONbv/9rwFOU/z9qgkE713T/1qEa3mp3PpIHr97SJyYfBxYtFSVZ82LC3eUxe
         /jXr/hkEtWnGGncqpN+HFq2kAeDkWnj9BzkdvmxmD1kx0vNl9QJ4vdsmrieQByn6FB
         kLrqHYT90Y+4jaB+2bc4haM+bjpuiQQIsl5YOKXc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Kenneth R. Crudup" <kenny@panix.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.4 21/28] tty: always relink the port
Date:   Tue, 14 Jan 2020 11:02:23 +0100
Message-Id: <20200114094343.787290745@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094336.845958665@linuxfoundation.org>
References: <20200114094336.845958665@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

commit 273f632912f1b24b642ba5b7eb5022e43a72f3b5 upstream.

If the serial device is disconnected and reconnected, it re-enumerates
properly but does not link it. fwiw, linking means just saving the port
index, so allow it always as there is no harm in saving the same value
again even if it tries to relink with the same port.

Fixes: fb2b90014d78 ("tty: link tty and port before configuring it as console")
Reported-by: Kenneth R. Crudup <kenny@panix.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191227174434.12057-1-sudipm.mukherjee@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/tty_port.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -48,8 +48,7 @@ void tty_port_link_device(struct tty_por
 {
 	if (WARN_ON(index >= driver->num))
 		return;
-	if (!driver->ports[index])
-		driver->ports[index] = port;
+	driver->ports[index] = port;
 }
 EXPORT_SYMBOL_GPL(tty_port_link_device);
 


