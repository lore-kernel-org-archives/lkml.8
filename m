Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBA2C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 18:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 586E9208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 18:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598726440;
	bh=JSJZCigk4E08VMIg4Hun3LtWiY2xMjZqNLjT154Yth8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aHKGGyTClr5Qb8K2CFPb0CthZ2YLVLCZYhN9/RWyxO8otjGDn7qnLWHad9De9/Svc
	 X6NF27w6GY4kHaUT0fgPQSoUV2uPwjKuXjjx2J7oVTpOfXaMPWcsCE133ts2lcttPy
	 +/aGhq4gtoh0izhEM0/4Lj1jeWfxgUKJQFlHzWh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgH2Skh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 14:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbgH2Skg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 14:40:36 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053EBC061236
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 11:40:35 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id c15so1410967lfi.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 11:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+bS3/ZAsJehAuh2OYGlyfD2Lwdw96EndWMQRFR9DTGM=;
        b=SwJ9R5Wz54BJCRFB5kIJHnx20MYlTokmP+L4EVQeClI13aHwe8h4KvW1MdMcB3Gu3J
         aRtlpjIHU5dTaSfiZ28QgnmgFA0JQC5E8yJmQI70bZoaERm1b9EuihErL1xMGIzXaq4Q
         nRgQWO3aoEWgvJzzXa0zFe3fqE1N5sJhcWpag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+bS3/ZAsJehAuh2OYGlyfD2Lwdw96EndWMQRFR9DTGM=;
        b=MtZtpwvCkn8C7Obo2TUfob4DzFoKWhvMvx8t/Yfqzp4nQUJwUufz81Ccl1b/IpfTsA
         0h8LgukJhQEXMFQL587f22bVeP5986wvS3/yA+jPko1RhO/HgGG4ho8wZYCXL3DbUSOp
         wDbtbc2Qwr/nqzC+e1ZyHUyh5p5wDMXLUQo3NSxAfN2gVfgEEmDbhg5obLRnidoso2ed
         jXP6OJxYrtLy3eI6/OVNOmxQVajhq1cFFyZkbeVQUu/KTJj61FdBiyvFC26h6/Ylgbmi
         /r77l9IVsUOhq/bfpee86q/cg4zZBhmVKn2YYsfwcZnAOEbrcufag1SLQb0p0u75yO8f
         fXgw==
X-Gm-Message-State: AOAM531wCXMhtKtrH5WMuqy5id6tSxzinqhDI+rFNoCs4z6EePNMMMLn
        yRXbBKSKRUWU9bo2cd5YoMVnFiKYMLUBLg==
X-Google-Smtp-Source: ABdhPJyJwbWVobBrdNbShjl4rivFSNqVBdWynAIJW+0tEDLV3ZhVGOS4gIGQr1A5l+KzIqA1ADXfCA==
X-Received: by 2002:a19:40c8:: with SMTP id n191mr2150173lfa.29.1598726434122;
        Sat, 29 Aug 2020 11:40:34 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id h18sm777293lfk.86.2020.08.29.11.40.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Aug 2020 11:40:32 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id t23so2421203ljc.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 11:40:32 -0700 (PDT)
X-Received: by 2002:a2e:b008:: with SMTP id y8mr1719908ljk.421.1598726432098;
 Sat, 29 Aug 2020 11:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <f7328aad-ce1d-dd3f-577b-20b3d2efbabc@dragonslave.de>
 <CAHk-=whuO3U90x_i6nq+xmVymwqcc=kkb5=gv4vyLScQn7ZwBw@mail.gmail.com>
 <20200829175735.GA16416@lst.de> <CAEJqkgjz2wHAOVfHTw0V1fU8nOR70WZtuY9vJKywrUkJetC=TQ@mail.gmail.com>
In-Reply-To: <CAEJqkgjz2wHAOVfHTw0V1fU8nOR70WZtuY9vJKywrUkJetC=TQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 29 Aug 2020 11:40:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgMJGVqiKnmL+mJ=mrHkc3JsABLrmuaxJ1T=xTrnDCqag@mail.gmail.com>
Message-ID: <CAHk-=wgMJGVqiKnmL+mJ=mrHkc3JsABLrmuaxJ1T=xTrnDCqag@mail.gmail.com>
Subject: Re: Kernel 5.9-rc Regression: Boot failure with nvme
To:     Gabriel C <nix.or.die@googlemail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Daniel Exner <dex@dragonslave.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gabriel C <crazy@frugalware.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 11:36 AM Gabriel C <nix.or.die@googlemail.com> wrote:
>
> > This kinda looks like the sqsize regression we had in earlier 5.9-rc,
> > but that should have been fixed in -rc2 with
>
> git tag --contains 7442ddcedc344b6fa073692f165dffdd1889e780
> returns nothing, that commit only exits in master, so probably in -rc3.

Right you are - that commit is not in rc2.

Daniel - that commit will be in rc3 when I cut that tomorrow, but if
you are willing to check current -git to verify that yes, it's fixed,
that would be lovely.

                  Linus
