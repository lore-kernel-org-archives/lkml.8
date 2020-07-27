Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C639CC433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A63A22078E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859180;
	bh=a6m3CaFs3ZpZE6yhHIWFLQwpvXISeqScorYP/Ei9aqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YTig/1fsr5ADq3c14C5IIYJ7GMa9TJXxgP8eyYk+uscE+CGdKiu9DBHDzqlFDLKl7
	 YJeOcEY+r62c4pJv9tZZurYrSsyb0PcqVcJF+d4cZ7nKGhAHyC3Oja2Cxu0XPfJGTd
	 CsRrBm9XjkHFPnLQpA7EXsNosZD24kNDp/J13PSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbgG0OM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:12:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730262AbgG0OMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:12:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 531962078E;
        Mon, 27 Jul 2020 14:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859167;
        bh=a6m3CaFs3ZpZE6yhHIWFLQwpvXISeqScorYP/Ei9aqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=18d3VvfFDRBqaNjFSQ6BOGGjvFsfs0eO+ebLgfy94e5vnzqZ3W2TtXupTdklJsJOx
         O+ccyB2Rv0QCQBkybLag0vqgHfD6WVZ34xgF15MQVMZStK2rXLNw79b+cIsilPz/jR
         e3gZN0OItV5Zc+znw8FwwgbH1X+laZY2LZr3t7Jg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: [PATCH 4.19 62/86] usb: xhci-mtk: fix the failure of bandwidth allocation
Date:   Mon, 27 Jul 2020 16:04:36 +0200
Message-Id: <20200727134917.538468116@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134914.312934924@linuxfoundation.org>
References: <20200727134914.312934924@linuxfoundation.org>
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
@@ -275,6 +275,10 @@ static bool need_bw_sch(struct usb_host_
 	if (is_fs_or_ls(speed) && !has_tt)
 		return false;
 
+	/* skip endpoint with zero maxpkt */
+	if (usb_endpoint_maxp(&ep->desc) == 0)
+		return false;
+
 	return true;
 }
 


