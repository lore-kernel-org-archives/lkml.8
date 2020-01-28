Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A42C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B422468A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220012;
	bh=TQM9MwrWosBxaOXUgZjjsrwBjU237+BVRe82b9oiL+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M+Yz/IfapLG1BgTmYMvKbMHamlcPZs4TgEkpjD8xdyBkB9r+wgxeGKZk3VgK2OX7P
	 eTtsDqC5gLsJpSHfdru/5meKCyR8O9sMtABNYMAMiuVDW1Mvm1rRwUsAxIT+J7SG0c
	 g7YVKifZ6307ihmwW3LZY59PGF7ioEEIxE5JW/aE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgA1OAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:00:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:45752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727202AbgA1OAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:00:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1DAC24688;
        Tue, 28 Jan 2020 14:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220007;
        bh=TQM9MwrWosBxaOXUgZjjsrwBjU237+BVRe82b9oiL+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=galyqPihg/VAeKrNIItAb96d/lE3IEz8WdT9ft5EURtTuJ9UIe6YnxklmO3CXylac
         EDmka039VNTrDoWCcYYKz4ZsOriFKaRcEZotyen83HEBaedvt2yg/hTqoL3T3vg14P
         YvA0NcN2mqEUS8hcCgSOJg49eR+T01yCxd/vZoDo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        Vladis Dronov <vdronov@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.14 31/46] Input: pegasus_notetaker - fix endpoint sanity check
Date:   Tue, 28 Jan 2020 14:58:05 +0100
Message-Id: <20200128135754.058557685@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135749.822297911@linuxfoundation.org>
References: <20200128135749.822297911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit bcfcb7f9b480dd0be8f0df2df17340ca92a03b98 upstream.

The driver was checking the number of endpoints of the first alternate
setting instead of the current one, something which could be used by a
malicious device (or USB descriptor fuzzer) to trigger a NULL-pointer
dereference.

Fixes: 1afca2b66aac ("Input: add Pegasus Notetaker tablet driver")
Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Martin Kepplinger <martink@posteo.de>
Acked-by: Vladis Dronov <vdronov@redhat.com>
Link: https://lore.kernel.org/r/20191210113737.4016-2-johan@kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/tablet/pegasus_notetaker.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/input/tablet/pegasus_notetaker.c
+++ b/drivers/input/tablet/pegasus_notetaker.c
@@ -260,7 +260,7 @@ static int pegasus_probe(struct usb_inte
 		return -ENODEV;
 
 	/* Sanity check that the device has an endpoint */
-	if (intf->altsetting[0].desc.bNumEndpoints < 1) {
+	if (intf->cur_altsetting->desc.bNumEndpoints < 1) {
 		dev_err(&intf->dev, "Invalid number of endpoints\n");
 		return -EINVAL;
 	}


