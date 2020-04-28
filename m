Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A07C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E12720B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgD1LSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 07:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgD1LSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 07:18:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DD2C03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 04:18:45 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1jTOG9-0000Qb-Kt; Tue, 28 Apr 2020 13:18:41 +0200
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1jTOG8-0006u4-TX; Tue, 28 Apr 2020 13:18:40 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     kernel@pengutronix.de, ceggers@arri.de,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v3 0/2] nvmem: skip nodes with compatibles other than "nvmem-cell"
Date:   Tue, 28 Apr 2020 13:18:25 +0200
Message-Id: <20200428111829.2215-1-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nvmem cell binding applies to all objects which match "^.*@[0-9a-f]+$",
without taking a compatible into account. This precludes extension of e.g.
eeprom nodes by any child nodes other than nvmem. Consider following example:

	eeprom@0 {
		reg = <0 64>;
		#address-cells = <1>;
		#size-cells = <1>;

		partitions {
			compatible = "fixed-partitions";
			#address-cells = <1>;
			#size-cells = <1>;
			bits = <64 64 64>; /* to verify it's skipped */

			part@0 {
				reg = <0x00 16>;
			};
		};

		no-cell@10 {
			compatible = "not-nvmem-cell";
			reg = <0x10 4>;
			bits = <64 64 64>; /* to verify it's skipped */
		};

		cell-old@14 {
			reg = <0x14 0x2>;
		};

		cell-new@16 {
			compatible = "nvmem-cell";
			reg = <0x16 4>;
		};
	};

Without this series, the NVMEM driver interprets all direct children of eeprom@0
as NVMEM cells and driver probe fails, because the partitions node lacks a reg
property, e.g.:

  nvmem 0-00000: nvmem: invalid reg on /eeprom@0

Running dtbs_check on the snippet will skip partitions (it doesn't match above
regex), but will flag no-cell@10 and cell-new@16 as invalid.

With this series applied, the driver will skip partitions and no-cell@10,
because they have a compatible but it's not "nvmem-cell".
Both cell-old@14 and cell-new@16 will be interpreted as cells.

Likewise, running dtbs_check on the snippet will skip partitions (compatible
doesn't match and regex doesn't either) and no-cell@10, but accept the other two.

This series resolves an existing clash between this nvmem-cell binding and
the barebox bootloader binding that extends the fixed-partitions MTD
binding to EEPROMs[1]. It's also a building block for getting nvmem cells and
partitions in MTD devices to co-exist in the same device tree node[2].

The changes are backwards-compatible, because, per binding, a compatible
property in a cell node was so far invalid. More details in the commit
messages.

[1]: https://www.mail-archive.com/barebox@lists.infradead.org/msg33944.html
[2]: https://patchwork.ozlabs.org/patch/890741/

v2 -> v3:
  - use optional compatible property to weed out nodes instead of name
  - extend binding documentation (Srini)
v1 -> v2:
  - use ->full_name instead of ->name as to not break existing correct
    cells (Christian)

Cheers,
Ahmad Fatoum (2):
  dt-bindings: nvmem: skip nodes with compatibles other than
    "nvmem-cell"
  nvmem: core: skip nodes with compatibles other than "nvmem-cell"

 Documentation/devicetree/bindings/nvmem/nvmem.yaml | 14 +++++++++++++-
 drivers/nvmem/core.c                               |  4 ++++
 2 files changed, 17 insertions(+), 1 deletion(-)

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
-- 
2.26.2

