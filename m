Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C882C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF582070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340120;
	bh=H1rDOZ11KHe0nX1EtfcHPf1Y4oEDWPCo9Bgq0ldHZUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fMgckWVP4b++h+WbSBBZQiajm3YoQTvs3703hWohHZRGfTjtQ9sdjAcz4O+f8QZzi
	 FqouAj9JybfU4/9D1/Bxwj/jKETyx4iZHTmFucfEifiTNN8JEKqPSnnyjrRHQb1F3v
	 T+uZhI4/Ek/s5NOKQHy5UZH92ayfgeOK9bLtDaaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730793AbgBJNIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:08:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:37456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728971AbgBJMja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:39:30 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DA2C20842;
        Mon, 10 Feb 2020 12:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338370;
        bh=H1rDOZ11KHe0nX1EtfcHPf1Y4oEDWPCo9Bgq0ldHZUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Evcli9vdPFYcRLCcn8xM0Pojym3pJeZ3+iFcTeTUq/YQTCsBiBxw0ln9VJ5SpZ7vb
         i+OxVUcer7oYp5Rt8wGF3jA0jH4j0FydhHBZ3uZqeHB5LJfsZNyeguh5V8JhqnYeUq
         idY5fomye0PlZ06zaVGO3VpZvFdxp44d+YffdNfM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 5.5 040/367] Bluetooth: btusb: fix memory leak on fw
Date:   Mon, 10 Feb 2020 04:29:13 -0800
Message-Id: <20200210122427.695693359@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

commit 3168c19d7eb17a0108a3b60ad8e8c1b18ea05c63 upstream.

Currently the error return path when the call to btusb_mtk_hci_wmt_sync
fails does not free fw.  Fix this by returning via the error_release_fw
label that performs the free'ing.

Addresses-Coverity: ("Resource leak")
Fixes: a1c49c434e15 ("Bluetooth: btusb: Add protocol support for MediaTek MT7668U USB devices")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/btusb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2867,7 +2867,7 @@ static int btusb_mtk_setup_firmware(stru
 	err = btusb_mtk_hci_wmt_sync(hdev, &wmt_params);
 	if (err < 0) {
 		bt_dev_err(hdev, "Failed to send wmt rst (%d)", err);
-		return err;
+		goto err_release_fw;
 	}
 
 	/* Wait a few moments for firmware activation done */


