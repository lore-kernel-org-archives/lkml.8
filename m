Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA519C52D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962C020578
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812931;
	bh=Sm8ml+Kds/HeCqMJ+bZa9a7cgf/7snaizLoOTD4idX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fVSUK0J0fRpZBBOZjcE+LKkisRoEXvS7Q3AKZSYCaLgMnDMyWE4pz/N0kjCtl3vzq
	 nXZGcz1w0wpBzAtZpH1ezTjG6czxjSrJgcp/uvr0QuAuXwUmL5rVPwrtIjFey5Y/9N
	 O/R9TJXTcowkAVOWH4Mko2qAjOZZZCAlax5iroLc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388917AbgB0OPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:15:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:55024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389303AbgB0OP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:15:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAB5220578;
        Thu, 27 Feb 2020 14:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812927;
        bh=Sm8ml+Kds/HeCqMJ+bZa9a7cgf/7snaizLoOTD4idX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jCLlq52o3p1FCUj+SUEsxv8JKw0xsW3LRtdgG1oV9bC0chWmOYXu54TSHDMGSQ1dt
         59D8IZFVIsNqxwLtFuCdUvtnkQenti4d1AwA+MK/ZeHD+scdcLLbYR73n1Qr2sLVyn
         8dT9rz70tJ3fmXuEKPraInc+iY+MmGfaYUO/scGI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Joel Stanley <joel@jms.id.au>
Subject: [PATCH 5.5 070/150] fsi: aspeed: add unspecified HAS_IOMEM dependency
Date:   Thu, 27 Feb 2020 14:36:47 +0100
Message-Id: <20200227132243.270735590@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132232.815448360@linuxfoundation.org>
References: <20200227132232.815448360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brendan Higgins <brendanhiggins@google.com>

commit ea3d147a474cb522bfdfe68f1f2557750dcf41dd upstream.

Currently CONFIG_FSI_MASTER_ASPEED=y implicitly depends on
CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
the following build error:

ld: drivers/fsi/fsi-master-aspeed.o: in function `fsi_master_aspeed_probe':
drivers/fsi/fsi-master-aspeed.c:436: undefined reference to `devm_ioremap_resource'

Fix the build error by adding the unspecified dependency.

Fixes: 606397d67f41 ("fsi: Add ast2600 master driver")
Cc: stable@vger.kernel.org
Reported-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Link: https://lore.kernel.org/r/20200131034832.294268-1-joel@jms.id.au
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/fsi/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/fsi/Kconfig
+++ b/drivers/fsi/Kconfig
@@ -55,6 +55,7 @@ config FSI_MASTER_AST_CF
 
 config FSI_MASTER_ASPEED
 	tristate "FSI ASPEED master"
+	depends on HAS_IOMEM
 	help
 	 This option enables a FSI master that is present behind an OPB bridge
 	 in the AST2600.


