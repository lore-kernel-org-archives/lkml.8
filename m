Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F242C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B362173E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581550354;
	bh=QUur6Tdhxx3i8fGGfMoEGp6FV02eDB8MM+/SlamQqQE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=pEaZ+AK+f+emC0z4gW7JL9UnVQ6ti4EIe2N591/WjfP1BSYQhmvjivTBFwM6ZeWl5
	 TXNILW240z6EBAMBT1uN3G+WDCyLkOfiF3924SKL4VJneZxfkyndxmC7jgYb8l1prE
	 nGF9b4Ms+iUtWiUy9Bb/3odz/PvBg4k0Y8oO0lyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgBLXcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 18:32:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:48496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729356AbgBLXcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:32:32 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A58D20578;
        Wed, 12 Feb 2020 23:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581550352;
        bh=QUur6Tdhxx3i8fGGfMoEGp6FV02eDB8MM+/SlamQqQE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Tnr3CbsNxfO01g8yvQkNowCz3Yt+ePdCaSITNALP2tISz4ya2nBO+KykqwUulUxWf
         u2xYAmVHrqczHOGg9AFBKK4Z78EkyxjftxkRgce/IGaCLj9jc41a8TifW9+T6uTAhm
         e+zYUhaSWde9AxRmj57MONjrXva9O6xZrAZODf3c=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1579261009-4573-5-git-send-email-claudiu.beznea@microchip.com>
References: <1579261009-4573-1-git-send-email-claudiu.beznea@microchip.com> <1579261009-4573-5-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH 4/4] clk: at91: usb: introduce num_parents in driver's structure
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com
Date:   Wed, 12 Feb 2020 15:32:31 -0800
Message-ID: <158155035131.184098.9806897959771690426@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2020-01-17 03:36:49)
> SAM9X60 USB clock may have up to 3 parents. Save the number of parents in
> driver's data structure and validate against it when setting parent.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next
