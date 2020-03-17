Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DB6C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 246FB20714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443519;
	bh=y+OaqMIx5L66GMyJ/vStR04kTYrrZ6vXz6F2UkjolYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fYoBQUBkzq5a7YyalBNWz1MK5bSy3HQq5Ho3d0JhwjVxZGAkT0u87r0z6afF1M0kC
	 wKTS0vCI7tELG47HmRCkjE0wLIF0GlbmkWHUj/OZkDIPyfTihUFSLjr72amsuwPNci
	 b4YsE0f4LJH1x9NbB+VSko72HFw+GR9yEe0DeT+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgCQLL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:11:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbgCQLLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:11:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47E6C20735;
        Tue, 17 Mar 2020 11:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443508;
        bh=y+OaqMIx5L66GMyJ/vStR04kTYrrZ6vXz6F2UkjolYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WphW424YbA90OmkEcnrMl1mQ4AldRkrGmDcO6Z9QMwBf2bQOu/Xrz85hMsXbU2SuP
         HklF0rX/njX/YHjgVi457loWCy1xZY8SAQVl7KU/tBGQ2ZNNhrsOdmqDannl9/AU2z
         bR2reSjuhEDXSUvl90IQotezCi4cUCNbd8WM8Xd8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Donnelly <john.p.donnelly@oracle.com>,
        Takashi Iwai <tiwai@suse.de>,
        Corey Minyard <cminyard@mvista.com>,
        Patrick Vo <patrick.vo@hpe.com>
Subject: [PATCH 5.5 106/151] ipmi_si: Avoid spurious errors for optional IRQs
Date:   Tue, 17 Mar 2020 11:55:16 +0100
Message-Id: <20200317103333.987948852@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103326.593639086@linuxfoundation.org>
References: <20200317103326.593639086@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 443d372d6a96cd94ad119e5c14bb4d63a536a7f6 upstream.

Although the IRQ assignment in ipmi_si driver is optional,
platform_get_irq() spews error messages unnecessarily:
  ipmi_si dmi-ipmi-si.0: IRQ index 0 not found

Fix this by switching to platform_get_irq_optional().

Cc: stable@vger.kernel.org # 5.4.x
Cc: John Donnelly <john.p.donnelly@oracle.com>
Fixes: 7723f4c5ecdb ("driver core: platform: Add an error message to platform_get_irq*()")
Reported-and-tested-by: Patrick Vo <patrick.vo@hpe.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Message-Id: <20200205093146.1352-1-tiwai@suse.de>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/ipmi/ipmi_si_platform.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/char/ipmi/ipmi_si_platform.c
+++ b/drivers/char/ipmi/ipmi_si_platform.c
@@ -194,7 +194,7 @@ static int platform_ipmi_probe(struct pl
 	else
 		io.slave_addr = slave_addr;
 
-	io.irq = platform_get_irq(pdev, 0);
+	io.irq = platform_get_irq_optional(pdev, 0);
 	if (io.irq > 0)
 		io.irq_setup = ipmi_std_irq_setup;
 	else
@@ -378,7 +378,7 @@ static int acpi_ipmi_probe(struct platfo
 		io.irq = tmp;
 		io.irq_setup = acpi_gpe_irq_setup;
 	} else {
-		int irq = platform_get_irq(pdev, 0);
+		int irq = platform_get_irq_optional(pdev, 0);
 
 		if (irq > 0) {
 			io.irq = irq;


