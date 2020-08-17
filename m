Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30BCC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 859A420758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597648388;
	bh=oTXbf1K0JfaqbK6sjMAlt2QAMJ8ewI4Je+6AHT1jcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A8UyzPM2snsT2MldhoZRNtYLufzQEyzQh9usxHwjTVNfHPvqnBzGtLOv2p5mqKx5X
	 ydNZLHiIkMZx2md72mvHDuJ+N11wVkDTR2Ibr+imN2FoQ7919wDL3opKeKOxW++jC+
	 9uyCM773KsLEAnuUDnypg/MMJoQYzwriVUjPQdlk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgHQHNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:13:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbgHQHLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:11:45 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F7BC22E00;
        Mon, 17 Aug 2020 07:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597648278;
        bh=oTXbf1K0JfaqbK6sjMAlt2QAMJ8ewI4Je+6AHT1jcvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FHQLInwcM6jAPEC/eV7JIZUVF51YJiQYwWlPl9l/M0NUWsmbHpbKwX+w436SD5gq/
         YC5st/KAXGXhbx2sT2W47i+E0qNAEERy2gthcfOsT+39COLtf6XV3XVQ4sWxjMOQZS
         PggsJDpW1CGCLq9trDQXh3KW8cQHnoKi1N/HVSMY=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k7ZIa-00BdlD-LS; Mon, 17 Aug 2020 09:11:16 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 42/44] MAINTAINERS: add an entry for HiSilicon 6421v600 drivers
Date:   Mon, 17 Aug 2020 09:11:01 +0200
Message-Id: <60a2766c2e64dc6957480231a4e9ad9e6b00ab40.1597647359.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597647359.git.mchehab+huawei@kernel.org>
References: <cover.1597647359.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for the SPMI, MFD and PMIC parts of the
HiSilicon 6421v600 support.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 956ecd5ba426..e2de0b2119fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7824,6 +7824,12 @@ F:	drivers/crypto/hisilicon/sec2/sec_crypto.c
 F:	drivers/crypto/hisilicon/sec2/sec_crypto.h
 F:	drivers/crypto/hisilicon/sec2/sec_main.c
 
+HISILICON STAGING DRIVERS FOR HIKEY 960/970
+M:	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	drivers/staging/hikey9xx/
+
 HISILICON TRUE RANDOM NUMBER GENERATOR V2 SUPPORT
 M:	Zaibo Xu <xuzaibo@huawei.com>
 S:	Maintained
-- 
2.26.2

