Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2738C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7652820714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f1Avysqv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgCQOZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:25:19 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:40902 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbgCQOZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=zEH7DLTd+LNHQwQHPQ4STBF90TjqC68onZDanLO/Qq8=; b=f1Avysqvpp0F6HPfEfeRxKif5A
        Zw+jykElYB/kJH7KClWMliT9UAwn/YSbYClWXi7KaMsosv67s9I5tUYs2PPCwAr6sh9Vvd6Gbbuxn
        25TmY4Yyw7fvw6nXaz7yrTOe1cfL69yU/w8QRSpC8pckBibZuGjokT3K+R/UuJHvwSU8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jED9f-0006vD-44; Tue, 17 Mar 2020 15:25:15 +0100
Date:   Tue, 17 Mar 2020 15:25:15 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     davem@davemloft.net, josua@solid-run.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] Revert "net: mvmdio: avoid error message for
 optional IRQ"
Message-ID: <20200317142515.GV24270@lunn.ch>
References: <20200316074907.21879-1-chris.packham@alliedtelesis.co.nz>
 <20200316074907.21879-2-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316074907.21879-2-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 08:49:06PM +1300, Chris Packham wrote:
> This reverts commit e1f550dc44a4d535da4e25ada1b0eaf8f3417929.
> platform_get_irq_optional() will still return -ENXIO when no interrupt
> is provided so the additional error handling caused the driver prone to
> fail when no interrupt was specified. Revert the change so we can apply
> the correct minimal fix.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
