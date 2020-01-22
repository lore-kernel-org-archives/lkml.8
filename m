Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F039FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98E624684
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686000;
	bh=bCq0ctxizNCAwzs1hJaNsvFiiEgdIQRvQWKcWtlFrOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xQrvwzMyjTVt9J5u55fpj+WzqBGKD6de7WKACr6GAba0VD3MDL7/QULRISjsMt2uO
	 yqjDv9Dd/q0rOlzZfvTnF4i6zY5uSVMS/m4eMcJNw0fpzsRjDYxZm3A8MM+/gTdrPE
	 sok3CxbGtkLe/QoanhQxiXPoxSo9qewbu9zSF5tA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732209AbgAVJj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:39:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:58300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733295AbgAVJjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:39:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AD8F24684;
        Wed, 22 Jan 2020 09:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685994;
        bh=bCq0ctxizNCAwzs1hJaNsvFiiEgdIQRvQWKcWtlFrOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A6pf4rb6SpOFBoQAEVk5dmG8f6yFKEyMNXdoD0bht5UT/xEclvMSQHDPwbO1tOu3J
         hpWnT92kCpO9bV7T1A2mUUg3S7nNoLcWYxLLFR+qqk28129259CmNzd01d+ipnvDVg
         ey9RIOoIrH77uhLRSb5AOjeVCh1rKPNrk878MyvE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 30/65] net: stmmac: Enable 16KB buffer size
Date:   Wed, 22 Jan 2020 10:29:15 +0100
Message-Id: <20200122092755.081585763@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092750.976732974@linuxfoundation.org>
References: <20200122092750.976732974@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <Jose.Abreu@synopsys.com>

commit b2f3a481c4cd62f78391b836b64c0a6e72b503d2 upstream.

XGMAC supports maximum MTU that can go to 16KB. Lets add this check in
the calculation of RX buffer size.

Fixes: 7ac6653a085b ("stmmac: Move the STMicroelectronics driver")
Signed-off-by: Jose Abreu <Jose.Abreu@synopsys.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1043,7 +1043,9 @@ static int stmmac_set_bfsize(int mtu, in
 {
 	int ret = bufsize;
 
-	if (mtu >= BUF_SIZE_4KiB)
+	if (mtu >= BUF_SIZE_8KiB)
+		ret = BUF_SIZE_16KiB;
+	else if (mtu >= BUF_SIZE_4KiB)
 		ret = BUF_SIZE_8KiB;
 	else if (mtu >= BUF_SIZE_2KiB)
 		ret = BUF_SIZE_4KiB;


