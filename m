Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A76C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25FA2468C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845441;
	bh=gFrqrhLXjpT3HEcrR0Q1T7zy75R4tXeetSmrWR2ertU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IDeRSCg6A8/6+EyRGD1Coqq2+3SwzkKhMuOmY4CBQYEZSemaW0scXAiBrwz0NbRPE
	 hfAzFcJlB6z1GW8HRjnQ5QgtSWY4F4Ybcb5EFSDF8Q6JRholK/7s+S8gXHo4BZZBbU
	 UspV5aOPvnIDdx0JidxzHhrtDdGtzWGSWyoml1Ro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbgCJNEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:04:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730676AbgCJND6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:03:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAF442468C;
        Tue, 10 Mar 2020 13:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845438;
        bh=gFrqrhLXjpT3HEcrR0Q1T7zy75R4tXeetSmrWR2ertU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OVYieRd1xTLkAdTM4mvEdFlXv6o56A6Y8MJGr89UgXRfm25b/61A0rqqqx9Hwu65L
         0oO4sIS7yQ09sD1H8Nx18MIzXLPBERXr9XrdeNp3hmxiGntbtWG7sadgpwVzHTp4W4
         VpQshCb/K71wz59MSVrXohVDNuaNj2ZSnpFsmPhM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5.5 182/189] bus: ti-sysc: Fix 1-wire reset quirk
Date:   Tue, 10 Mar 2020 13:40:19 +0100
Message-Id: <20200310123657.946101947@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

commit aec551c7a00fb7eae049c0c4cc3208ca53e26355 upstream.

Because of the i2c quirk we have the reset quirks named in a confusing
way. Let's fix the 1-wire quirk accordinlyg. Then let's switch to using
better naming later on.

Fixes: 4e23be473e30 ("bus: ti-sysc: Add support for module specific reset quirks")
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bus/ti-sysc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1406,7 +1406,7 @@ static void sysc_init_revision_quirks(st
 }
 
 /* 1-wire needs module's internal clocks enabled for reset */
-static void sysc_clk_enable_quirk_hdq1w(struct sysc *ddata)
+static void sysc_pre_reset_quirk_hdq1w(struct sysc *ddata)
 {
 	int offset = 0x0c;	/* HDQ_CTRL_STATUS */
 	u16 val;
@@ -1494,7 +1494,7 @@ static void sysc_init_module_quirks(stru
 		return;
 
 	if (ddata->cfg.quirks & SYSC_MODULE_QUIRK_HDQ1W) {
-		ddata->clk_enable_quirk = sysc_clk_enable_quirk_hdq1w;
+		ddata->clk_disable_quirk = sysc_pre_reset_quirk_hdq1w;
 
 		return;
 	}


