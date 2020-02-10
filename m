Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5ACC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860EA20733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581341156;
	bh=L2a3ZPEvJBW6FZWkcmZb6vnlHQ1i/qswxgmCR+QxS2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B6fiS8DIuIC6ETHgioTxELhrGS9mjFdPaH1G5jWzqKwjxscMxL0h9FeE3ycxL523q
	 jdmKFiMlHog9HOd/PfuEKT87LxilOWJun9w/NY5ewGx+D3k5T8poD4WfAUyZDm4HxY
	 i0qxHxwGk0Lm7j+54cYfG7VG5MSHbrXvNMfeI9qo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbgBJNZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:25:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:57184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728543AbgBJMgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:36:51 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBBD320661;
        Mon, 10 Feb 2020 12:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338210;
        bh=L2a3ZPEvJBW6FZWkcmZb6vnlHQ1i/qswxgmCR+QxS2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CIyvrdTHWasV/LjUaTCLEVJ9vGxL9aKIIxf3CRauPl510776yIzBX2uK+WukWOp2T
         JEvVLbEAiT73Ns+HsdBFYW5ge3g85gXylhOCEXk9GLhejL9F4NQiJh7ZTs2Nuvw3R0
         QR08smPwkohS44zN2RV67W837PPqwOUDx7jj5YWE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 5.4 034/309] Bluetooth: btusb: fix memory leak on fw
Date:   Mon, 10 Feb 2020 04:29:50 -0800
Message-Id: <20200210122409.386331191@linuxfoundation.org>
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
@@ -2850,7 +2850,7 @@ static int btusb_mtk_setup_firmware(stru
 	err = btusb_mtk_hci_wmt_sync(hdev, &wmt_params);
 	if (err < 0) {
 		bt_dev_err(hdev, "Failed to send wmt rst (%d)", err);
-		return err;
+		goto err_release_fw;
 	}
 
 	/* Wait a few moments for firmware activation done */


