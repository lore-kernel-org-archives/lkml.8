Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E40BC433EA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F6022CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260719;
	bh=qPbFVQa1Wx91Hp6x2uzH3y2LNvB6ddAdFBVb0dj/MTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TCiYP1TR22H81h75TIyPjKOPfEFS+weSMQIUQ2f9qqNYfv4JgHQHIwfflJn0cC7M3
	 zVvR3MmEpoSC4mi37ORU+HHijAyQ3RLosoku73naOtKqDIzjNonMcG+jXrrL5OYrng
	 5G2w6mGYtmNN0qxsRso+7fbFNiIu8K1hOBlnvh5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732066AbgGTP6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:58:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732051AbgGTP6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:58:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 342F1206E9;
        Mon, 20 Jul 2020 15:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260713;
        bh=qPbFVQa1Wx91Hp6x2uzH3y2LNvB6ddAdFBVb0dj/MTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KEiQLduSTcEONm/1LEiImXkt7O0RpfRquAmvzkgym8/OVj03rqgXi+St2ogT7zEyY
         RH1Nv+vFJ0fIRI34OKsgF4mJswIarMMf2BtZ5Zd4OjA4i3Sk5P1DShyTf7py8h7vLF
         oJ7D2SfU74JbxoMw6nVnqHpRxN5cnkAgaLAzDgAA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangmin Park <l4stpr0gr4m@gmail.com>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 039/215] dt-bindings: mailbox: zynqmp_ipi: fix unit address
Date:   Mon, 20 Jul 2020 17:35:21 +0200
Message-Id: <20200720152822.043412135@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152820.122442056@linuxfoundation.org>
References: <20200720152820.122442056@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangmin Park <l4stpr0gr4m@gmail.com>

[ Upstream commit 35b9c0fdb9f666628ecda02b1fc44306933a2d97 ]

Fix unit address to match the first address specified in the reg
property of the node in example.

Signed-off-by: Kangmin Park <l4stpr0gr4m@gmail.com>
Link: https://lore.kernel.org/r/20200625135158.5861-1-l4stpr0gr4m@gmail.com
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
index 4438432bfe9b3..ad76edccf8816 100644
--- a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
+++ b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
@@ -87,7 +87,7 @@ Example:
 		ranges;
 
 		/* APU<->RPU0 IPI mailbox controller */
-		ipi_mailbox_rpu0: mailbox@ff90400 {
+		ipi_mailbox_rpu0: mailbox@ff990400 {
 			reg = <0xff990400 0x20>,
 			      <0xff990420 0x20>,
 			      <0xff990080 0x20>,
-- 
2.25.1



