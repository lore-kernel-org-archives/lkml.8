Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302BFC761A1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 00:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E08206E2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 00:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582159081;
	bh=wVkJ6ZeLNIZiy6+11L33texKMe0DidKfbB80UOC5yMU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rcwsFGBPJbEO6JS26UUi4/fO/8Uiybyxr119KcsL+LBUm3rfL1yE6xWWVdiyO8LQ1
	 aHfgzlKQT5cG1PnKwKgFS84JyBXDnudUihQh0bKBGOXDlYxZ6TajYqXd3HUN8P3zsm
	 c/jGuTBUE2kMgov7jN2Rx7TCf35YdFai+wHOC6eQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbgBTAh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 19:37:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:33250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbgBTAh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 19:37:59 -0500
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D964524671;
        Thu, 20 Feb 2020 00:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582159079;
        bh=wVkJ6ZeLNIZiy6+11L33texKMe0DidKfbB80UOC5yMU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JvX8juVh7tpKnAmn/OnSmnaV1SywCv8p99C7KMYuMuHchY1f3H9mbVcavJ5WDnIDx
         fd+LRfCcjhWysTgGbamLuebqnSq3BvPmfgPMFn0qDXokqCkHRWDJPwS+cfv2x5o2Ex
         chnRTRGQGmTzPo9HAVCm/o/09yN/GqdL8fcXlZ7E=
Received: by mail-qk1-f175.google.com with SMTP id h4so2046277qkm.0;
        Wed, 19 Feb 2020 16:37:58 -0800 (PST)
X-Gm-Message-State: APjAAAVwevOxJXxYdKlGiQcANqwW9Eso1hf9U65pd9oxC9lyTPb6MN4D
        ff9gnYdbpZHoJA5aUSGaObbhzwRMq8JzhFHDvQ==
X-Google-Smtp-Source: APXvYqxK/YCRP+U9ZJ5s6W0p8TrvM7fN8CRsbqJZJ6kYIYqE9CGU40AmveoZ5T5GaZM7MUrQWu/w4Dbohg3zeMtMQ3A=
X-Received: by 2002:ae9:f205:: with SMTP id m5mr26414050qkg.152.1582159078007;
 Wed, 19 Feb 2020 16:37:58 -0800 (PST)
MIME-Version: 1.0
References: <1582097265-20170-1-git-send-email-peng.fan@nxp.com>
 <1582097265-20170-2-git-send-email-peng.fan@nxp.com> <20200219140921.GA7031@bogus>
 <AM0PR04MB44814713955807D7BB3E2CD088100@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB44814713955807D7BB3E2CD088100@AM0PR04MB4481.eurprd04.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 19 Feb 2020 18:37:46 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJWzax7eAc=qzWiSWtNtDuSyZ9OsnZ_rZNBSUgOQ7+fiQ@mail.gmail.com>
Message-ID: <CAL_JsqJWzax7eAc=qzWiSWtNtDuSyZ9OsnZ_rZNBSUgOQ7+fiQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] dt-bindings: remoteproc: Convert imx-rproc to json-schema
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "ohad@wizery.com" <ohad@wizery.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 8:34 AM Peng Fan <peng.fan@nxp.com> wrote:
>
> Hi Rob,
>
> > Subject: Re: [PATCH 1/9] dt-bindings: remoteproc: Convert imx-rproc to
> > json-schema
> >
> > On Wed, 19 Feb 2020 15:27:37 +0800, peng.fan@nxp.com wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Convert the i.MX remoteproc binding to DT schema format using
> > > json-schema
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  .../devicetree/bindings/remoteproc/imx-rproc.txt   | 33 ------------
> > >  .../devicetree/bindings/remoteproc/imx-rproc.yaml  | 61
> > > ++++++++++++++++++++++
> > >  2 files changed, 61 insertions(+), 33 deletions(-)  delete mode
> > > 100644 Documentation/devicetree/bindings/remoteproc/imx-rproc.txt
> > >  create mode 100644
> > > Documentation/devicetree/bindings/remoteproc/imx-rproc.yaml
> > >
> >
> > My bot found errors running 'make dt_binding_check' on your patch:
>
> My command:
> make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/remoteproc/imx-rproc.yaml
>
> and output:
>
>   CHKDT   Documentation/devicetree/bindings/remoteproc/imx-rproc.yaml
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.yaml
>   DTC     Documentation/devicetree/bindings/remoteproc/imx-rproc.example.dt.yaml
>   CHECK   Documentation/devicetree/bindings/remoteproc/imx-rproc.example.dt.yaml

Make sure dtschema is up to date though I'm not sure this could have
ever passed. 'items' value is clearly wrong.

Rob
