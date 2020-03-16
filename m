Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1682C2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A21A20674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584374472;
	bh=t/pIjGhuzitxvI1FhrtAZ+stJjkjYp4RVBftOt6/LV8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=RdSNYp2NSwL9+tjZfvu9/SBZkDwLpi5ZnvbxSr0NPKh2uWYUKq9NywQDXNIj/m+9f
	 FKa8l1Z0uOjuiYYb6XzAZtuHMM5t9RFYG5g4iWVcqCyTcmvJ6lzozbVPqERhkYWUGz
	 i0qTHLaVfcY8hEd3cqgmSDOR+WaYjQAqzN/3nZTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbgCPQBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 12:01:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731636AbgCPQBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 12:01:11 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15D1220674;
        Mon, 16 Mar 2020 16:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584374471;
        bh=t/pIjGhuzitxvI1FhrtAZ+stJjkjYp4RVBftOt6/LV8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=oQbD2GjYvIqgdhQLpPxyOdcl/TRovbeSgny2LQrp4QCe7fC2wkSmbT+EdoUDZgCas
         7iOAh8HPInfx+DepvLlUWAYVCjljT4UDjeK+0UstGO1ebjGNNcivJ3ClTJ4+hxeaqE
         fDNer6zYMv4OvvrXr+BC2vWJTWLf0t4TDp9epktw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8a863030-bf95-90c6-9f8b-2a55ad46cb03@kernel.org>
References: <20200228203611.15507-1-dinguyen@kernel.org> <158379285687.149997.12928033376494434912@swboyd.mtv.corp.google.com> <8a863030-bf95-90c6-9f8b-2a55ad46cb03@kernel.org>
Subject: Re: [PATCH] clk: socfpga: stratix10: use new parent data scheme
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Dinh Nguyen <dinguyen@kernel.org>
Date:   Mon, 16 Mar 2020 09:01:10 -0700
Message-ID: <158437447025.164562.7882527369683773048@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dinh Nguyen (2020-03-09 22:55:27)
>=20
>=20
> On 3/9/20 5:27 PM, Stephen Boyd wrote:
> > Quoting Dinh Nguyen (2020-02-28 12:36:11)
> >> +
> >> +static const struct clk_parent_data mpu_free_mux[] =3D {
> >> +       { .name =3D "main_mpu_base_clk", },
> >> +       { .name =3D "peri_mpu_base_clk", },
> >> +       { .name =3D "osc1", },
> >> +       { .name =3D "cb-intosc-hs-div2-clk", },
> >> +       { .name =3D "f2s-free-clk", },
> >> +};
> >=20
> > While this changes everything to use the new way it doesn't actually
> > migrate anything over to using direct pointers or the .fw_name field.
> > What's going on?
> >=20
>=20
> Sorry about that. I am using direct pointers to the new parent data here:
>=20
> in drivers/clk/socfpga/clk-periph-s10.c
>=20
> -       init.parent_names =3D parent_names;
> +       init.parent_names =3D NULL;
> +       init.parent_data =3D clks->parent_data;
>=20
> The driver seems to work fine without having to add .fw_name.
>=20

Yes, .fw_name would only be needed if the parent clks were external to
the clk controller. Furthermore if they are only clk_hw pointers then we
can use .parent_hws instead.
