Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD339C3B18F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 04:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B512420848
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 04:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tNql3Xx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgBNEkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 23:40:49 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33661 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbgBNEks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 23:40:48 -0500
Received: by mail-pl1-f195.google.com with SMTP id ay11so3255726plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 20:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mV/b33fX5O4Uwlfl3Gd/C2A6H9eBURl2CC4vnB/ScUc=;
        b=tNql3Xx0EqLiFHTw2SWEKNybEhJdG+p7J80PZC/SlxQOgfhCwbpJvm6gGvw7xXLE+z
         tRxTDxYV7xMdkQQbIble7Q5f15aYj7ZYmzNdxpCFCcj/uDKbXSyhyQkuTNeZpQUQB+a+
         /NDIFnTDn+P2UjPOMCdBKaA+WCrRPN5EvJtYtpQPLV3BRXR8aBZNXPJZ2FxYKyrFaO1T
         ou8x6FBKclpbx7Ra18Z1ke6M+TCSsc5h3MkJRXCdYbrDI9IEq6Wfj/sR4xMoiWQmAw5r
         0J6iYMaZDKBfPNYnrkwpnsb1wC861ESMf4TyQXT2fIUBXOuQifowBF3KMDQWru7uJW8c
         RW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mV/b33fX5O4Uwlfl3Gd/C2A6H9eBURl2CC4vnB/ScUc=;
        b=uRNUel72P/j37D4YuJ3BHezzph9EM2HK/HrLIUuGbHRp6PiRnlN+wYbL0Wqm/M3B7J
         /PossiRnjo3RzuhZeeudGeBiKoJ0glqH05vMXQNouNWd9XqmGS0Ek3OAyBtaBejWk1jV
         H2yOV/Jc8VpZGZPzfrmhfd7kJJTWKm9IPdt+DeQQfusetqLZVMHrVan6+pNxT/+ilYda
         4v6Z6jRi3w9QLbYUq8z0ohJg+DEVD1bPHy2q+Fd+YuPgnZSGtutDZMy6DnJRETbIJbtA
         QYAm+iq2vZIKXQDa3r1nT48tiAVhSN2Yu3WB1ybRNMIReO9Qi8YC+ApCPkNlYK4pDIB/
         4lZw==
X-Gm-Message-State: APjAAAVObqNBEC8XMmpZu5yaXJf4buh6e/N/x68Fwhnll0GTRxhDsy8t
        WmiJSglrDDus+dLcvBoBzeLlFA==
X-Google-Smtp-Source: APXvYqz4yePjmRoZNJimpJatSM40lC1fahi/dq1Wsa5+Jjr0X1Ix7F87Vn/cAZoldoHg6njMODPAFQ==
X-Received: by 2002:a17:902:a608:: with SMTP id u8mr1407814plq.76.1581655246497;
        Thu, 13 Feb 2020 20:40:46 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i6sm4928463pgm.93.2020.02.13.20.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 20:40:45 -0800 (PST)
Date:   Thu, 13 Feb 2020 20:40:43 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <sboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: Re: [PATCH v3 4/8] arm64: dts: qcom: qcs404: Add IMEM and PIL info
 region
Message-ID: <20200214044043.GS3948@builder>
References: <20200211005059.1377279-1-bjorn.andersson@linaro.org>
 <20200211005059.1377279-5-bjorn.andersson@linaro.org>
 <158164782444.184098.15673002519472990390@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158164782444.184098.15673002519472990390@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13 Feb 18:37 PST 2020, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2020-02-10 16:50:55)
> > diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > index 4ee1e3d5f123..f539293b875c 100644
> > --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > @@ -997,6 +997,19 @@ blsp2_spi0: spi@7af5000 {
> >                         status = "disabled";
> >                 };
> >  
> > +               imem@8600000 {
> > +                       compatible = "syscon", "simple-mfd";
> > +                       reg = <0x08600000 0x1000>;
> > +
> > +                       #address-cells = <1>;
> > +                       #size-cells = <1>;
> > +
> > +                       pil-reloc@94c {
> > +                               compatible ="qcom,pil-reloc-info";
> > +                               reg = <0x94c 200>;
> 
> Is it 200 in decimal? It looks weird that this is basically the only
> thing that isn't in hexadecimal.
> 

Yes it is and the size was documented as such... But you're probably not
the last one who will spend cycles wondering if I forgot the 0x.

Regards,
Bjorn

> > +                       };
> > +               };
> > +
