Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC349C35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A937320732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbgBXLai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 06:30:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49571 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgBXLai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 06:30:38 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6BwY-0000ka-L1; Mon, 24 Feb 2020 12:30:34 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 0E605104083; Mon, 24 Feb 2020 12:30:34 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Marc Zyngier <maz@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Cc:     linux-kernel@vger.kernel.org, wanghaibin.wang@huawei.com
Subject: Re: [PATCH] genirq/irqdomain: Make sure all irq domain flags are distinct
In-Reply-To: <7dec8c6eb07f634a4cccec3be5136e2f@kernel.org>
References: <20200221020725.2038-1-yuzenghui@huawei.com> <7dec8c6eb07f634a4cccec3be5136e2f@kernel.org>
Date:   Mon, 24 Feb 2020 12:30:33 +0100
Message-ID: <87eeuk43za.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Zyngier <maz@kernel.org> writes:
> On 2020-02-21 02:07, Zenghui Yu wrote:
>> Fixes: 6f1a4891a592 ("x86/apic/msi: Plug non-maskable MSI affinity 
>> race")
>
> To be fair, the real source of the bug is this:
>
> 6a6544e520abe ("genirq/irqdomain: Remove auto-recursive hierarchy 
> support")

Yes, but up to the MSI commit it was not a problem :)
