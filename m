Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2F9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEFC02063A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594132286;
	bh=u9cHwcNir4o7CZoNQdiplIx+fI5Q1NadDlETdmWe2oc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mew+rD/82A1rudqhxlq5/SHZEdt2CXrjYnIkjmvTg6NEAr9NaDUNV/gl3CTcTg9k4
	 WQ0aqZXPf7O0dXvrvozEfEBTQXlZmTBmtavkRWFR8QlUKNzg9fhjfnInafuQwELgQp
	 lcevymvvmFdxal10PpSQAh6LNG8K7kOyCIpEtY2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgGGObZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:31:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:60970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727895AbgGGObZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:31:25 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBBF22063A;
        Tue,  7 Jul 2020 14:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594132284;
        bh=u9cHwcNir4o7CZoNQdiplIx+fI5Q1NadDlETdmWe2oc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lsF4Y6TI4se0MULQuP2J7GCVnVkZH1HtvKHRAViGf7AzJiw+Z7pLIT0vKpzmqS2u2
         u49kEzWJOv9ebnbufCdyxWLBZVbDNSZLpNhQuVqmTnVv1hkGl0T+Wh/YcKmbonOIiS
         pdBnkAjOP/MiWgYxipjjYW4FXbuzs5EyhC/TLFOI=
Received: by mail-oi1-f170.google.com with SMTP id t198so22472079oie.7;
        Tue, 07 Jul 2020 07:31:24 -0700 (PDT)
X-Gm-Message-State: AOAM530fygOCNDFuGCiuE1o3lmvdZyp8+hCkV10NpKYERi6OhtqY1q3l
        YxGxJOXZeMo9RPKKY4Q05rBcHCBOJVP3G/nJ2A==
X-Google-Smtp-Source: ABdhPJxZpu3muVU1JSTu4HLqkdyNBb1nY6MBHbFPTUmS3FU1uehTPnYLfxZ3J02PgSTI2PbjH/Sgsk/bfoi+WKTi2sE=
X-Received: by 2002:aca:30d2:: with SMTP id w201mr3517914oiw.147.1594132284171;
 Tue, 07 Jul 2020 07:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
 <1593701576-28580-2-git-send-email-amittomer25@gmail.com> <20200702210014.GA1685248@bogus>
 <CABHD4K8=8+fFu=ZjQHEgR44x+QsvLZ+LW7w=XKH7O4oXu+QY4A@mail.gmail.com> <CABHD4K-_jmC512_ckmw66FppJHitkU8j-M9TQ316+M9zou3Fmg@mail.gmail.com>
In-Reply-To: <CABHD4K-_jmC512_ckmw66FppJHitkU8j-M9TQ316+M9zou3Fmg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 7 Jul 2020 08:31:12 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKrdP_XzG_iSgJmdp=tj7mdhTZZFNaRuUwe=YgmELeAGg@mail.gmail.com>
Message-ID: <CAL_JsqKrdP_XzG_iSgJmdp=tj7mdhTZZFNaRuUwe=YgmELeAGg@mail.gmail.com>
Subject: Re: [PATCH v5 01/10] dt-bindings: dmaengine: convert Actions Semi Owl
 SoCs bindings to yaml
To:     Amit Tomer <amittomer25@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Andre Przywara <andre.przywara@arm.com>,
        cristian.ciocaltea@gmail.com, Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-actions@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 3, 2020 at 1:55 AM Amit Tomer <amittomer25@gmail.com> wrote:
>
> On Fri, Jul 3, 2020 at 12:48 PM Amit Tomer <amittomer25@gmail.com> wrote:
> >
> > Hi Rob,
> >
> >
> > > If you already ran 'make dt_binding_check' and didn't see the above
> > > error(s), then make sure dt-schema is up to date:
> > >
> > > pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
> > >
> > > Please check and re-submit.
> >
> > I wasn't able to reproduce it, even after updating the dt-schema.
> > Kindly have a look at logs:
> >
> > https://pastebin.ubuntu.com/p/xTBNNyBdFv/
>
> Looks like, dtschema even after upgrade pointing to older commit "6a941d46b9f5".
> Wondering why it has not been pointing to latest commit "6a941d46b9f5"
>
> After upgrading the pip version for python3, and upgrading the dt-schema again
> https://pastebin.ubuntu.com/p/Rd9knQgvKH/
>
> Issue is still reproduced.

If dtschema is changed, you need a clean tree as make doesn't track
that changing. Specifically, processed-schema-examples.yaml needs to
be removed.

Rob
