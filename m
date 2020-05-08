Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956FAC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61C1524969
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942071;
	bh=sP2fDwHK0o+Nk6rO0FvGgB4mTCFHk1NwdhTnL2GdlBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=10Y/dk2ZiWh37ReZHwbniQEiiNudip4kQlyl/c4ELuXqdUfrJimkgv7tnc986E4Zp
	 cRNcH1Zyub5F0e4a1z/Xtjyn3SZOOgHa7VJ3q920699117VbnPze+CzWvM/kV9/7nr
	 ywBSVGqJo+dJyA3GoEHRxPnOY7Dlq4QQVS9g8R3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgEHMru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:47:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729581AbgEHMrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:47:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EA9621473;
        Fri,  8 May 2020 12:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942061;
        bh=sP2fDwHK0o+Nk6rO0FvGgB4mTCFHk1NwdhTnL2GdlBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GQXhyVi5wPQAn+nmt5VUv4d7Qsh7RjFznVa/hhxWEFBIi0YVLRjJ0Qfor0KW42rIG
         9XNFhBn8tjseRLYkjkOITYMVhOHXRHHOqZacxUKH5CbHX5Rm8Iqjccx1NmOjiEccuW
         bINrm49BgEBmnsVdgO+poXSc1LNKQwdGu0lkh5mY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 282/312] net: dsa: mv88e6xxx: enable SA learning on DSA ports
Date:   Fri,  8 May 2020 14:34:33 +0200
Message-Id: <20200508123144.243668620@linuxfoundation.org>
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

From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

commit 996ecb8246676100af2a4dc1cfed747712a3c85f upstream.

In multi-chip systems, DSA Tag ports must learn SA addresses in order to
correctly switch frames between interconnected chips.

This fixes cross-chip hardware bridging in a VLAN filtering aware
system, because a bridge group gets implemented as an hardware 802.1Q
VLAN and thus DSA and user ports share the same FDB.

Fixes: 4c7ea3c0791e ("net: dsa: mv88e6xxx: disable SA learning for DSA and CPU ports")
Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/dsa/mv88e6xxx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/dsa/mv88e6xxx.c
+++ b/drivers/net/dsa/mv88e6xxx.c
@@ -2064,8 +2064,8 @@ static int mv88e6xxx_setup_port(struct d
 	 * the other bits clear.
 	 */
 	reg = 1 << port;
-	/* Disable learning for DSA and CPU ports */
-	if (dsa_is_cpu_port(ds, port) || dsa_is_dsa_port(ds, port))
+	/* Disable learning for CPU port */
+	if (dsa_is_cpu_port(ds, port))
 		reg = 0;
 
 	ret = _mv88e6xxx_reg_write(ds, REG_PORT(port), PORT_ASSOC_VECTOR, reg);


