Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508D2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2402A207DA
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591034543;
	bh=R6DMhYBD4L29JjBJc9HRN3G2rhzvtNzRlF29p+QU+ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bZGCVpxCoYuXCq3xtwef/gKGc5orjhEVkl7UZLK6zkoP0gcWwiUCM8W+i2R7API6e
	 OYxqlJBM09Y1IGT1zka7Tw2Q4PoA02qj7I8RjzwDefTXJOQPS2EUAeanBypLgpteOu
	 R4Q6/TqCZ8n9yeWcu38Rj0GbcTb5e7uxAc9uXwhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbgFASCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:02:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728760AbgFASCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:02:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A173520776;
        Mon,  1 Jun 2020 18:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034537;
        bh=R6DMhYBD4L29JjBJc9HRN3G2rhzvtNzRlF29p+QU+ek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sjd8Fuz352/QTcuuu703tvak2IX4F8wE3nHG6+M1+6cXtIBjveVMLCws0zh2mdCK9
         E02GVTnzKRQfhgmyzfZiW0C1hEBpDvqphMMb6g0ZERGULYOzSjfwTZCe2jojA1b0xX
         Kwy3lF+N7qPUttnyA3Cb2OUP7HX51zBeEXaIpwmg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.14 76/77] net: hns: fix unsigned comparison to less than zero
Date:   Mon,  1 Jun 2020 19:54:21 +0200
Message-Id: <20200601174029.578918387@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174016.396817032@linuxfoundation.org>
References: <20200601174016.396817032@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

commit ea401685a20b5d631957f024bda86e1f6118eb20 upstream.

Currently mskid is unsigned and hence comparisons with negative
error return values are always false. Fix this by making mskid an
int.

Fixes: f058e46855dc ("net: hns: fix ICMP6 neighbor solicitation messages discard problem")
Addresses-Coverity: ("Operands don't affect result")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
@@ -2770,7 +2770,7 @@ static void set_promisc_tcam_enable(stru
 	struct hns_mac_cb *mac_cb;
 	u8 addr[ETH_ALEN] = {0};
 	u8 port_num;
-	u16 mskid;
+	int mskid;
 
 	/* promisc use vague table match with vlanid = 0 & macaddr = 0 */
 	hns_dsaf_set_mac_key(dsaf_dev, &mac_key, 0x00, port, addr);


