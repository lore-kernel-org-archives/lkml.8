Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4BFC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B31F2087D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598799574;
	bh=k61UfvEc8DHELFbKEqx7RRmQMIl6+gSfyKFF4QhDO5g=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=uSEiQygqYRazBjhv2uslg2CY1fjK5nmURkziwojB/fuWpsvxRcar55KeBjy4top+Q
	 dzCfWxAHiH/nWHRLvIo2H2UNCIU0R0kbqijodnY739RelWUIbVksPhe8lgTNB+mDiw
	 cynF9U9MO+5vVzXUyypKmUinEYVHutUDwjjUWjsY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgH3O7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 10:59:31 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40412 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgH3O70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 10:59:26 -0400
Received: by mail-ed1-f66.google.com with SMTP id l21so3201473eds.7;
        Sun, 30 Aug 2020 07:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=95aMteSUqz2UqRupz4OeuFOBpeiq87L2yzxyqFYtQ+8=;
        b=gLhtK7Djwq5yNMCTtSPk7dkaB+xLzfSvv6aTQs1PDYXPsWHFHDEmndjKyrYurVcP4O
         o2XoWEpA3f8RU1De8CTzYXIxqSetS62xjFv+SBCCNAB55GF6it4aoci761VOzJHiOX7V
         myVrZTWYyJIs9oVwr8w3GJYbLZmxwe+gAxr+8EZyQYu4ucSWyrqOhsrXbPdD88zVQM3r
         8+rl8X2feVAI+ZzSB53ExWFwgvAzrPXmU7f7+lQhdQy/gTwD5DKtUjJzQ6mpnEVKdOVk
         4+pwTifPU3sgd+hnQNQwC9SP2mbJnIO8pHcknVQgxqWZMmBbKkKN9s8hEV/kErlzUXWK
         0P5w==
X-Gm-Message-State: AOAM530XKRT4j3dHxiUDwHnEVpyNlmrM+OeIKM2341wf/887zchcIn1A
        X4RGQAf3je+L3rtBuWAnyfs=
X-Google-Smtp-Source: ABdhPJwcVzb4yfI4YklbaQxG3N3ankYfyi4ah8zSRp71BBpRya4zWDYzXjLfRyTH/iphXOiD4gIILw==
X-Received: by 2002:aa7:d981:: with SMTP id u1mr7471575eds.311.1598799564197;
        Sun, 30 Aug 2020 07:59:24 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id f22sm5003578edt.91.2020.08.30.07.59.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Aug 2020 07:59:23 -0700 (PDT)
Date:   Sun, 30 Aug 2020 16:59:21 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Barry Song <baohua@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>, Jun Nie <jun.nie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [RESEND PATCH 4/5] ARM: dts: tango: Align L2 cache-controller
 nodename with dtschema
Message-ID: <20200830145921.GC31461@kozik-lap>
References: <20200819175853.21492-1-krzk@kernel.org>
 <20200819175853.21492-4-krzk@kernel.org>
 <20200820093118.GC15884@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200820093118.GC15884@kozik-lap>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 11:31:18AM +0200, Krzysztof Kozlowski wrote:
> On Wed, Aug 19, 2020 at 07:58:52PM +0200, Krzysztof Kozlowski wrote:
> > Fix dtschema validator warnings like:
> >     l2-cache-controller@20100000: $nodename:0:
> >         'l2-cache-controller@20100000' does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  arch/arm/boot/dts/tango4-common.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> I forgot to add the tag provided on previous submission:
> Acked-by: Mans Rullgard <mans@mansr.com>

Hi,

Ping, any comments here?

Best regards,
Krzysztof

