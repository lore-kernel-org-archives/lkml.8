Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3A3C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 220332053B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593457277;
	bh=CLuD78hSDZry6q0IZ5+0dE6txkqVSlnjENSPHZm+94w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VZh0PSAQVnAJUN+VodcVf/pkg7yVHAC9GEvfSMek4P19doTJYoSWULRQJgjgaIq0X
	 Z6tdR1AGvnkwqy6IDP7csJEu3YD+g4+7uncMoeHvnxcX+VGa6XQtA7b+SFcfH5VvZM
	 MYJSV9Zrq4B4p2GOka0C/mprRX7euAuxIJTwdsiA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbgF2TBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:01:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:45420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730363AbgF2TAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:00:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 442C925549;
        Mon, 29 Jun 2020 15:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593446109;
        bh=CLuD78hSDZry6q0IZ5+0dE6txkqVSlnjENSPHZm+94w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s10LyWPLQJIoXcOHJ8Lr2i17ROBbmanOmn+u+BhUm6zrcK3AOjRN9g2gqencLDInI
         Zllln5EVqwnGmApC5NLHj89IeFHR1x/Wn8jzmCV4NsCBquG7JVOF/uJDiEpNGJHc/x
         IuVQlpcbK18nQ7fIaEwOSDOegroKDm89Ssu6Ey0o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.4 101/135] xhci: Fix incorrect EP_STATE_MASK
Date:   Mon, 29 Jun 2020 11:52:35 -0400
Message-Id: <20200629155309.2495516-102-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629155309.2495516-1-sashal@kernel.org>
References: <20200629155309.2495516-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.229-rc1
X-KernelTest-Deadline: 2020-07-01T15:53+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit dceea67058fe22075db3aed62d5cb62092be5053 upstream.

EP_STATE_MASK should be 0x7 instead of 0xf

xhci spec 6.2.3 shows that the EP state field in the endpoint context data
structure consist of bits [2:0].
The old value included a bit from the next field which fortunately is a
 RsvdZ region. So hopefully this hasn't caused too much harm

Cc: stable@vger.kernel.org
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20200624135949.22611-2-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 0a3aa38b3c96e..a7f346529f913 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -706,7 +706,7 @@ struct xhci_ep_ctx {
  * 4 - TRB error
  * 5-7 - reserved
  */
-#define EP_STATE_MASK		(0xf)
+#define EP_STATE_MASK		(0x7)
 #define EP_STATE_DISABLED	0
 #define EP_STATE_RUNNING	1
 #define EP_STATE_HALTED		2
-- 
2.25.1

