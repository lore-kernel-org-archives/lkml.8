Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2057FC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9D502495A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340170;
	bh=EJ6dlQJyvFOAXUfsGqol6Wmqc66jE3hiFMMygdlxfTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YKjGS8bxLBYN1itysnidNwHvJhzFjWoO1uUqGN1gKzmJ7xWu53aW0lXlpYukBJxPZ
	 b2Ifu/SrHseNLI/G+DAuTWSwO2dWs/HYDa/5joosOrTy8KZJ+TPWecHmpfRdQfe6iA
	 zTiQX4x+upPwkcNpgd63g8Rxd5cBO/dJxMFUjoPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbgEANgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:36:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730358AbgEANgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:36:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12DAC216FD;
        Fri,  1 May 2020 13:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340163;
        bh=EJ6dlQJyvFOAXUfsGqol6Wmqc66jE3hiFMMygdlxfTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kGTYwS5U7kfzDYmw7hHMUKdifE4YEeRXECFOLuxjVwG7ww9gYTO78/uqtbGFV8ml4
         Gn8CpWOLZJ38wkjhYY5bzz8ldMnodih1WWMhx8wZ+bFfJJG4fooLn0M81e0bQZJ0YW
         2XCV9AIAwxW0KCJaeKmgaiDoviv8Baok/Xp7FHuM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 4.19 06/46] usb: gadget: udc: bdc: Remove unnecessary NULL checks in bdc_req_complete
Date:   Fri,  1 May 2020 15:22:31 +0200
Message-Id: <20200501131501.364921548@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131457.023036302@linuxfoundation.org>
References: <20200501131457.023036302@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

commit 09b04abb70f096333bef6bc95fa600b662e7ee13 upstream.

When building with Clang + -Wtautological-pointer-compare:

drivers/usb/gadget/udc/bdc/bdc_ep.c:543:28: warning: comparison of
address of 'req->queue' equal to a null pointer is always false
[-Wtautological-pointer-compare]
        if (req == NULL  || &req->queue == NULL || &req->usb_req == NULL)
                             ~~~~~^~~~~    ~~~~
drivers/usb/gadget/udc/bdc/bdc_ep.c:543:51: warning: comparison of
address of 'req->usb_req' equal to a null pointer is always false
[-Wtautological-pointer-compare]
        if (req == NULL  || &req->queue == NULL || &req->usb_req == NULL)
                                                    ~~~~~^~~~~~~    ~~~~
2 warnings generated.

As it notes, these statements will always evaluate to false so remove
them.

Fixes: efed421a94e6 ("usb: gadget: Add UDC driver for Broadcom USB3.0 device controller IP BDC")
Link: https://github.com/ClangBuiltLinux/linux/issues/749
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/udc/bdc/bdc_ep.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/gadget/udc/bdc/bdc_ep.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_ep.c
@@ -540,7 +540,7 @@ static void bdc_req_complete(struct bdc_
 {
 	struct bdc *bdc = ep->bdc;
 
-	if (req == NULL  || &req->queue == NULL || &req->usb_req == NULL)
+	if (req == NULL)
 		return;
 
 	dev_dbg(bdc->dev, "%s ep:%s status:%d\n", __func__, ep->name, status);


