Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E46C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D72B2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340108;
	bh=AWY4JE3uYUiYjWZ0b4KcapCBnqk0yQ01OKRdGgKm2R0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bmiLk452UzxFnX9QoroYws1vZY3MOeKoQGdwNDXdvCwAQegwsh3UJgXMdO0bIbEeo
	 uWybw5A7fKt6J5wdlP66OCySNFt0kvWBvEdoifKhPUPf+G5RJ13e5s3YB02z4SZ3O+
	 GvDm8kspBy5e0pvkjZi+UXIaCsAYyoDC/arzGhls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbgEANfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729342AbgEANfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:35:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1664524953;
        Fri,  1 May 2020 13:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340104;
        bh=AWY4JE3uYUiYjWZ0b4KcapCBnqk0yQ01OKRdGgKm2R0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g0G6nnBumFn3ADmfqIUPsyWVYy5Jt8njrrfIZgYoPbPUwB9mFFw6/THTg5ANaHJnI
         kCIE4OtzrTQvwtLTbSVS6qWDxzaJgT7HY6cl5+M48eyl6kur3B1fibGs5lEJR3TSg7
         FELezar4QD/kjBIxuyXPPZUFc00EqUhMn6kDBX2I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 4.14 095/117] ARM: dts: bcm283x: Disable dsi0 node
Date:   Fri,  1 May 2020 15:22:11 +0200
Message-Id: <20200501131556.096980906@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131544.291247695@linuxfoundation.org>
References: <20200501131544.291247695@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

commit 90444b958461a5f8fc299ece0fe17eab15cba1e1 upstream.

Since its inception the module was meant to be disabled by default, but
the original commit failed to add the relevant property.

Fixes: 4aba4cf82054 ("ARM: dts: bcm2835: Add the DSI module nodes and clocks")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/bcm283x.dtsi |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -454,6 +454,7 @@
 					     "dsi0_ddr2",
 					     "dsi0_ddr";
 
+			status = "disabled";
 		};
 
 		thermal: thermal@7e212000 {


