Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B3CC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2992082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580409799;
	bh=LUJ1SViBsO0sH8k8QprJ9hxKXgXrgwcmXehoLdRiQ+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QwTJUXeUGi4irivyzu26SgruszvonGylicJk9sD86ZgB1GT41OxZ6O7/zR7A4dMFC
	 Eb0XNbrfbgKIj1xIOrDvRP59d4mz0XIFSgxmx7G15N1VE8Kn084zAQhOeYqSg2TQDZ
	 fe5TsqoBpHmDVbSfFgkJgdLzeZLTDZ/VkrHzPvFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbgA3SnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:43:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:51706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730538AbgA3SnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:43:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3462205F4;
        Thu, 30 Jan 2020 18:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580409789;
        bh=LUJ1SViBsO0sH8k8QprJ9hxKXgXrgwcmXehoLdRiQ+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fYPdpyhO0wKoJrkWhJBoSB6XtOV6khKRp+pGlJ94i7pkz3F5us5TsAQiwN1QWckG8
         5sn/j1nd0lkUh9rRcdSOQ53nQS0/JHrlv4bteSpGpCProXCfDDm2eyLnL/Flnn8yBf
         w9Rt7ZB2Qh+TIJ2oZnaHp2qv5mCUiTAW6OK0MQfY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jes Sorensen <Jes.Sorensen@redhat.com>,
        Johan Hovold <johan@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 5.4 033/110] rtl8xxxu: fix interface sanity check
Date:   Thu, 30 Jan 2020 19:38:09 +0100
Message-Id: <20200130183619.304143354@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183613.810054545@linuxfoundation.org>
References: <20200130183613.810054545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 39a4281c312f2d226c710bc656ce380c621a2b16 upstream.

Make sure to use the current alternate setting when verifying the
interface descriptors to avoid binding to an invalid interface.

Failing to do so could cause the driver to misbehave or trigger a WARN()
in usb_submit_urb() that kernels with panic_on_warn set would choke on.

Fixes: 26f1fad29ad9 ("New driver: rtl8xxxu (mac80211)")
Cc: stable <stable@vger.kernel.org>     # 4.4
Cc: Jes Sorensen <Jes.Sorensen@redhat.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5915,7 +5915,7 @@ static int rtl8xxxu_parse_usb(struct rtl
 	u8 dir, xtype, num;
 	int ret = 0;
 
-	host_interface = &interface->altsetting[0];
+	host_interface = interface->cur_altsetting;
 	interface_desc = &host_interface->desc;
 	endpoints = interface_desc->bNumEndpoints;
 


