Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838FEC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4931920656
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581610081;
	bh=vK0jvBmRKwQvyHXa/EMemD0TVUS1+x9d8R924du5diM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NjuMSV+CCu0SZh9EZxf4S4EJ8Ap5y+eYTBBy6d3iAEw1PtBK0YAtsNbKWu6Hbx0qZ
	 zxfM1SbmhbWKOUYsWj2of58jRabKVF/9ydrt1uJYfs93jf7ctiSuJYreSbDBQ6sJFq
	 R8VegrFX3+bRrdk8dLC+MwtsgG2PTgP/VjthRChQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbgBMQIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:08:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:33858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728308AbgBMPXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:23:14 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31DA7246B1;
        Thu, 13 Feb 2020 15:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607394;
        bh=vK0jvBmRKwQvyHXa/EMemD0TVUS1+x9d8R924du5diM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eA/qvSiCuxbJOJawFOFw11u2/CRsQ/EwfWhMAR98GE9WG+tWmXMJ/Sn/jEDpPrNFa
         XhJjsfL7zPJ00CiNPZk8OG0Lii7kVzgdyaFXV5+FLSeii0lxtvoM0oEl6pvipraDfl
         JnWxzWLvo+uY8Wndm/SAg7Kmv/TnDmNlS36FKjS8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Karl=20Rudb=C3=A6k=20Olsen?= <karl@micro-technic.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4.4 84/91] ARM: dts: at91: sama5d3: define clock rate range for tcb1
Date:   Thu, 13 Feb 2020 07:20:41 -0800
Message-Id: <20200213151855.286307286@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151821.384445454@linuxfoundation.org>
References: <20200213151821.384445454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

commit a7e0f3fc01df4b1b7077df777c37feae8c9e8b6d upstream.

The clock rate range for the TCB1 clock is missing. define it in the device
tree.

Reported-by: Karl Rudbæk Olsen <karl@micro-technic.com>
Fixes: d2e8190b7916 ("ARM: at91/dt: define sama5d3 clocks")
Link: https://lore.kernel.org/r/20200110172007.1253659-2-alexandre.belloni@bootlin.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/sama5d3_tcb1.dtsi |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/boot/dts/sama5d3_tcb1.dtsi
+++ b/arch/arm/boot/dts/sama5d3_tcb1.dtsi
@@ -23,6 +23,7 @@
 					tcb1_clk: tcb1_clk {
 						#clock-cells = <0>;
 						reg = <27>;
+						atmel,clk-output-range = <0 166000000>;
 					};
 				};
 			};


