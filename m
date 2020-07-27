Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE396C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6CA2207BB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595876557;
	bh=HSIZOSbBdMb6VdSL3tSd4Iq3pXLj2Kfj7HeeT8Y2K3Y=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=XWBJXox2mJm5WO9cl9WMbaWQFswYu75FaRbOnUqx1bDyVJs4rsqrrAcE2z1yVoXH7
	 UQ0BLFwyUcg7WtCEN6s0I+m2hAWA/49ZTZxTITXKX1PO5rBw5wriho7msBMlvFo8H5
	 mAf+t6Bh5HHuzWdjHT6ko7kw30jR5g+jitR3Mnuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgG0TCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 15:02:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgG0TCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 15:02:36 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 755752074F;
        Mon, 27 Jul 2020 19:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595876555;
        bh=HSIZOSbBdMb6VdSL3tSd4Iq3pXLj2Kfj7HeeT8Y2K3Y=;
        h=Date:From:To:Cc:Subject:From;
        b=E5k8wckeCWRGKrjoXhlbhQzokEsEqXckpIR0pIo1NjAuyXsrh3cYagdMhp6swLRpF
         dCjjPX7AQZ2KQdajj8Cv9xc4zahdLnZqf2/+spxnkNzLSx+Tzg/4vQ+FjmNUUrLqyn
         E4boQWGCsYcxGsjsC0Hzowa5UIj1kkqel5eSAriU=
Date:   Mon, 27 Jul 2020 14:08:29 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] staging: gdm724x: Use fallthrough pseudo-keyword
Message-ID: <20200727190829.GA30332@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the existing /* fall through */ comments and its variants with
the new pseudo-keyword macro fallthrough[1].

[1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/staging/gdm724x/gdm_lte.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gdm724x/gdm_lte.c b/drivers/staging/gdm724x/gdm_lte.c
index eb309190f5be..571f47d39484 100644
--- a/drivers/staging/gdm724x/gdm_lte.c
+++ b/drivers/staging/gdm724x/gdm_lte.c
@@ -784,7 +784,7 @@ static int gdm_lte_receive_pkt(struct phy_dev *phy_dev, char *buf, int len)
 			return index;
 		dev = phy_dev->dev[index];
 		gdm_lte_pdn_table(dev, buf, len);
-		/* Fall through */
+		fallthrough;
 	default:
 		ret = gdm_lte_event_send(dev, buf, len);
 		break;
-- 
2.27.0

