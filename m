Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D77C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE897206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587386968;
	bh=1Ke0FHQ8L7f/O4kVoZF4DVWzmo94lYs/wxyB+0UbbxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HjyhnffV4YTY2aBmlnUWxKXharsre0LkNkFCv+R+KpYryD8pSmjYZf0xEE+oPxhf2
	 O4aUfpmA2cTdNaZM5pmw0t2FUygw30eAY33YYWtL6rWSiWjfH8oyTJoQShPcTt6HUE
	 FucJhHdC1CpmM1exn26ux4PeSVKCdrvk+Wx6CTUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgDTMt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:49:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729390AbgDTMtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:49:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33C1C206DD;
        Mon, 20 Apr 2020 12:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386957;
        bh=1Ke0FHQ8L7f/O4kVoZF4DVWzmo94lYs/wxyB+0UbbxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PCkw5Psd6yrfmdN4tn0zUEFsf+e5+QvB+evic5SLC5vfrTMFSLwlFVDFWktucHch/
         26+rVfHyhDTt98l+5LWj4Tv+vnPbCX5AnW5fgqInpAeyBiopS5mz6msLvvO10Yd0l+
         pqtPlxgADwTKPxH7iHrATZFdOM7jw3FjzegBAdqs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dedy Lansky <dlansky@codeaurora.org>,
        Maya Erez <merez@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.19 35/40] wil6210: check rx_buff_mgmt before accessing it
Date:   Mon, 20 Apr 2020 14:39:45 +0200
Message-Id: <20200420121506.150644862@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121444.178150063@linuxfoundation.org>
References: <20200420121444.178150063@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dedy Lansky <dlansky@codeaurora.org>

commit d6a553c0c61b0b0219764e4d4fc14e385085f374 upstream.

Make sure rx_buff_mgmt is initialized before accessing it.

Signed-off-by: Dedy Lansky <dlansky@codeaurora.org>
Signed-off-by: Maya Erez <merez@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/ath/wil6210/txrx_edma.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/wireless/ath/wil6210/txrx_edma.c
+++ b/drivers/net/wireless/ath/wil6210/txrx_edma.c
@@ -268,6 +268,9 @@ static void wil_move_all_rx_buff_to_free
 	struct list_head *active = &wil->rx_buff_mgmt.active;
 	dma_addr_t pa;
 
+	if (!wil->rx_buff_mgmt.buff_arr)
+		return;
+
 	while (!list_empty(active)) {
 		struct wil_rx_buff *rx_buff =
 			list_first_entry(active, struct wil_rx_buff, list);


