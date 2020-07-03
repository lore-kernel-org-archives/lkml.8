Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BECFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 22:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF67820890
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 22:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jOaZSIgr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgGCWlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 18:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgGCWlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 18:41:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6279FC061794;
        Fri,  3 Jul 2020 15:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=qvP0Yw4ollo0NwA0iN4Ou2SAdf0fDm9BLSgkO8zwzUo=; b=jOaZSIgrpc/Ncf7S5alY28gAys
        c69UN0CCH7tPErpkLF/BnssLRfuTAytWM/nMElsGjfjJQ5MyMiY3UmfYMq3VxWHLNYEOvPxrLd3LJ
        bUKlnl1Qe3/XajMhfbZrvpn4epcqgEdmxf0pnVIvjbDiMZ5GOHxRjrCQqJiev1Dx7yYzDD6NywaMN
        DUUL42qZDLrbY6y9D9qvjpEfFKExoJU0v0qnKc/EGJIe2ReHlBjcsqhWHeEi7OzhyLGRXnNFRn37e
        oY44zGUxRgneepQWzi/V2woZvgZDElcQdCGFDARR0gyDtYSVNqzKgDlc128Pq+Mgazl4iCVA6znYW
        rMO4noLg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrUNH-0000A4-BV; Fri, 03 Jul 2020 22:41:40 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-hams@vger.kernel.org,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Howells <dhowells@redhat.com>,
        linux-afs@lists.infradead.org
Subject: [PATCH 5/7] Documentation: networking: ip-sysctl: drop doubled word
Date:   Fri,  3 Jul 2020 15:41:13 -0700
Message-Id: <20200703224115.29769-6-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703224115.29769-1-rdunlap@infradead.org>
References: <20200703224115.29769-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the doubled word "that".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
---
 Documentation/networking/ip-sysctl.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/networking/ip-sysctl.rst
+++ linux-next-20200701/Documentation/networking/ip-sysctl.rst
@@ -741,7 +741,7 @@ tcp_fastopen - INTEGER
 
 	Default: 0x1
 
-	Note that that additional client or server features are only
+	Note that additional client or server features are only
 	effective if the basic support (0x1 and 0x2) are enabled respectively.
 
 tcp_fastopen_blackhole_timeout_sec - INTEGER
