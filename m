Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3326CC3F2CE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F058F205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443818;
	bh=4PkmUEIgWoDG6R390YXiLlxF1ORJzlO7rszaWiK9n3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mp1DZg/kGvH4wJWDsgQ0r3gK1du9lQiU+n2bIWMYr3QBd6bS7N6sxEzfd5msjcF9h
	 ihaqDQvxYy/q+lhuqwvGLLr+WlEbgbuwo0YaPeP2zDFNCfckA/d6nMYZnIkne4oM/j
	 xO7tMslXxG3Ej1UUh26SeXrobZa/wBrbpx4ewj+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbgCQLQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:16:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727764AbgCQLIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:08:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFD6A2071C;
        Tue, 17 Mar 2020 11:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443303;
        bh=4PkmUEIgWoDG6R390YXiLlxF1ORJzlO7rszaWiK9n3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=phGf4yDQ92FNmSUJDKMdywwl4jFmg+3RodADWBPbJiHvT5TvOOUgjQMQlMaO2kDYM
         mx2nnnN3Ybf6GY2tpKxZ/sM2gPl0TD7KjBu5pcOww+kMUpV0FZeTkgFBv2GuZpB/Ax
         P9Dn1sWj0vg1ysnZDHYJYiZhWGnRGbv4wHHUhmlw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Madalin Bucur <madalin.bucur@nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 040/151] arm64: dts: ls1043a: FMan erratum A050385
Date:   Tue, 17 Mar 2020 11:54:10 +0100
Message-Id: <20200317103329.468695026@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103326.593639086@linuxfoundation.org>
References: <20200317103326.593639086@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madalin Bucur <madalin.bucur@nxp.com>

commit b54d3900862374e1bb2846e6b39d79c896c0b200 upstream.

The LS1043A SoC is affected by the A050385 erratum stating that
FMAN DMA read or writes under heavy traffic load may cause FMAN
internal resource leak thus stopping further packet processing.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi
@@ -20,6 +20,8 @@
 };
 
 &fman0 {
+	fsl,erratum-a050385;
+
 	/* these aliases provide the FMan ports mapping */
 	enet0: ethernet@e0000 {
 	};


