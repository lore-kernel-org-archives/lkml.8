Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AD8C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 00:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FC220714
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 00:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aO/UHxQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgCXACT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 20:02:19 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37128 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbgCXACT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 20:02:19 -0400
Received: by mail-pl1-f194.google.com with SMTP id x1so2608406plm.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 17:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FMJ8LYsOHCuxBqPm4WnPrre6tQnfFkDx3c9qEXiQywU=;
        b=aO/UHxQdGJRQXfe0gajEMy3sGlCxXRCc3f+LSbVWpchMNbVtKZlSBDkpbbwIq1wKKB
         l5LEj159s+8HKvRrWNsXpJ4o9nzeKqe/Bwt2n2HOwnq6c6ea2JdA304hfC5uwxVTWY3s
         CvBgDzZy77UyIYQ6nDbajdddwlhO2KtcrgZ9gKvon0KDcq6Rq8l1KDNq1Fak+VeYN7vo
         rU3ZxVAI4/u+gyyF0rwE+TtBqUlRA4/zknSEDLxE/82GNcxCXf+oUQjbVj3Fj2wsZ5OY
         mEvRKcuBOyBREANNxCGGIDLP7tR7ggXVT38pM2wvgc6Td4ZMmMXjeIkGmVWRoNuZ9pP7
         l7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FMJ8LYsOHCuxBqPm4WnPrre6tQnfFkDx3c9qEXiQywU=;
        b=QF0VM13XNXg60mDOGpvfuFALowEp5ul2iLw/LsHLpXybSDg2JsAOmrTehjRXzznqBJ
         FpPIk0qq11HuxllhVWhJB7Q3VE8NuyOQoXwrvuTkJK46bCb/GyoGjNOb/DBJ661k6EmE
         ncsSkVTlwTLGncHhnV6tEdC3gWqoTX8wInflwuJJZWyoI5pTbdFxEZeJsLiNuDaiSzZ0
         cCrTuURr/SEBkTtImgSmjP9iVjB1Jsc6bvZtfxhSYHatBBQ8GLEhE+OwhzXUQTzsl1k+
         Cx11DfGcKCmqINsuuYk7EUjtlSLJjrRONo42ugap9dcaWsa2XQDjFmM+fdbdmyTXynyX
         HLCQ==
X-Gm-Message-State: ANhLgQ0bT/HKYhKBSDe8r4jr4faVdr58odBUf2OKfYv+JUXWgGc9P4wE
        FAZF7f2//lqZY8b/dkj6VYg=
X-Google-Smtp-Source: ADFU+vt4eSDrMXwiJThWBk2KCPEqmaH+a6P8AsrouFAy5qucFrUDbg4uFbP014TWoquAwITfNMAoIg==
X-Received: by 2002:a17:902:a701:: with SMTP id w1mr21873666plq.165.1585008138501;
        Mon, 23 Mar 2020 17:02:18 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id z63sm13434476pgd.12.2020.03.23.17.02.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Mar 2020 17:02:17 -0700 (PDT)
Date:   Tue, 24 Mar 2020 00:02:15 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Two questions about cache coherency on arm platforms
Message-ID: <20200324000214.xl7aomdboyby3b4g@mail.google.com>
References: <20200323123524.w67fici6oxzdo665@mail.google.com>
 <20200323131720.GE2597@C02TD0UTHF1T.local>
 <20200323161537.ptjrihqotgmon7tr@mail.google.com>
 <20200323164723.GA8652@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200323164723.GA8652@lakrids.cambridge.arm.com>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 04:47:24PM +0000, Mark Rutland wrote:
> On Mon, Mar 23, 2020 at 04:15:40PM +0000, Changbin Du wrote:
> > Hi Mark,
> > Thanks for your answer. I still don't understand the first question.
> > 
> > On Mon, Mar 23, 2020 at 01:17:20PM +0000, Mark Rutland wrote:
> > > On Mon, Mar 23, 2020 at 08:35:26PM +0800, Changbin Du wrote:
> > > > Hi, All,
> > > > I am not very familiar with ARM processors. I have two questions about
> > > > cache coherency. Could anyone help me?
> > > > 
> > > > 1. How is cache coherency maintenanced on ARMv8 big.LITTLE system?
> > > > As far as I know, big cores and little cores are in seperate clusters on
> > > > big.LITTLE system.
> > > 
> > > This is often true, but not always the case. For example, with DSU big
> > > and little cores can be placed within the same cluster.
> > 
> > Yes, it is ture for DynamIQ that bl cores can be placed within the same cluster.
> > But I don't understand how linux support big.LITTLE before DynamIQ.
> 
> Multiple clusters can be in the same Inner Shareable domain, and Linux
> relies on this being the case for systems it supports. It's possible to
> build a system where clusters are in distinct Inner Shareable domains,
> but Linux does not support using all cores on such a system.
> 
> Even with CCI, CCN, CMN, etc, Linux requires that all cores (which it is
> told about) are in the same Inner Shareable domain. That is what is
> commonly built.
>
Thank you, I see now. I thought clusters must be in distinct Inner
Shareable domains. So I was wrong. The mannual is somewhat misleading.

> > I read below description in ARM Cortex-A Series Programmer’s Guide for
> > ARMv8-A.
> >  | big.LITTLE software models require transparent and efficient transfer of data between big and LITTLE clusters.
> >  | Coherency between clusters is provided by a cache-coherent interconnect such as the ARM CoreLink CCI-400 described in Chapter 14.
> > 
> > So I think  big cores and little cores are in different clusters in this
> > case. Then we are not within the same Inner Shareable domain?
> 
> Linux requires that those clusters are in the same Inner Shareable
> domain, and that's what people (mostly) build today.
> 
> Thanks,
> Mark.

-- 
Cheers,
Changbin Du
