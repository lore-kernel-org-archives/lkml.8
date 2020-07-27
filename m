Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B82CC433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 417162073E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595858887;
	bh=7rd/OGluXtLn4fNF/C5/d8dC2FG2dp25gWQxcM9U4/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oavMmPK3RMdBtWHPSuBEwQp4bKSIatpUzVF1zzA7xQL34owQaAi+Yf3jC/7rgsiII
	 XZvV3oqNsIeWyEZdYvHDCrdeLBq0sjeC1/Y6izcLeOkQ6Hm/PQIryIco/ZTb3Z1EcB
	 OQJ7osLxIa/Ymlk5KDFm9WQpkTzP18C1q3lCOJoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgG0OIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:08:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729354AbgG0OID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:08:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 891B22073E;
        Mon, 27 Jul 2020 14:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595858883;
        bh=7rd/OGluXtLn4fNF/C5/d8dC2FG2dp25gWQxcM9U4/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NNm8ab+iS9+8dfjW9iDVwEAWyVh3DKJ7YSD99xkrWoxjw0W2BMK4zL5/jkuiHGurO
         TuFzEq6sIANgc3JcTSGHupOJYtwFimUemHI4mPqfVCBQAqk1zFmR2HWjiEpbBsNxMh
         T6cGO/Kc9SllWrx2YFSeJIuLhqsnG8c6DcD5IV2Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: [PATCH 4.14 47/64] usb: xhci-mtk: fix the failure of bandwidth allocation
Date:   Mon, 27 Jul 2020 16:04:26 +0200
Message-Id: <20200727134913.520008557@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134911.020675249@linuxfoundation.org>
References: <20200727134911.020675249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunfeng Yun <chunfeng.yun@mediatek.com>

commit 5ce1a24dd98c00a57a8fa13660648abf7e08e3ef upstream.

The wMaxPacketSize field of endpoint descriptor may be zero
as default value in alternate interface, and they are not
actually selected when start stream, so skip them when try to
allocate bandwidth.

Cc: stable <stable@vger.kernel.org>
Fixes: 0cbd4b34cda9 ("xhci: mediatek: support MTK xHCI host controller")
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Link: https://lore.kernel.org/r/1594360672-2076-1-git-send-email-chunfeng.yun@mediatek.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-mtk-sch.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -284,6 +284,10 @@ static bool need_bw_sch(struct usb_host_
 	if (is_fs_or_ls(speed) && !has_tt)
 		return false;
 
+	/* skip endpoint with zero maxpkt */
+	if (usb_endpoint_maxp(&ep->desc) == 0)
+		return false;
+
 	return true;
 }
 


