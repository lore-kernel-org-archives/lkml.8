Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20957C35249
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD70A2086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580746849;
	bh=blro8WKHqirWAxDR/MgBABqkpB2q71gDN9yLScRLkCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OG7yVVJjVq6XD0+Sr7u2XA3GyDamD1jBu2Z1ThwrvczXzLmn16z1sL2X2MQf8Wg5f
	 FuKGX8xGDLE5HUalv1MoTvnEwOBBZxxBUMxY21FWBq7vkZeEn+lf9MwQ6fSLIXzifK
	 yhNzvPROornYjjGMfUQmyrgxOeks9dQyKETYVvag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgBCQUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:20:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:60680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728511AbgBCQUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:20:45 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B66720838;
        Mon,  3 Feb 2020 16:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580746845;
        bh=blro8WKHqirWAxDR/MgBABqkpB2q71gDN9yLScRLkCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IuBYm6jtmKorJT7MekdBIpNW9hU7mkfaG70Y6vkULdo+mSCIp9Iodny8nMshOUwTE
         0v0bmG6UikrO2ASMruGvwsQslIqv8aDOPr+PumD3XOkGgO7hqNYAF4zYi5utSdzVxP
         dsY8kPz6N2s8eAqgU4WH28O6Yrlk13cY+q/YADKY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fariya Fatima <fariyaf@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.4 03/53] rsi_91x_usb: fix interface sanity check
Date:   Mon,  3 Feb 2020 16:18:55 +0000
Message-Id: <20200203161903.650657231@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161902.714326084@linuxfoundation.org>
References: <20200203161902.714326084@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 3139b180906af43bc09bd3373fc2338a8271d9d9 upstream.

Make sure to use the current alternate setting when verifying the
interface descriptors to avoid binding to an invalid interface.

Failing to do so could cause the driver to misbehave or trigger a WARN()
in usb_submit_urb() that kernels with panic_on_warn set would choke on.

Fixes: dad0d04fa7ba ("rsi: Add RS9113 wireless driver")
Cc: stable <stable@vger.kernel.org>     # 3.15
Cc: Fariya Fatima <fariyaf@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/rsi/rsi_91x_usb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/rsi/rsi_91x_usb.c
+++ b/drivers/net/wireless/rsi/rsi_91x_usb.c
@@ -103,7 +103,7 @@ static int rsi_find_bulk_in_and_out_endp
 	__le16 buffer_size;
 	int ii, bep_found = 0;
 
-	iface_desc = &(interface->altsetting[0]);
+	iface_desc = interface->cur_altsetting;
 
 	for (ii = 0; ii < iface_desc->desc.bNumEndpoints; ++ii) {
 		endpoint = &(iface_desc->endpoint[ii].desc);


