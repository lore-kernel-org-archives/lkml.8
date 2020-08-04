Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEA1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 03:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AE54206DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 03:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596511584;
	bh=xxxkPUcG07JEhCvj4qQR6ACkCHP1pqgiPhJztLmSfzc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Fk27Ty663qXv/axj+lcJseUng4q4mM+bNDw4nHBxxoRCODqE81y6OaEqIm8gEcby8
	 qiWSghKaKcAixTsqNeTo1Z5um/61qUUred4El6QVBAax4XcuwGPbRqLIliNTnZgkUj
	 AdBNvjxT5EojeRuIhjCSqU9ScSGgLgbvjxQg1LHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbgHDD0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 23:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgHDD0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 23:26:21 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E28C061756
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 20:26:21 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z14so4350754ljm.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 20:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L0S6wIAy1k59MLOMeNhD5yQSuBj8TSGhfKg4AV6YzCM=;
        b=OvtZm4PLaQk00qzBS8G2+CcWXHzF7p+t/BFg7YcpEJNiKuxwZWP3j06xIQl0nuLvLU
         FdxWptleTj2pfi3DR8NOqN6gSSYUlakIoh2i3lqBiFIDc4S3iAjOs0OdbtcArIUX/v/T
         KURRMaRIqrf0qth5ixscu9IDOTHWWXxEqGC/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L0S6wIAy1k59MLOMeNhD5yQSuBj8TSGhfKg4AV6YzCM=;
        b=ayt8UY9QyiZdclz8Qfrfxkcp5+GZz1S8/zZinOcCp6EcpdNsCHmBH40NhfDREH4+D1
         UB7nQsd2bUSKRFE5S92glSlAf0NX/0NwIPhoJVFffTUZCCWv2a6LL415PtXHbm/c6WM2
         U7lM4bLe2pe+lXQb0q94xrDXERMAT5MFeb+RK2yYz/7yrMgM7CzaNR1j9QwmDg2xS3O/
         W6SqRqA3kh7/JpRjB6PiVNMw8R2ARYd6ndznX9lhXByAOh1AeUKtBdMpIf/2PnPX7fOC
         EJ0CF2TemKzhI12Liais7O79RGhEWaRmi25LW+hAR1q8KpfjABZ+Eevb1e9UfRITkj7w
         8V2Q==
X-Gm-Message-State: AOAM5320B2EbwUQCs7KlNcxgf7f2oWEbzjAF2+VETVT9WFvuJNj9gU0s
        V/LcgKTA44gAt2F/+BoG3ohDA2fNMZE=
X-Google-Smtp-Source: ABdhPJxQ5G55txwGx09UFy3rW/wH1s3yJfboYAfSrWARupyVRFIkz5djvI4oqxBtzudVLIdYmJxCOg==
X-Received: by 2002:a2e:85d1:: with SMTP id h17mr7059666ljj.341.1596511578729;
        Mon, 03 Aug 2020 20:26:18 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id f9sm5632487lfc.43.2020.08.03.20.26.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 20:26:17 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id v12so11616680ljc.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 20:26:17 -0700 (PDT)
X-Received: by 2002:a2e:545:: with SMTP id 66mr9565590ljf.285.1596511577146;
 Mon, 03 Aug 2020 20:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <0b3dd92e-0aa0-6f23-fcef-178f2bf6a1c1@linaro.org>
In-Reply-To: <0b3dd92e-0aa0-6f23-fcef-178f2bf6a1c1@linaro.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Aug 2020 20:26:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbPwsdPom8pcJyo7P5KRRjDef_6ZEMbavJy=qArVoqVw@mail.gmail.com>
Message-ID: <CAHk-=whbPwsdPom8pcJyo7P5KRRjDef_6ZEMbavJy=qArVoqVw@mail.gmail.com>
Subject: Re: [GIT PULL] thermal for v5.9-rc1
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

On Mon, Aug 3, 2020 at 2:44 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v5.9-rc1

This was all rebased just an hour before you sent it to me.

Why?

Maybe it's how you commonly work, and I just haven't noticed before,
but it's wrong for all the reasons I've stated about a million times
now.

What makes it so hard for people to understand? What makes that "you
sent me a completely untested pull request and that's not ok" so
difficult a concept to get?

And dammit, if you do it and have a good reason to do this despite
literally *decades* of me telling people not to do that, and why it's
wrong, then  you can spend the five minutes *explaining* why you do
something that is widely documented to be bad.

These commits sure as hell weren't in linux-next either.

                   Linus
