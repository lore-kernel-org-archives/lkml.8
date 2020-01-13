Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF6FC33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB5820CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qogD2atn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgAMKtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 05:49:09 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35956 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgAMKtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 05:49:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so8037121wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 02:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dJIJ8TE4q3821mbA7gJOKY19l0UD3HWAsSMco9Ho4C4=;
        b=qogD2atniaYCyI+/ifYIEcWu0V0PymnKN5/DklSu2Q4CvaU6deYGL7xeYrU+1J1fQU
         Rmv2wQhpmhJ+Y0ILck2SjdXhNBseiONexmAAbjKPytHvfsdhT420A3BcAZHBIDnVQLCL
         FMOQpm4+eFMt5GjRyinK4Zd+33Un3U1F7pkaankp0GfRewgn3jSFcm6Fv6CN/eYaft8J
         oBRPRxTWKkOT//lmiXWR7rRIyi8MEEeZ0NyQQfeMAsjRVvOO4jKZmiDlobBWRsFpZNgr
         GDvbnwjdx+np/tTfKXodm7ZhiFBssr+weWL+G4dSA7XVxgkVbK83X1B9lg5a4MGRRezG
         i27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dJIJ8TE4q3821mbA7gJOKY19l0UD3HWAsSMco9Ho4C4=;
        b=G5PbX6Ea/EKpVlZXs9y5rN52nQ0DnhDDjyPNxDWsKwnxMR+NSOqGofGapPSlRR6fTy
         UNpLV8cjxNYNtju/S5wExqz0/pcTohOogvVQlKWXu7f7wXH+aKfH2GZ8Rhx7Sg5+Q7Ut
         HRSYdWjvYFIhz6EQ307n1udGhLxk3vBPIEdl84fL7ndebhbul2bea0paVCV+UtTJLFzm
         IGwIvNOHAEPJcn0HDIUlRcX/8p0hc2S/Ii48xJBB3SdvFgNmep34Bnkv6xWaFVpgeQD4
         7NCP5auWPOMCDlwB4ht8w/JB/qGaK3U1R3vD023Z3w1IGKh9rZ9kWeMOBMG/3+bAPAcK
         xCxA==
X-Gm-Message-State: APjAAAX7X/oXHP3XD8YTltq1HeBEdazZVSGy1dK7fQ+HTt/WjMaRchY1
        ka61GRRd2PznSGFINztjOusjnw==
X-Google-Smtp-Source: APXvYqy01VtgOwE8RelnBXw+DBfdhJ79MbFiqHSSGoaBGghKby8swpt+ETldAaRCE1dZVQMt3+xneQ==
X-Received: by 2002:a5d:488c:: with SMTP id g12mr17615554wrq.67.1578912546094;
        Mon, 13 Jan 2020 02:49:06 -0800 (PST)
Received: from dell ([95.147.198.95])
        by smtp.gmail.com with ESMTPSA id e8sm14583552wrt.7.2020.01.13.02.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 02:49:05 -0800 (PST)
Date:   Mon, 13 Jan 2020 10:49:26 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] dt-bindings: bd718x7: Yamlify and add BD71850
Message-ID: <20200113104926.GE5414@dell>
References: <20191227111235.GA3370@localhost.localdomain>
 <20200107130155.GK14821@dell>
 <CAL_JsqJzaS1G-ODb4A5QGdhhJ+SXXYPY0nXvKfJnZKoRP+WmAA@mail.gmail.com>
 <821646c01d3efbba1eaabc7f5da8048fe4f25bbd.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <821646c01d3efbba1eaabc7f5da8048fe4f25bbd.camel@fi.rohmeurope.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Jan 2020, Vaittinen, Matti wrote:

> Hi de Ho Peeps,
> 
> On Tue, 2020-01-07 at 09:37 -0600, Rob Herring wrote:
> > On Tue, Jan 7, 2020 at 7:01 AM Lee Jones <lee.jones@linaro.org>
> > wrote:
> > > On Fri, 27 Dec 2019, Matti Vaittinen wrote:
> > > 
> > > > Convert ROHM bd71837 and bd71847 PMIC binding text docs to yaml.
> > > > Split
> > > > the binding document to two separate documents (own documents for
> > > > BD71837
> > > > and BD71847) as they have different amount of regulators. This
> > > > way we can
> > > > better enforce the node name check for regulators. ROHM is also
> > > > providing
> > > > BD71850 - which is almost identical to BD71847 - main difference
> > > > is some
> > > > initial regulator states. The BD71850 can be driven by same
> > > > driver and it
> > > > has same buck/LDO setup as BD71847 - add it to BD71847 binding
> > > > document and
> > > > introduce compatible for it.
> > > > 
> > > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com
> > > > >
> > > > ---
> > > > 
> > > > changes since v1:
> > > > - constrains to short and long presses.
> > > > - reworded commit message to shorten a line exceeding 75 chars
> > > > - added 'additionalProperties: false'
> > > > - removed 'clock-names' from example node
> > > > 
> > > >  .../bindings/mfd/rohm,bd71837-pmic.txt        |  90 -------
> > > >  .../bindings/mfd/rohm,bd71837-pmic.yaml       | 236
> > > > ++++++++++++++++++
> > > >  .../bindings/mfd/rohm,bd71847-pmic.yaml       | 222
> > > > ++++++++++++++++
> > > >  .../regulator/rohm,bd71837-regulator.txt      | 162 ------------
> > > >  .../regulator/rohm,bd71837-regulator.yaml     | 103 ++++++++
> > > >  .../regulator/rohm,bd71847-regulator.yaml     |  97 +++++++
> > > 
> > > Can you split these out per-subsystem, so that I can apply the MFD
> > > changes please?
> > 
> > That's not going to work any more. The MFD binding references the
> > child bindings and the complete example(s) resides in the MFD
> > binding.
> 
> So is it Ok to take all of these in MFD tree - or how should this be
> done? Can Rob get them in after acks from Lee/Mark?

I'm happy to take all of them, but will need Mark's Ack.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
