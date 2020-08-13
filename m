Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6AAC433E8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 09:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 828EA2080C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 09:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597309257;
	bh=qFqm7RI57Z11EUPH/Kh3a95i9oP3+JD5lchmy0LAfjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cJAbLGO7KiVIsCNv619JvBy168S6SDs8ad1koSbtCNUCruebwO3D/qfZESywqO+C0
	 501LeFOUN7Qi7sdEjcwPsZbHpKWteKwpt5c9A5Uq8vZpIdgCZVegE181wtpEfsqZd5
	 whuT+BWfqzHRWuOJyc1WhcslXjRHWZuUoCp/Z7oM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgHMJA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 05:00:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbgHMJAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 05:00:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C849D2074D;
        Thu, 13 Aug 2020 09:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597309255;
        bh=qFqm7RI57Z11EUPH/Kh3a95i9oP3+JD5lchmy0LAfjo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H8E6H9FpSb1gF9RmPNc7lAGjFiWOLNCCspFJB0pm/jza6QbJLCTsduRDe08S0Bi9E
         DeSfDAPYdkgxVUK88dNUQBpE0HoYn6PoPtIuIIQGJ5CxPTFVZ8bDi8XWA5M3vJPEU+
         RQ79nyqJA5+aAzrJ61DSuAIU3bAl8+zA9BxvvGA4=
Date:   Thu, 13 Aug 2020 11:01:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Gutson <daniel@eclypsium.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        Richard Hughes <hughsient@gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: intel-spi: Do not try to make the SPI
 flash chip writable
Message-ID: <20200813090105.GC3452881@kroah.com>
References: <20200804135817.5495-1-daniel.gutson@eclypsium.com>
 <CAK8P3a0_fJ0BfD5Qvxdo0s7CbjPWaGA8QTgYhbXR=omafOHH4Q@mail.gmail.com>
 <CAFmMkTHEm8k+5GZkVJbDZMEhMwpsqVKRb-hGskSpBstdLRuFyA@mail.gmail.com>
 <CAK8P3a27bTYyn3N+tX=i_6f4KrQkOmkUA1zUQfvCW7qw6smSkQ@mail.gmail.com>
 <CAFmMkTF9eVm0tpOKEy2rzdX=Scr3RwqHDFy_i24R3F5ok-4=eA@mail.gmail.com>
 <CAK8P3a3mf8_Y4DWe3WuBO-Xo0N4Jj=-rrtFzD6w0TriGZPu1_g@mail.gmail.com>
 <CAFmMkTFzmC=aY0gR6urLu-8Oq8aeHBUWi-TodG8XhXKCcC057A@mail.gmail.com>
 <CAFmMkTE+2Qxo43bZkwCszEYbXFV22YdpLJD40gB6LgvnPbvdSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFmMkTE+2Qxo43bZkwCszEYbXFV22YdpLJD40gB6LgvnPbvdSA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 12:41:35PM -0300, Daniel Gutson wrote:
> ping

What does that mean here?

