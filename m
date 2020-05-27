Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641F6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44DB920888
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590543954;
	bh=skOAIEeMhgTujA9wPOiBgduSAdizU8SP6hViN2DQrRQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=yC20Y3pLjGRFZAMmUNQ/mMWVNVLcf81xkhIF/GD/Cl582LXMp6TytCs25vgD00qaU
	 4MchgP10pdDwzEHyoi5EqbSOmkEGsWbyCpgK6yXbYN8FPM0kPQZ2Uqb27DTP3FnRj9
	 cnT1tTg/ppV/r0W4a5hzsRMNR8ZBHLJiIXLy+1xY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgE0Bpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 21:45:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgE0Bpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 21:45:53 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9DD9207CB;
        Wed, 27 May 2020 01:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590543952;
        bh=skOAIEeMhgTujA9wPOiBgduSAdizU8SP6hViN2DQrRQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=m1UHcX10J4hDkADzaerFDSfUmqzo4V2ra928S1MlVKmf2RFyIbStAEVifXu+WYtZA
         MGS+Pag/PWppgtZ0l0onCy7U/4CIXIfeHxCr4Q5Mg+IaZ5q+zYLqLp0xowY4VYcGhw
         RUxWq4aZVlYBR6bN1AblLGyQLwgjhSvTqu4lUHyg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200403083040.37748-1-yuehaibing@huawei.com>
References: <20200403083040.37748-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] clk: zynqmp: Make zynqmp_clk_get_max_divisor static
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
To:     m.tretter@pengutronix.de, michal.simek@xilinx.com,
        mturquette@baylibre.com, rajan.vaja@xilinx.com,
        tejas.patel@xilinx.com, yuehaibing@huawei.com
Date:   Tue, 26 May 2020 18:45:52 -0700
Message-ID: <159054395204.88029.15482859565178482479@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting YueHaibing (2020-04-03 01:30:40)
> Fix sparse warning:
>=20
> drivers/clk/zynqmp/divider.c:259:5: warning:
>  symbol 'zynqmp_clk_get_max_divisor' was not declared. Should it be stati=
c?
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Applied to clk-next
