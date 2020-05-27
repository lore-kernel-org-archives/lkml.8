Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64624C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 377FF20704
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590548765;
	bh=YbNeRVytyv7hmFv8eyt94pX7Zws5RRSp3CNsb4NKfkA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=F10QgbfePVJd44ZuqeOEpJS9P4rKhQ+NFR0VfbWNclgmI8no5nvn7mqpGcbbyN0u/
	 iHlX9J5Yd5fbs7OZJ3sPwr3MDArAvswQa/XtKG7UqOAqnMqj+EGE7yE3gCODOknu2e
	 ZMGixuLDAGxJN74H2umfBCwB7e3JhjjWFcdXihHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387464AbgE0DGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 23:06:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387403AbgE0DGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 23:06:02 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 287BB20704;
        Wed, 27 May 2020 03:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590548762;
        bh=YbNeRVytyv7hmFv8eyt94pX7Zws5RRSp3CNsb4NKfkA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Sn8YK+jBzUIMzXKJn7/wsSWSbhTvI7W6bjafgp6ioe35NvIChSrIgZFz/7Mq1s9wn
         C1ha2ECoBHOGMKxBCeXLzDBKUD0zDLNbnu4XPZPLniFsjExGOhLmyiFPG1KYI8YkoF
         8PuahXByZxzff9tpl2lZmKamrHmQSaBZtTi7QlZ0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <159054862230.88029.9004999082945050815@swboyd.mtv.corp.google.com>
References: <20200501223232.275800-1-konradybcio@gmail.com> <20200501223232.275800-5-konradybcio@gmail.com> <20200512224522.GA13463@bogus> <159054862230.88029.9004999082945050815@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH 4/4] dt-bindings: soc: qcom: Document MSM8936 SMD RPM compatible
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Andy Gross <agross@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
To:     Konrad Dybcio <konradybcio@gmail.com>,
        Rob Herring <robh@kernel.org>
Date:   Tue, 26 May 2020 20:06:01 -0700
Message-ID: <159054876138.88029.1324636788135726522@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-05-26 20:03:42)
> Quoting Rob Herring (2020-05-12 15:45:22)
> > On Sat,  2 May 2020 00:32:32 +0200, Konrad Dybcio wrote:
> > > From: Vincent Knecht <vincent.knecht@mailoo.org>
> > >=20
> > > Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> > > ---
> > >  Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt | 1 +
> > >  1 file changed, 1 insertion(+)
> > >=20
> >=20
> > Acked-by: Rob Herring <robh@kernel.org>
>=20
> I picked these ones up actually, not the other ones, but my MUA totally
> failed to open anything because the patches weren't sent To: anyone. O
> well!

Oh and now I've dropped them because:

drivers/clk/qcom/clk-smd-rpm.c:478:4: error: =E2=80=98RPM_SMD_SYSMMNOC_A_CL=
K=E2=80=99 undeclared here (not in a function); did you mean =E2=80=98RPM_S=
MD_SNOC_A_CLK=E2=80=99?
  478 |   [RPM_SMD_SYSMMNOC_A_CLK]  =3D &msm8936_sysmmnoc_a_clk,
      |    ^~~~~~~~~~~~~~~~~~~~~~
      |    RPM_SMD_SNOC_A_CLK

So please fix that and resend with proper To.
