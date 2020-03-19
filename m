Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F959C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E6B2071C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584637012;
	bh=qITxEULM5Ncg7snJOgrBb4YMWUJLNiO6B7ZZfpryEbQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=a/lZf0jIWL3agplXdR0FIwrgKZEp8t90ZdK3RIKZw1TzTs/2015SVIByNlX9bfNAd
	 Nhi55KUhSAz4LpE+oLs3+NeKcAyVNrQ7LhGRudqv+mGBuIob88jbdxUXztrbSBBwrt
	 QHOZJIjeh0mwcEB8Z6g6p0yIloouB46hIEI7nTGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgCSQ4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 12:56:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbgCSQ4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 12:56:48 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A22292173E;
        Thu, 19 Mar 2020 16:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584637007;
        bh=qITxEULM5Ncg7snJOgrBb4YMWUJLNiO6B7ZZfpryEbQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UyYhI+DOShWfNvcnPDbFix/e0gh/N8C7iwifqyq1jDDihFHxTuscSm0U4oofGLj5X
         UVPq4WctqBAv/mUis4FoXDdz7yFea4kuyFzcdjkBorvsOtaVzxkuohLqxztP31vqVa
         6X/6hr2UGimZf5kdwnL6xWl+kMH/gNXhMjW7bSiw=
Received: by mail-qk1-f169.google.com with SMTP id j4so3759654qkc.11;
        Thu, 19 Mar 2020 09:56:47 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3OB01vbwXwcIngFf6NE16U9U2HNys37m3IZ47wbxAjSFie3PaA
        0LXTKNYq2cn9Dt5fp/e7N7PhBsO20gV3j92Ulg==
X-Google-Smtp-Source: ADFU+vvx8Mto3b9ke4GB11bW5X8+6B732oYjPwoYLyKyoRcPOIqC6jH4W9EiQR64yH6UJnmnfxtJF04ZJlr3JwvgH1k=
X-Received: by 2002:a37:4a85:: with SMTP id x127mr4018507qka.152.1584637006758;
 Thu, 19 Mar 2020 09:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200317161022.11181-1-dinguyen@kernel.org> <20200317161022.11181-5-dinguyen@kernel.org>
 <20200318224042.GA32101@bogus> <30180323-3c74-d04a-b715-3b1f655d6a81@kernel.org>
In-Reply-To: <30180323-3c74-d04a-b715-3b1f655d6a81@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 19 Mar 2020 10:56:35 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ-c5tvWUMGKu4scy85cGdYHzPxR7NTzEd9V5RQHveW0g@mail.gmail.com>
Message-ID: <CAL_JsqJ-c5tvWUMGKu4scy85cGdYHzPxR7NTzEd9V5RQHveW0g@mail.gmail.com>
Subject: Re: [PATCHv3 4/5] dt-bindings: documentation: add clock bindings
 information for Agilex
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 10:16 AM Dinh Nguyen <dinguyen@kernel.org> wrote:
>
> Hi Rob,
>
> On 3/18/20 5:40 PM, Rob Herring wrote:
> > On Tue, 17 Mar 2020 11:10:21 -0500, Dinh Nguyen wrote:
> >> Document the Agilex clock bindings, and add the clock header file. The
> >> clock header is an enumeration of all the different clocks on the Agilex
> >> platform.
> >>
> >> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> >> ---
> >> v3: address comments from Stephen Boyd
> >>     fix build error(tab removed in line 37)
> >>     renamed to intel,agilex.yaml
> >> v2: convert original document to YAML
> >> ---
> >>  .../bindings/clock/intel,agilex.yaml          | 36 ++++++++++
> >>  include/dt-bindings/clock/agilex-clock.h      | 70 +++++++++++++++++++
> >>  2 files changed, 106 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/clock/intel,agilex.yaml
> >>  create mode 100644 include/dt-bindings/clock/agilex-clock.h
> >>
> >
> > My bot found errors running 'make dt_binding_check' on your patch:
> >
> > Error: Documentation/devicetree/bindings/clock/intel,agilex.example.dts:17.3-4 syntax error
> > FATAL ERROR: Unable to parse input tree
> > scripts/Makefile.lib:311: recipe for target 'Documentation/devicetree/bindings/clock/intel,agilex.example.dt.yaml' failed
> > make[1]: *** [Documentation/devicetree/bindings/clock/intel,agilex.example.dt.yaml] Error 1
> > Makefile:1262: recipe for target 'dt_binding_check' failed
> > make: *** [dt_binding_check] Error 2
> >
> > See https://patchwork.ozlabs.org/patch/1256630
> > Please check and re-submit.
> >
>
> I want to be able check these errors locally before sending the next
> version. But I keep getting various errors when I try to "make
> dt_binding_check":
>
> Traceback (most recent call last):
>   File "/bin/dt-doc-validate", line 15, in <module>
>     import ruamel.yaml
> ImportError: No module named 'ruamel'
> Documentation/devicetree/bindings/Makefile:12: recipe for target
> 'Documentation/devicetree/bindings/arm/l2c2x0.example.dts' failed
>
>
> Do you have a pointer on how to run the dt_binding_check?

Documentation/devicetree/writing-schema.rst

ruamel should get installed automatically when you run pip3. If you
just cloned dt-schema, then you still need to run pip on the project
directory. That's documented in the project readme.

Rob
