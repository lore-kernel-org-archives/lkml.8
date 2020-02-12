Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40D9C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE982082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581527224;
	bh=Ez7EJchARKYuQb1vm/cb3M4I/6E7nH23RNuR2J5qXSg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=wiqPTM73zabZnOwpt6B3Z0Q+SyZCrdH8J3eOnx1r8Qw/u5kaW25iqWslrYJPNb8kX
	 6/O1Q9TB2T4AC7ACrFJCc41tFbluuZ5O//Fz95pby26m/64dkVFJze/ko+kyN2lFg5
	 9Ow9XNmtcBK4ex72PeM3/D9wV0TFlf4vZn8MPJ6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgBLRHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 12:07:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:56146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgBLRHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:07:03 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 203A720658;
        Wed, 12 Feb 2020 17:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581527223;
        bh=Ez7EJchARKYuQb1vm/cb3M4I/6E7nH23RNuR2J5qXSg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=0fdPiTxFUXYvgLQL8UYo0Yp2lr8ZuJ3K8lvPoPfLS9FMXouTIqx5543yZ6pubMrXE
         fW2Ko2qXz/1/8Fw6eMiajFBeaamzEUJUqZ4XOGp7aZVq/0igAEZdalTn4ogCB4Q/MJ
         mMmY8y6RyhchM9jdAtHDu5p1IMNTOMjmyzDNvoEU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200212101140.23242-1-geert+renesas@glider.be>
References: <20200212101140.23242-1-geert+renesas@glider.be>
Subject: Re: [PATCH] h8300: Replace <linux/clk-provider.h> by <linux/of_clk.h>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     uclinux-h8-devel@lists.sourceforge.jp, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Date:   Wed, 12 Feb 2020 09:07:02 -0800
Message-ID: <158152722240.121156.15400505454189989547@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2020-02-12 02:11:40)
> The H8/300 platform code is not a clock provider, and just needs to call
> of_clk_init().
>=20
> Hence it can include <linux/of_clk.h> instead of <linux/clk-provider.h>.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
