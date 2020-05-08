Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76218C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50B9D218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588944041;
	bh=N0DLR3oAC035hFKiptxXpTnmpMQoMcr124/7seXz1ME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mAtcufo6YI8ArZm9+9TH9Mlqn6zoolRpK8JP7cqlC6oAOgASg22TULTBfiZMcGkD2
	 qFoiWCx0oAfgzjPwfjB5qRANgBFqG2sSd4giLNbwrJe9sHTDv37aWEO9SYRT1IdhtY
	 hoUbZZFHyOG9zfhjsp9NgAnhKdUxOdO+U0yNLfaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgEHNUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:20:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728750AbgEHMkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:40:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99DEC24968;
        Fri,  8 May 2020 12:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941653;
        bh=N0DLR3oAC035hFKiptxXpTnmpMQoMcr124/7seXz1ME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JeM6iYhIcnkLB09f0AD5UDiUMCaeguVVvGcByvZck/MW8jd4jS1AOvQlwDjD+0gXZ
         t2SwiqeBZuJ25N6mFMkeDDugNvySN3/hm0esKHVqIxEiM98jqj9kyoU789+FdsjyTL
         i4/cJR+SOK7cplje2FoeCkGTyYY+62YwPW7+YUdo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rene Herman <rene.herman@keyaccess.nl>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 4.4 119/312] isa: Call isa_bus_init before dependent ISA bus drivers register
Date:   Fri,  8 May 2020 14:31:50 +0200
Message-Id: <20200508123132.830428928@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Breathitt Gray <vilhelm.gray@gmail.com>

commit 32a5a0c047343b11f581f663a2309cf43d13466f upstream.

The isa_bus_init function must be called before drivers which utilize
the ISA bus driver are registered. A race condition for initilization
exists if device_initcall is used (the isa_bus_init callback is placed
in the same initcall level as dependent drivers which use module_init).
This patch ensures that isa_bus_init is called first by utilizing
postcore_initcall in favor of device_initcall.

Fixes: a5117ba7da37 ("[PATCH] Driver model: add ISA bus")
Cc: Rene Herman <rene.herman@keyaccess.nl>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/isa.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/base/isa.c
+++ b/drivers/base/isa.c
@@ -180,4 +180,4 @@ static int __init isa_bus_init(void)
 	return error;
 }
 
-device_initcall(isa_bus_init);
+postcore_initcall(isa_bus_init);


