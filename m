Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95256C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DF1620720
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592878049;
	bh=GbdniXafrEcdmTW4VyCq93Ez9AnCcjcIK81Hhg5Zeto=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=W5rPRy++GiPYOeFAlM8phXOHlRWgAc55jaynYZNuwRmG9w1KpOGkemSQGA1LZCDaW
	 Cj5LXEOITXwC9l5BsBNqjvTjQnxtukiFHpR/8SvQK4DKhgENxmmU/aln2q6FnLfZxm
	 20u8nXb0Sb9LQ4YJcKkwb2RMSHFtL2wN2Q4OB9Yw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbgFWCH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:07:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731319AbgFWCHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:07:25 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23F0420768;
        Tue, 23 Jun 2020 02:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592878045;
        bh=GbdniXafrEcdmTW4VyCq93Ez9AnCcjcIK81Hhg5Zeto=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=D7QR/ZXs/aoR3OtfdEuazL7m4FmnbErGBM6PgBHwGKdicrJmVD0dVccwXY0lWMO/7
         LGNqXQJi1me6DIoi/Wa+p9YOZYgtsU+6ekvP1zKNhsUOO5pAvu2QVvpv7Pwg9vtOkV
         y1rLIecf4ZCXuAvNywlR8+0nLisOcs9n5GHkNuDk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200603154329.31579-3-aford173@gmail.com>
References: <20200603154329.31579-1-aford173@gmail.com> <20200603154329.31579-3-aford173@gmail.com>
Subject: Re: [PATCH V3 3/3] clk: vc5: Enable addition output configurations of the Versaclock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Adam Ford <aford173@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Adam Ford <aford173@gmail.com>, linux-clk@vger.kernel.org
Date:   Mon, 22 Jun 2020 19:07:24 -0700
Message-ID: <159287804429.62212.3235888147816108649@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Adam Ford (2020-06-03 08:43:29)
> The existing driver is expecting the Versaclock to be pre-programmed,
> and only sets the output frequency.  Unfortunately, not all devices
> are pre-programmed, and the Versaclock chip has more options beyond
> just the frequency.
>=20
> This patch enables the following additional features:
>=20
>    - Programmable voltage: 1.8V, 2.5V, or 3.3V\u200b
>    - Slew Percentage of normal: 85%, 90%, or 100%
>    - Output Type: LVPECL, CMOS, HCSL, or LVDS
>=20
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---

Applied to clk-next
