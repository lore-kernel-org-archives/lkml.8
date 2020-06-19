Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21744C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5886217A0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592577872;
	bh=4JFtDNHFFW5pg3sH6TQO9VaAPDJzQon9y+GOPrV4sBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G50V+Uq/j4axsX8oJivoNbH+tM68P+Wk9NJvMxmr9S8wEQBSdx+Z+29ftDfTLli+Q
	 0iVQhv1Tgv7Xt8mtZ55yadbaOVK/7EA66keLpLenpIkP1D3u2RJiNo9agXlZW8+THO
	 E0mCXg3UZrmhRCIi5Nq4ITNKy6JosqzGSiAhbPyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388573AbgFSOo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388537AbgFSOoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:44:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDECD2168B;
        Fri, 19 Jun 2020 14:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577850;
        bh=4JFtDNHFFW5pg3sH6TQO9VaAPDJzQon9y+GOPrV4sBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gxFkBOlV18//lQoAgtHzg91rc7XBOyRwW6YFl+gPDBkQLRHN0JIsqpnJAWOdYKbs/
         aScuqPK7Ol567+FsBoQaK7SOdBOr2g5AbJA8j8w3u374e/brDKnzdh6DluECfX8nVr
         AeJXrAzPQ3Ub/dV0G3/AKUxeiZO/Q/f5x4gSte5s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.9 114/128] power: vexpress: add suppress_bind_attrs to true
Date:   Fri, 19 Jun 2020 16:33:28 +0200
Message-Id: <20200619141626.163662700@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141620.148019466@linuxfoundation.org>
References: <20200619141620.148019466@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anders Roxell <anders.roxell@linaro.org>

commit 73174acc9c75960af2daa7dcbdb9781fc0d135cb upstream.

Make sure that the POWER_RESET_VEXPRESS driver won't have bind/unbind
attributes available via the sysfs, so lets be explicit here and use
".suppress_bind_attrs = true" to prevent userspace from doing something
silly.

Link: https://lore.kernel.org/r/20200527112608.3886105-2-anders.roxell@linaro.org
Cc: stable@vger.kernel.org
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/power/reset/vexpress-poweroff.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/power/reset/vexpress-poweroff.c
+++ b/drivers/power/reset/vexpress-poweroff.c
@@ -150,6 +150,7 @@ static struct platform_driver vexpress_r
 	.driver = {
 		.name = "vexpress-reset",
 		.of_match_table = vexpress_reset_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
 


