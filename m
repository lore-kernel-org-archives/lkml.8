Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B05C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C25B206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581526957;
	bh=epztuBXNxSt78F+TKCt3ZY3CVeU3AJAclTwzzjcScOo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=Z+f9AsuqJd2uhVW/R78OTXV27vVd7U2Ms0so7NAUUbnZ2LAzd1qOEUSTG7/kcdWtS
	 WVhBUxCbQtjnsbrvQvtJofpZ4njkfGqGO1EB4zKswxAQMfLDtHA4vuU9g3rsKt91DJ
	 qPn5KFVpj8fypAQCGxHFmvIdugJ5LMqJhE57YC7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgBLRCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 12:02:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:54506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbgBLRCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:02:36 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D31420658;
        Wed, 12 Feb 2020 17:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581526955;
        bh=epztuBXNxSt78F+TKCt3ZY3CVeU3AJAclTwzzjcScOo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bO4uj04GC2zMlEPlQBJZaEiznnEDVyc6xaYnDmtAT3xtfJNbA5nMEcgKEkp/Q4fJj
         HPbwO4n1X2qBIVXufCpeUKIv5CrSl6w/6fFK0TBc8F5ccjYHRMIfQaBbg7ZcZtx2+N
         n5i7EVWUdyim1FdG7OhlyFMLjveKuvzih0+NOoSA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200212101947.9534-1-geert+renesas@glider.be>
References: <20200212101947.9534-1-geert+renesas@glider.be>
Subject: Re: [PATCH] xtensa: Replace <linux/clk-provider.h> by <linux/of_clk.h>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To:     Chris Zankel <chris@zankel.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Date:   Wed, 12 Feb 2020 09:02:34 -0800
Message-ID: <158152695460.121156.12938099669254492177@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2020-02-12 02:19:47)
> The Xtensa time code is not a clock provider, and just needs to call
> of_clk_init().
>=20
> Hence it can include <linux/of_clk.h> instead of <linux/clk-provider.h>.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
