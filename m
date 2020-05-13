Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8112BCA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5177520575
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589363540;
	bh=Vv9PhfdE/RaWowcul5qnKTkgLbCXCDjFn8b2JC2Q9co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DuygLBVqZIg/ccp79mvdyW1qm/2QRoNgNII7+VClwzgF7YRQGyAed2nCHPUD3NN5t
	 6s4zKnPpy1mD1TRjTb5gZveMNAjjMGFVWhDBo5AUOnY0FXDUtOrbEaYCU0W4DbhBdS
	 J5MtUdeWEk/kaevY1GmKr5LySPiQ8MJfTSIDOKBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387781AbgEMJwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:52:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387768AbgEMJwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:52:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83CDD20575;
        Wed, 13 May 2020 09:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363536;
        bh=Vv9PhfdE/RaWowcul5qnKTkgLbCXCDjFn8b2JC2Q9co=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rYmskubFlxIapZvDE3kf7ISJ+cWsfeB5U3osrVXEemjKPvWDBTuoYytrisoy1tgNu
         FQ/QsBg+cfMMwYcw31RgMHC64C58AiNUfERtzzH4vzovgnhdC9lqWHPn8GL23teWuY
         BmAo2BIHv7Zh5mwEmpjZKmWEC7wFiq3mGeZmLBTg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.6 023/118] net: dsa: Do not make user port errors fatal
Date:   Wed, 13 May 2020 11:44:02 +0200
Message-Id: <20200513094419.723032920@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094417.618129545@linuxfoundation.org>
References: <20200513094417.618129545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 86f8b1c01a0a537a73d2996615133be63cdf75db ]

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
@@ -459,7 +459,7 @@ static int dsa_tree_setup_switches(struc
 	list_for_each_entry(dp, &dst->ports, list) {
 		err = dsa_port_setup(dp);
 		if (err)
-			goto teardown;
+			continue;
 	}
 
 	return 0;


