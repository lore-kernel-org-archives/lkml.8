Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA04BC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B565C21734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609738;
	bh=wjMZnQfyloIGfZ0KwLemIcDV2Agj28XD6XtDPJ1ZVOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zb23HESeEwvr8hqJdte3S+d0PCKMRzp6ZMbxlGxMS2++josxt6i4DUyP7baqlPEMV
	 B467onqFfL3VPU6QG+FSVkZ3daiceE+bQj7dUza6V3g+dr6kGp/KhPsalfhLRwhhaC
	 yMAw6NFZe4nayi07fhyvir1/Rm6Vr7vrCbWFOUF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388270AbgBMQCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:02:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728237AbgBMPYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:24:33 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63966246B5;
        Thu, 13 Feb 2020 15:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607472;
        bh=wjMZnQfyloIGfZ0KwLemIcDV2Agj28XD6XtDPJ1ZVOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K9t55lLzEkfy9uTCWsj/3IhSd76hr3g/MuyDqrqmMzcIXHmF1r4fUhjYrBmkJAYST
         +PMphszdolNJzecsuCMStrtKyCt1AyukGbRkw+QBzMk0SRHTsxxHD08jR6P9zA9AAL
         yWzHkCETYIQOkNqnbZiFtw7XTAjrFz7JzwQPjNBU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        Johan Hovold <johan@kernel.org>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 002/173] media: iguanair: fix endpoint sanity check
Date:   Thu, 13 Feb 2020 07:18:25 -0800
Message-Id: <20200213151932.590682726@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151931.677980430@linuxfoundation.org>
References: <20200213151931.677980430@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 1b257870a78b0a9ce98fdfb052c58542022ffb5b ]

Make sure to use the current alternate setting, which need not be the
first one by index, when verifying the endpoint descriptors and
initialising the URBs.

Failing to do so could cause the driver to misbehave or trigger a WARN()
in usb_submit_urb() that kernels with panic_on_warn set would choke on.

Fixes: 26ff63137c45 ("[media] Add support for the IguanaWorks USB IR Transceiver")
Fixes: ab1cbdf159be ("media: iguanair: add sanity checks")
Cc: stable <stable@vger.kernel.org>     # 3.6
Cc: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/iguanair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/rc/iguanair.c b/drivers/media/rc/iguanair.c
index 3c2e248ceca87..03dbbfba71fc6 100644
--- a/drivers/media/rc/iguanair.c
+++ b/drivers/media/rc/iguanair.c
@@ -427,7 +427,7 @@ static int iguanair_probe(struct usb_interface *intf,
 	int ret, pipein, pipeout;
 	struct usb_host_interface *idesc;
 
-	idesc = intf->altsetting;
+	idesc = intf->cur_altsetting;
 	if (idesc->desc.bNumEndpoints < 2)
 		return -ENODEV;
 
-- 
2.20.1



