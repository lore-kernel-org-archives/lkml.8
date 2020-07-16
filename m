Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3351C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82CCF20739
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="SmB/X2pt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgGPMte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbgGPMtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:49:33 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B66CC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 05:49:33 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id el4so2588880qvb.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 05:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a2Z0NyBzSRfYPlTqQi5HC5Y/ZVbqT0rGo94ALPxovzk=;
        b=SmB/X2ptMLN6Gh28Aa1yG24xaAVEeCpLhMr2iyuzGOTVrugnhWM1xvD/ugry/VvPZt
         eBJSCTqtYpRYDYKlyF0KkdJlKNyIHywxoSLf9LaVEOWbumxa9Ayj4KTIA4wITulEZvYS
         wK3OQIn4XaNcDh0xP9KeVgHZ9jML6mGH1D3miOz/z7jtGjeNt/bWPaedkA9eLFDSsuTM
         NbfcGz++6PL52tLhylCYVajWFt0Jk+ji1XeXbCEWf5RQA1mpFJQVJ9eKWLFLiWrHeuDS
         PBDgUPTKzqLHwgjSJcl5TV6y++HVe2Xnan9bKzstyoDqZSS0Gj7zl3Y+2mcu1NQYj8d2
         kHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a2Z0NyBzSRfYPlTqQi5HC5Y/ZVbqT0rGo94ALPxovzk=;
        b=SvZq+iARNhRlTmoA5mFZNjTTH8HD3Etm0BA7VhM8x8A+tuuDd9ZSzQmJaUqvhh0rr4
         L7tHyJQMG1f8Tc1YBYwJxCJGkzc0eCeK+lQBfLooGrCEv3AtdUGfVWd5d/+VZi8aUEWf
         42WBHjuecj7CPOimI26zU4dFfnPRSKLz+G3HAo11K5gerQAawzzODH52Iwp1/359aXnj
         0Qo83d/kqeEBHqPcrE9C0SWYpNsQWeEw9YerwmWdMr4uu6BvDc/2ksyYAAuaTMLXoMPV
         zYdtCG89fHchlueaprfDEhDurBXTTihMPwSYVoPSQm3pDEKPuFwHksANvJiNC7BAbXkr
         GvBg==
X-Gm-Message-State: AOAM53158cW7LgXsiaREaXVJXmuJhliaSvWTCDyrHyaiDDDn30PuZUZD
        cYwzjLJRUZ0hpDr/94jinHRmzPL9jD6zueybjs2m/g==
X-Google-Smtp-Source: ABdhPJxMytH+NnNlQOn18gFigcvdXRMSyJe5kNmIjQVXJv41s/Kb4YrRfwI56uD/iLzp1GAHBqKKWpn7i7KV+arkG7Y=
X-Received: by 2002:a0c:9ae2:: with SMTP id k34mr3940006qvf.247.1594903772528;
 Thu, 16 Jul 2020 05:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200715070649.18733-1-tn@semihalf.com> <159488817559.3788855.4350396507732052751.b4-ty@kernel.org>
 <20200716120202.GA7485@willie-the-truck>
In-Reply-To: <20200716120202.GA7485@willie-the-truck>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Thu, 16 Jul 2020 14:49:21 +0200
Message-ID: <CAPv3WKc5hNhDCjgrX8uuJJm9MRS520QcD1NYTY1LWFHEBqJMfg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Add system mmu support for Armada-806
To:     =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        Tomasz Nowicki <tn@semihalf.com>,
        Hanna Hawa <hannah@marvell.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, kernel-team@android.com,
        nadavh@marvell.com, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 16 lip 2020 o 14:02 Will Deacon <will@kernel.org> napisa=C5=82(a):
>
> On Thu, Jul 16, 2020 at 01:00:43PM +0100, Will Deacon wrote:
> > On Wed, 15 Jul 2020 09:06:45 +0200, Tomasz Nowicki wrote:
> > > The series is meant to support SMMU for AP806 and a workaround
> > > for accessing ARM SMMU 64bit registers is the gist of it.
> > >
> > > For the record, AP-806 can't access SMMU registers with 64bit width.
> > > This patches split the readq/writeq into two 32bit accesses instead
> > > and update DT bindings.
> > >
> > > [...]
> >
> > Applied to will (for-joerg/arm-smmu/updates), thanks!
> >
> > [1/3] iommu/arm-smmu: Call configuration impl hook before consuming fea=
tures
> >       https://git.kernel.org/will/c/6a79a5a3842b
> > [2/3] iommu/arm-smmu: Workaround for Marvell Armada-AP806 SoC erratum #=
582743
> >       https://git.kernel.org/will/c/f2d9848aeb9f
> > [3/3] dt-bindings: arm-smmu: add compatible string for Marvell Armada-A=
P806 SMMU-500
> >       https://git.kernel.org/will/c/e85e84d19b9d
>
> (note that I left patch 4 for arm-soc, as that's just updating .dts files=
)
>

Hi Gregory,

Can you please help with the review/merge of patch #4?

Best regards,
Marcin
