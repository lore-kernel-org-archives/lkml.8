Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDABC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA4224681
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221520;
	bh=TQM9MwrWosBxaOXUgZjjsrwBjU237+BVRe82b9oiL+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YMoRdFBq338igcPefXSSiZBk8TAcTs9CO7rt+1nFbINekibbx6CCIR6BXLZA7KYDv
	 TeCJNazPCJrjuDlJkhcKb/eBge+FZo2qiD6yLqF0jwVWU6bhR2hZ/GBtC25gF68CY/
	 QP7UJtG+dpo2H2v3Uf4v7FX2DrLqbbG1mIc3DT44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbgA1OZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:25:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:52172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730397AbgA1OZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:25:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C49EA21739;
        Tue, 28 Jan 2020 14:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221515;
        bh=TQM9MwrWosBxaOXUgZjjsrwBjU237+BVRe82b9oiL+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QbCyC02114iEaIRhek2BxHZlarj//VuERl7LNkl888XjY6JiWt9BHinmUVIj7ci8k
         Hl+zxuMMorfG+lvjN8UT8a2vdszM7mYOuDt8WROdiei1FY6BtCKNMF5KBq4tImtdmB
         secptJyJAa4zU08ACCNDtRzROXAYwh6EtJbvZFxg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        Vladis Dronov <vdronov@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.9 255/271] Input: pegasus_notetaker - fix endpoint sanity check
Date:   Tue, 28 Jan 2020 15:06:44 +0100
Message-Id: <20200128135911.576746222@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
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


