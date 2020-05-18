Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A31C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E60932083E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589825280;
	bh=XdSVoiFRtf3cyz7ypktPW4mY6jLVSFfO5OzF2dGq2VA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cxhsDiniJpVpLLAwHCF0RtXT61VcvRexE3qTcRrBrUrTSdkVdhXah5Unc87bpgdXf
	 FOkJUFOqDFdholPMOLPiWRW3rpn5/T5o/7gz1kPmMBVZWGKjxVdtxGgrNtUJv0qzWf
	 He1oSbS5FmHQcck2rbKMw0eeg2OEa34am4p56mUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387463AbgERSH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:07:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387453AbgERSHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:07:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4403720715;
        Mon, 18 May 2020 18:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589825274;
        bh=XdSVoiFRtf3cyz7ypktPW4mY6jLVSFfO5OzF2dGq2VA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lubQ/c4isrqLxTBAprtw6kF4g4HNrxUJMeNBsxFEpasCxpSn+/x+3BHLFqUbTx0C3
         ssVwD+I257vyebV3+hsIiUVbpBcthL7Rr02rkDwloOs2p6frTrDDozFJqTxHEJwfS3
         79bOW+mGRlBSg1RnyhazEPAwzKTOUegzTJb/9MI4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 5.6 168/194] usb: gadget: legacy: fix error return code in gncm_bind()
Date:   Mon, 18 May 2020 19:37:38 +0200
Message-Id: <20200518173545.187850802@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173531.455604187@linuxfoundation.org>
References: <20200518173531.455604187@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

commit e27d4b30b71c66986196d8a1eb93cba9f602904a upstream.

If 'usb_otg_descriptor_alloc()' fails, we must return a
negative error code -ENOMEM, not 0.

Fixes: 1156e91dd7cc ("usb: gadget: ncm: allocate and init otg descriptor by otg capabilities")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/legacy/ncm.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/usb/gadget/legacy/ncm.c
+++ b/drivers/usb/gadget/legacy/ncm.c
@@ -156,8 +156,10 @@ static int gncm_bind(struct usb_composit
 		struct usb_descriptor_header *usb_desc;
 
 		usb_desc = usb_otg_descriptor_alloc(gadget);
-		if (!usb_desc)
+		if (!usb_desc) {
+			status = -ENOMEM;
 			goto fail;
+		}
 		usb_otg_descriptor_init(gadget, usb_desc);
 		otg_desc[0] = usb_desc;
 		otg_desc[1] = NULL;


