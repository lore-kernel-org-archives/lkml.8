Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CFAC0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 16:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DDE2206E7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 16:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZeSdqsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbgCKQql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 12:46:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59979 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730175AbgCKQql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583945199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ADDrO4QRY1lhdD1iQPV3hdTUF0WjB+BNSCx2nCz9XEE=;
        b=FZeSdqsJM3f8wip7JeTiN7q2vrF6w1e62iLEpJqFGH1Bj/GXwVtq7n+zuvJXBk+MQApGHO
        HCQKblTEPOwi9XLoItptg5frKpqXtZ1DNYAMXrY0bMcZ7FlrnudaEfaOw8t0ZnDvTYKbiv
        NhEZPSKaQEjtc5/uieBaPtAKLPO6thQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-ERRbUndcPbCQJOpqCIO01g-1; Wed, 11 Mar 2020 12:46:33 -0400
X-MC-Unique: ERRbUndcPbCQJOpqCIO01g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44D5CA0CDB;
        Wed, 11 Mar 2020 16:46:32 +0000 (UTC)
Received: from ovpn-120-185.rdu2.redhat.com (ovpn-120-185.rdu2.redhat.com [10.10.120.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6024810013A1;
        Wed, 11 Mar 2020 16:46:31 +0000 (UTC)
Message-ID: <2d277b96875e2320a3a7ccd8bfb8881f68e1353c.camel@redhat.com>
Subject: Re: [PATCH] irqchip/gic-v3: Workaround Cavium erratum 38539 when
 reading GICD_TYPER2
From:   Mark Salter <msalter@redhat.com>
To:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Robert Richter <rrichter@marvell.com>
Date:   Wed, 11 Mar 2020 12:46:30 -0400
In-Reply-To: <20200311115649.26060-1-maz@kernel.org>
References: <20200311115649.26060-1-maz@kernel.org>
Organization: Red Hat, Inc
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-11 at 11:56 +0000, Marc Zyngier wrote:
> Despite the architecture spec requiring that reserved registers in the GIC
> distributor memory map are RES0 (and thus are not allowed to generate
> an exception), the Cavium ThunderX (aka TX1) SoC explodes as such:
> 
> [    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
> [    0.000000] GICv3: 128 SPIs implemented
> [    0.000000] GICv3: 0 Extended SPIs implemented
> [    0.000000] Internal error: synchronous external abort: 96000210 [#1] SMP
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.0-rc4-00035-g3cf6a3d5725f #7956
> [    0.000000] Hardware name: cavium,thunder-88xx (DT)
> [    0.000000] pstate: 60000085 (nZCv daIf -PAN -UAO)
> [    0.000000] pc : __raw_readl+0x0/0x8
> [    0.000000] lr : gic_init_bases+0x110/0x560
> [    0.000000] sp : ffff800011243d90
> [    0.000000] x29: ffff800011243d90 x28: 0000000000000000
> [    0.000000] x27: 0000000000000018 x26: 0000000000000002
> [    0.000000] x25: ffff8000116f0000 x24: ffff000fbe6a2c80
> [    0.000000] x23: 0000000000000000 x22: ffff010fdc322b68
> [    0.000000] x21: ffff800010a7a208 x20: 00000000009b0404
> [    0.000000] x19: ffff80001124dad0 x18: 0000000000000010
> [    0.000000] x17: 000000004d8d492b x16: 00000000f67eb9af
> [    0.000000] x15: ffffffffffffffff x14: ffff800011249908
> [    0.000000] x13: ffff800091243ae7 x12: ffff800011243af4
> [    0.000000] x11: ffff80001126e000 x10: ffff800011243a70
> [    0.000000] x9 : 00000000ffffffd0 x8 : ffff80001069c828
> [    0.000000] x7 : 0000000000000059 x6 : ffff8000113fb4d1
> [    0.000000] x5 : 0000000000000001 x4 : 0000000000000000
> [    0.000000] x3 : 0000000000000000 x2 : 0000000000000000
> [    0.000000] x1 : 0000000000000000 x0 : ffff8000116f000c
> [    0.000000] Call trace:
> [    0.000000]  __raw_readl+0x0/0x8
> [    0.000000]  gic_of_init+0x188/0x224
> [    0.000000]  of_irq_init+0x200/0x3cc
> [    0.000000]  irqchip_init+0x1c/0x40
> [    0.000000]  init_IRQ+0x160/0x1d0
> [    0.000000]  start_kernel+0x2ec/0x4b8
> [    0.000000] Code: a8c47bfd d65f03c0 d538d080 d65f03c0 (b9400000)
> 
> when reading the GICv4.1 GICD_TYPER2 register, which is unexpected...
> 
> Work around it by adding a new quirk for the following variants:
> 
>  ThunderX: CN88xx
>  OCTEON TX: CN83xx, CN81xx
>  OCTEON TX2: CN93xx, CN96xx, CN98xx, CNF95xx*
> 
> and use this flag to avoid accessing GICD_TYPER2. Note that all
> reserved registers (including redistributors and ITS) are impacted
> by this erratum, but that only GICD_TYPER2 has to be worked around
> so far.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Robert Richter <rrichter@marvell.com>
> ---
> This is a respin of [1], with the erratum number and affected
> platform list provided by Robert.
> 
> [1] https://lore.kernel.org/lkml/20191027144234.8395-11-maz@kernel.org/

Tested-by: Mark Salter <msalter@redhat.com>


