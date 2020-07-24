Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E3DC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 546B7206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgGXOyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:54:55 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:53830 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgGXOyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:54:54 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1jyz65-006gqD-1y; Fri, 24 Jul 2020 16:54:53 +0200
Date:   Fri, 24 Jul 2020 16:54:53 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Luka Kovacic <luka.kovacic@sartura.hr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jason@lakedaemon.net, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com,
        Luka Perkov <luka.perkov@sartura.hr>,
        Jakov Petrina <jakov.petrina@sartura.hr>
Subject: Re: [PATCH 2/4] arm: mvebu: dts: Add CRS305-1G-4S board
Message-ID: <20200724145453.GD1594328@lunn.ch>
References: <20200724103840.18994-1-luka.kovacic@sartura.hr>
 <20200724103840.18994-3-luka.kovacic@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724103840.18994-3-luka.kovacic@sartura.hr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 12:38:38PM +0200, Luka Kovacic wrote:
> MikroTik CRS305-1G-4S board has a switch chip with an integrated
> Marvell Prestera 98DX3236 CPU.
> 
> This commit includes two board variants, namely the factory
> default one and a Bit variant. The Bit variant has a
> bigger Macronix flash.
> 
> This device tree includes basic Linux support.
> 
> Signed-off-by: Luka Kovacic <luka.kovacic@sartura.hr>
> Cc: Luka Perkov <luka.perkov@sartura.hr>
> Cc: Jakov Petrina <jakov.petrina@sartura.hr>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
