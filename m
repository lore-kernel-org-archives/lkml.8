Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4C8C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A61B21927
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587047445;
	bh=0xsYi/11uzlyBJ4Trt/P+eIrlBBktqV/M2hg5BUuIQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uxFks9kOUUrYwqiShwcomynkiBulnqJD1jtWumJaCDQ/FaPIdqb0BGwQqc6OvY8J0
	 RKMoUTGrpw6RHLRjgoWcnZRw3PmIyedXBm+IgsMwyZ1CZTuUk/NjOBQ/ZchUxh4w/4
	 IZ0hDZcVhqXD2RgfR05tBe9le2/ZN/O+toQm4/zs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394267AbgDPOan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:30:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409500AbgDPOBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:01:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D749222247;
        Thu, 16 Apr 2020 14:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045704;
        bh=0xsYi/11uzlyBJ4Trt/P+eIrlBBktqV/M2hg5BUuIQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bky9ClmXWOHJggoMCWg4niOPd2/kpSSIReeuIVMcWI7U18ve0uE63dZlSFX8HcWym
         wujPZqxeMfKv1jN+OowxXQebW4OBbI3m1PRRUW04nANU4y1wIQud9Pv1BXtVVzq6iB
         52ugemxBCEeTKp2HU6FnfgbJ4d710hq1LGSmJAWc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        kbuild test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 5.6 226/254] clk: ingenic/jz4770: Exit with error if CGU init failed
Date:   Thu, 16 Apr 2020 15:25:15 +0200
Message-Id: <20200416131354.033811918@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Cercueil <paul@crapouillou.net>

commit c067b46d731a764fc46ecc466c2967088c97089e upstream.

Exit jz4770_cgu_init() if the 'cgu' pointer we get is NULL, since the
pointer is passed as argument to functions later on.

Fixes: 7a01c19007ad ("clk: Add Ingenic jz4770 CGU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lkml.kernel.org/r/20200213161952.37460-1-paul@crapouillou.net
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/ingenic/jz4770-cgu.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/clk/ingenic/jz4770-cgu.c
+++ b/drivers/clk/ingenic/jz4770-cgu.c
@@ -432,8 +432,10 @@ static void __init jz4770_cgu_init(struc
 
 	cgu = ingenic_cgu_new(jz4770_cgu_clocks,
 			      ARRAY_SIZE(jz4770_cgu_clocks), np);
-	if (!cgu)
+	if (!cgu) {
 		pr_err("%s: failed to initialise CGU\n", __func__);
+		return;
+	}
 
 	retval = ingenic_cgu_register_clocks(cgu);
 	if (retval)


