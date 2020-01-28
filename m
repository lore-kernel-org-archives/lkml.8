Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3094C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C24724681
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220417;
	bh=pmqHN+/C7U2lZy72AZuc5kA1ElFsvkkwvoGCGdIcREU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DtwnjYeL8coYpDcvmcQHutomnb0w2wTVumEsj5e6+/g6PPfoN+GDJ6n9qgPty27bB
	 m8OBRTWBkyPIH5zca2WCeXAQ9Wstd2fWFjkXeOmrSIsbdunx2HZItsf/IutFs0x0DQ
	 qt0N75OImC88pTZyA+hEMP1onh1Nr0RA34GlwcnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgA1OEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:04:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:50762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbgA1ODw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:03:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A664F205F4;
        Tue, 28 Jan 2020 14:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220232;
        bh=pmqHN+/C7U2lZy72AZuc5kA1ElFsvkkwvoGCGdIcREU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KTnkBk2g1MpSBfwCgygj5pBtgOvtt9Xyvd+bXB4Xq1CQNqs4XlVued5oMzdOqclX2
         Su6nWs9Oz3xXYzsQYZaqgR8pe/rgjGieZB3czliLIA8PSGsSOkNa/6jeXZusKhPqcb
         Cy3IB1SaDk8V7UmKTa5VR0k8qkiKsul5kUp2bc+E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        Vladis Dronov <vdronov@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.4 068/104] Input: pegasus_notetaker - fix endpoint sanity check
Date:   Tue, 28 Jan 2020 15:00:29 +0100
Message-Id: <20200128135826.795873755@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135817.238524998@linuxfoundation.org>
References: <20200128135817.238524998@linuxfoundation.org>
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
@@ -275,7 +275,7 @@ static int pegasus_probe(struct usb_inte
 		return -ENODEV;
 
 	/* Sanity check that the device has an endpoint */
-	if (intf->altsetting[0].desc.bNumEndpoints < 1) {
+	if (intf->cur_altsetting->desc.bNumEndpoints < 1) {
 		dev_err(&intf->dev, "Invalid number of endpoints\n");
 		return -EINVAL;
 	}


