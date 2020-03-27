Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C48CC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 14:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FBD62074F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 14:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585320904;
	bh=NLcg8KW/dZw7wy0b01U+CcbR/Kn5ISoIiCtxhv/EldU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=M/I6gnMhq/2F7jiLMArrnidzpU2XRXnlYF9L2b0k388+vr4BWKaAcvhGWHAT6Jtbt
	 AcMAjONbM/lI4QS2amzYg8qUDwQpYlJXIXoygIVPa0ii4+5mVDR1A1iAW/NfjAXUuP
	 DMw+Aryip6QWPyx4L+rXdpdolkn8MfSdcl3P1ERs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgC0OzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 10:55:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgC0OzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 10:55:02 -0400
Received: from coco.lan (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 342442073B;
        Fri, 27 Mar 2020 14:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585320902;
        bh=NLcg8KW/dZw7wy0b01U+CcbR/Kn5ISoIiCtxhv/EldU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lj+ypSdD3GgA7cTWkjGw6AEbmyo0TBSyGhajV9dIULl5V9teVxwnjAmjzq0QD5wyJ
         BOBtagFDlNDVunjYnRRgq0tXkMaUncYAH4kmdu9qLvmu5DZD82jkf1Aj6eiKVkoSM2
         P4dczkaw3svEpC60eOqFY4A5RZavGk1tWvTjYCRU=
Date:   Fri, 27 Mar 2020 15:54:56 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Marcel Holtmann <marcel@holtmann.org>,
        Simon Horman <simon.horman@netronome.com>,
        Harish Bandi <c-hbandi@codeaurora.org>,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] docs: dt: fix a broken reference for a file converted
 to json
Message-ID: <20200327155456.6d582bde@coco.lan>
In-Reply-To: <CAL_JsqLZQN253PDi-HXtP3s5CCg0OzaUK99onC9UjQWeVw3KYw@mail.gmail.com>
References: <33fa622c263ad40a129dc2b8dd0111b40016bc17.1585316085.git.mchehab+huawei@kernel.org>
        <CAL_JsqLZQN253PDi-HXtP3s5CCg0OzaUK99onC9UjQWeVw3KYw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 27 Mar 2020 08:26:58 -0600
Rob Herring <robh+dt@kernel.org> escreveu:

> On Fri, Mar 27, 2020 at 7:34 AM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > Changeset 32ced09d7903 ("dt-bindings: serial: Convert slave-device bindings to json-schema")
> > moved a binding to json and updated the links. Yet, one link
> > was forgotten.  
> 
> It was not. There's a merge conflict, so I dropped it until after rc1.

Ah, ok.

Thanks!
Mauro

> >
> > Update this one too.
> >
> > Fixes: 32ced09d7903 ("dt-bindings: serial: Convert slave-device bindings to json-schema")
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> > index beca6466d59a..d2202791c1d4 100644
> > --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> > +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> > @@ -29,7 +29,7 @@ Required properties for compatible string qcom,wcn399x-bt:
> >
> >  Optional properties for compatible string qcom,wcn399x-bt:
> >
> > - - max-speed: see Documentation/devicetree/bindings/serial/slave-device.txt
> > + - max-speed: see Documentation/devicetree/bindings/serial/serial.yaml
> >   - firmware-name: specify the name of nvm firmware to load
> >   - clocks: clock provided to the controller
> >
> > --
> > 2.25.1
> >  



Thanks,
Mauro
