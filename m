Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5E6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 22:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F01D206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 22:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="zTFfBPkH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbgEYW4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 18:56:11 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:50534 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgEYW4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 18:56:10 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 5255C8066C;
        Tue, 26 May 2020 10:56:03 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1590447363;
        bh=ZMRob+0ctuRiuZToWIvZ4v9nfwliXnBhCHGT1KikOsE=;
        h=From:To:Cc:Subject:Date;
        b=zTFfBPkHBQ+FkZ34aZyuftnXiCnYplWuyEr7UMfwLIjQzA5Hwt6TiRDGNIdOW0dGS
         tzPKwReGbXqILaGV25t0a/ih0db74NIJqUt7yzgUExevr4C0uPkFqbYIPc7raovpy7
         hEB6mKmEG4b6Mxx9M3/xp7Zabgs4kycigeoD9qdc3nYTxYDYY3vXMl0NkEwEAAfdmI
         vxuiArfa5bgCfQ14LVADtIU0laFabh8ofYUl7UjwOd/a7rc3jMPDHexrUtr1u/tv4C
         hmmaMb/vKECB8c+vzfz+wr+c1ZENXWC8miuNtH+uxn21X1MoOFF+4U5VhzyEl9gk9t
         nSVu7h6YaAOkQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5ecc4d030000>; Tue, 26 May 2020 10:56:03 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 11E7113ED4B;
        Tue, 26 May 2020 10:56:02 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 0499C28006C; Tue, 26 May 2020 10:56:03 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     vyasevich@gmail.com, nhorman@tuxdriver.com,
        marcelo.leitner@gmail.com, davem@davemloft.net
Cc:     linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
        trivial@kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH] net: sctp: Fix spelling in Kconfig help
Date:   Tue, 26 May 2020 10:55:59 +1200
Message-Id: <20200525225559.13596-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change 'handeled' to 'handled' in the Kconfig help for SCTP.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 net/sctp/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/Kconfig b/net/sctp/Kconfig
index 6e2eb1dd64ed..68934438ee19 100644
--- a/net/sctp/Kconfig
+++ b/net/sctp/Kconfig
@@ -31,7 +31,7 @@ menuconfig IP_SCTP
 	  homing at either or both ends of an association."
=20
 	  To compile this protocol support as a module, choose M here: the
-	  module will be called sctp. Debug messages are handeled by the
+	  module will be called sctp. Debug messages are handled by the
 	  kernel's dynamic debugging framework.
=20
 	  If in doubt, say N.
--=20
2.25.1

