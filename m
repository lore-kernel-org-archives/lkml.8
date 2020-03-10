Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43E1C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9177E222C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U+DI/gme"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbgCJV5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 17:57:50 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38571 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgCJV5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 17:57:50 -0400
Received: by mail-pl1-f195.google.com with SMTP id w3so70080plz.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 14:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qYdxwwwpYm23LuoOol66JOS31vLZfpo3MXiCkbyPzr8=;
        b=U+DI/gmeBVvE0NZblYAgaOZPjifrN5fk+p5gpLgDTyfGPTvgXLQ9vkTEgIGJXF4uJL
         Fd952FkPe2/jNEyATMsvJrqqJ6kZ+XFOunzZ92lTnwRcgI7Pa8CXnOyw7Qb8CEESpM7G
         WfgtTQ5XY2rs03J4e6y3h1z8ES9S3LYFcA/sA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qYdxwwwpYm23LuoOol66JOS31vLZfpo3MXiCkbyPzr8=;
        b=hFHM+g0Z/CLYbK+ghbF6bLgAiCN1ma+fsK1EQS0uiFCsIFsIk0YbjbpR9kG8AL7Pu7
         2udtRe/Io1mbenPKD1Y3TnTNetOFkr+3081wHAJwTiET/8SqNd1qdxUCI7xl8gkKmxoW
         Bdp6FjA4L0wgX4F/x+lS9iQeMO/JwaXruuIfIeaXfox5ISnM1jsuYps6PLPfhz2aVIq8
         vM924amOcW3pQCgTRBKBo2KhPJWwr9g++IpR4olDtuIu2Lf8VrID6UrrxCOUU1BKAyoj
         s2CCSYVACixy2X/YDJ5hUcl0KygY3x5hJKzG5+cHsNd70o5SbWi3hQoY32W7aHJXQvPY
         KSQg==
X-Gm-Message-State: ANhLgQ3WbC51PssBq6Z77RVy7fQEZXHIEwVYYuVEgHEkQJ3nGK3xHCBH
        7S92aYCneRWYKYPw7DHLd1dICQ6pr20=
X-Google-Smtp-Source: ADFU+vuBaEaTeYfHN/Q5va1wjqReuMLDH16k2pXg+pd13QFSJEnP/TcDz8IkAB3cuekA2ZHVICXqlg==
X-Received: by 2002:a17:90a:8c0f:: with SMTP id a15mr58797pjo.156.1583877468981;
        Tue, 10 Mar 2020 14:57:48 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id mr7sm3122253pjb.12.2020.03.10.14.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 14:57:48 -0700 (PDT)
Date:   Tue, 10 Mar 2020 14:57:46 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     robh+dt@kernel.org, agross@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgautam@codeaurora.org,
        rojay@codeaurora.org, skakit@codeaurora.org, swboyd@chromium.org
Subject: Re: [PATCH V4 3/3] dt-bindings: geni-se: Add binding for UART pin
 swap
Message-ID: <20200310215746.GZ24720@google.com>
References: <1581932212-19469-1-git-send-email-akashast@codeaurora.org>
 <1581932212-19469-4-git-send-email-akashast@codeaurora.org>
 <20200218190731.GC15781@google.com>
 <ec5de895-3e86-811e-7ffc-fb98e115f850@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ec5de895-3e86-811e-7ffc-fb98e115f850@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akash,

The patch that implements the binding landed in tty/tty-next:

9fa3c4b1fa379 tty: serial: qcom_geni_serial: Fix GPIO swapping with workaround

The binding needs a re-spin to match the implementation.

Thanks

Matthias

On Wed, Feb 19, 2020 at 06:51:35PM +0530, Akash Asthana wrote:
> Hi Matthias,
> 
> On 2/19/2020 12:37 AM, Matthias Kaehlcke wrote:
> > Hi Akash,
> > 
> > I didn't see a patch that implements the binding, did you post it?
> 
> We haven't posted any update on patch@
> https://patchwork.kernel.org/cover/11313817/
> 
> [tty: serial: qcom_geni_serial: Configure UART_IO_MACRO_CTRL register]. We
> will spin it ASAP.
> 
> > 
> > 
> > On Mon, Feb 17, 2020 at 03:06:52PM +0530, Akash Asthana wrote:
> > > Add documentation to support RX/TX/CTS/RTS pin swap in HW.
> > > 
> > > Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> > > ---
> > >   Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml | 9 +++++++++
> > >   1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
> > > index 11530df..7e4b9af 100644
> > > --- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
> > > +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
> > > @@ -165,6 +165,15 @@ patternProperties:
> > >             - description: UART core irq
> > >             - description: Wakeup irq (RX GPIO)
> > > +      rx-tx-swap:
> > > +        description: RX and TX pins are swap.
> > s/swap/swapped/
> Ok
> > 
> > > +
> > > +      cts-rts-swap:
> > > +        description: CTS and RTS pins are swap.
> > s/swap/swapped/
> Ok
> > 
> > > +
> > > +      rx-tx-cts-rts-swap:
> > > +        description: RX-TX and CTS-RTS both pairs are swap.
> > I don't think this option adds much value, if both pairs are swapped
> > the above two properties can be set.
> 
> Yeah ok, It is possible to derive value for rx-tx-cts-rts if above 2
> properties are set.
> 
> > 
> > > +
> > >       required:
> > >         - compatible
> > >         - interrupts
> > > -- 
> > > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
> 
> Thanks for reviewing,
> 
> 
> Regards,
> 
> Akash
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
