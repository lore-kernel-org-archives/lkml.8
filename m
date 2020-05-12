Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FACAC2D0FB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 23:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 010EF20740
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 23:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XykURp4F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731313AbgELXL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 19:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgELXL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 19:11:56 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FFDC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 16:11:56 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id b8so6049720plm.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 16:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cRS+W9NxDVdwVTiFN0l9ExezMIc5nDe+dyNeHTBjkIE=;
        b=XykURp4FJBnb1NDLtmsfas0RMXCTZ1f6SPlMvC2oHQW5MXG0wb9WHmjFUHaViJ5Afb
         +HK1vb7kjaXg93IiAdXBsFbxS/G0MBCOlblM+sLSJGM7GICmDTtIyHJVL21kHMYHf0hn
         gBKA9wZ9SKnPhXOxOouI+0sHHGpJto4/DklF9mpZAYuBm096UWS76EN/yEWIYoP03m/J
         ivohfgjk1/Ll6gv6CfvE8XRZ2Y+yPlY+bHnU7kHj6IZfDbuQpfkOzPhaiwKaX/AE0BTP
         45ywcRKBfZmvYdiycsDP1nF9tqpJIKAsHroteH4dTezglcaiLpI1GuIQqhSOL8vGzHCl
         SjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cRS+W9NxDVdwVTiFN0l9ExezMIc5nDe+dyNeHTBjkIE=;
        b=L168qmzxaSioujQC9f0/YXMDao4Xd1GN3x8U41SmB9Aa0/wO3RUqPou8IaQrf43ryJ
         WG/V223kknuUeQAq+FMKWZdwQKaDpgf1n1F0cz0zK36nryNvirgsFdkgAv4Yfdgya/LU
         kCInitJNmBRt0zxuPTS38H3j6sLEc6PnzWFhz/ozEHz2VRTzyPYiz1yZ6QKVfQxoCw2l
         L5VW8Jdk3VLInwR8PWHtFnt7OiFTNTpxpXsL0Cg2X7uWKsUktthxCFXEX1f7ft3xfe8T
         V8hYt6avG+yZsDk7khCP+gcgTuDGJtgSOizwf24R+IZ4sYX0Pd3DnB+3wIdlnLmiv0Cb
         4LMA==
X-Gm-Message-State: AGi0Pua5vwU6T88uBNXkM1fixUkCtAdyeBmAkvUkYAXAoHDM4Xpmit1m
        Bb2mDIhAtkpw5Gg2BHDZBP76zef1kow=
X-Google-Smtp-Source: APiQypJPwDNwMc6aDkz72BkNABgQHIdpHcDvsM3KyBdYCF/5uYbZRx5CrVulpuN2jkmmoKeb06OC+w==
X-Received: by 2002:a17:90a:db0a:: with SMTP id g10mr31732936pjv.54.1589325115922;
        Tue, 12 May 2020 16:11:55 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x19sm12810390pfq.137.2020.05.12.16.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 16:11:54 -0700 (PDT)
Date:   Tue, 12 May 2020 16:10:22 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Tero Kristo <t-kristo@ti.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Misc. rproc fixes around fixed memory region
 support
Message-ID: <20200512231022.GC16107@builder.lan>
References: <20200420160600.10467-1-s-anna@ti.com>
 <181b6c56-420c-f306-f2cf-53380ad1f37b@ti.com>
 <0a2aa179-9a97-003d-d682-283a8c354ea7@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a2aa179-9a97-003d-d682-283a8c354ea7@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 08 May 08:14 PDT 2020, Suman Anna wrote:

> Hi Bjorn,
> 
> On 5/2/20 1:29 PM, Suman Anna wrote:
> > Hi Bjorn,
> > 
> > On 4/20/20 11:05 AM, Suman Anna wrote:
> > > Hi Bjorn,
> > > 
> > > This is another minor revision of the fixes around fixed memory region
> > > support [1] series. Patch 1 is revised to go back to the logic used in v1
> > > after a long discussion on the v2 version [2]. The other suggestions can
> > > be future improvments as they would require corresponding platform driver
> > > changes. Please look through the discussion there and let us know your
> > > preference. Patches are based on v5.7-rc1.
> > > 
> > > I really appreciate it if you can target the series for the current
> > > 5.7 -rc's.
> > > The fixes would apply for all 5.1+ kernels.
> > 
> > Ping on these.
> 
> The patches have been reviewed and/or acked by both Mathieu and Arnaud.

Thanks for the reviews!

> Can you please get these into the current -rc's?
> 

The offending patch appeared in 5.1, so I have a hard time claiming that
this is a regression in 5.7-rc. I've added Cc: stable and picked the two
patches for 5.8.

Thanks,
Bjorn

> Thanks,
> Suman
> 
> > 
> > regards
> > Suman
> > 
> > > 
> > > Please see the v1 cover-letter [1] for the details on the issues.
> > > 
> > > regards
> > > Suman
> > > 
> > > [1] https://patchwork.kernel.org/cover/11422723/
> > > [2] https://patchwork.kernel.org/comment/23274389/
> > > 
> > > Suman Anna (1):
> > >    remoteproc: Fix and restore the parenting hierarchy for vdev
> > > 
> > > Tero Kristo (1):
> > >    remoteproc: Fall back to using parent memory pool if no dedicated
> > >      available
> > > 
> > >   drivers/remoteproc/remoteproc_core.c   |  2 +-
> > >   drivers/remoteproc/remoteproc_virtio.c | 12 ++++++++++++
> > >   2 files changed, 13 insertions(+), 1 deletion(-)
> > > 
> > 
> 
