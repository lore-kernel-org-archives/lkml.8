Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1848C3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B2920730
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgBDL6g convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:58:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:59050 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbgBDL6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 06:58:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BF1DDADFF;
        Tue,  4 Feb 2020 11:58:33 +0000 (UTC)
Date:   Tue, 4 Feb 2020 12:58:33 +0100
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     David Miller <davem@davemloft.net>
Cc:     ralf@linux-mips.org, paulburton@kernel.org,
        linux-mips@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: sgi: ioc3-eth: Remove leftover free_irq()
Message-Id: <20200204125833.f4fd62590d0539cf87527286@suse.de>
In-Reply-To: <20200204.124455.1858606436930758654.davem@davemloft.net>
References: <20200204113628.13654-1-tbogendoerfer@suse.de>
        <20200204.124455.1858606436930758654.davem@davemloft.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Feb 2020 12:44:55 +0100 (CET)
David Miller <davem@davemloft.net> wrote:

> From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> Date: Tue,  4 Feb 2020 12:36:28 +0100
> 
> > Commit 0ce5ebd24d25 ("mfd: ioc3: Add driver for SGI IOC3 chip") moved
> > request_irq() from ioc3_open into probe function, but forgot to remove
> > free_irq() from ioc3_close.
> > 
> > Fixes: 0ce5ebd24d25 ("mfd: ioc3: Add driver for SGI IOC3 chip")
> > Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> 
> ioc3_open() still has the request_irq() in my tree.

then I guess you don't have commit 0ce5ebd24d25 in your tree. My Patch is
against linus/master, where it is already applied. Should I rebase against your
net tree, when the commit shows up ?

Thomas.

-- 
SUSE Software Solutions Germany GmbH
HRB 36809 (AG Nürnberg)
Geschäftsführer: Felix Imendörffer
