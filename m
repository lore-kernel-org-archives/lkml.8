Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66614C35641
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354EB2072C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582330099;
	bh=BrRfehQdzb5bz752ZpMmH9DvlLGQmOT2vvBQEpdwBXI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aLPD3Isz//dU4A41QTwJlkjWXwOc47uoJsgA5bfKpn+vh8k6MG3HqFtMNdjikzRpe
	 aQGiPMfFMtFqmKbyJ9L/qYONC/HQ2Ax7Z1uBcV/8XAPrW8Uax+c7ySPfTMVS0gTJ+P
	 QTje2xhXaPFP+L+/M+47yv0qGPo+IEan8l9XZgo4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbgBVAIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 19:08:17 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46161 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbgBVAIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 19:08:16 -0500
Received: by mail-lj1-f196.google.com with SMTP id x14so3953569ljd.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 16:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hTZLASrKaO6Lu2MZ2kRwzgF8PAll7uJUJBFH4TuSO0k=;
        b=Q0+ypkclrbDMqnAbtdLiAw4UgHHFj80CuJmseTHZvfOXtb1BSs5LnmvcigQzHvmi26
         vInYZNvVLDqswmmLqu35PaXa+dDNmIf4eDNiAAvnnqrHBt5DIRKxaDPgxZVSNIUE/NXH
         2p2Tybx+pwJKeOkZfVcS2rzrLhwLY0Nb6vugM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hTZLASrKaO6Lu2MZ2kRwzgF8PAll7uJUJBFH4TuSO0k=;
        b=GDvcVDscZOBp91gh///Ay3GCj2Vlwp+QCBkOkndeP9AlALnfz5280aFfMlkOZoT36w
         tn3zufrgym1fZFWGnrTUS2xa3mhbE3/itbrKPtXpGXj2/Ntiz25eL9rcL1klhmJHEpLC
         WShP+u0f1C75JXy1MNoCurpKoyBhs50kN4CviHAIk/CM+YGGIuovRVShqBhNU5ju3BOv
         LBrL+Lff5voEzeW0ok9kM9fe4pdRh4DPVe2l60ud8NIE0wKUZ+xfA7XmKn3sueIgsTeV
         tJsM1qfmBitP8vogUmukzO20W1G+lNsY72Cbu+Qut8xU3Rwm78ssjpGvz9zcGV5Ot4yk
         30vQ==
X-Gm-Message-State: APjAAAWWI+tyyaH2+rQQlHZ0TgoYL77mnCf5lJvcsP/3Zk5BtbEP3vRZ
        kfvSbQOIHxXnI+zAwzbQf1By4Oruf2o=
X-Google-Smtp-Source: APXvYqzLVHFqh2j5SSrN0OeMrBfcc16qkfFvigwRcrh5HJrJ7IrAPIKHnxUtkf1QExlog7gM1RKhcg==
X-Received: by 2002:a05:651c:314:: with SMTP id a20mr23679807ljp.91.1582330093888;
        Fri, 21 Feb 2020 16:08:13 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id v7sm2372201lfd.51.2020.02.21.16.08.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 16:08:12 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id q8so4001323ljb.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 16:08:12 -0800 (PST)
X-Received: by 2002:a2e:580c:: with SMTP id m12mr23646052ljb.150.1582330092251;
 Fri, 21 Feb 2020 16:08:12 -0800 (PST)
MIME-Version: 1.0
References: <20200221160126.GB19330@willie-the-truck>
In-Reply-To: <20200221160126.GB19330@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Feb 2020 16:07:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjyde11qnRQAMgibwcvNCd0bQX5chFgdu58tP0NPhnk_Q@mail.gmail.com>
Message-ID: <CAHk-=wjyde11qnRQAMgibwcvNCd0bQX5chFgdu58tP0NPhnk_Q@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 fixes for -rc3
To:     Will Deacon <will@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 8:01 AM Will Deacon <will@kernel.org> wrote:
>
> That said, this is core code and I know you'd prefer to limit the change
> to brk(), so the patch is sitting on top of the branch in case you prefer
> not to include it. If you decide to tweak it manually, please can you
> update the docs at the same time?

I've taken it as-is, since I don't think any of the solutions were wrong.

The mremap() case looks odd, with the _old_ address untagged, but the
new one not. I see the logic, but because it looks so odd I think it
might be worth a comment.

Not a big deal, and more of a "if you get around to it later" note.

            Linus
