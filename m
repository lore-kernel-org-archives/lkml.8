Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0720AC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 22:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA43C20718
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 22:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579817272;
	bh=QlwrFB/8SQuEz72x5eJ/IwwmULMw3LNCA6dsBx7N75U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qx8BhMym08XPLlGpj+5YvJ4N3v0m4Ef5CWMHMS95rTkfqzp8hhsxaE8v+xXY6St0M
	 vbdYbzhkXRpocjAf2luvQ9N2OLWs8OQuVq4edGh3A4IKfgwvhQahcorxef7jJlG7C2
	 qKXG0Qrxh+efY+scqMt0Alu85Fiwwc3W6R2CWrdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgAWWHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 17:07:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:52962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgAWWHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 17:07:52 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 792EB21734;
        Thu, 23 Jan 2020 22:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579817270;
        bh=QlwrFB/8SQuEz72x5eJ/IwwmULMw3LNCA6dsBx7N75U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JLUm1d1nZ3Ot8n7cZT2wO+oEqAb8ecDHj+2YmMHmDw461svQo2lhvJ8Uie/M/2Ehu
         +Y3C5f3ghUA5lmBaBkWnqUrJX1zjMmBmygXBa4uk6NeZgnanX2J0A4u+9eLTLJ1dbJ
         XVTjHfUYxMyDGpA8yfTM9lNlWLjr1lGuHwZxSzd4=
Received: by mail-qt1-f182.google.com with SMTP id e12so22326qto.2;
        Thu, 23 Jan 2020 14:07:50 -0800 (PST)
X-Gm-Message-State: APjAAAXC71H3286DlFJoP8L+yz9WmJl21/aiFDKE47olirPLj933HVxe
        v+nS8TU9T9ukTSDxyGqDklCi0rwaJeJ4EXib9Q==
X-Google-Smtp-Source: APXvYqxzfWxfFKwXzKXbl8qhH8ZiP9eveL4Sd9dFSyn/yz3xnENA89DFYjvHnIiSUkXEweXnfPoeCbjrCT3FHrpjlZI=
X-Received: by 2002:ac8:59:: with SMTP id i25mr419976qtg.110.1579817269622;
 Thu, 23 Jan 2020 14:07:49 -0800 (PST)
MIME-Version: 1.0
References: <20191227053215.423811-1-bjorn.andersson@linaro.org>
 <20191227053215.423811-2-bjorn.andersson@linaro.org> <20200104213804.GA30385@bogus>
 <20200104221752.GW549437@yoga>
In-Reply-To: <20200104221752.GW549437@yoga>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 23 Jan 2020 16:07:38 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJEq-eX-LoRiHHot8De4RbRS4-Np+hisTk4TWpehqsRwg@mail.gmail.com>
Message-ID: <CAL_JsqJEq-eX-LoRiHHot8De4RbRS4-Np+hisTk4TWpehqsRwg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] dt-bindings: remoteproc: Add Qualcomm PIL info binding
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 4, 2020 at 3:17 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Sat 04 Jan 13:38 PST 2020, Rob Herring wrote:
>
> > On Thu, Dec 26, 2019 at 09:32:08PM -0800, Bjorn Andersson wrote:
> > > Add a devicetree binding for the Qualcomm periperal image loader
> > > relocation info region found in the IMEM.
> > >
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > ---
> > >
> > > Changes since v1:
> > > - New patch
> > >
> > >  .../bindings/remoteproc/qcom,pil-info.yaml    | 35 +++++++++++++++++++
> > >  1 file changed, 35 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml
> > > new file mode 100644
> > > index 000000000000..715945c683ed
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml
> > > @@ -0,0 +1,35 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: "http://devicetree.org/schemas/remoteproc/qcom,pil-info.yaml#"
> > > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > > +
> > > +title: Qualcomm peripheral image loader relocation info binding
> > > +
> > > +description:
> > > +  This document defines the binding for describing the Qualcomm peripheral
> > > +  image loader relocation memory region, in IMEM, which is used for post mortem
> > > +  debugging of remoteprocs.
> > > +
> > > +maintainers:
> > > +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: qcom,pil-reloc-info
> > > +
> > > +  offset:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: Offset in the register map for the memory region
> >
> > Why not use 'reg' instead?
> >
>
> Because we have one prior example of subdevice of "imem", which is
> compatible "syscon-reboot-mode" and that binding uses "offset".

Not that I'm proposing this, but nothing should prevent both from coexisting.

Rob
