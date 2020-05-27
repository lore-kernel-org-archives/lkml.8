Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0049C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEC042078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590561650;
	bh=EZwP7lM7uW8E9faXfL+mfjk8mEB24LowJAd2r0TjsKw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=T5s+zkzxwhkF5/HBaCEvypqqTcXGrFDy/l4Jycq4+m84/2q1DoMmE84JAqhwcxvef
	 E74VMZjbG1xQiyhHGiCZ1lslFS7+uNF32GK8W6XTu44JERofD6UNQm97MnsU5GOpOd
	 Vh2D7LoEamu5azJBFoa7xi6X+e3Xp0jvU0gR7/Ew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgE0Gku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:40:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbgE0Gkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:40:49 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45BA320776;
        Wed, 27 May 2020 06:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590561649;
        bh=EZwP7lM7uW8E9faXfL+mfjk8mEB24LowJAd2r0TjsKw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=MH1cB4g5OtKBSVv3WSdi9m2jR9lhT/vmwZCONqPoMT3+Ce88BKvyOL+HVXmagezpm
         wulNTl8dERmfVgt2aShrusAVGKgfQJY5UV0BqzBeQ8QA6VaRpmL71LNJBqFY98GSwj
         4GQjpl2oUbMsjotc+GP51phe9+IIAHeGg6kdgfQc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200526224116.63549-1-colin.king@canonical.com>
References: <20200526224116.63549-1-colin.king@canonical.com>
Subject: Re: [PATCH] clk: versatile: remove redundant assignment to pointer clk
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Colin King <colin.king@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Date:   Tue, 26 May 2020 23:40:48 -0700
Message-ID: <159056164860.88029.7554351167857846969@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Colin King (2020-05-26 15:41:16)
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The pointer clk is being initialized with a value that is never read
> and is being updated with a new value later on. The initialization
> is redundant and can be removed.
>=20
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Applied to clk-next
