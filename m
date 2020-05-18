Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5582C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9869220715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824138;
	bh=2xa3pvPKEgoQ0Tksu296dChthZNJ30YWexkmI4oQoiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fPEEC6Ft4lHBAaF+4PTtwoSN+2cczLrNhGKHmt/f5f10FDONI9x1hRpM5nqLP/2aS
	 NnMaYgtCJ31E0Z1J5rnHWyK0qleT4EcTZ3ybWbIiwasJVXdiNC5Z37vYRGsLxw4jm4
	 FEtq7aywwhpyHC+wmH2cFLSGY3qEze8pGHcrOyP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbgERRs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:48:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730449AbgERRsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:48:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FFBF20715;
        Mon, 18 May 2020 17:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824134;
        bh=2xa3pvPKEgoQ0Tksu296dChthZNJ30YWexkmI4oQoiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k3Z8P87DsyqwY68Apof+UlaDhbGjl1tWiN3bF2hBWOiTGH7oX/CMn0RLXIxnkm/Ps
         3Qe/bCk/kAaFibuJmZRGoZJTJ93Px9SO17wlH55gY2DLcbbH8GnQ9wl9EbKYCxzuOc
         3GVcry87RMvPvMVdVLc9sBhSeJW03k1n1WeEZOzo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 4.14 086/114] net: dsa: loop: Add module soft dependency
Date:   Mon, 18 May 2020 19:36:58 +0200
Message-Id: <20200518173518.051408353@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173503.033975649@linuxfoundation.org>
References: <20200518173503.033975649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 3047211ca11bf77b3ecbce045c0aa544d934b945 ]

There is a soft dependency against dsa_loop_bdinfo.ko which sets up the
MDIO device registration, since there are no symbols referenced by
dsa_loop.ko, there is no automatic loading of dsa_loop_bdinfo.ko which
is needed.

Fixes: 98cd1552ea27 ("net: dsa: Mock-up driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/dsa_loop.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/dsa/dsa_loop.c
+++ b/drivers/net/dsa/dsa_loop.c
@@ -357,6 +357,7 @@ static void __exit dsa_loop_exit(void)
 }
 module_exit(dsa_loop_exit);
 
+MODULE_SOFTDEP("pre: dsa_loop_bdinfo");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Florian Fainelli");
 MODULE_DESCRIPTION("DSA loopback driver");


