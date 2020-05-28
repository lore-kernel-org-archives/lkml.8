Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCF2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE268208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590627698;
	bh=/cfme9qFtEfSiPTmZ3d4UlDj8Liid7lrNnPgryXW+cw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=qggqe3tLdZ8Qos5DTqFQnNTeGXuaA5nKgy7dnUAuaUa23II6FjQeGvIvvFwgFRBrs
	 ICjSTwYupCNjnjPuKNNOhogHgZ1ixxUrEBeiR+FutYKQdEliV/LpvBNVafnVUASL9Q
	 QRtXBh7YmlkwwzTNeeP41JKaXrEXW/p16x7IX0bM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgE1BBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 21:01:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbgE1BBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 21:01:34 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6961920888;
        Thu, 28 May 2020 01:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590627694;
        bh=/cfme9qFtEfSiPTmZ3d4UlDj8Liid7lrNnPgryXW+cw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=aZYltYdohI82m0SvYjSAQurwTlCYIEbdyJqgyAl6vATOo9SWKfUIVZ6yMxkZrEHs0
         EX+7faGDdWkH8X5pOOmH6aLDaDpg8OwdEOlI4GHQM9K0xmFA9Pe09/CeGdNOrshiEM
         iA6cMYvrB997kRcOH8nsQiskoqtNCElr8GvicO4s=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200519224151.2074597-11-lkundrak@v3.sk>
References: <20200519224151.2074597-1-lkundrak@v3.sk> <20200519224151.2074597-11-lkundrak@v3.sk>
Subject: Re: [PATCH v3 10/13] dt-bindings: marvell,mmp2: Add ids for the power domains
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Date:   Wed, 27 May 2020 18:01:33 -0700
Message-ID: <159062769380.69627.618330738209211571@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2020-05-19 15:41:48)
> On MMP2 the audio and GPU blocks are on separate power islands. On MMP3
> the camera block's power is also controlled separately.
>=20
> Add the numbers that we could use to refer to the power domains for
> respective power islands from the device tree.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Rob Herring <robh@kernel.org>
>=20
> ---

Applied to clk-next
