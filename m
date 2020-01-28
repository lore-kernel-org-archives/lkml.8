Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EF6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5640224685
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220722;
	bh=T7GAyNYqf50JYFR50rTmjH1fXw/zdgb+oHJL67cc+kM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ExumEGnwaoEYtzS9FguT6WRCHXIx42LcVCXpUzpkLUc170CfYJ0pUzSu71t1MhMdp
	 lGf40AYSui83vWLhJYsTyY2M0KwFkTBz+XzY9jwEvasMmwRm7KltsGhU0YL2wHIdkx
	 3P5iasLufJVa0iP5+1bbdU8i6rqAropwinzbXBFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgA1OMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:12:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:32968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbgA1OL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:11:56 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07FBB24690;
        Tue, 28 Jan 2020 14:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220716;
        bh=T7GAyNYqf50JYFR50rTmjH1fXw/zdgb+oHJL67cc+kM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lEWPu8fRV8cNg6eIYgLdRDue1bY2WUjjerC0pBxjEea5lndzdCisuCf4BzEffTna5
         boR7FzHFZAVg1WVioClTIOAmghDyNwSgmHVnR3YAIP8wE+SSYVrGa1yPscl0vO8E2S
         GP98S4ocUbl1hgVV97D/bJnuTQ1KDOizE+2Xb01U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Li Yang <leoyang.li@nxp.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 071/183] soc/fsl/qe: Fix an error code in qe_pin_request()
Date:   Tue, 28 Jan 2020 15:04:50 +0100
Message-Id: <20200128135837.101811933@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135829.486060649@linuxfoundation.org>
References: <20200128135829.486060649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 5674a92ca4b7e5a6a19231edd10298d30324cd27 ]

We forgot to set "err" on this error path.

Fixes: 1a2d397a6eb5 ("gpio/powerpc: Eliminate duplication of of_get_named_gpio_flags()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/sysdev/qe_lib/gpio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/qe_lib/gpio.c b/arch/powerpc/sysdev/qe_lib/gpio.c
index 521e67a49dc40..4052e3d7edbd5 100644
--- a/arch/powerpc/sysdev/qe_lib/gpio.c
+++ b/arch/powerpc/sysdev/qe_lib/gpio.c
@@ -155,8 +155,10 @@ struct qe_pin *qe_pin_request(struct device_node *np, int index)
 	if (err < 0)
 		goto err0;
 	gc = gpio_to_chip(err);
-	if (WARN_ON(!gc))
+	if (WARN_ON(!gc)) {
+		err = -ENODEV;
 		goto err0;
+	}
 
 	if (!of_device_is_compatible(gc->of_node, "fsl,mpc8323-qe-pario-bank")) {
 		pr_debug("%s: tried to get a non-qe pin\n", __func__);
-- 
2.20.1



