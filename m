Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D852C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73C212063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="LPesvD1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgF2Sos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:44:48 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:13134 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729232AbgF2Soo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:44:44 -0400
IronPort-SDR: 1FbhWjwLcEdn1Q0su9oP38NdY2BKY6oXeFifTV9dO+033aukPIh430pBrmZ1g0n3zOXxH9lRL1
 7tf8AxYnlIkNxvdhh0LbyXMkotSJTW8gUyW3NZsJ0wOlfc0d9Naew0Jg9b03KycF9Ex7VzXslI
 4VaHJGdgzY+qPGevaqx8fU3JG896QEFyxxnKKDtT6rJ2Sud/pb3e+8Ja+GDSK+c39aPDUwiuBR
 mK4m0EjeNNa+jzwZF5DDAztyxBAlCTv9SootrYyj8pd0RL4xVtto9Rr9WCmF7u5eEXl5OU6LRG
 Wlk=
X-IronPort-AV: E=Sophos;i="5.75,294,1589234400"; 
   d="scan'208";a="12880961"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 29 Jun 2020 15:22:03 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 29 Jun 2020 15:22:03 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 29 Jun 2020 15:22:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1593436923; x=1624972923;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d765UglviXAqW+GAijNHXP9xNKKGdAwIhk+fTvwY8VY=;
  b=LPesvD1rXXYhkRpxl1FfikAZIZD/im6ie8wuU/x98l56AY+NiRGXLDhL
   a9dLbgeIweQlEIZfGaGtaXY2LmOn6EGIE2EHvYxDC/UrWTWpkmkbQkNjs
   MxSrafFu4JnXnF9BI5WYt8KXgErmM7Teyj+b/kncNubiJZgXrqlGNjL/5
   J7ScWseQmjRtHCtTtVT55ZPAYmUib2dJfoUeSgEFnDc3071pK78GHkQGW
   jlBHlEFex9vaWIaj8Rw2TyC3Xf4+Lcs0P3JMMLGac8h0H2Htj+k0HlIEh
   UVRl6hex7UG0qRY5DltPSiRRnGFvCCA9Pibg9qdpdsBH1LJGqw8kycPi3
   A==;
IronPort-SDR: e+L1oTFDLOrjFOUDjEXWydcdezL20EffWxOmHbukB/o/vXOiCuLRGv7XJ+HsiX4z+tLAaf163B
 CtfaaEHOxpUCdWGOb7oZU2r2oEv7hh9bwOvHBE+i0KynHNXnNpLQpYiF0p8oslv8qv8GnoARSe
 OpC+3mLqTwFr41W0W2JFQ5LJlzNaF4JwE1gJMsoY4Z3Us09XtGKRf+fdsKWGTY5+1d7lHxQWEC
 a2Qpd8AaZqIpCd9tfPMS/i488P/znhWF+nnRpWKGpZLKI88JanWcXQvS3WllWlLjjDvIdBA+eF
 QkE=
X-IronPort-AV: E=Sophos;i="5.75,294,1589234400"; 
   d="scan'208";a="12880960"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 29 Jun 2020 15:22:03 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 5DB1F280065;
        Mon, 29 Jun 2020 15:22:03 +0200 (CEST)
Message-ID: <570474bcc4055527d85ca8cf84b653f56bef3e23.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: [PATCH] mtd: spi-nor: micron-st: enable 4-byte
 opcodes for n25q512a
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Tudor.Ambarus@microchip.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        michael.krummsdorf@tq-group.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Date:   Mon, 29 Jun 2020 15:22:01 +0200
In-Reply-To: <e94d42be-5e40-e2bb-4683-cc7af59e801a@microchip.com>
References: <20200610091616.29555-1-matthias.schiffer@ew.tq-group.com>
         <e94d42be-5e40-e2bb-4683-cc7af59e801a@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-06-29 at 13:02 +0000, Tudor.Ambarus@microchip.com wrote:
> Hi, Matthias,
> 
> On 6/10/20 12:16 PM, Matthias Schiffer wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> > 
> > From: Michael Krummsdorf <michael.krummsdorf@tq-group.com>
> > 
> > Set SPI_NOR_4B_OPCODES, as the flash supports 4-byte opcodes.
> 
> I remember that we stripped SPI_NOR_4B_OPCODES intentionally for the
> n25q
> flashes, check  https://lkml.org/lkml/2019/12/5/50.
> 
> Cheers,
> ta

Ah, thank you for the pointer. Looking at a boot log of a more recent
kernel again, the SPI-NOR flash on our hardware is actually detected as
mt25qu512a and not n25q512a now, so everything should work as expected
without this patch.


