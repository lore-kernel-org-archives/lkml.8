Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E24C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A264208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BX0LOotV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgIKPy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 11:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgIKPwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:52:41 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0AAC0617A2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 06:52:42 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id g10so8370385otq.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 06:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nzmY8qHBC7Hn4hT/mqduo9xIcqJb48H8H8bYW2+kdKs=;
        b=BX0LOotVaYOnKN4OT6XmK+cMBT1CxWmFzPpGGk1mY5LWvunLEszBuF8rCp+wK3bbsg
         JB6Ceqrdxgab2ORWCFl63fFW+c0flSFFwAmetVwEYcIFHW+SKIj+V//cxLKgQnk56png
         O5njrWf9XoUCdd2ECAo+ygPmlXqPGhghoCHphtBTAIAr4dsAN0hHNtoz3O0BzKx7r3Ap
         ZPpmNl//tbXnoWHkCx5DeUG6ELFCT7QQAB02gukcUyhFZsdvwO45O08zRsQxlNOVW+uj
         8O5KFwFX/IwZ+2pHyC4JLncr2Rrh1WnET/yEi+8AYneoUXgSWHS8bVkb+AjK5N1+2Mjx
         it+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nzmY8qHBC7Hn4hT/mqduo9xIcqJb48H8H8bYW2+kdKs=;
        b=jDGlZQP7uo1OI7rMj3bXerxQgZJaGvsU5FW01gAsXzEmXnOyf/+uSlF9iISoJ9oNVH
         akupcCVoQ9nGGZEK55825UPSZtUb/9q3ops3jp+EI3HjEe9uW6fFxXFX8UgHaYxksbOm
         cZfFAeX87LqTZxAPM8yTDwuFXk5gXJVQiJCm+Lr7aqJMzAvBgmpFPYZopO92OvymE7xI
         kTfUEB675ELGn5p3Ixut3AMDmeoN7YAG074wZN1r51DpJlKXs6agn1SB/WG3bX7QrW/w
         VM/TrFKep+pVHdlm5iYmNjF1Cf+7g68CyiWjshmFsCvzIn+EUdnYrowlw5Mc9I0H2wdf
         fXCQ==
X-Gm-Message-State: AOAM533p4mtoAm1/YXmjGGBWBhGK39zh6KdkHA7HhMJb5tr9Zl1ohiFl
        /DDHwaXfdpTno7uuYTT9E729bw==
X-Google-Smtp-Source: ABdhPJxY+os+5x0DwAanxGsJ38K45dys4bD8AAAM2cMbDKFwfx8nSxclD9cDMJzBOUbOwthuqItxBg==
X-Received: by 2002:a9d:5a91:: with SMTP id w17mr1295437oth.345.1599832355866;
        Fri, 11 Sep 2020 06:52:35 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id p20sm411734ook.27.2020.09.11.06.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 06:52:35 -0700 (PDT)
Date:   Fri, 11 Sep 2020 08:52:32 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     skakit@codeaurora.org
Cc:     Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        msavaliy@qti.qualcomm.com
Subject: Re: [PATCH V5 2/4] arm64: dts: qcom: sc7180: Add necessary pinctrl
 and interrupt config for BT UART
Message-ID: <20200911135232.GY3715@yoga>
References: <1599742438-16811-1-git-send-email-skakit@codeaurora.org>
 <1599742438-16811-3-git-send-email-skakit@codeaurora.org>
 <CAD=FV=ULJqgHutr524wb-wVq4gejqo1p_zqRXP=h4Co6Gvmzew@mail.gmail.com>
 <010101747ca94cce-42d129fa-0374-4f12-aab8-2ccafd02b3c7-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010101747ca94cce-42d129fa-0374-4f12-aab8-2ccafd02b3c7-000000@us-west-2.amazonses.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 11 Sep 05:15 CDT 2020, skakit@codeaurora.org wrote:

> On 2020-09-10 20:10, Doug Anderson wrote:
> > Hi,
> > 
> > On Thu, Sep 10, 2020 at 5:55 AM satya priya <skakit@codeaurora.org>
> > wrote:
> > > 
> > > Add a suitable sleep configuration for uart3 to support Bluetooth
> > > wakeup.
> > > 
> > > If QUP function is selected in sleep state, UART RTS/RFR is pulled
> > > high
> > > during suspend and BT SoC not able to send wakeup bytes. So, configure
> > > GPIO mode in sleep state to keep it low during suspend.
> > > 
> > > Signed-off-by: satya priya <skakit@codeaurora.org>
> > > Reviewed-by: Akash Asthana <akashast@codeaurora.org>
> > > ---
> > > Changes in V2:
> > >  - This patch adds sleep state for BT UART. Newly added in V2.
> > > 
> > > Changes in V3:
> > >  - Remove "output-high" for TX from both sleep and default states
> > >    as it is not required. Configure pull-up for TX in sleep state.
> > > 
> > > Changes in V4:
> > >  - As per Matthias's comment, removed drive-strength for sleep state
> > >    and fixed nit-pick.
> > > 
> > > Changes in V5:
> > >  - As per Matthias's comments, moved pinmux change for sleep state,
> > >    pinctrl and interrupt config to the board specific file.
> > > 
> > >  arch/arm64/boot/dts/qcom/sc7180-idp.dts | 48
> > > +++++++++++++++++++++++++++++++++
> > >  1 file changed, 48 insertions(+)
> > 
> > Similar comment to patch #1 in that this applies only to the IDP board
> > but that's not obvious from ${SUBJECT}
> > 
> 
> Okay.
> 
> > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> > > b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> > > index 04888df..e529a41 100644
> > > --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> > > +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> > > @@ -344,6 +344,10 @@
> > >  };
> > > 
> > >  &uart3 {
> > > +       pinctrl-names = "default", "sleep";
> > > +       pinctrl-1 = <&qup_uart3_sleep>;
> > > +       interrupts-extended = <&intc GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>,
> > > +                               <&tlmm 41 IRQ_TYPE_EDGE_FALLING>;
> > 
> > You need a:
> > 
> > /delete-property/interrupts;
> > 
> > ...or, alternatively, a patch before this one that converts all the
> > UARTs in sc7180 to just use interrupts-extended.
> > 
> 
> Sure, I will add this. But I think when both are added,
> "interrupts-extended" will get priority as per [1] and there wouldn't be any
> problem.
> 

You're indeed correct, please stick with what you have.

Regards,
Bjorn

> [1] https://www.kernel.org/doc/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> 
> > 
> > >         status = "okay";
> > 
> > Slight nit is that usually I see the status line first.  All the other
> > instances in this file have it that way.  Can you match?
> > 
> 
> Ok, will correct it.
> 
> > 
> > 
> > 
> > -Doug
