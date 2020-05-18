Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09F7C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C88FA207C4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824907;
	bh=E62aFs6PBTk5tFC7+VokOo5cOK1GtOKO7f7fTsT5TE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OxbVk07od2WixxCjelw87xI+6fUEVNFFoWgysmH3NMfN1dF8mxfrxjQf9zbEkvEfz
	 jJURrFiyfEGR3NszFcmXqbEOTdmA2o0/AKdwXu5kmlq46mM3cNtkVnqrSfWQlpmGcw
	 ZJPwKOo8IncAYJRz0xubAPZQw0wnqGdYRUnCjK8c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbgERSBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:01:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732415AbgERSBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:01:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39893207C4;
        Mon, 18 May 2020 18:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824896;
        bh=E62aFs6PBTk5tFC7+VokOo5cOK1GtOKO7f7fTsT5TE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LpDj2PErEKeCQALJhG3WOeJnWboS3j3vEvxtNXf12/oFTBgav8KWA8msPNeJvcCUr
         mDuZKjc8urpD6G+9IkG+xO/4seoG5gLqw4/NZ1mGqi96uw7zqBJPCA3V0NsNHbWA8N
         QS9rNqoxJCN5X9X/FeTNHngjRVMYrqDAie2FH7RY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Camale=C3=B3n?= <noelamac@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.6 048/194] r8169: re-establish support for RTL8401 chip version
Date:   Mon, 18 May 2020 19:35:38 +0200
Message-Id: <20200518173535.816265470@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173531.455604187@linuxfoundation.org>
References: <20200518173531.455604187@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 1f8492df081bd66255764f3ce82ba1b2c37def49 ]

r8169 never had native support for the RTL8401, however it reportedly
worked with the fallback to RTL8101e [0]. Therefore let's add this
as an explicit assignment.

[0] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=956868

Fixes: b4cc2dcc9c7c ("r8169: remove default chip versions")
Reported-by: Camaleón <noelamac@gmail.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169_main.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2127,6 +2127,8 @@ static void rtl8169_get_mac_version(stru
 		{ 0x7cf, 0x348,	RTL_GIGA_MAC_VER_07 },
 		{ 0x7cf, 0x248,	RTL_GIGA_MAC_VER_07 },
 		{ 0x7cf, 0x340,	RTL_GIGA_MAC_VER_13 },
+		/* RTL8401, reportedly works if treated as RTL8101e */
+		{ 0x7cf, 0x240,	RTL_GIGA_MAC_VER_13 },
 		{ 0x7cf, 0x343,	RTL_GIGA_MAC_VER_10 },
 		{ 0x7cf, 0x342,	RTL_GIGA_MAC_VER_16 },
 		{ 0x7c8, 0x348,	RTL_GIGA_MAC_VER_09 },


