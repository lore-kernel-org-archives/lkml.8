Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03E3C2BA1B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C2D233F8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586187964;
	bh=TuYK1/4o6ZZ/fyaixxDzEKaiwpsGT3vCUO+eNOmZytQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=12oXQEHtyIV5gyWhSh/KUv3gTfAFtDqwhn2USDGwCAyTQKylORrjVDyI4e6BJ92Vo
	 wkFU/WV17T2tWZR6Y25W/Uu8s7qSZaBK4IaYGidhAgK82CYVwJcy4xEcNESJrJD5Ql
	 JGI6QUhn4BlO5R2VsldToyYSddrSkUPrSgh+Zc9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbgDFPqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 11:46:03 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42865 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbgDFPqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 11:46:03 -0400
Received: by mail-lf1-f66.google.com with SMTP id s13so12227249lfb.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 08:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LM6NO7u4VQbW1lu00t+WWOxSqJndpnDnuJ4jQghzPUE=;
        b=ATtWeB7TwKV6tUS3q6yFJi1J5lOkwm97vHKEGbXjnLuGfMid4PPhCTZgQ2vsCOmNGU
         RiYbV8tKrIQdoH02NJrHKlPaJ1z+Gg/umexn+w7pNGlqbGfueHwbmEnhwW50uiV+P6Xe
         tzqpk2+YAxnZ96b7z/etLmw36EArLqaTVor5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LM6NO7u4VQbW1lu00t+WWOxSqJndpnDnuJ4jQghzPUE=;
        b=fbl5dG3ylW4lDfpjOiDXAbAv+QJyyIrrRT/HsyN9odUkEEhGukhpUCg4dSVbVpaWPH
         Sf7pwcHi3aYmeyrB5xLMvfeqtGJUcbXXtuTm2NHpb8a2EUC5qrC0nXEhWN7qfg14I+p9
         BQmipPtRkMPWYzSvRn6kqlcwsEhK6Ay9UyK05rOkaZPnUJeCE9gsBQiUfwPzzv/5F/kR
         334SSBvIm6k7sFyi6IyZA4eBHKXqR6YYtekcPbNoMxAM+HE04bJ8BbO6z0QFis3B+jz6
         evm0aKnEKERBsULeHRhB4LSrASPrkqGTLzs9m6Fglvu39uIjSJZKd7L+guxpxTZIQBgK
         9fuw==
X-Gm-Message-State: AGi0PuYWKVBClG1OgCfHiLpFA+xmCaS1LgE0nAhDqJiOf6v2wBLHowaT
        pV7N1KgMQiuNRNCTcOwxLnIsglx1JXA=
X-Google-Smtp-Source: APiQypLxSoHqktx6TtA4bZvn+J6duXrjq/RMFemgijEb5CuwDcrWcfFUVfchENFIyYfaJxXtTr6Nkw==
X-Received: by 2002:a19:ef0e:: with SMTP id n14mr13437453lfh.61.1586187958938;
        Mon, 06 Apr 2020 08:45:58 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 6sm11795698lft.83.2020.04.06.08.45.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 08:45:58 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id p10so210990ljn.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 08:45:57 -0700 (PDT)
X-Received: by 2002:a2e:8911:: with SMTP id d17mr12856259lji.16.1586187957613;
 Mon, 06 Apr 2020 08:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200406144032.GU23230@ZenIV.linux.org.uk>
In-Reply-To: <20200406144032.GU23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Apr 2020 08:45:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2UALsz8=R54WLGzhz8mGqzMnKqV1E=SaFOETYhrjYYg@mail.gmail.com>
Message-ID: <CAHk-=wj2UALsz8=R54WLGzhz8mGqzMnKqV1E=SaFOETYhrjYYg@mail.gmail.com>
Subject: Re: [git pull] regression fix in namei
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 7:40 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Dumb braino in legitimize_path()...

Well, the type system can't help us because the types are the same,
but I do wonder if at least the naming couldn't have been slightly
more explicit. "mseq" vs "seq" is a bit subtle.

I guess this is mostly a one-time conversion issue, so not worth
trying to worry about any more, but that internal interface does look
like it's ripe for mistakes.

              Linus
