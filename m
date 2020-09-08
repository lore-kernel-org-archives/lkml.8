Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7D8C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 23:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ECF020757
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 23:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MA3klo6H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgIHX4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 19:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgIHX4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 19:56:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F247BC061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 16:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=EK9nCPA8Amh2jxRu+oV/LS9FWBTa7vHxNwTW3NXJse0=; b=MA3klo6Ht+sTgmyqNNpAuyGXK7
        FIPRvHG4I/77N2XWo41bS5s+vLglm9b18XFMj9rjdzdH0hejbyL4YYA+HK+Aqy7RQ+ZB+opBfvTga
        TsLwFbfbu/kuPp+EtK8m+b2yiQxI7AFvBtwl1eZ+22RUQtlmXTeJoA2p7RS6Vvy+neLVlTOhJKLEO
        gR1TD3GLgvuHLeEnmSLpGS0UsDW1xei8rWVhRaEt8JfvCqC9G3f7o0sZXOuuJ3Szj4MHENTArPGhU
        tqKaFy/ut2sGaMkpv0fNrEjnxPm4HVv2O92X9W2OC+gzxlTauwAzBZyB7zlukZ6VKdxGoQNi/kKl4
        OR9PPI4Q==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFnTA-0003fN-VS; Tue, 08 Sep 2020 23:56:13 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] drm: amd/display: fix spelling of "function"
Message-ID: <a31672e7-9047-e4ef-93d8-d0c9afd47964@infradead.org>
Date:   Tue, 8 Sep 2020 16:56:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix spellos of "function" in drivers/gpu/drm/amd/display/.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.h   |    2 +-
 drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.h |    2 +-
 drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.h   |    2 +-
 drivers/gpu/drm/amd/display/dc/gpio/dce120/hw_factory_dce120.c      |    2 +-
 drivers/gpu/drm/amd/display/dc/gpio/dcn10/hw_factory_dcn10.c        |    2 +-
 drivers/gpu/drm/amd/display/dc/gpio/dcn20/hw_factory_dcn20.c        |    2 +-
 drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_factory_dcn21.c        |    2 +-
 drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c        |    2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

--- linux-next-20200908.orig/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.h
+++ linux-next-20200908/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.h
@@ -33,7 +33,7 @@ struct display_mode_lib;
 
 // Function: dml_rq_dlg_get_rq_reg
 //  Main entry point for test to get the register values out of this DML class.
-//  This function calls <get_rq_param> and <extract_rq_regs> fucntions to calculate
+//  This function calls <get_rq_param> and <extract_rq_regs> functions to calculate
 //  and then populate the rq_regs struct
 // Input:
 //  pipe_src_param - pipe source configuration (e.g. vp, pitch, etc.)
--- linux-next-20200908.orig/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.h
+++ linux-next-20200908/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.h
@@ -33,7 +33,7 @@ struct display_mode_lib;
 
 // Function: dml_rq_dlg_get_rq_reg
 //  Main entry point for test to get the register values out of this DML class.
-//  This function calls <get_rq_param> and <extract_rq_regs> fucntions to calculate
+//  This function calls <get_rq_param> and <extract_rq_regs> functions to calculate
 //  and then populate the rq_regs struct
 // Input:
 //  pipe_src_param - pipe source configuration (e.g. vp, pitch, etc.)
--- linux-next-20200908.orig/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.h
+++ linux-next-20200908/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.h
@@ -32,7 +32,7 @@ struct display_mode_lib;
 
 // Function: dml_rq_dlg_get_rq_reg
 //  Main entry point for test to get the register values out of this DML class.
-//  This function calls <get_rq_param> and <extract_rq_regs> fucntions to calculate
+//  This function calls <get_rq_param> and <extract_rq_regs> functions to calculate
 //  and then populate the rq_regs struct
 // Input:
 //  pipe_param - pipe source configuration (e.g. vp, pitch, scaling, dest, etc.)
--- linux-next-20200908.orig/drivers/gpu/drm/amd/display/dc/gpio/dce120/hw_factory_dce120.c
+++ linux-next-20200908/drivers/gpu/drm/amd/display/dc/gpio/dce120/hw_factory_dce120.c
@@ -162,7 +162,7 @@ static void define_hpd_registers(struct
 }
 
 
-/* fucntion table */
+/* function table */
 static const struct hw_factory_funcs funcs = {
 	.init_ddc_data = dal_hw_ddc_init,
 	.init_generic = NULL,
--- linux-next-20200908.orig/drivers/gpu/drm/amd/display/dc/gpio/dcn10/hw_factory_dcn10.c
+++ linux-next-20200908/drivers/gpu/drm/amd/display/dc/gpio/dcn10/hw_factory_dcn10.c
@@ -194,7 +194,7 @@ static void define_hpd_registers(struct
 }
 
 
-/* fucntion table */
+/* function table */
 static const struct hw_factory_funcs funcs = {
 	.init_ddc_data = dal_hw_ddc_init,
 	.init_generic = dal_hw_generic_init,
--- linux-next-20200908.orig/drivers/gpu/drm/amd/display/dc/gpio/dcn20/hw_factory_dcn20.c
+++ linux-next-20200908/drivers/gpu/drm/amd/display/dc/gpio/dcn20/hw_factory_dcn20.c
@@ -221,7 +221,7 @@ static void define_generic_registers(str
 	generic->base.regs = &generic_regs[en].gpio;
 }
 
-/* fucntion table */
+/* function table */
 static const struct hw_factory_funcs funcs = {
 	.init_ddc_data = dal_hw_ddc_init,
 	.init_generic = dal_hw_generic_init,
--- linux-next-20200908.orig/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_factory_dcn21.c
+++ linux-next-20200908/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_factory_dcn21.c
@@ -202,7 +202,7 @@ static void define_hpd_registers(struct
 }
 
 
-/* fucntion table */
+/* function table */
 static const struct hw_factory_funcs funcs = {
 	.init_ddc_data = dal_hw_ddc_init,
 	.init_generic = dal_hw_generic_init,
--- linux-next-20200908.orig/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
+++ linux-next-20200908/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
@@ -218,7 +218,7 @@ static void define_hpd_registers(struct
 }
 
 
-/* fucntion table */
+/* function table */
 static const struct hw_factory_funcs funcs = {
 	.init_ddc_data = dal_hw_ddc_init,
 	.init_generic = dal_hw_generic_init,

