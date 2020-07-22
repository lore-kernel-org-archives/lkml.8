Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E53AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3137207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595443488;
	bh=0fOuKB5wNovBWJZh4x8Q1GvHavLuQWcSq049hFg7PXc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=LkY/J+w1gFsV1GWBumdl4jR70He6WP5tY4Xv5zoA/bqMRkLax9DN+xOSf7WigPsgX
	 dZ/RKEsfTLQNJ2hYpkJ2k28HDRYXEArhmJMplvnMwOFe6lVZ9cpoEBVIaJrVjHdrwO
	 Q6KmExnmpj9dSErm2iqXxx13O/FIkJa+lAAPN4XU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732387AbgGVSor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:44:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgGVSor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:44:47 -0400
Received: from embeddedor (unknown [201.162.161.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF0A020737;
        Wed, 22 Jul 2020 18:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595443486;
        bh=0fOuKB5wNovBWJZh4x8Q1GvHavLuQWcSq049hFg7PXc=;
        h=Date:From:To:Cc:Subject:From;
        b=c6QRcXojSP6KwsyLh/KePkCCoc6LRQMR9qm+X9Ov2TkDnL9qlkBj9XofaJL0TUEzv
         3FInJ2kEUV7hgRSk75An15zIeKWs818EMDc+mh09fty1jssiXCTZQ72U4rQdlHzHvr
         XaOJY2QfDTOuXQ1ZnWeA+XraISCR1lceo3txK1uM=
Date:   Wed, 22 Jul 2020 13:50:24 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Rasesh Mody <rmody@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     GR-Linux-NIC-Dev@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] bna: bfi.h: Avoid the use of one-element array
Message-ID: <20200722185024.GA15894@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays are being deprecated[1]. Replace the one-element
array with a simple value type 'u8 rsvd'[2], once it seems this is
just a placeholder for alignment.

[1] https://github.com/KSPP/linux/issues/79
[2] https://github.com/KSPP/linux/issues/86

Tested-by: kernel test robot <lkp@intel.com>
Link: https://github.com/GustavoARSilva/linux-hardening/blob/master/cii/0-day/bfi-20200718.md
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/brocade/bna/bfi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/brocade/bna/bfi.h b/drivers/net/ethernet/brocade/bna/bfi.h
index 09c912e984fe..f780d42c946d 100644
--- a/drivers/net/ethernet/brocade/bna/bfi.h
+++ b/drivers/net/ethernet/brocade/bna/bfi.h
@@ -389,7 +389,7 @@ struct bfi_msgq_mhdr {
 	u16	msg_token;
 	u16	num_entries;
 	u8	enet_id;
-	u8	rsvd[1];
+	u8	rsvd;
 } __packed;
 
 #define bfi_msgq_mhdr_set(_mh, _mc, _mid, _tok, _enet_id) do {	\
-- 
2.27.0

