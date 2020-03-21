Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6006C43332
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 18:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9361C20775
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 18:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584816195;
	bh=TuwfuUTLsIiC41Ku4BtjHbWONlHCrlEleOBEtJOmKuU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=VUEvJybkU2CsC3dH1f8RYjmkBXWUnOgQ3j6Ekeq/M/k/d/4zuvUjbn9XaMtwN4PfC
	 SSSvfek54ox4mt9lmy4IDlQju/h+dZ6L0wemBuIGBqBqh48AUHa6bVm7fltjdgvE0W
	 kGUeQFJCiZ3LyZVZ/4BiyofLc78qJhj0Yjxco1O0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbgCUSnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 14:43:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbgCUSnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 14:43:14 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C31520724;
        Sat, 21 Mar 2020 18:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584816193;
        bh=TuwfuUTLsIiC41Ku4BtjHbWONlHCrlEleOBEtJOmKuU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=DXUcGFj5ncUXdFUsONtObkvRjSvHMeV+B0kN2e9sFsLqlmgf0Qq9UB5fVpjQ40ieE
         A3edJHNJn1KYYmMhlwjIlnsp9dyYxI5ZVk/KjhHevHOBgtQ2VMoTxVtz+YP/PtxvlL
         ID10Q7e/QraS6gnKNB8rRS5J6ugAITv8wjPimPz8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200321051612.GA5063@builder>
References: <20200319053902.3415984-1-bjorn.andersson@linaro.org> <20200319053902.3415984-3-bjorn.andersson@linaro.org> <158474710844.125146.15515925711513283888@swboyd.mtv.corp.google.com> <20200321051612.GA5063@builder>
Subject: Re: [PATCH 2/4] clk: qcom: mmcc-msm8996: Properly describe GPU_GX gdsc
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Sat, 21 Mar 2020 11:43:12 -0700
Message-ID: <158481619279.125146.6917548675896981321@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2020-03-20 22:16:12)
> On Fri 20 Mar 16:31 PDT 2020, Stephen Boyd wrote:
>=20
> > Quoting Bjorn Andersson (2020-03-18 22:39:00)
> > > diff --git a/Documentation/devicetree/bindings/clock/qcom,mmcc.yaml b=
/Documentation/devicetree/bindings/clock/qcom,mmcc.yaml
> > > index 85518494ce43..65d9aa790581 100644
> > > --- a/Documentation/devicetree/bindings/clock/qcom,mmcc.yaml
> > > +++ b/Documentation/devicetree/bindings/clock/qcom,mmcc.yaml
> > > @@ -67,6 +67,10 @@ properties:
> > >      description:
> > >         Protected clock specifier list as per common clock binding
> > > =20
> > > +  vdd_gfx-supply:
> >=20
> > Why not vdd-gfx-supply? What's with the underscore?
> >=20
>=20
> The pad is named "VDD_GFX" in the datasheet and the schematics. I see
> that we've started y/_/-/ in some of the newly added bindings, would you
> prefer I follow this?

If the datasheet has this then I guess it's fine. I'll wait for Rob to
ack.
