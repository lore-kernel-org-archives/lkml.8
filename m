Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBD2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D86420737
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgGXO4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:56:46 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:53864 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbgGXO4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:56:45 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1jyz7s-006grk-HZ; Fri, 24 Jul 2020 16:56:44 +0200
Date:   Fri, 24 Jul 2020 16:56:44 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Luka Kovacic <luka.kovacic@sartura.hr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jason@lakedaemon.net, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com,
        Luka Perkov <luka.perkov@sartura.hr>,
        Jakov Petrina <jakov.petrina@sartura.hr>
Subject: Re: [PATCH 4/4] MAINTAINERS: Add an entry for MikroTik CRS3xx
 98DX3236 boards
Message-ID: <20200724145644.GF1594328@lunn.ch>
References: <20200724103840.18994-1-luka.kovacic@sartura.hr>
 <20200724103840.18994-5-luka.kovacic@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724103840.18994-5-luka.kovacic@sartura.hr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 12:38:40PM +0200, Luka Kovacic wrote:
> An entry is added for MikroTik CRS3xx 98DX3236 based switches.
> 
> Signed-off-by: Luka Kovacic <luka.kovacic@sartura.hr>
> Cc: Luka Perkov <luka.perkov@sartura.hr>
> Cc: Jakov Petrina <jakov.petrina@sartura.hr>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
