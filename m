Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4504C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAA9D206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593459941;
	bh=OCXb/vDVKTu9y6J5IRsL8Nl2H5rnFdeMpMS5a7nUwUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NNh2h5RxEfuNdoDjbjaysE2KDBIfVqhQUZMnnwjA8EShGwDVR0Qz+lC2PtcI6sykB
	 8DJsZeoODkwjP9fDWyzURaZq8sD1na99dVSQ0Y8clD9vRr/ztZj8yiJCABW0mWy/HZ
	 7XxK2qEImPZv9sVXe/NqCcbWhOTzi3J7W+xGMNxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388032AbgF2Tpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:45:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387820AbgF2Tko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:40:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACAA92486F;
        Mon, 29 Jun 2020 15:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444369;
        bh=OCXb/vDVKTu9y6J5IRsL8Nl2H5rnFdeMpMS5a7nUwUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iobce1+ojYq5jfTqnkqYf3NOSSAvyqNCT4/ctDxbufAUbpRD6ia4Gl+cddZxyCTFi
         nGWttRa5UxZVQm0e9JkydbxPzJOUYh/ZvoOCYaUSI2PS1VFnZDbl50Z/x0rGVQra1T
         hHYwCSln5/iPYJ9+EmSUAObdTTX5aue3oRmG1PcM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Chen <peter.chen@nxp.com>,
        Pawel Laszczak <pawell@cadence.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.4 046/178] usb: cdns3: trace: using correct dir value
Date:   Mon, 29 Jun 2020 11:23:11 -0400
Message-Id: <20200629152523.2494198-47-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629152523.2494198-1-sashal@kernel.org>
References: <20200629152523.2494198-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.50-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.50-rc1
X-KernelTest-Deadline: 2020-07-01T15:25+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Chen <peter.chen@nxp.com>

commit ba3a80fe0fb67d8790f62b7bc60df97406d89871 upstream.

It should use the correct direction value from register, not depends
on previous software setting. It fixed the EP number wrong issue at
trace when the TRBERR interrupt occurs for EP0IN.

When the EP0IN IOC has finished, software prepares the setup packet
request, the expected direction is OUT, but at that time, the TRBERR
for EP0IN may occur since it is DMULT mode, the DMA does not stop
until TRBERR has met.

Cc: <stable@vger.kernel.org>
Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Reviewed-by: Pawel Laszczak <pawell@cadence.com>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/cdns3/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/trace.h b/drivers/usb/cdns3/trace.h
index e92348c9b4d71..7cc8bebaa07da 100644
--- a/drivers/usb/cdns3/trace.h
+++ b/drivers/usb/cdns3/trace.h
@@ -150,7 +150,7 @@ DECLARE_EVENT_CLASS(cdns3_log_ep0_irq,
 		__dynamic_array(char, str, CDNS3_MSG_MAX)
 	),
 	TP_fast_assign(
-		__entry->ep_dir = priv_dev->ep0_data_dir;
+		__entry->ep_dir = priv_dev->selected_ep;
 		__entry->ep_sts = ep_sts;
 	),
 	TP_printk("%s", cdns3_decode_ep0_irq(__get_str(str),
-- 
2.25.1

