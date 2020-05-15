Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7381C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4BD020767
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=unikie-com.20150623.gappssmtp.com header.i=@unikie-com.20150623.gappssmtp.com header.b="cLQIrNYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgEOIOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 04:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726732AbgEOIOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 04:14:04 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3275EC05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 01:14:04 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 82so1074446lfh.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 01:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unikie-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lq5DIesF+RbxQOK8sQT3VRTvChBQJEKKHevS1i912BY=;
        b=cLQIrNYIqNnFQZxSDv3Nao/EiRz4C4v3D5BsBSJVZsrGzek1Zb7axRteBeyR0qa7GO
         yI83eqGb7l8aeRIoZ41ZzQJnP8p+wDG3/134icS+IYgUd8aBV6O/angx23NyzRP3aBAY
         n0bavOIby4D3JUeSr7fsE/+suHe4jfZ/MgBwZJeSzD5CFAwzNuFgsLsA9Qmw55Sn5kzn
         NeOiIQLvd6/ZjDd3ER6ipv11n8qjnN7tOYcYK3KYUxRwUHNkVS/Tv+BjO5nQoOCCX6UK
         ay1dyBIwzzehakQ5ovJc8SZsV4puGQLX3H9rZtegPRjGx35oz11ZFWdZfW6Anex29nBm
         FKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lq5DIesF+RbxQOK8sQT3VRTvChBQJEKKHevS1i912BY=;
        b=lqspXYSHK7EyeWyHbtZQKetCQhknImgs1D4VtfdvXhcIYYpRIPspbA0BXcazx2Op/R
         aGVlf+UVfkUVWHq82IbDu0V/5Mg5XWkW6RM7B/xB+AgFl1ncEKCBunT/a7M0dJLT5rLT
         SJs12DZie0YRFRuZ0DhrzMF1e96G82Ebm+zAFJ7CWWBdCtXqshZYrXZAAPQjXsA4Z2Kd
         iPSOo/psk3MMLHPe6AAxj2Wq3CP7VcQ13FwwYnR2ELnq33U+BTOXKpjHyiK0XdFM2OH4
         3Wfgw9nAW1TPRPTj7ypcQIHlSNzRMv5NOgCXTuTmcPnGw6dzAOsnFXEBBf1z6wxVfgNv
         qjWw==
X-Gm-Message-State: AOAM533t8M6K68MkbIqtLM0Z0gEtp1ezlcerJ5TGj7OlWZcAGe+pMWln
        yVrHvv/REf/zzJYFpBrLwFlF0A==
X-Google-Smtp-Source: ABdhPJxHpquJ2A/U+NfvfBKSNQ9J9hevvQWZxQllmv4qLIHrrF1Bxp11wqKzmG9P7N3gTkhnycKxrg==
X-Received: by 2002:a05:6512:310d:: with SMTP id n13mr1575556lfb.205.1589530442388;
        Fri, 15 May 2020 01:14:02 -0700 (PDT)
Received: from buimax ([109.204.208.150])
        by smtp.gmail.com with ESMTPSA id y76sm1049432lff.45.2020.05.15.01.14.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 May 2020 01:14:01 -0700 (PDT)
Date:   Fri, 15 May 2020 11:14:00 +0300
From:   Henri Rosten <henri.rosten@unikie.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: stable/linux-4.4.y bisection: baseline.login on
 at91-sama5d4_xplained
Message-ID: <20200515081357.GA3257@buimax>
References: <5eb8399a.1c69fb81.c5a60.8316@mx.google.com>
 <2db7e52e-86ae-7c87-1782-8c0cafcbadd8@collabora.com>
 <20200512111059.GA34497@piout.net>
 <980597f7-5170-72f2-ec2f-efc64f5e27eb@gmail.com>
 <20200512211519.GB29995@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512211519.GB29995@sasha-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 05:15:19PM -0400, Sasha Levin wrote:
> On Tue, May 12, 2020 at 01:29:06PM -0700, Florian Fainelli wrote:
> > 
> > 
> > On 5/12/2020 4:10 AM, Alexandre Belloni wrote:
> > > Hi,
> > > 
> > > On 12/05/2020 06:54:29+0100, Guillaume Tucker wrote:
> > > > Please see the bisection report below about a boot failure.
> > > > 
> > > > Reports aren't automatically sent to the public while we're
> > > > trialing new bisection features on kernelci.org but this one
> > > > looks valid.
> > > > 
> > > > It appears to be due to the fact that the network interface is
> > > > failing to get brought up:
> > > > 
> > > > [  114.385000] Waiting up to 10 more seconds for network.
> > > > [  124.355000] Sending DHCP requests ...#
> > > > ..#
> > > > .#
> > > >  timed out!
> > > > [  212.355000] IP-Config: Reopening network devices...
> > > > [  212.365000] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
> > > > #
> > > > 
> > > > 
> > > > I guess the board would boot fine without network if it didn't
> > > > have ip=dhcp in the command line, so it's not strictly a kernel
> > > > boot failure but still an ethernet issue.
> > > > 
> > > 
> > > I think the resolution of this issue is
> > > 99f81afc139c6edd14d77a91ee91685a414a1c66. If this is taken, then I think
> > > f5aba91d7f186cba84af966a741a0346de603cd4 should also be backported.
> > 
> > Agreed.
> 
> Okay, I've queued both for 4.4, thanks!

I notice 99f81afc139c was reverted in mainline with commit b43bd72835a5.  
The revert commit points out that:

"It was papering over the real problem, which is fixed by commit
f555f34fdc58 ("net: phy: fix auto-negotiation stall due to unavailable
interrupt")"

Maybe f555f34fdc58 should be backported to 4.4 instead of 99f81afc139c?

Thanks,
-- Henri
