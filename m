Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EB2C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E262620575
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099772;
	bh=RatZWJj2molmVc4U4IIdVkhkfYTHFDUQlZN6Amy12T0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ULuo4SeqGWyXNKbbK4CrKYegpMAJ2X0BHRfIhQ/NrwCgLaJrf2xkgr93AXddsPOZ9
	 ak51IDQtcqUq2gYKHjMhwwLBUByv3YxzBy/eU4LdVVnGEC0Ifl88LIlKHCW0RBf2v3
	 NxsgUT+2+pFDWNPzgdCLcycAtoHDBETJSjicqMn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbgD1Stb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:49:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730479AbgD1SkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:40:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4084920575;
        Tue, 28 Apr 2020 18:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099214;
        bh=RatZWJj2molmVc4U4IIdVkhkfYTHFDUQlZN6Amy12T0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=StBqV7xzLX6pRiI/OFc4uasOEaSifzzzhGjg51qaiwZJQ9F9IaFn7cNWOyUFD5EhA
         C1AMTZARSQi+kdHiyoStVSWco9/fDXftmSGHxNX8Y7WwYa3dSzpIm8XuSqVvu/EPP9
         wOv7koMPH0qprkc8lhSOxp0IlyNCRrErDckBy5Es=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 4.19 115/131] vt: dont hardcode the mem allocation upper bound
Date:   Tue, 28 Apr 2020 20:25:27 +0200
Message-Id: <20200428182239.702907674@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182224.822179290@linuxfoundation.org>
References: <20200428182224.822179290@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Pitre <nico@fluxnic.net>

commit 2717769e204e83e65b8819c5e2ef3e5b6639b270 upstream.

The code in vc_do_resize() bounds the memory allocation size to avoid
exceeding MAX_ORDER down the kzalloc() call chain and generating a
runtime warning triggerable from user space. However, not only is it
unwise to use a literal value here, but MAX_ORDER may also be
configurable based on CONFIG_FORCE_MAX_ZONEORDER.
Let's use KMALLOC_MAX_SIZE instead.

Note that prior commit bb1107f7c605 ("mm, slab: make sure that
KMALLOC_MAX_SIZE will fit into MAX_ORDER") the KMALLOC_MAX_SIZE value
could not be relied upon.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
Cc: <stable@vger.kernel.org> # v4.10+
Link: https://lore.kernel.org/r/nycvar.YSQ.7.76.2003281702410.2671@knanqh.ubzr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/vt/vt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1209,7 +1209,7 @@ static int vc_do_resize(struct tty_struc
 	if (new_cols == vc->vc_cols && new_rows == vc->vc_rows)
 		return 0;
 
-	if (new_screen_size > (4 << 20))
+	if (new_screen_size > KMALLOC_MAX_SIZE)
 		return -EINVAL;
 	newscreen = kzalloc(new_screen_size, GFP_USER);
 	if (!newscreen)


