Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B575C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6846620792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595543641;
	bh=/8xkQxLnfQT4NZiwsR/r0CU07hbWyRk/kiSCZjqn8cI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=BC/diWLXecKpiEPmGR97wBsMVqDnkK17sdJAafjlA60QIAwgEoMXNN0TxurQkak+k
	 Gwjpw30eRXlZa/ncorIPxnwd9YSN1uaq5GGT9EN/W+jN+GbKJwHX4g3uS+VoYRxnaA
	 0KsEI8TqTuhmPbUBJL1jiTgzgw6kf9L8dh7NwcTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgGWWeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 18:34:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbgGWWd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 18:33:59 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7334F20737;
        Thu, 23 Jul 2020 22:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595543639;
        bh=/8xkQxLnfQT4NZiwsR/r0CU07hbWyRk/kiSCZjqn8cI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=L9wGmtWQ0YWrv5tnTwdehfSlzchpe9N/AeAiNDHBUCaGChQ3e7XEAfW5h8F7JaYNo
         OFRVwLzmKtxdnsDTjgXG8R8CpPc4GHQnXTe+w9Lw10sb8gqXZx+EQ+OH6D02FoZvPF
         HpFl1dttkaVNTVsNKE2z1X3YIinv5/iasqgY6P7o=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200723074112.3159-2-luca@lucaceresoli.net>
References: <20200723074112.3159-1-luca@lucaceresoli.net> <20200723074112.3159-2-luca@lucaceresoli.net>
Subject: Re: [PATCH v4 1/3] dt-bindings: clk: versaclock5: fix 'idt' prefix typos
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Adam Ford <aford173@gmail.com>, Rob Herring <robh@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>, linux-clk@vger.kernel.org
Date:   Thu, 23 Jul 2020 15:33:58 -0700
Message-ID: <159554363886.3847286.9460505411529663516@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Luca Ceresoli (2020-07-23 00:41:10)
> 'idt' is misspelled 'itd' in a few places, fix it.
>=20
> Fixes: 34662f6e3084 ("dt: Add additional option bindings for IDT VersaClo=
ck")
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> Reviewed-by: Rob Herring <robh@kernel.org>
>=20
> ---

Applied to clk-next
