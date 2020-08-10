Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF1AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E71E720656
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D315fVRb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgHJUOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 16:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgHJUOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 16:14:33 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4688CC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:14:33 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id e4so654200pjd.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yjJB3+Z/0aZarJNHmOU4wwzDVsOhWe4UX3O+qXnKkZk=;
        b=D315fVRb850mO3LUwSaH5+WRqtQmJmDFRqL2o4vasXmIOfw3VutVGbMieVHlV2+0w3
         CORt+WG1i6KWddVJL9TGkYpPQZZBnUI2jlQ/6+oxD7/SK9NwtZzgw8XASnhjv86r9lG7
         NdOdfMDxsJaJh+5bixY34Qp8RXFczHt9VnFb+oU9B0oMHBmrPJxZNZtS3j9g5xGV/sVs
         7gIplLgBcSi7Fv9dkvhJHDVJVs/5bUQy9Q8yiadzlPbZJZkPfhBvvP6nXpmE7lo20k2J
         8pV7jNmcXeSidq8zL6XSO45EiVX9xk7WarsehNhXhQH6G7kLe5oerN15lRCzMGuYgZcw
         2l4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yjJB3+Z/0aZarJNHmOU4wwzDVsOhWe4UX3O+qXnKkZk=;
        b=ZzIF2q4TTTyWoINAiHoRODg7QiwXSoslsJ4uB3sSrvl/LdFyLvFUHfIcvy4qLltimt
         56vWzduXTefeiMJYnsYnk2MCcfMv75rGZCpYFS4abRk7gYrt8y8VYDL1gJ3oleKw0R8N
         DBZAv5A1owhXZ8hGrvFFODa4PkLwhP3pvsWiEOZBY8BwAwl3DSdVbrThSNeh+e1ok12W
         4XRA4e4s+q5w5gl+qzsL4vicbsgeP9pIIkOsZtD3rcz8G5WFGg9ZquP05V1OvxPkFTkV
         o/caFiMStxb3HvLZpMHFl2tPN5OhHB4SNDcsWX68Se+DcCOq9BJQZeDTZj7Qz7T7XYLC
         f5qA==
X-Gm-Message-State: AOAM530a1lj2zMn3z9x9gcRws5blm4Hz/Wv37IPwLn9AWL4+N9RjtnEQ
        H+bBjLG2UNKvxe9gqSDhipbhWw==
X-Google-Smtp-Source: ABdhPJz0Ia+wr+uzc5KKftJulbyoLBKBFceiyjkmmkJYK0EY6YnedgFHXqXlLMMam09Ze8RCIOmJwQ==
X-Received: by 2002:a17:902:714c:: with SMTP id u12mr8565017plm.290.1597090472745;
        Mon, 10 Aug 2020 13:14:32 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f3sm24471837pfj.206.2020.08.10.13.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 13:14:32 -0700 (PDT)
Date:   Mon, 10 Aug 2020 14:14:30 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, coresight@lists.linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 14/14] dts: bindings: coresight: ETMv4.4 system
 register access only units
Message-ID: <20200810201430.GC3223977@xps15>
References: <20200722172040.1299289-1-suzuki.poulose@arm.com>
 <20200722172040.1299289-15-suzuki.poulose@arm.com>
 <20200729172058.GA3060370@xps15>
 <7036b8c5-b920-3de7-21d0-474e759e2624@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7036b8c5-b920-3de7-21d0-474e759e2624@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 05:38:37PM +0100, Suzuki K Poulose wrote:
> On 07/29/2020 06:20 PM, Mathieu Poirier wrote:
> > On Wed, Jul 22, 2020 at 06:20:40PM +0100, Suzuki K Poulose wrote:
> > > Document the bindings for ETMv4.4 and later with only system register
> > > access.
> > > 
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: devicetree@vger.kernel.org
> > > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > Cc: Mike Leach <mike.leach@linaro.org>
> > > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > ---
> > >   Documentation/devicetree/bindings/arm/coresight.txt | 6 +++++-
> > >   1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> > > index d711676b4a51..cfe47bdda728 100644
> > > --- a/Documentation/devicetree/bindings/arm/coresight.txt
> > > +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> > > @@ -34,9 +34,13 @@ its hardware characteristcs.
> > >   					Program Flow Trace Macrocell:
> > >   			"arm,coresight-etm3x", "arm,primecell";
> > > -		- Embedded Trace Macrocell (version 4.x):
> > > +		- Embedded Trace Macrocell (version 4.x), with memory mapped access.
> > >   			"arm,coresight-etm4x", "arm,primecell";
> > > +		- Embedded Trace Macrocell (version 4.4 and later) with system
> > > +		  register access only.
> > > +			"arm,coresight-etm-v4.4";
> > 
> > I would rather call this "arm,coresight-etm-v4.4+" so that the binding's
> > semantic is still relevant when dealing with ETM v4.5 and onward.
> 
> AFAIUC, "compatible" stands for something that is compatible with v4.4.
> All v4.4+ versions that are compatible with v4.4 are covered here.

Your position is valid - let's to with what you had.

> Having said that I am fine with "arm,coresight-etm-v4.4+" , if it
> is fine by the DT conventions.
> 
> Cheers
> Suzuki
