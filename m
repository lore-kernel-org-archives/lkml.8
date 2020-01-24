Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B5BC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D76214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L9ErBMyC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389005AbgAXOCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:02:45 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52280 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387698AbgAXOCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:02:44 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so1769347wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 06:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P//bELOAogzapLRAvc0MrTECr/vkbTdTXm/vZxUoi7A=;
        b=L9ErBMyCtJKb5ZEZYl3TmzU8EuI/xFUWYDF+VW9m90cvjhClhkYvKXe8R60FO1jApB
         myLg4r9b28I5Vc+4zNLsdEfYsQ9aWxkO/BdkYOuyV0Au5mSq/4JtRW7JFx3Q9S24CGvD
         2Mt0W5leTE7dWl9zVcoVSRPAuGZBK0Oa9tvBEwzJWzXG5ls6izBvvc/iSVkBHUTOe1UN
         lVmz78njpXZZBYDF4uVoTiXQxlxnKtYYk/B3Bkv9edn4xJEHhsz8BwyM/v73POvMSl67
         SKL+XWTPYoyrQQQ9G67iRS++pePFi6hYUxk0uCIipKFSOxIjcgoZK3kfOa46mExL59tk
         73/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P//bELOAogzapLRAvc0MrTECr/vkbTdTXm/vZxUoi7A=;
        b=iYigmuAVwfO74C5FwHT7fzErEUiKTAUt+PmAd1ljyZyELGaeJX/X1zFmgiTTUyVScy
         k+TZUikyagiI6BtpOlui4YiCD4JqUFoCkfdc0CvEHLzoAo58Z+43FiMJISXJE85VRZI7
         9+Ml4YOtcIGBqxTxMomkzFLaA+TEl4V3yr76OG55yIQKEXW/5mTXkpRNySUzSQmJUqwr
         JeFMgOYIt91rPrdgEKOpsvUQETngPFLqMmCv7mX64Q51QyBd+anQ4XTltiiv88IEqENA
         alMN5iRl02zzigYlS4TNl22jGf8h9ZVfQ8Ipe1DYlfH76MuFpfl9wIXOVo1uehw7UA1Z
         eyrg==
X-Gm-Message-State: APjAAAXYRh/HPeFa5lR9ETw6V7d/eveB8N4ZZiuA2f2msESa4w4aRDcV
        DWIccFZPCshRfiAliZZ3+CI/739JJ6OTfw==
X-Google-Smtp-Source: APXvYqwh++vgRWy9mDsoWvMlmUS3xeKplJZO2IFAv+YwFA/ve3hr0mvoCovh3TlbiktzN44VhH43YQ==
X-Received: by 2002:a1c:1b4d:: with SMTP id b74mr1475490wmb.33.1579874562635;
        Fri, 24 Jan 2020 06:02:42 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id o1sm7474771wrn.84.2020.01.24.06.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:02:41 -0800 (PST)
Date:   Fri, 24 Jan 2020 14:02:37 +0000
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        kvmarm@lists.cs.columbia.edu, kernel-team@android.com
Subject: Re: [PATCH v2 0/1] arm/arm64: add support for folded p4d page tables
Message-ID: <20200124140237.GA180536@google.com>
References: <20200113111323.10463-1-rppt@kernel.org>
 <20200122185017.GA17321@willie-the-truck>
 <cb6357040bd5d9fa061a8d3bd96fb571@kernel.org>
 <20200124122053.GA150292@google.com>
 <af9e7292f723f808406510f437d5b0eb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af9e7292f723f808406510f437d5b0eb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 Jan 2020 at 13:34:35 (+0000), Marc Zyngier wrote:
> I don't disagree at all. To be honest, I've been on the cusp of getting
> rid of it for a while, for multiple reasons:
> 
> - It has no users (as you noticed)
> - It is hardly tested (a consequence of the above)
> - It isn't feature complete (no debug, no PMU)
> - It doesn't follow any of the evolution of the architecture (a more
>   generic feature of the 32bit port, probably because people run their
>   64bit-capable cores in 64bit mode)
> - It is becoming a mess of empty stubs
> 
> The maintenance aspect hasn't been a real problem so far. Even the NV
> support is only about 200 lines of stubs. But what you have in mind is
> going to be much more invasive, and I wouldn't want an unused feature to
> get in the way.
> 
> What I may end-up doing is to send a RFC series to remove the 32bit host
> support from the tree during in the 5.6 cycle, targeting 5.7. If someone
> shouts loudly during that time frame, we keep it and you'll have to work
> around it. If nobody cares, then dropping it is the right thing to do.
> 
> Would that be OK with you?

Absolutely. And yes, if there are users of the 32 bits port, it'll be on
us to work around in a clean way, but I think this is perfectly fair.
I'll be happy to try and test your RFC series when it goes on the list
if that can help.

Thanks!
Quentin
