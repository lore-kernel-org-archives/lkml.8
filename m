Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D68C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73DF620A8B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586421129;
	bh=HHg0BqEx2wX4+fY3s+CC32jN5T6NYFSdDY3cPqUsvzM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=ht2Cb2F7rDB9VPbtbiZAFBkV+yU61rJu0N1AGm+ydjvZoXgqWum6NycZwDZQWBJvI
	 loTZNQ3yvh9ou3+RPmHlLYo5e9OKaRVAp/3d7SNdZLQO0LhN3e06pCCwyaHhLuuKTk
	 IwOuteqd71RKLxeRh3nKMnrsrGMBUkDGV1YUnRv4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgDIIcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 04:32:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgDIIcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 04:32:07 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6BE120784;
        Thu,  9 Apr 2020 08:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586421128;
        bh=HHg0BqEx2wX4+fY3s+CC32jN5T6NYFSdDY3cPqUsvzM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=iyZWNiM2+06Wrw83+BipkEQbvQmZUxRzpeELkS1Sd4fm+uqGxE2UOtinJ7dEH7lZx
         zZo4v1dctQs+Xhggv3a7OWPLwq+HQmoVFJt81XJN1Qfs2caGTnW6m3LiHiwK4hU8P7
         bzMBRZrh2Itd7VHUSb1ja1OheDJvNLYtAzdgEmoE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200406193050.GA53133@roeck-us.net>
References: <20200309194254.29009-1-lkundrak@v3.sk> <20200309194254.29009-5-lkundrak@v3.sk> <20200406193050.GA53133@roeck-us.net>
Subject: Re: [PATCH v2 04/17] clk: mmp2: Add support for PLL clock sources
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
To:     Guenter Roeck <linux@roeck-us.net>, Lubomir Rintel <lkundrak@v3.sk>
Date:   Thu, 09 Apr 2020 01:32:04 -0700
Message-ID: <158642112482.126188.12721741681509681049@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Guenter Roeck (2020-04-06 12:30:50)
> On Mon, Mar 09, 2020 at 08:42:41PM +0100, Lubomir Rintel wrote:
> > The clk-of-mmp2 driver pretends that the clock outputs from the PLLs are
> > constant, but in fact they are configurable.
> >=20
> > Add logic for obtaining the actual clock rates on MMP2 as well as MMP3.
> > There is no documentation for either SoC, but the "systemsetting" drive=
rs
> > from Marvell GPL code dump provide some clue as far as MPMU registers on
> > MMP2 [1] and MMP3 [2] go.
> >=20
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/lkundrak/linux-mmp3=
-dell-ariel.git/tree/drivers/char/mmp2_systemsetting.c
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/lkundrak/linux-mmp3=
-dell-ariel.git/tree/drivers/char/mmp3_systemsetting.c
> >=20
> > A separate commit will adjust the clk-of-mmp2 driver.
> >=20
> > Tested on a MMP3-based Dell Wyse 3020 as well as MMP2-based OLPC
> > XO-1.75 laptop.
> >=20
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>=20
> This patch results in:
>=20
> arm-linux-gnueabi-ld: drivers/clk/mmp/clk.o: in function `mmp_register_pl=
l_clks':
> drivers/clk/mmp/clk.c:192: undefined reference to `mmp_clk_register_pll'
>=20
> when building arm:pxa910_defconfig.
>=20

Thanks. I see that Arnd has sent a fix for this.

https://lore.kernel.org/r/20200408160518.2798571-1-arnd@arndb.de
