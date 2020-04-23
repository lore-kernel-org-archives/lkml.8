Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313B9C55191
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 19:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A0822076C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 19:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fqm9ZIjY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgDWTj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 15:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbgDWTj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 15:39:27 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F44C09B044
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 12:39:26 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t11so3403671pgg.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 12:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7VPU62AS0hE3DKQRkOunlFCKQKhdwD9eupm/jSgSc0o=;
        b=fqm9ZIjYeSPBDfE/QRu99KVQdVsUeerRL5pAVUVajv+e2SuYpHLE1FyB095+rRNLhg
         /J3qFsRFP7AfK6wYscG9PXM49C3MZEyA5tvD/Zv8lnY8QYwqZoSxa+Y04fsNkGs3+dpZ
         9g6GfHdmQjY9gvJea954/kRhpTEdxkybP1Axg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7VPU62AS0hE3DKQRkOunlFCKQKhdwD9eupm/jSgSc0o=;
        b=Vu2+/3AkmT8DxvBZYzUc2fVreuuaByxEaB3BA1ZR9m8vOZlZ49k7cbdJ2Ymy1F94O3
         bn/VqmEmNH8y9/lsnNhxCUxgp7HXZT11qSk5RhljpIRB8vFoRHj4XPYMwryXz0yFKb9e
         TEvf9hkxMUEh3oviilI3HZAi0oWVJRowwjeddwxeiyxjbh5kpt4oP3PzNbkJAcyyPRrT
         xjzhNaa9nzvc9JA1oiWLHxJPowzUSSgg11GvMN+gi2pf/rT28GBAcdZ2s/MaJhB7vW58
         4Rh3V7D4Ynykxfi4jtEot9Hu7LxZS6SN94WMuOC8mO/oxs2mwj73iMyhbt2spD8M5mle
         k9Jw==
X-Gm-Message-State: AGi0PuZdUbYpdrsRyO4Y8D665jRFJ74NnWHWCI6+RIRrEF/dgjXcFbWd
        sEs0lB5nBkdtYpfktLVAQ+XTDA==
X-Google-Smtp-Source: APiQypJd4T0HLRLEhYMctigRHwArQ5Lyj7Ah48K5q+Fq0x5nv4fDYp6iTUKOzhPoARFHEfZwN9MqWQ==
X-Received: by 2002:a62:8202:: with SMTP id w2mr5342725pfd.117.1587670766035;
        Thu, 23 Apr 2020 12:39:26 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id l185sm3281987pfl.104.2020.04.23.12.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 12:39:24 -0700 (PDT)
Date:   Thu, 23 Apr 2020 12:39:23 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     "Sandeep Maheswaram (Temp)" <sanm@codeaurora.org>
Cc:     Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: usb: qcom,dwc3: Convert USB DWC3
 bindings
Message-ID: <20200423193923.GK199755@google.com>
References: <1585206368-685-1-git-send-email-sanm@codeaurora.org>
 <1585206368-685-2-git-send-email-sanm@codeaurora.org>
 <20200404171700.GA10096@bogus>
 <5e2eb0a4-ed70-4212-fc70-6ee850507a7e@codeaurora.org>
 <5793ea62-7a73-789e-33d6-6b2fb37b376c@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5793ea62-7a73-789e-33d6-6b2fb37b376c@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 02:23:29PM +0530, Sandeep Maheswaram (Temp) wrote:
> Hi Rob,
> 
> Any suggestions to solve this error in assigned-clock-rates

> On 4/6/2020 10:09 PM, Sandeep Maheswaram (Temp) wrote:
> > Hi Rob,
> > 
> > On 4/4/2020 10:47 PM, Rob Herring wrote:
> > > On Thu, Mar 26, 2020 at 12:36:07PM +0530, Sandeep Maheswaram wrote:
> > > > Convert USB DWC3 bindings to DT schema format using json-schema.
> > > > 
> > > > Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> > > > ---
> > > >   .../devicetree/bindings/usb/qcom,dwc3.txt          | 104
> > > > --------------
> > > >   .../devicetree/bindings/usb/qcom,dwc3.yaml         | 158
> > > > +++++++++++++++++++++
> > > >   2 files changed, 158 insertions(+), 104 deletions(-)
> > > >   delete mode 100644
> > > > Documentation/devicetree/bindings/usb/qcom,dwc3.txt
> > > >   create mode 100644
> > > > Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> > > 
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> > > > b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> > > > new file mode 100644
> > > > index 0000000..0f69475
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml

...

> > > > +    items:
> > > > +      - description: Must be 19.2MHz (19200000).
> > > Sounds like a constraint:
> > > 
> > > - const: 19200000
> > > 
> > > > +      - description: Must be >= 60 MHz in HS mode, >= 125 MHz
> > > > in SS mode.
> > > - minimum: 60000000
> > >    maximum: ?
> > 
> > Tried  as below but facing errors
> > 
> > assigned-clock-rates:
> >     items:
> >       - const: 19200000
> >       - minimum: 60000000
> >         maximum: 150000000
> > 
> > Errors
> > 
> > linux-next/Documentation/devicetree/bindings/usb/qcom,dwc3.example.dt.yaml:
> > usb@a6f8800: assigned-clock-rates: Additional items are not allowed
> > ([150000000] was unexpected)
> > linux-next/Documentation/devicetree/bindings/usb/qcom,dwc3.example.dt.yaml:
> > usb@a6f8800: assigned-clock-rates:0: [19200000] is too short
> > linux-next/Documentation/devicetree/bindings/usb/qcom,dwc3.example.dt.yaml:
> > usb@a6f8800: assigned-clock-rates: [[19200000], [150000000]] is too long

judging from the error messages my uneducated guess is that the above rules for
assigned-clock-rates expect a single tuple of two elements, not two tuples with
a single element, i.e.

assigned-clock-rates = <19200000, 150000000>;

  instead of

assigned-clock-rates = <19200000>, <150000000>;

I experimented a bit but couldn't find the magic incantation to appease the
schema deities.

Rob, could you please help to distentangle this?

Thanks

Matthias
