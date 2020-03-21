Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F0DC4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 00:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1366A20777
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 00:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584749338;
	bh=BwR1A0LR4kSGnvfTTmFx0nWVw51KQHZYZJj7qIvL188=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=xdAlfMmLriaKDxVw8eVHQHAWTyZJd7W8gMs3Yq03r/iKZxDeP1i8736azqrCP2lSq
	 umh/161VTLLVk/K4V0FOZtttIfj0kiyLICUEkNaZvFmYukrT74CEIKZgiEbUI8G//t
	 ldKJZtBwSLKCMEJBBpWlhYsjybLOAfkNcibMwN6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbgCUAI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 20:08:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgCUAI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 20:08:56 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 843B72076E;
        Sat, 21 Mar 2020 00:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584749335;
        bh=BwR1A0LR4kSGnvfTTmFx0nWVw51KQHZYZJj7qIvL188=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=lHMA/IdtyWk6BevCXweklo6NBit2XzYMm6/rufxTgug66xoBm+c5MVhb89OOcdrtW
         U5FReYFgVaP00VPGp6yGqM3xqzszCBLILZUkWNPBKUIKTeGdTl84xqw/Bnk/1Xmhm4
         +dUtw81U4aelKaM1NaiqKEVv6ePknOBegQNDN5jA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200213161952.37460-1-paul@crapouillou.net>
References: <20200213161952.37460-1-paul@crapouillou.net>
Subject: Re: [PATCH v2 1/2] clk: ingenic/jz4770: Exit with error if CGU init failed
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     od@zcrc.me, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Stephen Boyd <sboyd@codeaurora.org>
Date:   Fri, 20 Mar 2020 17:08:54 -0700
Message-ID: <158474933477.125146.7017462796685890112@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2020-02-13 08:19:51)
> Exit jz4770_cgu_init() if the 'cgu' pointer we get is NULL, since the
> pointer is passed as argument to functions later on.
>=20
> Fixes: 7a01c19007ad ("clk: Add Ingenic jz4770 CGU driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---

Applied to clk-next
