Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD6AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFB7220715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824238;
	bh=nBbrIivAPlOsYkCOCIweAJk+9Fv0sCwKtYP491W2//U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=agXlqXkFGSEcFiXmJ506b1IxBoT8COlXQPNotKpe49Q3zKYLy2skKIJnEXrbM/VlM
	 uPbwuUhkeDDVnmnlWhI/DU8WAtNGNghBN+jsf/H4IFcvOAGDLjdUJ8mz3ua0KzoDId
	 U/N+YyCLKe/Ha20UyOZ6tB1BU5QaWNtetgtz5c18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbgERRue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:50:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:52692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728907AbgERRua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:50:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2953920674;
        Mon, 18 May 2020 17:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824229;
        bh=nBbrIivAPlOsYkCOCIweAJk+9Fv0sCwKtYP491W2//U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sFghHwpD8q78YDUFITO5BI2zN4wn+EUzs/A5ZUSS8r8M2t2cdoWK2Qy1NSn/59oP7
         E/wO1kZse1UUHQxS8we/R2dEcft6I+4d0ZJSEe/koS7QpqTnRkvYbJ4B6yZ/76fYzA
         +83UJADCEIZrkJSkii75cH2MvbW2Lo8Tozi1Y+aA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 01/80] net: dsa: Do not make user port errors fatal
Date:   Mon, 18 May 2020 19:36:19 +0200
Message-Id: <20200518173450.419156571@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.097837707@linuxfoundation.org>
References: <20200518173450.097837707@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

commit 86f8b1c01a0a537a73d2996615133be63cdf75db upstream.

Prior to 1d27732f411d ("net: dsa: setup and teardown ports"), we would
not treat failures to set-up an user port as fatal, but after this
commit we would, which is a regression for some systems where interfaces
may be declared in the Device Tree, but the underlying hardware may not
be present (pluggable daughter cards for instance).

Fixes: 1d27732f411d ("net: dsa: setup and teardown ports")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/dsa/dsa2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -412,7 +412,7 @@ static int dsa_tree_setup_switches(struc
 
 		err = dsa_switch_setup(ds);
 		if (err)
-			return err;
+			continue;
 
 		for (port = 0; port < ds->num_ports; port++) {
 			dp = &ds->ports[port];


