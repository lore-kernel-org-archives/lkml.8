Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FD7C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72225206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eF4UZfPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbgELJ7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 05:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725889AbgELJ7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 05:59:04 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05C3C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 02:59:03 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 8so7321920lfp.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 02:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WXd5QHwJ1tPi5716Xcmxn3FGS3giieue5uSgZlXtiWg=;
        b=eF4UZfPdwxY2kcJ3SbBcXESksctSLMe0oyp3Dqb6rpox9rfOdE5TWSXlhLeZ7WVuJu
         K9EZyurUt4GoHXQGQJ/s/OIEAI31LdtzoB4OLI3c504mIW9b3C07x0rNyN/WpEEkui5z
         VayR7QZBrGhhSxZ7mnv/UaXebyvcd/obTk6ROY/uR8l1vWjvlXye4pt4sY7vBX1vTxHl
         lQlCW8H2SUcm6avA6W8stsSGIosReXoSyNmTLwiN8IH+JEk8cfxsp0MNEE4UFeELbKri
         KVXEW3tiDJ6y1cjGXzsEfdg4CZr29OfRHfERGPeFut8XyeYZP8PWMVEK0wlzjsF6ZOtf
         WWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WXd5QHwJ1tPi5716Xcmxn3FGS3giieue5uSgZlXtiWg=;
        b=Iew6Ntlgg/yXalZHZ5mBMEXRBmSq9d5aZ6je5+gKL5icobjUaURHAnpiou63L5gysO
         t+/NA1YXNeSU+I/spmsY1MkdFCa81zTUJT4y16i/9opRuGVzSFdmWv8sqPAe3N2TiLwD
         ofvOnO0J5jVKq4I2PR7BDu9qy4uWHtQ3NA3cCy8r5wIvGsQk8hrQOuQKqfE4wCG/g53D
         A8ix06KdaYAf1aO2sxRBwSsSeKiGzO6dwgAbcMzmChNSGOi0W62XSOjLrU/S5DaavacZ
         8ihPCGRI1lmqJd708Vm2nHOP6WQcXx2gSDBxF7OGW+6k/lvcKTAo3Fvvv/Bq3nlG7Y1A
         wKtg==
X-Gm-Message-State: AOAM530O+msp03pXlHzcOfLYgoYq12rY+a75I0AoSFKpDZkbER95nncQ
        /AGM8IC+htOf0WMiLszD2cbDAp0ki9uvzxXW+pVg6A==
X-Google-Smtp-Source: ABdhPJyBq7To18Sh0+GIDcFRF81NKkhoFYKeSr+78ZnK/tfcB+M6Xqf+HgiWU5Chhbq4xITdhpfrF18M/MgtiTWvtZ0=
X-Received: by 2002:ac2:555b:: with SMTP id l27mr14203108lfk.170.1589277541973;
 Tue, 12 May 2020 02:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200508134527.26555-1-etienne.carriere@linaro.org> <CAL_JsqJVaWDYZWwRwotSQyaL5bOugM3judxipS9oKveV3FdK8w@mail.gmail.com>
In-Reply-To: <CAL_JsqJVaWDYZWwRwotSQyaL5bOugM3judxipS9oKveV3FdK8w@mail.gmail.com>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Tue, 12 May 2020 11:58:50 +0200
Message-ID: <CAN5uoS8GzbFyQq=kjZuxNwBDJ8cn9q-sq8C=VLN5UWWD0HXWaA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: nvmem: stm32: new property for data access
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Etienne Carriere <etienne.carriere@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,


On Tue, 12 May 2020 at 03:51, Rob Herring <robh+dt@kernel.org> wrote:
>
> On Fri, May 8, 2020 at 8:47 AM Etienne Carriere
> <etienne.carriere@linaro.org> wrote:
> >
> > From: Etienne Carriere <etienne.carriere@st.com>
> >
> > Introduce boolean property st,non-secure-otp for OTP data located
> > in a factory programmed area that only secure firmware can access
> > by default and that shall be reachable from the non-secure world.
> >
> > Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
> > ---
> >  .../bindings/nvmem/st,stm32-romem.yaml          | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
> > index d84deb4774a4..c11c99f085d7 100644
> > --- a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
> > +++ b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
> > @@ -24,6 +24,18 @@ properties:
> >        - st,stm32f4-otp
> >        - st,stm32mp15-bsec
> >
> > +patternProperties:
> > +  "^.*@[0-9a-f]+$":
> > +    type: object
> > +
> > +    properties:
> > +      st,non-secure-otp:
> > +        description: |
> > +          This property explicits a factory programmed area that both secure
> > +          and non-secure worlds can access. It is needed when, by default, the
> > +          related area can only be reached by the secure world.
> > +        type: boolean
> > +
> >  required:
> >    - "#address-cells"
> >    - "#size-cells"
> > @@ -41,6 +53,11 @@ examples:
> >        calib@22c {
> >          reg = <0x22c 0x2>;
> >        };
> > +
> > +      mac_addr@e4 {
> > +        reg = <0xe4 0x8>;
> > +        st,non-secure-otp;
>
> This fails validation. You need to drop 'additionalProperties' in nvmem.yaml.

My apologies. I guess I did not test `dt_binding_check` on this change.
I'll send a v2.

Regards,
Etienne

>
> Rob
