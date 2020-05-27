Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F68C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73470207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590549263;
	bh=Cum1L2le/T0Vli/1oJgj9yXnah5bCcZ7M+9h6Nq8jOs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=idFD3mtqYFSpljh34/EHSJ+3VcB9ynb3vXa7WN8mLbKEngV1pNBvdgWhVil6cBqj1
	 jeWAjIUu7Yq+1cqXK5DB9KD3gFqgLVrtxH182h2pptuPe26Nl72jPC+VWpDO6wnelo
	 kDVOPeKOrny6BZ3q249vSY02AgtaCb2ahOp2oUeg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgE0DOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 23:14:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgE0DOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 23:14:22 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE41B206DF;
        Wed, 27 May 2020 03:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590549262;
        bh=Cum1L2le/T0Vli/1oJgj9yXnah5bCcZ7M+9h6Nq8jOs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=tmMR4ZMNM6AdsZqUpzWNqgP7jAsJM105b6RPT5Ucbk5r8EayAtpwWsRJ7KUW3EbHx
         PAj4GwJZvaCUK2u8dN1QXYydTunOxDRr5VewNvRYmP8EF6YreiXKpfH/JKPZX67WkF
         UQjcS+tK8/HtTG15jb4uJUigFK49piff0js9XtKc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200519030036.1785-1-zhang.lyra@gmail.com>
References: <20200519030036.1785-1-zhang.lyra@gmail.com>
Subject: Re: [PATCH 1/2] clk: sprd: mark the local clock symbols static
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
To:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Tue, 26 May 2020 20:14:21 -0700
Message-ID: <159054926118.88029.4068340884703067794@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chunyan Zhang (2020-05-18 20:00:35)
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>=20
> There's a few pll gate clocks which were not marked with static, and
> those clock are used only in the current file, so add static key word
> for them.
>=20
> Fixes: 0e4b8a2349f3 ("clk: sprd: add clocks support for SC9863A")
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---

Applied to clk-next
