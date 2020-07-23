Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DA4C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 23:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5252420792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 23:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="mT+3gEYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgGWXVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 19:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgGWXV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 19:21:28 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A64C0619E3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 16:21:27 -0700 (PDT)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 344AA891B1;
        Fri, 24 Jul 2020 11:21:24 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1595546484;
        bh=T1NDCOv0skNanugiuqRd6tsZXmRq6oJXFqorxiFMMaU=;
        h=From:To:Cc:Subject:Date;
        b=mT+3gEYAZh6OeAx89PqpsyP8ik4duX2l7atrsGdH7+cIHPt4Sjlt2+J9y3yhrlCyE
         3B8B85+M1GOL5zN9Ipbupf5Z2Oyz1CPOwNKePTjcl8gE4R/sdEGJVQ3/v6RjiMTpRy
         4RKErm3BR3Ajm58DVGt3W15VVpVy/uIXhSjVvA1DiiMy0qHbV6gTWi4cgni91GEG2n
         6dZLQV0HV8dMV0wt8gveIeO36T8FHvc2tDRP21uG7z7ATS+h1iq2yYgAC2GVqCGjAi
         IsZYKULDWIudrkW8XcocA6018QZD78aQ9nINflGthAXdlIdC5r4MxwbWwLU1TCiMjR
         nmJnnkc98rBBg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f1a1b720001>; Fri, 24 Jul 2020 11:21:22 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id C7A0313EEB7;
        Fri, 24 Jul 2020 11:21:23 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id EE543280079; Fri, 24 Jul 2020 11:21:23 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 0/3] net: dsa: mv88e6xxx: port mtu support
Date:   Fri, 24 Jul 2020 11:21:19 +1200
Message-Id: <20200723232122.5384-1-chris.packham@alliedtelesis.co.nz>
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

I've rebased this series on top of net-next/master to pick up Andrew's ch=
ange
for the gigabit switches. Patch 1 and 2 are unchanged (aside from adding
Andrew's Reviewed-by). Patch 3 is reworked to make use of the existing mt=
u
support.

Chris Packham (3):
  net: dsa: mv88e6xxx: MV88E6097 does not support jumbo configuration
  net: dsa: mv88e6xxx: Support jumbo configuration on 6190/6190X
  net: dsa: mv88e6xxx: Use chip-wide max frame size for MTU

 drivers/net/dsa/mv88e6xxx/chip.c    | 12 +++++++++++-
 drivers/net/dsa/mv88e6xxx/chip.h    |  3 +++
 drivers/net/dsa/mv88e6xxx/global1.c | 17 +++++++++++++++++
 drivers/net/dsa/mv88e6xxx/global1.h |  2 ++
 4 files changed, 33 insertions(+), 1 deletion(-)

--=20
2.27.0

