Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8D4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F62C2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592583872;
	bh=dGUE12/42yvGP/krDtbWrOV0Sj51B3xIa7MIrNpMlhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PBhUtWyer5NS+bQvAqA51/kzdCVZILkCALauztiBspytCRov3L33S5s7d73Sb5ZIw
	 mVhbt0kDKcyMjL9tWn6veBPM+aDdrSrMA54Dv3zD0mZ56gvSaOxNeqTP4YNj3WSbah
	 ew3SQpVOMqge5CKhBEXOCB8fGCRt6WLfr0439EF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404887AbgFSQYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:24:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389806AbgFSO6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:58:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB74921974;
        Fri, 19 Jun 2020 14:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578691;
        bh=dGUE12/42yvGP/krDtbWrOV0Sj51B3xIa7MIrNpMlhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xmnvMixZGjGcG22zsSbIEuuuRIjuUoKGb5LEfKEzXnx5jT/jahVaW+W1WbZmLM8Ib
         0LNJnViapf9FzY9JmDINRiui8VLkSKvt8jVgHFn4I8hneqrib8f20YLpAk3le+UO3T
         QrTIGg4sAYadlgASY9BN3qKH6wScuQ3wOwv0Se70=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4.19 089/267] ARM: dts: at91: sama5d2_ptc_ek: fix sdmmc0 node description
Date:   Fri, 19 Jun 2020 16:31:14 +0200
Message-Id: <20200619141653.135640879@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Desroches <ludovic.desroches@microchip.com>

commit a1af7f36c70369b971ee1cf679dd68368dad23f0 upstream.

Remove non-removable and mmc-ddr-1_8v properties from the sdmmc0
node which come probably from an unchecked copy/paste.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Fixes:42ed535595ec "ARM: dts: at91: introduce the sama5d2 ptc ek board"
Cc: stable@vger.kernel.org # 4.19 and later
Link: https://lore.kernel.org/r/20200401221504.41196-1-ludovic.desroches@microchip.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts |    2 --
 1 file changed, 2 deletions(-)

--- a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
@@ -125,8 +125,6 @@
 			bus-width = <8>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_sdmmc0_default>;
-			non-removable;
-			mmc-ddr-1_8v;
 			status = "okay";
 		};
 


