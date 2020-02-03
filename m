Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF625C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A737220838
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747127;
	bh=gwwaMJc62zOc4cwZ+A57UL//D1KSGXRTJYpOZuPMX4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QfcqB17OgKrCHJvYTr7iTwOlxKjHjEC1WKxmDvxbTJnN3Gt6ktOnPHFDu6eksjck4
	 owbo+X862NR1JpmInYJTYL47F6KR3D/LTTZ72MPTeu8l1ERccKUsd2bnW2IUf8A7Dy
	 KAnkVxBbELtggPNtjRioFD4ZQfK/MTZpIXIwcdXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgBCQZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:25:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:36074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728276AbgBCQZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:25:24 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 926042080C;
        Mon,  3 Feb 2020 16:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747124;
        bh=gwwaMJc62zOc4cwZ+A57UL//D1KSGXRTJYpOZuPMX4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GL2I5KGoXSrEyMpxYb9qj/DDK/YxeFrwyQUqozLzCcab6cTC7O3VgulU8N6kchzQm
         IvmZrbGYJZbDQsnKhWClg2JKpvXesCHKs/QramNrJJKGRCFNmCSxCOzPOcoUwh2q8h
         vaEeA/vKhT4qibfwZEYVvY3SfUox2vx6kIGoGZmg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.9 04/68] USB: serial: ir-usb: add missing endpoint sanity check
Date:   Mon,  3 Feb 2020 16:19:00 +0000
Message-Id: <20200203161905.441371311@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161904.705434837@linuxfoundation.org>
References: <20200203161904.705434837@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 2988a8ae7476fe9535ab620320790d1714bdad1d upstream.

Add missing endpoint sanity check to avoid dereferencing a NULL-pointer
on open() in case a device lacks a bulk-out endpoint.

Note that prior to commit f4a4cbb2047e ("USB: ir-usb: reimplement using
generic framework") the oops would instead happen on open() if the
device lacked a bulk-in endpoint and on write() if it lacked a bulk-out
endpoint.

Fixes: f4a4cbb2047e ("USB: ir-usb: reimplement using generic framework")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable <stable@vger.kernel.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/ir-usb.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/serial/ir-usb.c
+++ b/drivers/usb/serial/ir-usb.c
@@ -198,6 +198,9 @@ static int ir_startup(struct usb_serial
 {
 	struct usb_irda_cs_descriptor *irda_desc;
 
+	if (serial->num_bulk_in < 1 || serial->num_bulk_out < 1)
+		return -ENODEV;
+
 	irda_desc = irda_usb_find_class_desc(serial, 0);
 	if (!irda_desc) {
 		dev_err(&serial->dev->dev,


