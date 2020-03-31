Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D37C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCCC206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o3zehxjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731117AbgCaQCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:02:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38056 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730286AbgCaQCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:02:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id c21so9871147pfo.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 09:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eZXXG443uKpSgfNEJ0dEluZmkv04301vNY8sTrH9njo=;
        b=o3zehxjmag5NakEZfFg2RqsjIVFQbAr+Hr142Z/jaWpzD9M9pV55Ec6CyR8+WtYyNj
         zJEShpo6DAxWY0maP0Xrkt76nMtW6ucnH/4pQ1CpiUpIiu+ywNAjKuA8Elnq7L4qwQUu
         MbcTePJ2DxRo1GtsWqIi74HsVCfTb+K/DhueZVyIKCP3bppxBYeImYRF4dpqOcPwdMgG
         NsLBacY7UPqGdcdMa7uDMrZ6PlW67aqPb+yf98FlKfC2EeVKg/d4JtAqY264r0NI0R8U
         uMJAowrGvTxrqmYc614/RlhbEOQhYy+eylmncvKQPrYPEOtt0flq5i0P4nAMPttkTbw+
         2klA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eZXXG443uKpSgfNEJ0dEluZmkv04301vNY8sTrH9njo=;
        b=s8cjFE7LOVdSq73xSsaGM9c6LV8IUZxrFuhkVAQV6D9e09GZ5fO8Se9EsIzv0qudg9
         fLxToGvtXoB6KbWAWcj7OvFsh0pW0bfTG+fgaP0Xy6R4r2EiSPtbof7a50Tve3Z/YnIb
         c7TRglM/95loapoG7EguAvcwywHbeYy4WmMWIgwRSkT+Vlc072KERsiSnwK40HHf9H2f
         AVSKq2u/mNnrARmGxUV1XBE8hbbarXo3o2uhsBDcrAsJDHx0ejXmjCF8BsEuMgpTqVKn
         gRU/8tdLjMu+fOtDaXwzjUMmOpUn9AKblvZgwA+ti9ex3gv/kdwoBMA4deSxCeio0YrD
         TP2w==
X-Gm-Message-State: AGi0PubXPo3lKdNEqiiQr8NgIkkXk6cEDQT/lZgGlElFkoPWZw1w7nne
        f4IntkO1jknmpb365h055Xv70Mb+Pb4DmxEQvIRS3A==
X-Google-Smtp-Source: APiQypKTUIgSCVTCzjJmedQpID1qg/aVFr9Kah3/bPpP/Wb+lalxGGDeco9c06qITTHZkr7RMLAO4TtzxWyduyG/tMQ=
X-Received: by 2002:aa7:919a:: with SMTP id x26mr15382467pfa.39.1585670551606;
 Tue, 31 Mar 2020 09:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200326194155.29107-1-natechancellor@gmail.com>
 <CAK7LNAQ8uHtuhd7DiGGOLbkEX524rPjfUuWAHjU-_92Ow3_1Pg@mail.gmail.com> <20200331101122.GA6292@ubuntu-m2-xlarge-x86>
In-Reply-To: <20200331101122.GA6292@ubuntu-m2-xlarge-x86>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 31 Mar 2020 09:02:19 -0700
Message-ID: <CAKwvOdkkpnkLwtNctSnebXTwumfprEQtLiuM5_4e-UBFTYBUxg@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: Enable -Wtautological-compare
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 3:11 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
> Just a follow up, those two patches have been picked up and should be in
> this coming release:
>
> https://git.kernel.org/balbi/usb/c/58582220d2d34228e5a1e1585e41b735713988bb
> https://git.kernel.org/rostedt/linux-trace/c/bf2cbe044da275021b2de5917240411a19e5c50d
>
> As of next-20200331, with the former applied (because it is not there
> yet) along with this patch, I see no warnings on arm, arm64, x86_64
> all{mod,yes}config.

kbuild test robot is testing more arch's than that with Clang so it
may report if it finds more instances of that warning in those.

-- 
Thanks,
~Nick Desaulniers
