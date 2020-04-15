Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D2AC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3B5B20775
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="R+fcctcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895159AbgDOIwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2505552AbgDOIwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:52:19 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42646C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 01:52:18 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id i27so2633495ota.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 01:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZCUHiYYMH/G4Vj/Sqwd6OPeDpXyCtDoKrnuuyZW76nM=;
        b=R+fcctcpUVM7bgjtt7NExQLE64KZbCPh591b4Nqle1ymrs0xUAs9xAbfm+y3RIteHq
         LZxzhYavPfqV/e56OMNc9fNpAdNOssa0Vb8X/Bw6xr8synPXvDFNV45/vPdjIJcBEQmH
         l2mazh36QyecmW4hnuCSM5+VX0lRsNTYPmTGNuojb/6qa9ihAt/B2DCHdCxFk2+KSAra
         7P3OBmp6OUvC0jtT53z0pD2OD5MIZwXz0qmVMwhRnon+Q4lvKVEy89DaxcChUQJhu5Q6
         8epUAaEKHdykKA1+Hru1q0GxZUHAtW5+Q1+pqR+Zju9M/NWp/k9cGQGaT1D3UZuQkIlh
         nUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZCUHiYYMH/G4Vj/Sqwd6OPeDpXyCtDoKrnuuyZW76nM=;
        b=cyLL4lIL220w+O3cYbOmj8wzj8bEZveWFYJGaMTtdNIuaTaekcWUEpb6rzyZrp+Ru+
         hywZjEktz+rK+2GWqxDtTKdJmdh2SzbVeSpkTthexyv1uRolXK8BSJktBiMJFdObiuPN
         Iplt3DkgagnlN48YX3yq2sjTLVGDfNsHWBPRF/9fjAaQvhNAdqCDIIUEW/Gp84OngiBu
         dO7M15haMUpyGm2A1jglTmQkJEI37iCYABJSuBl6nEP/D0X7huLhJZhjSs+fsid79lYu
         KhS5/AXYYayth3QPkKvQOZOIJBDcTKYtJEi2dWmEMFMkW5+fgSK8w0VlHoP1W7Jrh6Iw
         0oYQ==
X-Gm-Message-State: AGi0PuaFP6JuWEy+9osx2qIiXaghGvkDpoGzTGwgNY8fjfi1HEA0S0It
        4ry3HK+LXCwWLvGBdJEZcfN2jXu2Dq+x28Ey+K6GQQ==
X-Google-Smtp-Source: APiQypKBgMlXolVF7p7MsOedbvV4RyaNeLUsZBlgYqPA/1aeIk6fU5CCiWfO/6W9C+vbRqDTHLyMDAXwBdIuvXdXvZM=
X-Received: by 2002:a9d:6041:: with SMTP id v1mr11709860otj.66.1586940737597;
 Wed, 15 Apr 2020 01:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200414181012.114905-1-robert.marko@sartura.hr>
 <20200414181012.114905-2-robert.marko@sartura.hr> <08c288da-6f5c-7f04-81bc-4c7cb311af3e@gmail.com>
In-Reply-To: <08c288da-6f5c-7f04-81bc-4c7cb311af3e@gmail.com>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Wed, 15 Apr 2020 10:52:06 +0200
Message-ID: <CA+HBbNEke7e=+_zoiv67V5_pZqes+3P7pR6VkTz24=CQySLtRw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: add Qualcomm IPQ4019 MDIO bindings
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, Luka Perkov <luka.perkov@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 11:11 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 4/14/2020 11:10 AM, Robert Marko wrote:
> > This patch adds the binding document for the IPQ40xx MDIO driver.
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > Cc: Luka Perkov <luka.perkov@sartura.hr>
> > ---
>
> [snip]
>
> > +examples:
> > +  - |
> > +    mdio@90000 {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +      compatible = "qcom,ipq40xx-mdio";
> > +      reg = <0x90000 0x64>;
> > +      status = "disabled";
>
> I believe the preference is to not put status properties in examples.
> Other than that:
Will be changed in v3.
Thanks
>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> --
> Florian
