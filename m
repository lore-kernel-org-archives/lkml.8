Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5854C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 23:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B77682086A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 23:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598656206;
	bh=cuzIipgBvlguG990N/YxERo27x/8SCCyR8Aa2meH1IU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ym6XxPLmy2E9xMHJfSMfmZkv7fMykXTjOGk7JJd34ENYRgp6URNS5o8G86GqnBhQo
	 eSmI1kzqxS4k9N0zJ6+GTzSMFtmXyW4PVbsWdNAGPbg530RTqb+ije0UU8x+K+naeL
	 OZ3/n6UAtJuFWJZ6ed/Jj4cgEL/7qYuhccTUMBjY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgH1XKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 19:10:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbgH1XKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 19:10:05 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 727412086A;
        Fri, 28 Aug 2020 23:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598656204;
        bh=cuzIipgBvlguG990N/YxERo27x/8SCCyR8Aa2meH1IU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oui75MntViOoplgl+Tc3SLIcjQ+hsfAAenAmW0GSBwQOZbM4d3b0h1BdONgTUV3W0
         hqps76DCyv6YFuSYThWWdSZXRibH2XDDHZRjfIdUPz75FBXqCzxq3cEduqnnCDNJIM
         M29s4ztjnnJsJzm0D1+3dQ38XaHwWJcq1CZS897c=
Received: by mail-ot1-f49.google.com with SMTP id i11so636106otr.5;
        Fri, 28 Aug 2020 16:10:04 -0700 (PDT)
X-Gm-Message-State: AOAM531qBPwIwZZRuR0zacqAMQH7/F96iBQShkGjEzJ1LAvO3lm6xU7K
        mmpTzC+tZWPyISOu/K+w6v6mvwX0jJHqyrSUsA==
X-Google-Smtp-Source: ABdhPJzjDUg54XSBKQFWzL3Kiv6AKutLQFPS6idWqVm+lWPNPPnQ22CiTHLkuFJm61VlJ3fFHj86WY0RjuOlhLhE9Hc=
X-Received: by 2002:a05:6830:1d94:: with SMTP id y20mr655920oti.129.1598656203809;
 Fri, 28 Aug 2020 16:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200828021939.2912798-1-andrew@lunn.ch> <20200828130034.GA2912863@lunn.ch>
In-Reply-To: <20200828130034.GA2912863@lunn.ch>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 28 Aug 2020 17:09:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK18GoqkNPePh1+jiEk0JoLH01yPr0dD0AkswXP1N+qzA@mail.gmail.com>
Message-ID: <CAL_JsqK18GoqkNPePh1+jiEk0JoLH01yPr0dD0AkswXP1N+qzA@mail.gmail.com>
Subject: Re: [PATCH] of: of_match_node: Make stub an inline function to avoid
 W=1 warnings
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 7:00 AM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Aug 28, 2020 at 04:19:39AM +0200, Andrew Lunn wrote:
> > When building without CONFIG_OF and W=1, errors are given about unused
> > arrays of match data, because of_match_node is stubbed as a macro. The
> > compile does not see it takes parameters when not astub, so it
> > generates warnings about unused variables. Replace the stub with an
> > inline function to avoid these false warnings.
>
> Hi Rob
>
> So 0-day shows some people have worked around this with #ifdef
> CONFIG_OF around the match table.
>
> I checked the object code for the file i'm interested in.  The
> optimiser has correctly throw away the match table and all code around
> it with the inline stub.
>
> Which do you prefer? This patch and i remove the #ifdef, or the old
> stub and if add #ifdef around the driver i'm getting warnings from?

Use of_device_get_match_data instead of of_match_node.

Rob
