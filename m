Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF16CC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C652205C9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340856;
	bh=QJO36q4IXEUTVwczK7dZ+w+1pFYj+cSeiVaPtCGjnPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ji4vQ7A8yxoE8seeUmRw4C3LcEnZT3WBu0pq0DMi0Q5OTv9L8EJ/Ye3Ewj+ZbDwmA
	 Jyntf8ViD91e8vQdhh32uC7BB8bKk5YB6E4jj+/NCvm8no56d+p0eDXzoIGKHcdMMV
	 a4NDLvChtTP/JfBu60bKAxEIGc+UqlLLNOjok2es=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731626AbgEANnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:43:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731619AbgEANnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:43:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E4B520757;
        Fri,  1 May 2020 13:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340600;
        bh=QJO36q4IXEUTVwczK7dZ+w+1pFYj+cSeiVaPtCGjnPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R+qNicoRm4NVjAPU3N23o4XdEfAH2Mc7wlDVtiEhoSB67DV2be6Xg8AjmLzahp+qX
         x/YFJ2bSYLHIqmslGMLuoQdaXquUdOjwcf5p83x3MNwVFpCVapAqeUykK/S/SW70O6
         np3DoOhTygpMiVBrL58Qh0U5yRkD/Gn8r/oVi1wk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 5.6 048/106] ARM: dts: bcm283x: Disable dsi0 node
Date:   Fri,  1 May 2020 15:23:21 +0200
Message-Id: <20200501131549.463229361@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131543.421333643@linuxfoundation.org>
References: <20200501131543.421333643@linuxfoundation.org>
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
@@ -372,6 +372,7 @@
 					     "dsi0_ddr2",
 					     "dsi0_ddr";
 
+			status = "disabled";
 		};
 
 		aux: aux@7e215000 {


