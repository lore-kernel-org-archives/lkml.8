Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D9CC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFA720721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgAJONJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:13:09 -0500
Received: from foss.arm.com ([217.140.110.172]:45160 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbgAJONJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 09:13:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E075B328;
        Fri, 10 Jan 2020 06:13:08 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B292E3F534;
        Fri, 10 Jan 2020 06:13:07 -0800 (PST)
Date:   Fri, 10 Jan 2020 14:13:03 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Robert Hancock <hancock@sedsystems.ca>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/14] net: axienet: Autodetect 64-bit DMA capability
Message-ID: <20200110141303.2e5863ab@donnerap.cambridge.arm.com>
In-Reply-To: <20200110140852.GF19739@lunn.ch>
References: <20200110115415.75683-1-andre.przywara@arm.com>
        <20200110115415.75683-13-andre.przywara@arm.com>
        <20200110140852.GF19739@lunn.ch>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 15:08:52 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

Hi Andrew,

thanks for having a look!

> > To autodetect this configuration, at probe time we write all 1's to such
> > an MSB register, and see if any bits stick.  
> 
> So there is no register you can read containing the IP version?

There is, and I actually read this before doing this check. But the 64-bit DMA capability is optional even in this revision. It depends on what you give it as the address width. If you say 32, the IP config tool disables the 64-bit capability completely, so it stays compatible with older revisions.
Anything beyond 32 will enable the MSB register and will also require you to write to them.

Cheers,
Andre
