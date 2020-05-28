Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A17BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21D022074B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590707008;
	bh=AwQh/Z5dE3PvNZvMfXgCYlntTVYdDkWce9DobLD86rE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=xXWKYNqIBfxHU4XU7aAzM0yv/ZaVgbNAnfeuTi5PPT3zRWbOiSDwoXvSTMuAqvI+x
	 nC9JxGzMLstwgkFqtmAoPrF+c4pGuwWQGdIkmiccZlgY13xI6F1HPxms2jSGbfh25E
	 HaBaq1GI4JzHgMaxfo/LTlodIiduCgUeQprFthfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437452AbgE1XD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 19:03:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437385AbgE1XDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 19:03:15 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3206B207F9;
        Thu, 28 May 2020 23:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590706995;
        bh=AwQh/Z5dE3PvNZvMfXgCYlntTVYdDkWce9DobLD86rE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=KC0TwjgabgvXc4Y7ZE4f+fdTNNSpjXdSnNiU52VALuT/cB4nDEVYdbAS3g6Ae9iQ1
         FxeIIzDgFsXqBc48e63Rm+XAGmMqhLIHl0F/7oRd2SJ6sfE8RqClhmsB+px2OMajbl
         wpqzhX6rLTgYGH2lSMPz6Bkz5qeynkjSjUDx5nLM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1j8shbkhsq.fsf@starbuckisacylon.baylibre.com>
References: <20200519170440.294601-1-jbrunet@baylibre.com> <CAFBinCBXTwKz81bQK3U1bv7vGiryhShijqh2hqaypPvLopvwNA@mail.gmail.com> <1j8shbkhsq.fsf@starbuckisacylon.baylibre.com>
Subject: Re: [PATCH] clk: add api to get clk consummer from clk_hw
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 28 May 2020 16:03:14 -0700
Message-ID: <159070699457.69627.14852370592791335742@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2020-05-28 11:58:45)
>=20
> On Wed 27 May 2020 at 22:07, Martin Blumenstingl <martin.blumenstingl@goo=
glemail.com> wrote:
>=20
> > Hi Jerome,
> >
> > On Tue, May 19, 2020 at 7:09 PM Jerome Brunet <jbrunet@baylibre.com> wr=
ote:
> > [...]
> >> + * Calls to this function must be balanced with calls clk_put()
> >> + */
> >> +struct clk *clk_hw_get_clk(struct clk_hw *hw)
> > I haven't looked at it myself yet, but would it be hard to have a
> > devm_ variant of this function as well?
>=20
> Seems easy enough.
> Stephen is this OK with you ?
>=20
> I'm just wondering if this devm_ function should use the device pointer
> embedded in the clk_hw structure or have it as an argument ?
>=20
> The 1st option seems simpler but I'm not sure it is correct.
>=20
> Thoughts ?
>=20

devm API sounds OK to me. For now we can use the one embedded in the
clk_hw structure and if we have to we can replace it with the one that
the caller passes in. Hopefully we never need to do that because then it
means we have drivers passing around clk_hw pointers instead of having
the caller use proper clk_get() style APIs.
