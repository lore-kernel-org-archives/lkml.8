Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5896EC2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB67212CC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="l+VQkb6b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731279AbgCaQjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:39:46 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42387 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731254AbgCaQjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:39:45 -0400
Received: by mail-ot1-f67.google.com with SMTP id z5so22441410oth.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 09:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ov6AG3nE3+MtOCiHDlj60sdbUhq5hEaFe9zVBx+P27w=;
        b=l+VQkb6bwKJOThmnyCC10CwEOtsZOP24hLYtTswccJePRSil3fW6xjYocjY0fJk+X4
         JkD/9byEVa1zeQnAL/sAb5fQTlQkcNf1lZBgVVSG+g2vah16TUT0jTubRean+hWjbPO6
         AA2OTsI3+PvkPu8mutfpmH9E5wz94DuX+/q8H97WrRMjpGACpvEfC2WiKUfAdTw/CP0u
         9F3Z4KkFo5fkNfRvSVT8dq7bgH1lxXPYsvwehvnLx/3F7oSwxAReWrvoOVQIcak01bEW
         hewmwMYcekmYnYoR+/iMSkVDfVoksK+NTbCNugA/yh8VS8+gDCV4Ms1tiwdIQWOpCoyZ
         2O7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ov6AG3nE3+MtOCiHDlj60sdbUhq5hEaFe9zVBx+P27w=;
        b=sMQrrfykG/QCKxDl+Csl9sboUmKfGEv1sPekZGjg3+Oht9d0KOFAeG/ElsF5YkrEAj
         k10+yxrwmW5WR3k7nxhgDkSU5O5Afr57tFDOkJQauPn4EidrFex8rKZNpFSWKicsbRkg
         Tv67H02wq87Dx6Bhgeh1P/N3E4Ur7YGRV5v980HNbx7Am/zPS+20B5QMOuT0SNQO2RM8
         0sG8qol2AtadbRRznpKVjl5lCHH1Ol62hHH69m5ZqzYY2oqK1VzY2xvsxsxvQUddXg3r
         AhyJUQCuEHXmnNE+Nfwj7mmytKSDIqJN2txHnn45ktdjdyg+Sh7mks6m+H7lmclEnpxm
         5Lbg==
X-Gm-Message-State: ANhLgQ15QrastDozpZFPgl6YIC9AO5ILLO2JqhW/d6QIwi5p0fNnTUqu
        hdUV66VhIIW2AENAXAMMraS+OW3qKwEKV4o0o4r7nA==
X-Google-Smtp-Source: ADFU+vscDcSfsWlh1Nmpu15Lpf59l4utYcpIPnNeUyJPDiys2SdwfpqoLIizgcnX4KY1Lx+tscetaPUvaZiLHnnXYa0=
X-Received: by 2002:a9d:4506:: with SMTP id w6mr2571484ote.94.1585672784543;
 Tue, 31 Mar 2020 09:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200330164328.2944505-1-robert.marko@sartura.hr>
 <20200330164328.2944505-2-robert.marko@sartura.hr> <20200331163103.GA27585@bogus>
In-Reply-To: <20200331163103.GA27585@bogus>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Tue, 31 Mar 2020 18:39:33 +0200
Message-ID: <CA+HBbNEnH+0g0GK+xMGF48vJbLH3Ud2VY6yDOAxdgbRra3Y25A@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] dt-bindings: phy-qcom-ipq4019-usb: add binding document
To:     Rob Herring <robh@kernel.org>
Cc:     agross@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        kishon@ti.com, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        John Crispin <john@phrozen.org>,
        Luka Perkov <luka.perkov@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 6:31 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, 30 Mar 2020 18:43:29 +0200, Robert Marko wrote:
> > This patch adds the binding documentation for the HS/SS USB PHY found
> > inside Qualcom Dakota SoCs.
> >
> > Signed-off-by: John Crispin <john@phrozen.org>
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > Cc: Luka Perkov <luka.perkov@sartura.hr>
> > ---
> > Changes from v4 to v5:
> > * Replace tabs with whitespaces
> > * Add maintainer property
> >
> >  .../bindings/phy/qcom-usb-ipq4019-phy.yaml    | 48 +++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> Error: Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.example.dts:21.25-26 syntax error
> FATAL ERROR: Unable to parse input tree
> scripts/Makefile.lib:311: recipe for target 'Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.example.dt.yaml' failed
> make[1]: *** [Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.example.dt.yaml] Error 1
> make[1]: *** Waiting for unfinished jobs....
> Makefile:1262: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2
>
> See https://patchwork.ozlabs.org/patch/1264091
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
>
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
>
> Please check and re-submit.
Hi Rob,
I tested locally before submitting and it will pass.
It appears that the bot will fail in your tree as a patch to add DT
nodes is part of the series and not yet upstream.

Best regards
Robert
