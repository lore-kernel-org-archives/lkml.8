Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EF8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1EDD205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699445;
	bh=LKn34jeZ7BEJ305ROwgKrRwdo1cq3ycsr0mq4leW8Nw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MMXEGoIkAKl66cSrBxrYWEdX4mdTvNOAhdnSO3N0+ajzPI67vlr2orZNt5a0WzePI
	 ZkhSS14Xptl8BvbQzoOU/TBwVyCw+S4u81kcXrlGuK4A4oqeuxHqlkCZ8uup9Bk0gJ
	 d6qlTSqcoJin1hT5S4jGe65KT+MHzJLfULVZ2oPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbgAVNYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:24:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:42750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729740AbgAVNYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:24:03 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACB35205F4;
        Wed, 22 Jan 2020 13:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699443;
        bh=LKn34jeZ7BEJ305ROwgKrRwdo1cq3ycsr0mq4leW8Nw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VlIWes2zpLncb16nB7UnDc1K/NlW3Srk3iJAmFa6N3cMz4Z1XRrpQAloV4tSnMDkk
         5XNRxJt1NGQo9zOaehCZ173I4tuJvhqgk+7cCaJIb8VVix4ScnG4HZJTFOFLtzMQ0O
         tputaoGDI5dHWwzf8a9KgPdRgOhKmombZV43itbs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 145/222] net/wan/fsl_ucc_hdlc: fix out of bounds write on array utdm_info
Date:   Wed, 22 Jan 2020 10:28:51 +0100
Message-Id: <20200122092844.113309872@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit ddf420390526ede3b9ff559ac89f58cb59d9db2f ]

Array utdm_info is declared as an array of MAX_HDLC_NUM (4) elements
however up to UCC_MAX_NUM (8) elements are potentially being written
to it.  Currently we have an array out-of-bounds write error on the
last 4 elements. Fix this by making utdm_info UCC_MAX_NUM elements in
size.

Addresses-Coverity: ("Out-of-bounds write")
Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wan/fsl_ucc_hdlc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -73,7 +73,7 @@ static struct ucc_tdm_info utdm_primary_
 	},
 };
 
-static struct ucc_tdm_info utdm_info[MAX_HDLC_NUM];
+static struct ucc_tdm_info utdm_info[UCC_MAX_NUM];
 
 static int uhdlc_init(struct ucc_hdlc_private *priv)
 {


