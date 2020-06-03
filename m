Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4BFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 16:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA0E920738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 16:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="z09PZN4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgFCQT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 12:19:59 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:35174 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgFCQT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 12:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Ap0HrE1yyAHm1/rpPi75EQ4+ZazeVU8zI4zzPaFZsTY=; b=z09PZN4GoJwNNubifeP1bOW3zw
        GWst+QSWTOzlPMCUnvI72TiABITKfR6LzS2kTE7xHd4gOE3vy21QS3VuYJ4bEYwgSuYt6BZkE3uHz
        XX206M9IJnD2CPGImAOzZCkqE+719sjnPNHNXjPw5xLi5REKliykc2aq+wwTDSVwvg7E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jgW6b-0044LQ-FY; Wed, 03 Jun 2020 18:19:05 +0200
Date:   Wed, 3 Jun 2020 18:19:05 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 2/6] net: phy: fixed_phy: Remove unused seqcount
Message-ID: <20200603161905.GE869823@lunn.ch>
References: <20200603144949.1122421-1-a.darwish@linutronix.de>
 <20200603144949.1122421-3-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603144949.1122421-3-a.darwish@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 04:49:45PM +0200, Ahmed S. Darwish wrote:
> Commit bf7afb29d545 ("phy: improve safety of fixed-phy MII register
> reading") protected the fixed PHY status with a sequence counter.
> 
> Two years later, commit d2b977939b18 ("net: phy: fixed-phy: remove
> fixed_phy_update_state()") removed the sequence counter's write side
> critical section -- neutralizing its read side retry loop.
> 
> Remove the unused seqcount.
> 
> Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
