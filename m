Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FF3C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33B5F20B80
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099075;
	bh=nZOTCztkrvm3VQFpmLiXSlzVzJMlPmcb9EM8YgnLKNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TgbH/sRCfmJZLLUPzquwdu+84ChfP7XeqdWWr4zTZqjAQpWDNu2+YLgPdVo2x2B+Y
	 TAVXW0+3pwzb0ZSHAiaO625RPyBUsNTpIX4ppQINfdaJ1Z4q+2jt3SRSg/dGpySEaR
	 PsuSIoUkigPhEG579/axFNBvwtZTPHJEXVhmCshM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbgD1Shy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:37:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730544AbgD1Shu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:37:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFD7620575;
        Tue, 28 Apr 2020 18:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099070;
        bh=nZOTCztkrvm3VQFpmLiXSlzVzJMlPmcb9EM8YgnLKNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iLibpF3oB31lNDOGQ9+HDkdr3Seck4eVuxyHIFSxZKnfESXab5FK+7yPcwrC12ZGD
         1tpY82dYkfQfhd3gka6nsVVbQKoXn9FS6SmpPwR/NPSI6Em8dBShZy9cE2Qnb1MYT7
         ogX+Qtgj0pVqsWYh464dFG6JY5CBJ3p+unYFgwcs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 5.6 136/167] vt: dont hardcode the mem allocation upper bound
Date:   Tue, 28 Apr 2020 20:25:12 +0200
Message-Id: <20200428182242.697621873@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182225.451225420@linuxfoundation.org>
References: <20200428182225.451225420@linuxfoundation.org>
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
@@ -1206,7 +1206,7 @@ static int vc_do_resize(struct tty_struc
 	if (new_cols == vc->vc_cols && new_rows == vc->vc_rows)
 		return 0;
 
-	if (new_screen_size > (4 << 20))
+	if (new_screen_size > KMALLOC_MAX_SIZE)
 		return -EINVAL;
 	newscreen = kzalloc(new_screen_size, GFP_USER);
 	if (!newscreen)


