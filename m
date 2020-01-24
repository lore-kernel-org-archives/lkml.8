Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310B7C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24C8214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579860520;
	bh=OXQy5n8zYk62OPY+B6WvTiq81LyTp13h6i04WnY3StQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OgpHvYrxzimmqWAlggmd862uyhEAqUKMDYyMl4PK6Gp1kdz0Ofxkp++NkaA/ow8iX
	 kyIoDCExeDGlNIdC9fWEi1pG0ibo/j9ChAxTqzDrEQEmvU41qVycNsfLU7LE+DmCXl
	 3dD7983/1CnjZeS8cCHLffiyEwkX4K7UwGNMtyIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389536AbgAXKIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 05:08:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:45426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389216AbgAXKIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 05:08:36 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C903D20709;
        Fri, 24 Jan 2020 10:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579860516;
        bh=OXQy5n8zYk62OPY+B6WvTiq81LyTp13h6i04WnY3StQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qD/i5XG9EfFuXk6qJjez98MSE4uJ0C5D8x41XA3KXikkNf8ygH43olCeUSHVB+Ea3
         swN7OLCPvEeH0dBdIVl370nX73aiIVghd/fDxT+1Ro3aah64PX8TlHvc0qxV1GHKjo
         EOrVZx+/TBw1nzybB0Enp85c0+op0Qs11rpsctMI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 4.19 017/639] ipmi: Fix memory leak in __ipmi_bmc_register
Date:   Fri, 24 Jan 2020 10:23:07 +0100
Message-Id: <20200124093049.298618182@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

commit 4aa7afb0ee20a97fbf0c5bab3df028d5fb85fdab upstream.

In the impelementation of __ipmi_bmc_register() the allocated memory for
bmc should be released in case ida_simple_get() fails.

Fixes: 68e7e50f195f ("ipmi: Don't use BMC product/dev ids in the BMC name")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Message-Id: <20191021200649.1511-1-navid.emamdoost@gmail.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/ipmi/ipmi_msghandler.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -2965,8 +2965,11 @@ static int __ipmi_bmc_register(struct ip
 		bmc->pdev.name = "ipmi_bmc";
 
 		rv = ida_simple_get(&ipmi_bmc_ida, 0, 0, GFP_KERNEL);
-		if (rv < 0)
+		if (rv < 0) {
+			kfree(bmc);
 			goto out;
+		}
+
 		bmc->pdev.dev.driver = &ipmidriver.driver;
 		bmc->pdev.id = rv;
 		bmc->pdev.dev.release = release_bmc_device;


