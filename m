Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1641EC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD26F24679
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996721;
	bh=y3hojQXEA8XV+d/pNvuWwQg0+T/RPwpbZaLgU7memec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NenKpBi1jt808EcTl2K2nW9tlMhO+VnTRYu1nfBrfOSTZFtekIEWvueLr2RXeR942
	 oC9YZMtVe97Jg9sjaab+ZP0lGfs5HVIi/e5SCBiv0U+QDfRGp4Xl44wvuPSpaoz3BJ
	 RFF+Gt49Tg5XbO9yvjQZzuuPBfEjP4MWbMwqBuIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732864AbgANKMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:12:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:47808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731514AbgANKL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:11:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C1EB207FF;
        Tue, 14 Jan 2020 10:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996717;
        bh=y3hojQXEA8XV+d/pNvuWwQg0+T/RPwpbZaLgU7memec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NK+jxkqwKMHjnsGmNMWe9/M5vWMapUYTl9nAMu++iCYZ2RsOibexStEgeHbL85SCV
         7Xxbk1l/h5IkI3PVTQiB8gftHT/r+JM9w41zjiuzkH+K/mRZnkC3SrMP9bq/zs9+9n
         3wW2GOiv35eVxYUGo/0QSHEsbuteO7ey85jeCAFc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.9 09/31] HID: uhid: Fix returning EPOLLOUT from uhid_char_poll
Date:   Tue, 14 Jan 2020 11:02:01 +0100
Message-Id: <20200114094341.392739255@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094334.725604663@linuxfoundation.org>
References: <20200114094334.725604663@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Holtmann <marcel@holtmann.org>

commit be54e7461ffdc5809b67d2aeefc1ddc9a91470c7 upstream.

Always return EPOLLOUT from uhid_char_poll to allow polling /dev/uhid
for writable state.

Fixes: 1f9dec1e0164 ("HID: uhid: allow poll()'ing on uhid devices")
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Cc: stable@vger.kernel.org
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/uhid.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -26,6 +26,7 @@
 #include <linux/uhid.h>
 #include <linux/wait.h>
 #include <linux/uaccess.h>
+#include <linux/eventpoll.h>
 
 #define UHID_NAME	"uhid"
 #define UHID_BUFSIZE	32
@@ -774,7 +775,7 @@ static unsigned int uhid_char_poll(struc
 	if (uhid->head != uhid->tail)
 		return POLLIN | POLLRDNORM;
 
-	return 0;
+	return EPOLLOUT | EPOLLWRNORM;
 }
 
 static const struct file_operations uhid_fops = {


