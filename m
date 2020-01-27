Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E649C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 21:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F6C20CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 21:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="UYaETZAL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgA0VEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 16:04:37 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:41960 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgA0VEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 16:04:30 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 42F078365B;
        Tue, 28 Jan 2020 10:04:27 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1580159067;
        bh=zObOk1gVPEvabf/4BaqStZTqrwbvqmmwomyYCQ/yN4g=;
        h=From:To:Cc:Subject:Date;
        b=UYaETZALE0H7ZSGG/Rn6jhVwjKzKAsshnEuTczDwb4IZbCu/cTL8KG4IHCpGXscCd
         z7bFZ28yTtsCpKvBUnWIzl/7HSbv/1yRp4uZQ6pYN7CAYiHbRii0keDOjQA01mk3nr
         Yg7ynGDSoKffdjGdqrNELZdV522vd3n1uXCIVoytjYj7ZcN+moHQg/YMNsmDSmU5dt
         nHWUYVbCWFbrMwwfWJxEs+OGbr6dyZLBYv7y52IPH6Y5PmUy8WGOMcV/bS5QRJOhAB
         HsIPrAQ1kQmOc/eQIA/WUAIKth/sIXYI7N02xwH4SW/R6o/10pSgGjCiZEarI0NRdE
         iZrGVSVH0KuGg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e2f50560000>; Tue, 28 Jan 2020 10:04:27 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id B7AA313EEC9;
        Tue, 28 Jan 2020 10:04:21 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id E318C280071; Tue, 28 Jan 2020 10:04:21 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 0/2] SPI bus multiplexing
Date:   Tue, 28 Jan 2020 10:04:13 +1300
Message-Id: <20200127210415.5708-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a revisit of two earlier efforts to add more complex mutliplexing=
 to
SPI busses.

https://patchwork.kernel.org/patch/2706151/
https://patchwork.kernel.org/patch/10897255/

This version makes use of the general purpose mux controller which simpli=
fies
things greatly.

One outstanding problem is the need for the spi-max-frequency on the mux
device. This is not used for anything and is just needed to satisfy the s=
pi
driver infrastructure which expects all spi devices to have this property=
.

Chris Packham (2):
  dt-bindings: spi: Document binding for generic SPI multiplexer
  spi: Add generic SPI multiplexer

 .../devicetree/bindings/spi/spi-mux.yaml      |  89 +++++++++
 drivers/spi/Kconfig                           |  12 ++
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-mux.c                         | 189 ++++++++++++++++++
 4 files changed, 291 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mux.yaml
 create mode 100644 drivers/spi/spi-mux.c

--=20
2.25.0

