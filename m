Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E90C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 15:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 713192075D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 15:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596815689;
	bh=ujLxZdzWMLkFysjX3cqgi3CzgY3O80RonxmO4PRD4Ys=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=O6OovvmYeVxMsGhcIh6NkEU8LrJpRc65CBGNAwLW+6lJHbwMTvSabPPE7VYoJ5aVc
	 V/HNJPxenhEaKiXXSbJXQQ9OQKvoHbPen4hX3PnMmELevvDMmn+D7lBSmBpP5ie1p7
	 iNYxOQKA94iAJ4IQeHoVXHhnHg9gECmkB6a2dEFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgHGPys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 11:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgHGPyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 11:54:47 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65517C061757
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 08:54:45 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 185so2716231ljj.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 08:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xOQvVQqkh0nIyyp2B3PI0JXNJza+PnzRNp2yCtr3Mkw=;
        b=NWZK2PIgQcGaLlGhXQiIZ/ii/pVqfoT2UR8kSA9UcJdxQNWMw1+rjix7K1SduAqoSD
         gi5P8s3ejXFub/LB9x7qhaCMCiCdHcPBEcoCqQEuvpdDJkWLn4nm5A7A6LSc5cjDeWJB
         mc342Scak5zLyQFEd3zBQbJMDms7jfoYsoA5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xOQvVQqkh0nIyyp2B3PI0JXNJza+PnzRNp2yCtr3Mkw=;
        b=I/p+Z0Y3zRimpR04uq6AbN8iOOgvcIgmuwpJaHEUD/P9deWGBawEodp9FPlkjt+uzr
         1Xk8Ncj60rHZdTFXwhYCwNE16NAxiozEoBP/oS58/xD2TBKMQ8uJH+bH6De2a3A1+4E6
         9jb74ne/SIxJPwcsHJdswCPS3jyhHx62CbYWS2ASMvBYClyXj04HcVJ5zPK0ygEgzSVl
         1yMezvWHsrVz5eGIg10i+j1MX1/31WUBtkcb+JgQQOiQ2byVr1j4HflU7IQ18Ad2FoSj
         DhBDRiHoMSE0iASWw6ul0ib3SPbku91076cvLhNd1b8Wwv8PK2+fkOLXmt0iYONt4bw4
         fjtg==
X-Gm-Message-State: AOAM530z9XuEf6XW7sCLYkHOSGkV/v0NheNrTpft44b3v8CR/U7BdzR7
        niwJSmCF37JFQP2tuCdzeZUN0u+lS5g=
X-Google-Smtp-Source: ABdhPJySthXwj+B17CUBME2BXTiQx+XtlMU7RtnDZAfPKilZ/tABxOosxE1n3RVQlBeSellYTBjpXA==
X-Received: by 2002:a2e:b604:: with SMTP id r4mr6558289ljn.382.1596815683219;
        Fri, 07 Aug 2020 08:54:43 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id h26sm4401771lfj.20.2020.08.07.08.54.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 08:54:41 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 185so2716039ljj.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 08:54:41 -0700 (PDT)
X-Received: by 2002:a2e:92d0:: with SMTP id k16mr1055600ljh.70.1596815680797;
 Fri, 07 Aug 2020 08:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <db1dc155-0c7c-f4eb-7fa6-047a78829a82@linaro.org>
 <CAHk-=wgLt61owJ_eKwy43bBujxy3-s=xQXwsSi6VHME7SiAgiA@mail.gmail.com> <b903cdd8-cbb5-1a6a-3943-9bb019f1eed7@linaro.org>
In-Reply-To: <b903cdd8-cbb5-1a6a-3943-9bb019f1eed7@linaro.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Aug 2020 08:54:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgSJwbghhQYCoAVq6ewGKZ+rZvxeKvxb-o_gMt7d7-Nbw@mail.gmail.com>
Message-ID: <CAHk-=wgSJwbghhQYCoAVq6ewGKZ+rZvxeKvxb-o_gMt7d7-Nbw@mail.gmail.com>
Subject: Re: [GIT PULL] RESEND: thermal for v5.9-rc1
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Colin King <colin.king@canonical.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Lukasz Luba <Lukasz.Luba@arm.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Henry Yen <henry.yen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Marian-Cristian Rotariu 
        <marian-cristian.rotariu.rb@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 7, 2020 at 2:40 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> It defaults to 'y' because the previous (but unused) implementation was
> unconditionally compiled-in and because of the thermal users needs.
>
> Is default=y wrong given this history?

One million percent wrong.

The fact that the old implementation was never used just shows that
it's not so important, and it shouldn't be default 'y'. Not having it
doesn't break anything.

And the new implementation presumably isn't even compatible with the
old format also means that it shouldn't be default 'y'. Building it in
wouldn't help anyway.

And the fact that _some_ users might want it does not mean that it
should be default 'y', because those users presumably _know_ they want
it.

IOW, defaulting to 'y' is just wrong in every possible way. This is
not some kind of "to maintain compatibility and not break existing
users we should enable this" kind of thing.

And it's not some kind of "everybody should have it" thing either,
since presumably nobody has the user-space support for it anyway.

It's something that a new distro would enable _if_ they actually end
up supporting the user space. Not something the kernel should enable
"just because".

Really: "default y" is _wrong_. Every developer thinks that _their_
code is so magical and special that everybody should run it.

And every developer is almost always wrong. Unless you have a "not
having this will break existing users", you don't do it.

                 Linus
