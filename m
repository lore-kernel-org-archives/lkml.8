Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47741C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2519D207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590742358;
	bh=lM0pqY9A9HZVoYYkL4jwxKyhd9Qx14GNUqXeaDFjVOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q6KQJ3VC6C95gIizI1XgeBGy+fiV82fLTzrIENXd0XHxTVRE/6EmFug+0Frpct1q1
	 +uWHcOae2wuKjQvzILhCPceG3die4Tw6sX6+4fm0iqaMN3vLvl6imzjkt9E1qAaafX
	 mQ2w5yVHVT8OLXB3Nd/LSu3EUG6Bxc/TMkE9XQCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgE2Iwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:52:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgE2Iwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:52:37 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64BD020776;
        Fri, 29 May 2020 08:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590742356;
        bh=lM0pqY9A9HZVoYYkL4jwxKyhd9Qx14GNUqXeaDFjVOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZgClWNM0sAw4ZxYh9THr6qbNd7jM70YaNC0SdMPioFnxjGn4TcS7nYa5LWy/VP0+i
         ExwrRSZ7UhSxoLq0udFelaLxB5gmonMSGF/EV90Bh2Km2pWII+L0wohxOBx5xnDnGc
         a7Klo8lfxdyhf3TgBAi2FGW440lqLHzZp6h9SrS8=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jeakk-00GDsx-Na; Fri, 29 May 2020 09:52:34 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-kernel@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Huacai Chen <chenhc@lemote.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 0/6] Three Loongson irqchip support
Date:   Fri, 29 May 2020 09:52:13 +0100
Message-Id: <159074223979.887186.1909053030258448427.b4-ty@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528152757.1028711-1-jiaxun.yang@flygoat.com>
References: <20200528152757.1028711-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: jiaxun.yang@flygoat.com, linux-kernel@vger.kernel.org, jason@lakedaemon.net, chenhc@lemote.com, robh+dt@kernel.org, devicetree@vger.kernel.org, linux-mips@vger.kernel.org, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020 23:27:48 +0800, Jiaxun Yang wrote:
> v5:
>   - Add some range checks in dt-schema
> 
> Jiaxun Yang (6):
>   irqchip: Add Loongson HyperTransport Vector support
>   dt-bindings: interrupt-controller: Add Loongson HTVEC
>   irqchip: Add Loongson PCH PIC controller
>   dt-bindings: interrupt-controller: Add Loongson PCH PIC
>   irqchip: Add Loongson PCH MSI controller
>   dt-bindings: interrupt-controller: Add Loongson PCH MSI
> 
> [...]

Applied to irq/irqchip-next, thanks!

[1/6] irqchip: Add Loongson HyperTransport Vector support
      commit: 818e915fbac518e8c78e1877a0048d92d4965e5a
[2/6] dt-bindings: interrupt-controller: Add Loongson HTVEC
      commit: 6c2832c3c6edc38ab58bad29731b4951c0a90cf8
[3/6] irqchip: Add Loongson PCH PIC controller
      commit: ef8c01eb64ca6719da449dab0aa9424e13c58bd0
[4/6] dt-bindings: interrupt-controller: Add Loongson PCH PIC
      commit: b6e4bc125fc517969f97d901b1845ebf47bbea26
[5/6] irqchip: Add Loongson PCH MSI controller
      commit: 632dcc2c75ef6de3272aa4ddd8f19da1f1ace323
[6/6] dt-bindings: interrupt-controller: Add Loongson PCH MSI
      commit: da10a4b626657387845f32d37141fc7d48ebbdb3

I've cherry-picked Rob's Rbs that were posted on the v4 series.

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


