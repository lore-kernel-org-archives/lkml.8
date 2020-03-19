Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F41C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9D320724
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584624064;
	bh=1sBIkeTKIfNbKJsAZXXIYq07vCvmoC9l+d3drbBYvkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yPDfYxgbFknLUoAt9AeJhfd0DaHaPiy1vWPXavW8hL3Kd8Cwls7wYV+XwshYGRKS7
	 J5PEe3Ee8jwg597zNL8wWQVBBagUEaOLYznf+D1T0pN2s5p2+L2lr1j8wNrskNGr+O
	 LqTBdnU+wIiaCRwz4L/hf+tLitrLtHWpDVEem4BM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbgCSNVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:21:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730043AbgCSNU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:20:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E737B20724;
        Thu, 19 Mar 2020 13:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584624059;
        bh=1sBIkeTKIfNbKJsAZXXIYq07vCvmoC9l+d3drbBYvkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YkAwN4wgHERiMri46xDIEePb39+PgKbzkPhXs08GPNkfd/2Mm4Tli1YHUywgdZ31t
         YH55p2WfODXrhRaSHqstmGzqvYLW5Qi9xyKXXOblNPBCDX8QRYmfvKGTaZ0vUhBP6n
         3adLVcAG+jfB0Bcu9MOLNDosKXUc0q867eKv8zAI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 4.19 43/48] ARM: 8957/1: VDSO: Match ARMv8 timer in cntvct_functional()
Date:   Thu, 19 Mar 2020 14:04:25 +0100
Message-Id: <20200319123916.335652762@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123902.941451241@linuxfoundation.org>
References: <20200319123902.941451241@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

commit 45939ce292b4b11159719faaf60aba7d58d5fe33 upstream.

It is possible for a system with an ARMv8 timer to run a 32-bit kernel.
When this happens we will unconditionally have the vDSO code remove the
__vdso_gettimeofday and __vdso_clock_gettime symbols because
cntvct_functional() returns false since it does not match that
compatibility string.

Fixes: ecf99a439105 ("ARM: 8331/1: VDSO initialization, mapping, and synchronization")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/kernel/vdso.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -104,6 +104,8 @@ static bool __init cntvct_functional(voi
 	 */
 	np = of_find_compatible_node(NULL, NULL, "arm,armv7-timer");
 	if (!np)
+		np = of_find_compatible_node(NULL, NULL, "arm,armv8-timer");
+	if (!np)
 		goto out_put;
 
 	if (of_property_read_bool(np, "arm,cpu-registers-not-fw-configured"))


