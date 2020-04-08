Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BC9C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 13:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E144206F7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 13:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTBMY2BU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgDHNN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 09:13:57 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34167 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgDHNN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 09:13:57 -0400
Received: by mail-io1-f65.google.com with SMTP id f3so1368ioj.1;
        Wed, 08 Apr 2020 06:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8nD34K5pjnKrhNZ/IDFX0q8TbRjSUPEDKUV8DiV88EM=;
        b=fTBMY2BUApkworc3vB/SEq2Tj2Ebry8B29xg6eiIaBN0kfm7DSk1BzZ4/iP1l9XOHq
         zSc23vODTSVFwtfd9Zw4RB763HLpGeNzPSOwPC8zX2JQl4eUmdnePV+34+Kc0m4PWh+k
         rcDEH1GOvygS8953k9AjW7xx+PpVNwzCBKXDRyomHgsK9peCbjiU0rq1lVE4O5tLw0Za
         KprMRiVP5dREID+UMAvzKVAY0kFzgINYjQhLgoEmCxnlBpN2qY8yQ0HDKmItOOu3YyT7
         vBScu63QYN/qc5wUT30O7j/DXuxdJpTr+RdLZFfMqOcM7MwMP4FdCuJBeJesaFCVkoT1
         itqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8nD34K5pjnKrhNZ/IDFX0q8TbRjSUPEDKUV8DiV88EM=;
        b=kdq7WkQb0OywRIShDLsyJouPXHdm2OBJnjK/tZAZHY5repKglqyi74Lf3HM6E9L/At
         +AqylYSqMhsJ3yYOxgaNCftIivL5ggDrUnOyUJIpm4CJL08Cz02Aj4E7wbZktN80s+Nj
         9WZU+X5svC6UYMql8tiSDCNo46KApw1ruP1l58cgyK0IxGECchzXUZqwk/Px8lChE82U
         OAIihkAyEDrrCFPdOPtAKpNCPIfi3PsrrchA58arEdoyVEfgaekASdzDqySetE7/XsqL
         INYdIyQi9P559wBv6jBHKo64gHcC9uM9DvJ+ZKonlPLPCrJ7Xn85j68UlfyNMAnLyqd5
         rx0g==
X-Gm-Message-State: AGi0PuZOBQ3DTM1hQ7mfV7wzWaF6OuzuCft2+GMNmFjEIHITO2FyC3AV
        PEq+PTUEjLFizbGjfIEYSPVLsSWtAlaYsiygTRI=
X-Google-Smtp-Source: APiQypKe/jG/Ygr7L5LC6TETf4HSCl2G7Zz2PbD1bznu/pDr8JB9qbVFTLFFJ9NDoQA/XxfMFeD356DZa5k9dnCEDpc=
X-Received: by 2002:a02:ccf4:: with SMTP id l20mr1046213jaq.28.1586351636019;
 Wed, 08 Apr 2020 06:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200327204711.10614-1-alcooperx@gmail.com> <20200327204711.10614-2-alcooperx@gmail.com>
 <20200330154006.GA21478@bogus> <7e980e08-bc4c-aad5-fce0-0133e4e479f8@gmail.com>
In-Reply-To: <7e980e08-bc4c-aad5-fce0-0133e4e479f8@gmail.com>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Wed, 8 Apr 2020 09:13:45 -0400
Message-ID: <CAOGqxeWuP5c2VtA5qHertbwzKrBjEA2Bo4ds_H+vqQ=h_zABEg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: Add Broadcom STB USB support
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        DTML <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sending again in plain text.

On Tue, Apr 7, 2020 at 4:28 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 3/30/2020 8:40 AM, Rob Herring wrote:
> > On Fri, 27 Mar 2020 16:47:08 -0400, Al Cooper wrote:
> >> Add DT bindings for Broadcom STB USB EHCI and XHCI drivers.
> >>
> >> NOTE: The OHCI driver is not included because it uses the generic
> >>       platform driver.
> >>
> >> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> >> ---
> >>  .../bindings/usb/brcm,bcm7445-ehci.yaml       | 61 +++++++++++++++++++
> >>  .../devicetree/bindings/usb/usb-xhci.txt      |  1 +
> >>  2 files changed, 62 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
> >>
> >
> > My bot found errors running 'make dt_binding_check' on your patch:
> >
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.example.dt.yaml: ehci@f0b00300: 'interrupt-names' does not match any of the regexes: 'pinctrl-[0-9]+'
>
> This warning does not seem to be legitimate, the 'interrupt-names'
> property is a valid one, where do we update the schema such that it
> knows about it?

It looks like I need to specify it in the specification portion of my
file if I want it in the example, like I did for "clock-names" and
"phy-names".
Since the driver always get the interrupt by index, I'm going to
remove "interrupt-names" from the example.

Al

>
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.example.dt.yaml: ehci@f0b00300: $nodename:0: 'ehci@f0b00300' does not match '^usb(@.*)?'
>
> This one is a legitimate one and should be fixed.
> --
> Florian
>
>
