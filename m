Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378F3C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 00:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07AA2229EF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 00:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592613398;
	bh=jPBgI4QiwDIShR7MqXJxRmkH5IZj3qWkZ/G42r75oxo=;
	h=In-Reply-To:References:Subject:From:To:Date:List-ID:From;
	b=cu1EWo7A7HxvGBQszDtM0xF0kofww3CtJir0pN8L6DsnKMFvMpE0arNisMAeQpWZ4
	 SizDX5DmyBeKK2p6GplBp65SeUd5SuDhcsgI/O7IMcdbv4BqurNLuOKuoAnkb/l6T+
	 RD5hE4RY6wc9/A48LUX/8eh0T0QZapRTpFqmLVzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730978AbgFTAgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 20:36:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730293AbgFTAgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 20:36:36 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2729E225A9;
        Sat, 20 Jun 2020 00:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592613396;
        bh=jPBgI4QiwDIShR7MqXJxRmkH5IZj3qWkZ/G42r75oxo=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=JDi4r0yam0XbhtKGe+ZPfgptLCP76hjezDbcioZDsGYEg9rPfAm7ilNgjmuS8f3kw
         X0yRlwzySg+6dJxhgVDV0PgY/4X+lXLl1dVVMtPEGKklRe9uYVQeIsaMkKQMZYYYRn
         CRETehh4vlG2lRcTRyRKEedgmLuCySB4svSIyP2Q=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1591440907-20021-2-git-send-email-sivaprak@codeaurora.org>
References: <1591440907-20021-1-git-send-email-sivaprak@codeaurora.org> <1591440907-20021-2-git-send-email-sivaprak@codeaurora.org>
Subject: Re: [PATCH V7 1/4] dt-bindings: clock: add ipq6018 a53 pll compatible
From:   Stephen Boyd <sboyd@kernel.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org,
        sivaprak@codeaurora.org
Date:   Fri, 19 Jun 2020 17:36:35 -0700
Message-ID: <159261339539.62212.17722723971033735363@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sivaprakash Murugesan (2020-06-06 03:55:04)
> cpus on ipq6018 are clocked by a53 pll, add device compatible for a53
> pll found on ipq6018 devices.
>=20
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> ---
> [V7]
>  * Addressed minor review comment from Rob
>  .../devicetree/bindings/clock/qcom,a53pll.yaml         | 18 ++++++++++++=
++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml b/D=
ocumentation/devicetree/bindings/clock/qcom,a53pll.yaml
> index 20d2638..3161fab 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
> @@ -15,6 +15,7 @@ description:
> =20
>  properties:
>    compatible:
> +    const: qcom,ipq6018-a53pll
>      const: qcom,msm8916-a53pll
> =20
>    reg:

I'm getting this error when running dt binding check:

ruamel.yaml.constructor.DuplicateKeyError: while constructing a mapping
  in "<unicode string>", line 18, column 5
found duplicate key "const" with value "qcom,msm8916-a53pll" (original valu=
e: "qcom,ipq6018-a53pll")
  in "<unicode string>", line 19, column 5
