Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F44EC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3F5217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609358;
	bh=Y1qJ4WosxJNPcN5BVx7gfDlF+Vvx9yR2+2ZUjt6mZSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rhq20C9tLiGIgfV2skeid23dknHwBeu935WswcC/24LA6BKCvqXiRp4ZiDpOb/wga
	 jAMPzxTVExDFfMgCk0AfNT8o+OBj5dtChzRPsLRpxHGRk/kljJbjmn1B9Cy4iGhehI
	 O3AXJ0oM6Etz1OGDOzkONsFGtwLLHNqSPcaKAWPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbgBMPz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:55:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:41354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387438AbgBMPZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:25:31 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8586F20848;
        Thu, 13 Feb 2020 15:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607530;
        bh=Y1qJ4WosxJNPcN5BVx7gfDlF+Vvx9yR2+2ZUjt6mZSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jFv/gKKZ50Qq2qsCeYSGshYevXTWlOj1jmnb89NEqxSN/LotmwNgAhkolBwc41BCC
         VHacN7leCOPZ1orFRGuKlnVgVZohdypo5REfVY7DCHCuCJY9hlOcv9VTFUUUgxRCSG
         sMrAK/4wApD7nVeJbUIa4yYDjMjht4f8vVPVtBUg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 102/173] net: smc911x: Adjust indentation in smc911x_phy_configure
Date:   Thu, 13 Feb 2020 07:20:05 -0800
Message-Id: <20200213151958.460440491@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151931.677980430@linuxfoundation.org>
References: <20200213151931.677980430@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

commit 5c61e223004b3b5c3f1dd25718e979bc17a3b12d upstream.

Clang warns:

../drivers/net/ethernet/smsc/smc911x.c:939:3: warning: misleading
indentation; statement is not part of the previous 'if'
[-Wmisleading-indentation]
         if (!lp->ctl_rfduplx)
         ^
../drivers/net/ethernet/smsc/smc911x.c:936:2: note: previous statement
is here
        if (lp->ctl_rspeed != 100)
        ^
1 warning generated.

This warning occurs because there is a space after the tab on this line.
Remove it so that the indentation is consistent with the Linux kernel
coding style and clang no longer warns.

Fixes: 0a0c72c9118c ("[PATCH] RE: [PATCH 1/1] net driver: Add support for SMSC LAN911x line of ethernet chips")
Link: https://github.com/ClangBuiltLinux/linux/issues/796
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/smsc/smc911x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/smsc/smc911x.c
+++ b/drivers/net/ethernet/smsc/smc911x.c
@@ -948,7 +948,7 @@ static void smc911x_phy_configure(struct
 	if (lp->ctl_rspeed != 100)
 		my_ad_caps &= ~(ADVERTISE_100BASE4|ADVERTISE_100FULL|ADVERTISE_100HALF);
 
-	 if (!lp->ctl_rfduplx)
+	if (!lp->ctl_rfduplx)
 		my_ad_caps &= ~(ADVERTISE_100FULL|ADVERTISE_10FULL);
 
 	/* Update our Auto-Neg Advertisement Register */


