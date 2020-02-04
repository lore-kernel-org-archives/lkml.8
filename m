Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EC5C3524B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 03:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA34E2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 03:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="ZCcomTI7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgBDD2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 22:28:52 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:54310 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgBDD2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 22:28:51 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 27A40806B7;
        Tue,  4 Feb 2020 16:28:47 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1580786927;
        bh=sxkGEz4O83Xf4r/8UbYxhATgoU07+v1dwRiroPZLKQA=;
        h=From:To:Cc:Subject:Date;
        b=ZCcomTI7/ulzRD4eSdUYg61Ex01nzwfH1/FiUXVoJSoIsrPFSdZhWcfS9YqY7Xq+U
         4BOmdn3E4LPBtgncBWi7avdg16xk6UC11RcF5VnVx1oMtR/sYZMMbSzwZ5ffIcnlv5
         mcwQNERChllPjciRKo/LQFt/tg5TWDAM9iCb7SmRgZ1b3l7fyF04s14awxmqY9S83Z
         UIZg/X8R2dIAmcCPDlAqEUmyt3Ton6t3pFaBo9dAYwHJlz458JCEP6TW4FS1KUvVMB
         8wmxGuj3OPGSPg1Mi2eW84nvITfaxkMxcaTfrsn1URK8hgNlNWQcPkz7gEVeUQBPEb
         egUxJnU7rMbxg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e38e4e90000>; Tue, 04 Feb 2020 16:28:46 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 61EEA13EED4;
        Tue,  4 Feb 2020 16:28:41 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 8AEF1280071; Tue,  4 Feb 2020 16:28:41 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v5 0/2] SPI bus multiplexing
Date:   Tue,  4 Feb 2020 16:28:36 +1300
Message-Id: <20200204032838.20739-1-chris.packham@alliedtelesis.co.nz>
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
 drivers/spi/Kconfig                           |  11 ++
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-mux.c                         | 187 ++++++++++++++++++
 4 files changed, 288 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mux.yaml
 create mode 100644 drivers/spi/spi-mux.c

--=20
2.25.0

