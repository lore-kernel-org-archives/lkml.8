Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99753C1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 07:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD3820674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 07:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="EI7lYRK9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbgCPHtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 03:49:16 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:39899 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729974AbgCPHtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 03:49:16 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 82F278364E;
        Mon, 16 Mar 2020 20:49:14 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1584344954;
        bh=1rQSyOnMwjAoffjicjGeCZR94Ltrz9583k/PTHp0BH4=;
        h=From:To:Cc:Subject:Date;
        b=EI7lYRK9wkGl/zkiUMTdCjb5k4hDJifXZL18Fvc4kMUEW60KmxA/QPtzM8PHVVAbW
         OacM7TQjTHpUJiLOuOI7XOmVt1LSsLlh/R5VFco0fhtuy8XDNv7qEApH9qKI1RyCki
         KqZgQRHzUonocMLeW59Z6d5K6RlgxHdoSl/uKX/YiHU/LDSTQmzxX88EifAN6GHoz8
         FLllPOAAtg2J6W76Nj8NECyhFXuM84G2N17Q2ECCTMTZSTmXTi9AwhHfrEzIHLxRku
         1jYICPw6qxSKapAMp+HHCs3cN0ozCPO996tydm2nEuF9VVgxoftgDjLs6jtwdfP/S1
         sh1BsDOm4yTPw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e6f2f750000>; Mon, 16 Mar 2020 20:49:14 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id E429113EF2A;
        Mon, 16 Mar 2020 20:49:08 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 4203528006E; Mon, 16 Mar 2020 20:49:09 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     davem@davemloft.net, andrew@lunn.ch, josua@solid-run.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 0/2] net: mvmdio: avoid error message for optional IRQ
Date:   Mon, 16 Mar 2020 20:49:05 +1300
Message-Id: <20200316074907.21879-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've gone ahead an sent a revert. This is the same as the original v1 exc=
ept
I've added Andrew's review to the commit message.

Chris Packham (2):
  Revert "net: mvmdio: avoid error message for optional IRQ"
  net: mvmdio: avoid error message for optional IRQ

 drivers/net/ethernet/marvell/mvmdio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--=20
2.25.1

