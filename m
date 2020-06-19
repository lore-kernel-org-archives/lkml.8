Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D658C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E65B121919
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580582;
	bh=kImEQXpoBvj021v/XvDW3o3pNA8HAb7guZPNEA6KIsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WV4QGcC0sYM3G/bBvxATkmZvaVBGccO93QN1mbgRrXhjqM4l4nQOVlEWfFNog6zYH
	 XHAn6LCx5vffG2QUin4yw2XRBE+648L7xVAl+Y2dh0AI84dYBNJ3pQtZRVdSgATm1s
	 qvs7NlWl+LBKKqlO/pJC3jL7RJQDjcWjuyyyDWPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404697AbgFSP3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:29:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404660AbgFSP33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:29:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5771C21919;
        Fri, 19 Jun 2020 15:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580568;
        bh=kImEQXpoBvj021v/XvDW3o3pNA8HAb7guZPNEA6KIsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=poggNzXKlA35FcmCCBry/NREO3JqTSEzENiN96W36ZRTu3SWljPB9EgNBHbV0ijyn
         S4hnjrm/2MLSUcifzFb5Rs1Rx0iP+/geJtljnQbkVD03l3QkobV7QOP2cAa1W/7fU/
         otNqBi0ukJIPUdaLuRJtsUFIgTBgukpjuWtuAwSA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 5.7 299/376] clocksource/drivers/timer-microchip-pit64b: Select CONFIG_TIMER_OF
Date:   Fri, 19 Jun 2020 16:33:37 +0200
Message-Id: <20200619141724.493797286@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

commit 25259f7a5de2de9d67793dc584b15c83a3134c93 upstream.

This driver is an OF driver, it depends on OF, and uses
TIMER_OF_DECLARE, so it should select CONFIG_TIMER_OF.

Without CONFIG_TIMER_OF enabled this can lead to warnings such as:

  powerpc-linux-ld: warning: orphan section `__timer_of_table' from
  `drivers/clocksource/timer-microchip-pit64b.o' being placed in
  section `__timer_of_table'.

Because TIMER_OF_TABLES in vmlinux.lds.h doesn't emit anything into
the linker script when CONFIG_TIMER_OF is not enabled.

Fixes: 625022a5f160 ("clocksource/drivers/timer-microchip-pit64b: Add Microchip PIT64B support")
Cc: stable@vger.kernel.org # v5.6+
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200426124356.3929682-1-mpe@ellerman.id.au
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clocksource/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -709,6 +709,7 @@ config MICROCHIP_PIT64B
 	bool "Microchip PIT64B support"
 	depends on OF || COMPILE_TEST
 	select CLKSRC_MMIO
+	select TIMER_OF
 	help
 	  This option enables Microchip PIT64B timer for Atmel
 	  based system. It supports the oneshot, the periodic


