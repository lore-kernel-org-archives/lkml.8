Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEB8C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048FD2468C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845420;
	bh=ufhKVVNyjq8Y1qCZPHnjcRs1TwGgtAcKA5uVgpTmO9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qi0VjAeRMifnP+OrI0yo7OBrEm5i2qVVExnO4/vV1nnMszjncXhAb445rgQbPTmhD
	 v1RsOoljgoilbT50oD3l/mdu/cwlg9GDW9MxIkZ9WRZgBmfsaUs/VtezyRUw0xcOyx
	 ok7MB3qPAII9qkIVxpzKUfglKaADwKxrpjvsZtaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbgCJNDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:03:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729616AbgCJNDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:03:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D772524691;
        Tue, 10 Mar 2020 13:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845410;
        bh=ufhKVVNyjq8Y1qCZPHnjcRs1TwGgtAcKA5uVgpTmO9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ji8s77AP47k+UuktWI/15j9sXi2m0BFJ5bqDKkNr6K2XoMlR/Tf1A4tNgpQCX2O4G
         lRSs6o0fhtZSWP68h0SmCOtEEhvRmLgltSxcqOx9IGKG8K3mISpWfcq9xx5bcZwP/i
         1SJHnjnfvyc0d6nNq4H6AiEZceedfChPXIQTwVrA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roger Quadros <rogerq@ti.com>,
        Suman Anna <s-anna@ti.com>, Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5.5 173/189] ARM: dts: am437x-idk-evm: Fix incorrect OPP node names
Date:   Tue, 10 Mar 2020 13:40:10 +0100
Message-Id: <20200310123657.299404422@linuxfoundation.org>
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

From: Suman Anna <s-anna@ti.com>

commit 31623468be0bf57617b8057dcd335693935a9491 upstream.

The commit 337c6c9a69af ("ARM: dts: am437x-idk-evm: Disable
OPP50 for MPU") adjusts couple of OPP nodes defined in the
common am4372.dtsi file, but used outdated node names. This
results in these getting treated as new OPP nodes with missing
properties.

Fix this properly by using the correct node names as updated in
commit b9cb2ba71848 ("ARM: dts: Use - instead of @ for DT OPP
entries for TI SoCs").

Reported-by: Roger Quadros <rogerq@ti.com>
Fixes: 337c6c9a69af ("ARM: dts: am437x-idk-evm: Disable OPP50 for MPU")
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/am437x-idk-evm.dts |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/am437x-idk-evm.dts
+++ b/arch/arm/boot/dts/am437x-idk-evm.dts
@@ -526,11 +526,11 @@
 	 * Supply voltage supervisor on board will not allow opp50 so
 	 * disable it and set opp100 as suspend OPP.
 	 */
-	opp50@300000000 {
+	opp50-300000000 {
 		status = "disabled";
 	};
 
-	opp100@600000000 {
+	opp100-600000000 {
 		opp-suspend;
 	};
 };


