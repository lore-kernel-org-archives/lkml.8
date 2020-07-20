Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0B3C433EA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B5322065E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261325;
	bh=qPbFVQa1Wx91Hp6x2uzH3y2LNvB6ddAdFBVb0dj/MTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZKHhentS07xvjX+xr9uIFbN5XkLTAFTYo7thy53fzfhUO/Sbt/cFNKRFq16Sv6BeN
	 IvpFQGbIg4I0c8msmQEqMThTk7Dv+AJ5Omso4248rPl63jeBqsbJzTvYBBOYcSdZ3b
	 gtC2zepR89YU71GRY1LKLuo8IbM1lg96s8TG/yAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387427AbgGTQIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:08:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387420AbgGTQIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:08:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC65C2064B;
        Mon, 20 Jul 2020 16:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261320;
        bh=qPbFVQa1Wx91Hp6x2uzH3y2LNvB6ddAdFBVb0dj/MTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ddfR6aJCGEZ6YiAmV9AHI1joxAWwZu5BF2yo7jCPReCovVt2gBzhKBl+7mBV+3d35
         4jukWfC6McjSy5zYdcFt5j4wSaoLFHHqfcLuCYEBU6UyuuJp/zE5AKDXMAkJWRzpgd
         mIvDWhdhTtWOj7cw/uaEN0kACoZpRbRn3Tgy8iQQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangmin Park <l4stpr0gr4m@gmail.com>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 043/244] dt-bindings: mailbox: zynqmp_ipi: fix unit address
Date:   Mon, 20 Jul 2020 17:35:14 +0200
Message-Id: <20200720152827.906504650@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
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



