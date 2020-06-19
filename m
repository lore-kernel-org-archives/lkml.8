Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3504CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 079CE206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580948;
	bh=QasecetVS2wywm5+DfOgUE0zZX8LEXJJBx2rbD4hdMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vupRKHGMF1eSllR17fYd3yfbJ796f2Kx65D/kpKMVqZDWB8CtAOuNGipRFilxd7xq
	 8eOBE3ISG7Y5rgW9V1G+S0WBRzoOivJGbILcDjxB7POyrPuGjaeLLzzfIs078G9z6V
	 02MS6uXJ/TkHl5Hd1Fh0RE/VhUIkjYOr9GDqKhKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405040AbgFSPfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:35:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404855AbgFSPba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:31:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 795E420734;
        Fri, 19 Jun 2020 15:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580690;
        bh=QasecetVS2wywm5+DfOgUE0zZX8LEXJJBx2rbD4hdMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FvorxeJ1LZ3JFx/n3UCVZYVUkKxuXDpcgMFGjrh/zk2XYzpqj0Pg0V/efKlu0pKLN
         7FIZbHSJhOg9WbazEBNyQnSj2kfue4V+hREznb6uSqkiDBmMgIPbsJSGY22wBsBoh+
         dviPyhJGwLwSU0e/QHnso0KJiU0oQ07qC49ENuyE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5.7 315/376] power: vexpress: add suppress_bind_attrs to true
Date:   Fri, 19 Jun 2020 16:33:53 +0200
Message-Id: <20200619141725.248342027@linuxfoundation.org>
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

From: Anders Roxell <anders.roxell@linaro.org>

commit 73174acc9c75960af2daa7dcbdb9781fc0d135cb upstream.

Make sure that the POWER_RESET_VEXPRESS driver won't have bind/unbind
attributes available via the sysfs, so lets be explicit here and use
".suppress_bind_attrs = true" to prevent userspace from doing something
silly.

Link: https://lore.kernel.org/r/20200527112608.3886105-2-anders.roxell@linaro.org
Cc: stable@vger.kernel.org
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/power/reset/vexpress-poweroff.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/power/reset/vexpress-poweroff.c
+++ b/drivers/power/reset/vexpress-poweroff.c
@@ -143,6 +143,7 @@ static struct platform_driver vexpress_r
 	.driver = {
 		.name = "vexpress-reset",
 		.of_match_table = vexpress_reset_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
 


