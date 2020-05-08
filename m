Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3D4C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50A09208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588944227;
	bh=bxj8mKoo5XMAehimjbYu3A/YMqmLED2vL3bovyybDMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gptgvN4vxwY/ug7d6XHuMZjYHzx7a/3kDIFmiJLj1/dR2KI9Fus5o+SyNxrtiiQMB
	 R0HAVqeTHXex1JU/9u32hcfAlrd634pWvrbkdfCvf/pgI9BfhbW5fEKf+aoIQt/ZKT
	 TCJtbuj6jTra6Zf4n3+GrjiejG+0F7nVMF0bXF7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbgEHNXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:23:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbgEHMhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:37:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD0B9207DD;
        Fri,  8 May 2020 12:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941467;
        bh=bxj8mKoo5XMAehimjbYu3A/YMqmLED2vL3bovyybDMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KTNc5Y/AlC9VyVyn2ivaAcs1ryWirSKJBe6PARU50nA0MVoEixTM3/9cJYH1uKnV9
         tK0tSnBu92c9B1um4ZefwkQMYbieS2I87qVULJ/1JKfLZT9UJYXq02s+g4FIMIyHkE
         vKZE6Qe/oVCZ3iXsDc3IfLlhNptrdJHjlSWVTa3k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 4.4 043/312] ARM: dts: kirkwood: add kirkwood-ds112.dtb to Makefile
Date:   Fri,  8 May 2020 14:30:34 +0200
Message-Id: <20200508123127.585764495@linuxfoundation.org>
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

From: Heinrich Schuchardt <xypron.glpk@gmx.de>

commit fc5c796e12511a7c027b5a4438719dde2f796208 upstream.

Commit 2d0a7addbd10 ("ARM: Kirkwood: Add support for many Synology
NAS devices") created the new file kirkwood-ds112.dts but did not
add it to the Makefile.

Fixes: 2d0a7addbd10 ("ARM: Kirkwood: Add support for many Synology NAS devices")
Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/Makefile |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -166,6 +166,7 @@ dtb-$(CONFIG_MACH_KIRKWOOD) += \
 	kirkwood-ds109.dtb \
 	kirkwood-ds110jv10.dtb \
 	kirkwood-ds111.dtb \
+	kirkwood-ds112.dtb \
 	kirkwood-ds209.dtb \
 	kirkwood-ds210.dtb \
 	kirkwood-ds212.dtb \


