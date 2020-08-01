Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1D1C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 16:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC0AF2071E
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 16:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="QpBmy8JE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gmwiPuLf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgHAQaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 12:30:00 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37301 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726300AbgHAQ37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 12:29:59 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 08F835C00CD;
        Sat,  1 Aug 2020 12:29:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 01 Aug 2020 12:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=FhcIa5vl19H1Q
        blhkWUef9NQmw0YCfpphgojts1RzX8=; b=QpBmy8JELAjTsoUSWhhnQ8Xsdarfx
        j45BkSPOB3LmOa0asJz/gYTMUMp5RIRFpnsT4ckK0XkbW0KtxgNAzAlY2MQDaAD7
        uKnqjuJs9BxSAAbvY68kZipHASbjPK+VBpKO3Pu/8vyaHKke9447zy1H1py4od+Y
        4PdihZQL/7lj9/oAr5KL98gFrioLT5d+cfUTjR6e7Ssl6KI8C0EhPmcxz7n6Db87
        0R+oCAEauWH0HZUXuwAmO7v63EyZXCTj1V1zH5WxLh3IjlaNqjGMGPFZ7mucaXUt
        EVqlxbFtq4+QPd9sGV1jhe48Vqgls/5khhHO2I5GoUQByr410L+DPgqLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=FhcIa5vl19H1QblhkWUef9NQmw0YCfpphgojts1RzX8=; b=gmwiPuLf
        ty1/QDRZRbPvvrv/SqW6plo6h4QMXFosA6rGaWIqn8N6gdztx5cuQTZVzZLktmVA
        UzI8GGNGoZl1o1Y7Zt38/f2oPhDVt42ac6erQVMjl2q6dFmvyAjnhFq2h70bAuaF
        S4P+b+aQ3VhZOzXYqhrCFbmLwxJOn8Y79II4dCRVc7NRmdXNBvHfKmH7z+R2czZt
        6vloy6fyudN8+JJyosbv5cLijoRtAjiqfo2khnRwPkJ2QQx84NGAjiMijvz5YFtk
        qfzAjzsSJoXp683vK/FPektO9wso9u/I07yMZXV+zQoSpcdRqYO5ng/Tlzb9IIe6
        q6tdD6wXVLjJhg==
X-ME-Sender: <xms:hZglX-zzVCEIuYxrRQvlXZ8ffFA6pNqOl_gOufbNw3j0_q9YLt2sBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrjedtgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:hZglX6T_11FImR_VqxvSK0Okm5jIBH_klhrlqv9zyWj_hA634qyI9Q>
    <xmx:hZglXwWJNcNxBH1tNwasgUlcibr1fHyeAFS4EQ73qV2G7YXn06gsNg>
    <xmx:hZglX0hBZSKGFCDdYP9I8oN_N2P-bAz0oNynOsuI3zc6vkGhya9IKA>
    <xmx:hpglXzO6UewIaOa9yafvbfqzrlXCpHXMfd0901VORoXUHbO40w85lg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8C2C23060067;
        Sat,  1 Aug 2020 12:29:57 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 2/2] Bluetooth: hci_ldisc/hci_serdev: Cancel init work before unregistering
Date:   Sat,  1 Aug 2020 11:29:56 -0500
Message-Id: <20200801162956.22610-2-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200801162956.22610-1-samuel@sholland.org>
References: <20200801162956.22610-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If hci_uart_tty_close() or hci_uart_unregister_device() is called while
hu->init_ready is scheduled, hci_register_dev() could be called after
the hci_uart is torn down. Avoid this by ensuring the work is complete
or canceled before checking the HCI_UART_REGISTERED flag.

Fixes: 9f2aee848fe6 ("Bluetooth: Add delayed init sequence support for UART controllers")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/bluetooth/hci_ldisc.c  | 1 +
 drivers/bluetooth/hci_serdev.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 85a30fb9177b..f83d67eafc9f 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -538,6 +538,7 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
 		percpu_up_write(&hu->proto_lock);
 
+		cancel_work_sync(&hu->init_ready);
 		cancel_work_sync(&hu->write_work);
 
 		if (hdev) {
diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index 7b233312e723..3977bba485c2 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -355,6 +355,8 @@ void hci_uart_unregister_device(struct hci_uart *hu)
 	struct hci_dev *hdev = hu->hdev;
 
 	clear_bit(HCI_UART_PROTO_READY, &hu->flags);
+
+	cancel_work_sync(&hu->init_ready);
 	if (test_bit(HCI_UART_REGISTERED, &hu->flags))
 		hci_unregister_dev(hdev);
 	hci_free_dev(hdev);
-- 
2.26.2

