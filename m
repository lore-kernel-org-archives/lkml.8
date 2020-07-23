Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D0CC433EA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 04:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD69020723
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 04:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="CHdGi5z6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgGWD7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 23:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgGWD7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 23:59:53 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF960C0619E3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 20:59:52 -0700 (PDT)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 628318011F;
        Thu, 23 Jul 2020 15:59:47 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1595476787;
        bh=Kut2y6uoflZI3Pk/ydLz6Tf8M+7u4NnAKlxGGdBL6fc=;
        h=From:To:Cc:Subject:Date;
        b=CHdGi5z66j6tw5JJgkUjBzXtiRLA8m+PRHSueLu5KTdHG78MxTvDdKYA7Vn4e1x9g
         tdZ8eHN1HgayLesfE7xl1V4QSIh3LO3asJiX0HudHjKydZbUDIOAn/UmZhxCx97lmt
         Ctq8423WGl5rrbuE/js6B5e++Ti/YE+0jMYqe9Tbn9e2tlWY/319B48WQK3y6ztQed
         59GTpi5ayh/4pl65om25Q1iUzQ2xPZVz0lzYK0H40Bx/l378CkeZwRk5h5InXpmhuw
         Fzicflj0nKHAVtpJJubRPw5wrtY8sQmBoZHPqp84VvgAsUyyUdHT1v6JhOm6i62qgw
         HnM+m9hOnyi/g==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f190b330000>; Thu, 23 Jul 2020 15:59:48 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id B325B13EEA1;
        Thu, 23 Jul 2020 15:59:45 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id E0864280079; Thu, 23 Jul 2020 15:59:46 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 0/4] net: dsa: mv88e6xxx: port mtu support
Date:   Thu, 23 Jul 2020 15:59:38 +1200
Message-Id: <20200723035942.23988-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series connects up the mv88e6xxx switches to the dsa infrastructure =
for
configuring the port MTU. The first patch is also a bug fix which might b=
e a
candiatate for stable.

Chris Packham (4):
  net: dsa: mv88e6xxx: MV88E6097 does not support jumbo configuration
  net: dsa: mv88e6xxx: Support jumbo configuration on 6190/6190X
  net: dsa: mv88e6xxx: Implement .port_change_mtu/.port_max_mtu
  net: dsa: mv88e6xxx: Use chip-wide max frame size for MTU

 drivers/net/dsa/mv88e6xxx/chip.c    | 38 ++++++++++++++++++++++++++++-
 drivers/net/dsa/mv88e6xxx/chip.h    |  3 +++
 drivers/net/dsa/mv88e6xxx/global1.c | 17 +++++++++++++
 drivers/net/dsa/mv88e6xxx/global1.h |  2 ++
 4 files changed, 59 insertions(+), 1 deletion(-)

--=20
2.27.0

