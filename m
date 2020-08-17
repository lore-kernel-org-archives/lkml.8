Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC058C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88BCD204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597689993;
	bh=4CFGfsTcuLmf6c/2l3yQniiMu66wdLCJlBLj0T632xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qc40Xhu/L5jeh8TzYe/IoMnHobv6klvRxGPIAhJsyyAKGbPWx4mb/Ta7+jmDYPp4X
	 SmF+6LyV9Tk7kVL+teWMu0keBK4JHwhHDk8uIL7W5eyiKsrWU+wiRrv/SNUK6Dwf16
	 yjy5rkrnnSwtjcT4JhhN7izugcIHvNm0iIH4ucbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391589AbgHQSqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:46:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388043AbgHQPzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:55:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E22D2072E;
        Mon, 17 Aug 2020 15:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679748;
        bh=4CFGfsTcuLmf6c/2l3yQniiMu66wdLCJlBLj0T632xw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tQC/iTIZvDADxgBE3HZqZ30RWTZq+gsO+TqnchXNNvcoCobzOBMPCBEctAGSvbZG1
         V0Na3tqOApw0O9gP/Z7ThNHI/uBgKVFDB4fnCn3AvNghp5N9NvjV+48n2cvEY8vdMQ
         TYWTI5PemKEBhzQOOV7B2z0utq4S8mUMTGWwNgio=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Wang Hai <wanghai38@huawei.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 290/393] wl1251: fix always return 0 error
Date:   Mon, 17 Aug 2020 17:15:40 +0200
Message-Id: <20200817143833.689660983@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Hai <wanghai38@huawei.com>

[ Upstream commit 20e6421344b5bc2f97b8e2db47b6994368417904 ]

wl1251_event_ps_report() should not always return 0 because
wl1251_ps_set_mode() may fail. Change it to return 'ret'.

Fixes: f7ad1eed4d4b ("wl1251: retry power save entry")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200730073939.33704-1-wanghai38@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ti/wl1251/event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ti/wl1251/event.c b/drivers/net/wireless/ti/wl1251/event.c
index 850864dbafa11..e6d426edab56b 100644
--- a/drivers/net/wireless/ti/wl1251/event.c
+++ b/drivers/net/wireless/ti/wl1251/event.c
@@ -70,7 +70,7 @@ static int wl1251_event_ps_report(struct wl1251 *wl,
 		break;
 	}
 
-	return 0;
+	return ret;
 }
 
 static void wl1251_event_mbox_dump(struct event_mailbox *mbox)
-- 
2.25.1



