Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F162FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C18A52067B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591726987;
	bh=sDGANuZ7FD1nVMA1tNWPzxIt/Uk/CzGd5Gz40qhIhgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GT7Vf8yjCusjhWnLfqG3/aC2b/xkR44ARr9hwvz/d6+ATPnEgWjohTKuqN+PZzgqV
	 HjXfBdaMgElWhEabIUYrRjGLLGpB80fvLJH8NNNvTZfzlhpkIwbYsMMPTxG1Xam+v7
	 BEnrQJjvUNP6umJ9adkBFhTkAL4EjapiLoII5GYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732459AbgFISXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:23:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732146AbgFIRru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:47:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D46320825;
        Tue,  9 Jun 2020 17:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591724869;
        bh=sDGANuZ7FD1nVMA1tNWPzxIt/Uk/CzGd5Gz40qhIhgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gerFKBfyOdKrgKQqg7t+/gmCNwuxgX8bAVSnOn/Y+wvKQ63YNULRyjb93aVuId1hB
         juLVS2s0FyIRvcuWsXnxlVosSJAWD0nCFr3CHjIoM6r5hT5jXCW4/PT8NGHnjZVDPJ
         6ZFnR+FIbQq5hFAn9ojlnO5iu+S7ZWO69HInVhRs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Giuseppe Marco Randazzo <gmrandazzo@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Christian Lamparter <chunkeey@gmail.com>
Subject: [PATCH 4.9 15/42] p54usb: add AirVasT USB stick device-id
Date:   Tue,  9 Jun 2020 19:44:21 +0200
Message-Id: <20200609174017.128858518@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174015.379493548@linuxfoundation.org>
References: <20200609174015.379493548@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Giuseppe Marco Randazzo <gmrandazzo@gmail.com>

commit 63e49a9fdac1b4e97ac26cb3fe953f210d83bc53 upstream.

This patch adds the AirVasT USB wireless devices 124a:4026
to the list of supported devices. It's using the ISL3886
usb firmware. Without this modification, the wiki adapter
is not recognized.

Cc: <stable@vger.kernel.org>
Signed-off-by: Giuseppe Marco Randazzo <gmrandazzo@gmail.com>
Signed-off-by: Christian Lamparter <chunkeey@gmail.com> [formatted, reworded]
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200405220659.45621-1-chunkeey@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/intersil/p54/p54usb.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/wireless/intersil/p54/p54usb.c
+++ b/drivers/net/wireless/intersil/p54/p54usb.c
@@ -64,6 +64,7 @@ static struct usb_device_id p54u_table[]
 	{USB_DEVICE(0x0db0, 0x6826)},	/* MSI UB54G (MS-6826) */
 	{USB_DEVICE(0x107b, 0x55f2)},	/* Gateway WGU-210 (Gemtek) */
 	{USB_DEVICE(0x124a, 0x4023)},	/* Shuttle PN15, Airvast WM168g, IOGear GWU513 */
+	{USB_DEVICE(0x124a, 0x4026)},	/* AirVasT USB wireless device */
 	{USB_DEVICE(0x1435, 0x0210)},	/* Inventel UR054G */
 	{USB_DEVICE(0x15a9, 0x0002)},	/* Gemtek WUBI-100GW 802.11g */
 	{USB_DEVICE(0x1630, 0x0005)},	/* 2Wire 802.11g USB (v1) / Z-Com */


