Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512AAC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC4B20873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JV96VDGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbgCISv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 14:51:27 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:54559 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbgCISvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 14:51:25 -0400
Received: by mail-pj1-f66.google.com with SMTP id np16so266277pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 11:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oMIq8nf8l37k+xc/nmQRiBDab2+u6nWIzujXfP0wRko=;
        b=JV96VDGxym68PMmFm3L2QPWppkEBRoLWFyJsxYTYbr57gNjbFV2zyv/AkBOqsMyGy9
         r0iFvkFMQeE1iVCbdPlAsHo7nOoL/b+J+ZsAbcq60L5jRRFD1dLywiruCX+c1n5vCdLv
         uwbn4UDHIJcBwge6x4WpK/HFXyHFMtxXLgfeuFGQQvMZ6+TYutTzIfjJaC56Lj2iwZ0m
         8SWywDabn5XrewHk4OBynpLwb1Cm2lJA5ues+0kgw9K64g+VnpdLa/2CwKkgSNAcFcs6
         4GNniTIf+eViDzocUYFGtDP3OZkIK8sTucbJ+tbH9LKdArPqUiauS76qh8T+DAjNeWUj
         bsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oMIq8nf8l37k+xc/nmQRiBDab2+u6nWIzujXfP0wRko=;
        b=lqsM0//IelKICk2d1H7YELBySAUP8zPgRuEGOfqjyICaJpGD7Tec19eCfrXtsJA5dc
         Si6bWtb/4DfmCKySs8DUFx/ABus+LHQXFoJoye7xUwG8oiH99zqvPEimLQz+11zrZMe1
         WEXzUHSPjUfKyqs5fFUh61oyiGFNT8uvn/9Z0E3Md7LdX6QbndATSidYfNphx23qOJkq
         jo5XKRPByE73E1VHp7fyOWOUmG78DxmCApLnq29i+5LOjX/sAQJmEVXfKj37KnU9PzMf
         j6lmNhCtVK+qOFS/p29e+p2uE+/XVQxlW56gxZvcnfwA3C9G/a0NxvQvZFRnXRmPTECM
         sdzA==
X-Gm-Message-State: ANhLgQ2OG1+vKzaIDZt09yRQ0IFxQ6CDt+mxpdH65VtnT1qxTLBfNWMb
        GNoDKOi5lKolMMVvEDI8peHyDw==
X-Google-Smtp-Source: ADFU+vuTiXSQEWF3vDz7zbEWlep/T7QabW2QTc3JChjYyJnTWvNWTPcTOEkvT88T/e4nIeN9OV/Jyg==
X-Received: by 2002:a17:902:9349:: with SMTP id g9mr17844084plp.16.1583779883026;
        Mon, 09 Mar 2020 11:51:23 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id cm2sm277840pjb.23.2020.03.09.11.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 11:51:22 -0700 (PDT)
Date:   Mon, 9 Mar 2020 11:51:20 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Maulik Shah <mkshah@codeaurora.org>, evgreen@chromium.org,
        mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: Introduce SoC sleep stats bindings
Message-ID: <20200309185120.GC1098305@builder>
References: <1583752457-21159-1-git-send-email-mkshah@codeaurora.org>
 <1583752457-21159-2-git-send-email-mkshah@codeaurora.org>
 <158377818530.66766.4481786840843320343@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158377818530.66766.4481786840843320343@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09 Mar 11:23 PDT 2020, Stephen Boyd wrote:

> Quoting Maulik Shah (2020-03-09 04:14:14)
> > From: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> > 
> > Add device binding documentation for Qualcomm Technologies, Inc. (QTI)
> > SoC sleep stats driver. The driver is used for displaying SoC sleep
> > statistic maintained by Always On Processor or Resource Power Manager.
> > 
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> > Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> > Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  .../bindings/soc/qcom/soc-sleep-stats.yaml         | 46 ++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.yaml b/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.yaml
> > new file mode 100644
> > index 00000000..7c29c61
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.yaml
> > @@ -0,0 +1,46 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/soc/qcom/soc-sleep-stats.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm Technologies, Inc. (QTI) SoC sleep stats bindings
> > +
> > +maintainers:
> > +  - Maulik Shah <mkshah@codeaurora.org>
> > +  - Lina Iyer <ilina@codeaurora.org>
> > +
> > +description:
> > +  Always On Processor/Resource Power Manager maintains statistics of the SoC
> > +  sleep modes involving powering down of the rails and oscillator clock.
> > +
> > +  Statistics includes SoC sleep mode type, number of times low power mode were
> > +  entered, time of last entry, time of last exit and accumulated sleep duration.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - qcom,rpmh-sleep-stats
> > +      - qcom,rpm-sleep-stats
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +examples:
> > +  # Example of rpmh sleep stats
> > +  - |
> > +    rpmh_sleep_stats@c3f0000 {
> > +      compatible = "qcom,rpmh-sleep-stats";
> > +      reg = <0 0xc3f0000 0 0x400>;
> > +    };
> > +  # Example of rpm sleep stats
> > +  - |
> > +    rpm_sleep_stats@4690000 {
> 
> Node names don't have underscores. It really feels like we should be able
> to get away with not having this device node at all. Why can't we have
> the rpm message ram be a node that covers the entire range and then have
> that either create a platform device for debugfs stats or just have it
> register the stat information from whatever driver attaches to that
> node?
> 
> Carving this up into multiple nodes and making compatible strings
> doesn't seem very useful here because we're essentially making device
> nodes in DT for logical software components that exist in the rpm
> message ram.

It's been a while since I discussed this with Lina, but iirc I opted for
the model you suggest and we concluded that it wouldn't fit with the RPM
case.

And given that, for reasons unknown to me, msgram isn't a single region,
but a set of adjacent memory regions, this does seem to represent
hardware better.

Regards,
Bjorn
