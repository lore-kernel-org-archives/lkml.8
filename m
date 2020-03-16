Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3CFC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00703206B1
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="z7ChbV5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbgCPIiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 04:38:14 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:37834 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730016AbgCPIiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 04:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=k/vVSi3mYwF3AAtmeH2/WIkOImNO/t9AnTjIZUcijF4=; b=z7ChbV5lrfp/2p0zLSdtkc6Ol9
        Q2lV7Q8lkm6qOYM/TgZ7rbuAxYqAPx4je3UreOEfBgRP4mCzsM7ue0maUdCdoHoZnwhP4Jwq8QOSZ
        wKgm5mFH0ME4sX5dNsrYAbvKZwYW2YsQimsAkrWml4Jjsmdm1iVYh4y5fEi9All7Ulk8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jDlG4-0005ni-8K; Mon, 16 Mar 2020 09:38:00 +0100
Date:   Mon, 16 Mar 2020 09:38:00 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "josua@solid-run.com" <josua@solid-run.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] net: mvmdio: avoid error message for optional IRQ
Message-ID: <20200316083800.GB8524@lunn.ch>
References: <20200311200546.9936-1-chris.packham@alliedtelesis.co.nz>
 <63905ad2134b4d19cb274c9e082a9326a07991ac.camel@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63905ad2134b4d19cb274c9e082a9326a07991ac.camel@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Actually on closer inspection I think this is wrong.
> platform_get_irq_optional() will return -ENXIO if the irq is not
> specified.

The _optional is then pointless. And different to all the other
_optional functions which don't return an error if the property is not
defined.

Are you really sure about this? I don't have the time right now to
check.

	Andrew
