Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF945C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC3321D56
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="ZiaKT00s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbgCKHtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:49:36 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:39835 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbgCKHtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:49:36 -0400
Received: from mwalle01.sab.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9114423E29;
        Wed, 11 Mar 2020 08:49:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1583912973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ID8vu+nei5FhOwCQgHpXoAnIy2AzwgasaSZg5n49nuQ=;
        b=ZiaKT00sod91tIUoYUk+lbqgqDXpVzGOwRUFqtAnh6KmXYhXlN+uKlZwTsRgIZvOSqmOR/
        yddFYIa3fLVmSUtu5/ktGKe/Cv4RaQmm/E/c3/NVkcdUuyPp7p9v4hRAXLpomUz+ILXINY
        sr3gUP2Bff1E3pBjZ2xB+/Emxng73CE=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>
Subject: [PATCH v2 0/4] arm64: dts: ls1028a: various sl28 fixes/updates
Date:   Wed, 11 Mar 2020 08:49:25 +0100
Message-Id: <20200311074929.19569-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 9114423E29
X-Spamd-Result: default: False [6.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_SPAM(0.00)[0.797];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[8];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:12941, ipnet:213.135.0.0/19, country:DE];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patchset contains device tree fixes and updates for the Kontron
SMARC-sAL28 board.

Changes since v1:
 - added "arm64: dts: freescale: sl28: add SPI flash" which was forgotten
   in the first series.

Michael Walle (4):
  arm64: dts: freescale: sl28: add SPI flash
  arm64: dts: ls1028a: sl28: fix on-board EEPROMS
  arm64: dts: ls1028a: sl28: expose switch ports in KBox A-230-LS
  arm64: dts: ls1028a: sl28: add support for variant 2

 arch/arm64/boot/dts/freescale/Makefile        |  1 +
 .../fsl-ls1028a-kontron-kbox-a-230-ls.dts     | 66 +++++++++++++++++-
 .../fsl-ls1028a-kontron-sl28-var2.dts         | 68 +++++++++++++++++++
 .../fsl-ls1028a-kontron-sl28-var3-ads2.dts    | 23 +++++--
 .../freescale/fsl-ls1028a-kontron-sl28.dts    | 12 ++++
 5 files changed, 161 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dts

-- 
2.20.1

