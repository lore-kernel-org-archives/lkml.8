Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C61C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610D92070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340594;
	bh=fQAz3IvNxpOZZlPxtQGQqgPRu0k0bCDbi1STD+6Z5M8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wl79yLEpseBoTleSK+3lIAdNCxlphQQRRrgbR54+n8XaTLNMed7Th6ZguVpw415o9
	 vHmlVXVL/DX9CilGuREXJ10ONQMPlPKDrz8nJ3sfoQJi+Ajy4KNX0fG6Zy6asGMyMo
	 1lL2QjzVwhxN+di3+6Qgo6QarUW0MPnHx2yn0h3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbgBJNQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:16:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:33054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729033AbgBJMiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:38:09 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1675D20733;
        Mon, 10 Feb 2020 12:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338289;
        bh=fQAz3IvNxpOZZlPxtQGQqgPRu0k0bCDbi1STD+6Z5M8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ColV959AZjdM15tpzwdlEG11g0c8FPvq0Xut7guR0aFq1juOJztLsC1kLS3b0AS4u
         jUZV/jE3xV6S5XCqYUGV4GBYpdv9jJ3gP5fRkdon9Ow3FkNnnCZuP3xaGV446KFcOl
         hAhrcHKxHp4K+L4O26EZ+qACMYDDnnTbuohGise8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        Johan Hovold <johan@kernel.org>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 5.4 190/309] media: iguanair: fix endpoint sanity check
Date:   Mon, 10 Feb 2020 04:32:26 -0800
Message-Id: <20200210122424.808494428@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 1b257870a78b0a9ce98fdfb052c58542022ffb5b upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/rc/iguanair.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/rc/iguanair.c
+++ b/drivers/media/rc/iguanair.c
@@ -413,7 +413,7 @@ static int iguanair_probe(struct usb_int
 	int ret, pipein, pipeout;
 	struct usb_host_interface *idesc;
 
-	idesc = intf->altsetting;
+	idesc = intf->cur_altsetting;
 	if (idesc->desc.bNumEndpoints < 2)
 		return -ENODEV;
 


