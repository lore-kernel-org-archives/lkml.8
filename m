Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B924EC433EB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 01:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9740F20838
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 01:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595899195;
	bh=idQyZYrj17x1YCQSrUFvka4rxp717SD+lk/boc2tq/0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=0t/tyscLxIBV5bZADb0FYGAYCZ3i/ObQllofUpcQZBodZ7fLy8MfmSnO/oopspkws
	 HPiaOD1yo697XZrPFvTu7aU8mMI336c6u3BSBTAEwTUObNIIphXs+Gfj38z6E0zY2j
	 e0UdjFYM1sRSPSiL6pwqvIei7YFSWzrocMb9h6c4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgG1BTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 21:19:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgG1BTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 21:19:54 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D358C20714;
        Tue, 28 Jul 2020 01:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595899193;
        bh=idQyZYrj17x1YCQSrUFvka4rxp717SD+lk/boc2tq/0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=nX9R2lWy+xbhUKE1BQaUQ608KhDxzYh7rEQeQ6pskyfQ5yhZZScl1UdLwecUq6P5U
         e+oOrUyskTkWBuOCNRse7ERx3NdePLFOuoZtMBTYcmNFJAMYhEJEBwYvEXNrrknqVz
         4aXLISMSkbBwKLDLeSzUHfZByU+h5554045Y4PQo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200725051136.58220-1-zhouyanjie@wanyeetech.com>
References: <20200725051136.58220-1-zhouyanjie@wanyeetech.com>
Subject: Re: [PATCH 0/3] Add RTC related clocks for Ingenic SoCs.
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, paul@crapouillou.net,
        prasannatsmkumar@gmail.com, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
To:     mturquette@baylibre.com, robh+dt@kernel.org,
        =?utf-8?b?5ZGo55Cw5p2w?= (Zhou Yanjie) 
        <zhouyanjie@wanyeetech.com>
Date:   Mon, 27 Jul 2020 18:19:52 -0700
Message-ID: <159589919283.1360974.18345961645229247747@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) (2020-07-24 22:11:33)
> 1.Add RTC related clocks bindings for the JZ4780 SoC,
>   the X1000 SoC, and the X1830 SoC.
> 2.Add "XXXX_CLK_EXCLK_DIV512" and "XXXX_CLK_RTC" for
>   the JZ4780 SoC, the X1000 SoC, and the X1830 SoC.
>=20
> =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) (3):
>   dt-bindings: clock: Add RTC related clocks for Ingenic SoCs.
>   dt-bindings: clock: Add tabs to align code.
>   clk: Ingenic: Add RTC related clocks for Ingenic SoCs.
>=20
>  drivers/clk/ingenic/jz4780-cgu.c       |  12 +++
>  drivers/clk/ingenic/x1000-cgu.c        |  13 +++
>  drivers/clk/ingenic/x1830-cgu.c        |  13 +++
>  include/dt-bindings/clock/jz4780-cgu.h | 144 +++++++++++++++++----------=
------

Thanks. Applied to clk-next.
