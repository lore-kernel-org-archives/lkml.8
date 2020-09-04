Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC5BC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11163206D4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="LavJHK0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbgIDDXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 23:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729724AbgIDDXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 23:23:05 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AC7C061249
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 20:23:04 -0700 (PDT)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9E07D84488;
        Fri,  4 Sep 2020 15:23:02 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1599189782;
        bh=SYPM5NmO2oFScs3sCrM5DJmQkLy/qPNPYboTphS/uI8=;
        h=From:To:Cc:Subject:Date;
        b=LavJHK0Atihlh25m8bejpmJ0sJAKAx77eAo7BPQ2rAa/2e0WClbU4VnpdMYS1OGfX
         bKjK7Jic0OFFdYvLqIOMARnUDPLgPk9RvveRSIXhH4KVTne1c2HifM7IdNnmMsdHWE
         n/6r/yOTAP621L4r/ox3+GvTeD+teJth+QtvydrfK+SnS8EPduKzZbiyRVh0Yj0NNH
         jl/zPPccSmXOENKJ+J06wGR6zgIkaMybiaHFf2TLgZTIDBx+MCWxGwNGyhPMaQ/v3i
         HBJEkEpoxLaYc7p6aI1ft+bycmvEHvbFY7temOm0YA5xoPeugKbRaOzx/Dh8p1YPLO
         IHJSU3Rj2t6JA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f51b3120000>; Fri, 04 Sep 2020 15:23:02 +1200
Received: from hamishm-dl.ws.atlnz.lc (hamishm-dl.ws.atlnz.lc [10.33.24.30])
        by smtp (Postfix) with ESMTP id AECFB13EEBA;
        Fri,  4 Sep 2020 15:22:57 +1200 (NZST)
Received: by hamishm-dl.ws.atlnz.lc (Postfix, from userid 1133)
        id 00B942A06EA; Fri,  4 Sep 2020 15:22:57 +1200 (NZST)
From:   Hamish Martin <hamish.martin@alliedtelesis.co.nz>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Subject: [PATCH 0/2] usb: ohci: Per-port overcurrent protection
Date:   Fri,  4 Sep 2020 15:22:45 +1200
Message-Id: <20200904032247.11345-1-hamish.martin@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a dt-binding to select per-port overcurrent protection mode so handle
spurious overcurrent events from unconnected ports.

Hamish Martin (2):
  usb: ohci: Add per-port overcurrent quirk
  dt-bindings: usb: generic-ohci: Document per-port-overcurrent property

 Documentation/devicetree/bindings/usb/generic-ohci.yaml | 5 +++++
 drivers/usb/host/ohci-hcd.c                             | 4 ++++
 drivers/usb/host/ohci-platform.c                        | 3 +++
 drivers/usb/host/ohci.h                                 | 1 +
 4 files changed, 13 insertions(+)

--=20
2.28.0

