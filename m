Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54087C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 19:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FD38206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 19:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588705926;
	bh=kG4CkVHdPSFNSk//wEUiNx4HcAcholUGFbWBHBSfob8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=2GnM08rtm1++t+KheVRwlyPpgLK8/GhxhkK2pLasT3+MuDwPwf7/yUYLzU7H9dRap
	 Z4qdTc6PbFd25K73/HxJ/9VjvQaCOn9DRAOU4GJCn5Eh2KKGqGdkyXnlUi44T9A+CL
	 gBdwkUpv/yEgdUuBiiWUbjMsZjANpB0xeNH5o/CE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgEETMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 15:12:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgEETMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 15:12:05 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98C50206FA;
        Tue,  5 May 2020 19:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588705924;
        bh=kG4CkVHdPSFNSk//wEUiNx4HcAcholUGFbWBHBSfob8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=E1ln3WDAKNT3LLokR08JUlTQaD1WDUuwjQ8rTYld3ToQl6kR+7eB9kMAvIN3iGYeM
         Z+zWhJ63LjZ17BnXSwfd/PPTxzBcSbJkYtPiU4Oe2lQaMAbgm1LMH71J/Vik0WjaMK
         rJmki3mAmrQ/Ugs2SeNx/9FoFZj3UBujT6DJ9rts=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200505140953.409430-1-maz@kernel.org>
References: <20200505140953.409430-1-maz@kernel.org>
Subject: Re: [PATCH] clk: Unlink clock if failed to prepare or enable
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Michael Turquette <mturquette@baylibre.com>
To:     Marc Zyngier <maz@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 05 May 2020 12:12:03 -0700
Message-ID: <158870592381.26370.8784478076215991539@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marc Zyngier (2020-05-05 07:09:53)
> On failing to prepare or enable a clock, remove the core structure
> from the list it has been inserted as it is about to be freed.
>=20
> This otherwise leads to random crashes when subsequent clocks get
> registered, during which parsing of the clock tree becomes adventurous.
>=20
> Observed with QEMU's RPi-3 emulation.
>=20
> Fixes: 12ead77432f2 ("clk: Don't try to enable critical clocks if prepare=
 failed")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> ---

Applied to clk-fixes
