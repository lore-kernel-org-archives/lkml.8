Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B72C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7EAD208B8
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CvnTOWt8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgFQR2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 13:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgFQR2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 13:28:40 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC26AC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 10:28:39 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id b10so1045665uaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 10:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UWll59MdN+ez6rWdnCElUjlRL1alI73PEwi04U04HAI=;
        b=CvnTOWt81baGdhjQChJpjeoBAJiA931fOK8jDOKIWzJx1WjRaeTmgcPKQ4GL8/VAnF
         CBPWQHyMTNs23BL/btIg4GSiZYTRy7ApJShGSsKJQ3Jmk61PA1L5zC6owRPNNDAkzFiU
         R7uHZ9DL3iZnfWBtoC9Mb9tZYMgBB1+aIBo7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UWll59MdN+ez6rWdnCElUjlRL1alI73PEwi04U04HAI=;
        b=iK/ek1YVg0iT9NUV/t6eeCxVMzZnTDFkZ/eqj+vgNUS1K59vtOlf5RaXDb3AaZrK6C
         HaJRc+3GAcNlnCgAwPIwHN6ix7bc4BpVHpslZesKNr9Uy1Lyj6OQEvfS6QvGQR5C6Js7
         YPeLcW87NZHBnwaVuADWOWNiJUITHk4awGBbXDTZ9+N12mgF/woiSW7vecUEdKc416b1
         ONm+mqGueqFrZQ6nt//kgBdE/5bsy/8ABysBvDS1k+yV6ZZmwC83jafifXKBriYRI779
         w6wuPo7XZT0I45w+ZTMjx8nI7zwNtaLg5ZPKZQBAWKmeQ4xWNTggUnUYRLeU83JyREUB
         Es+g==
X-Gm-Message-State: AOAM530qvM1Y65/M4FvxmAS/jFa9fMiWWoqTqx6LA4X+8WvPO/hRn8nr
        AhzDwOFpgEA3cDsj2xUTUHnVgNGwyU8=
X-Google-Smtp-Source: ABdhPJz/2BJlV8pll/SWD7Eq/8xQm8RfsC7CpWiis6ek6jGNjFDto4RhRdJJgmauKRAz9ayHCBknAA==
X-Received: by 2002:ab0:6341:: with SMTP id f1mr47329uap.42.1592414918560;
        Wed, 17 Jun 2020 10:28:38 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id w21sm41306vkd.13.2020.06.17.10.28.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 10:28:37 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id b13so1036974uav.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 10:28:37 -0700 (PDT)
X-Received: by 2002:a9f:3b1c:: with SMTP id i28mr55758uah.22.1592414917295;
 Wed, 17 Jun 2020 10:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200617145116.247432-1-dianders@chromium.org>
 <20200617074930.v3.1.Iea2704ec2cb40c00eca47781c310a6330ac5dd41@changeid>
 <ed6d22a1-0d38-9874-d5cc-efe39f360baa@linaro.org> <0181cfe3-6627-e599-8f2f-1f433d9e0596@codeaurora.org>
In-Reply-To: <0181cfe3-6627-e599-8f2f-1f433d9e0596@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 17 Jun 2020 10:28:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WJeWudDDp79pZepX3o7yXUqEojy9_VM6ER4z-u=LK9eA@mail.gmail.com>
Message-ID: <CAD=FV=WJeWudDDp79pZepX3o7yXUqEojy9_VM6ER4z-u=LK9eA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: nvmem: qfprom: Convert to yaml
To:     "Ravi Kumar Bokka (Temp)" <rbokka@codeaurora.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, dhavalp@codeaurora.org,
        mturney@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        sparate@codeaurora.org, mkurumel@codeaurora.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 17, 2020 at 9:26 AM Ravi Kumar Bokka (Temp)
<rbokka@codeaurora.org> wrote:
>
>
>
> On 6/17/2020 8:48 PM, Srinivas Kandagatla wrote:
> >
> >
> > On 17/06/2020 15:51, Douglas Anderson wrote:
> >> From: Ravi Kumar Bokka <rbokka@codeaurora.org>
> >>
> >> This switches the bindings over from txt to yaml.
> >>
> >> Signed-off-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
> >> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >> ---
> >>
> >> Changes in v3:
> >> - Split conversion to yaml into separate patch new in v3.
> >> - Use 'const' for compatible instead of a 1-entry enum.
> >> - Changed filename to match compatible string.
> >> - Add #address-cells and #size-cells to list of properties.
> >> - Fixed up example.
> >>
> >>   .../bindings/nvmem/qcom,qfprom.yaml           | 45 +++++++++++++++++++
> >>   .../devicetree/bindings/nvmem/qfprom.txt      | 35 ---------------
> >>   2 files changed, 45 insertions(+), 35 deletions(-)
> >>   create mode 100644
> >> Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> >>   delete mode 100644 Documentation/devicetree/bindings/nvmem/qfprom.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> >> b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> >> new file mode 100644
> >> index 000000000000..5efa5e7c4d81
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> >> @@ -0,0 +1,45 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/nvmem/qcom,qfprom.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Qualcomm Technologies Inc, QFPROM Efuse bindings
> >> +
> >> +maintainers:
> >> +  - Ravi Kumar Bokka <rbokka@codeaurora.org>
> >> +
> >
> > Am not sure this was intentional, but the old maintainer name is totally
> > lost in this patch!
> >
> > Please fix this!
> >
>
> Hi Srinivas,
> The existed qfprom dt-bindings in .txt format.
> I will make it as it is to merge whole content in .yaml format once
> confirm all the parameters with this new driver changes.

Ah, right.  It makes more sense to set you as the maintainer since you
were listed as the maintainer for the Linux driver and also the author
of the old bindings.  I'll change it to you then.

Unless I hear otherwise, I'll plan to send out a v4 tomorrow with
feedback I've gotten today.

-Doug
