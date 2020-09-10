Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B7DC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5121520BED
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VrdgTAIU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgIJTLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgIJTGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 15:06:21 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16713C06179E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 12:06:08 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id x77so4214452lfa.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 12:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1VaKTVNQG/MS4VikQREyIs4KXpzJcL7hR40l97tZdj0=;
        b=VrdgTAIURoCk9FvstPzXIWoDxbgN9o0EAGwgNgOl+kp3kj+fHQ7bEn+5pylmp58MjZ
         4F7I4q5nDLYkUCrr3rIv1XGnkTi8udCCbOVF7r13QTf9HXmphW+SDTBAph6TCuwHrY4M
         9cCUFLnGVOQL8VJ4F7iR7YuIW6YFqwp3GcL7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1VaKTVNQG/MS4VikQREyIs4KXpzJcL7hR40l97tZdj0=;
        b=QYfjiQvmLh4+EbGzxTUSxzQm5pPk2DrTZHDZPX+iqBh+PDRts/zKN14sMf7x9oD7+o
         1+2AO7YCX50fpV9HHVKaB3dYCCMHsauCxKGQuFerygomSEdwFTK4/rqwSmW8K6+DwKEm
         1c551WUruGIH+C3CLOwxxa4kkfuUsNLBOWZdihMynan6PgDVShvD9HwvPsyXAqoTmSQe
         TcTgiNDQjDeLnhHzVe3uxpCkarw6+d7HNuiU3t0ClYQMfZ+aV4GaT6gdHh96vooRRuuG
         TG4CueFLpxa56z4qntciZk5YSD53JFfFu3O/Uw8JWcmIQ/zswKtmRYPr/3wSx39p81aB
         5RIA==
X-Gm-Message-State: AOAM530kRJwoUGrwylfdenjxirRV8Gta0XDvfLvz/v8iRMy6YhgcC//j
        8qGY9A3pk3WJw1pEdS6pKK1rrmg67/dAbA==
X-Google-Smtp-Source: ABdhPJy7yr0KYMQNFI0JOPa+hft7ZmJ7fZUuBOVDiMTafwXU0Gtnh/ojCz8DrV+u0beGOACvWFZedA==
X-Received: by 2002:ac2:4e82:: with SMTP id o2mr5094786lfr.170.1599764765346;
        Thu, 10 Sep 2020 12:06:05 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id a1sm1815393ljb.64.2020.09.10.12.06.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 12:06:04 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id a15so9658943ljk.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 12:06:04 -0700 (PDT)
X-Received: by 2002:a2e:b704:: with SMTP id j4mr4966232ljo.329.1599764763554;
 Thu, 10 Sep 2020 12:06:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200910112701.13853-1-linux@rasmusvillemoes.dk> <CAK7LNARE6NpCYAd7=--m-oO8_LweBWhP2aWfSRdTz=TX8dM5rw@mail.gmail.com>
In-Reply-To: <CAK7LNARE6NpCYAd7=--m-oO8_LweBWhP2aWfSRdTz=TX8dM5rw@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 10 Sep 2020 12:05:51 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOuK=iCdzWbtc+aRhBy=8xy860XqxwJg+wFuQaXKfg3UQ@mail.gmail.com>
Message-ID: <CA+ASDXOuK=iCdzWbtc+aRhBy=8xy860XqxwJg+wFuQaXKfg3UQ@mail.gmail.com>
Subject: Re: [PATCH] scripts/setlocalversion: make git describe output more reliable
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 7:35 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> On Thu, Sep 10, 2020 at 8:57 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
> > So in order to avoid `uname -a` output relying on such random details
> > of the build environment which are rather hard to ensure are
> > consistent between developers and buildbots, use an explicit
> > --abbrev=15 option (and for consistency, also use rev-parse --short=15
> > for the unlikely case of no signed tags being usable).

For the patch:

Reviewed-by: Brian Norris <briannorris@chromium.org>

> I agree that any randomness should be avoided.
>
> My question is, do we need 15-digits?
...
> So, I think the conflict happens
> only when we have two commits that start with the same 7-digits
> in the _same_ release. Is this correct?

For the rev-parse usage ("unlikely case where we have no signed tag"),
the total number of objects is definitely relevant, and the man-page
says:
"unique prefix with at least length characters"
i.e., it might be longer, if needed for uniqueness.

For git-describe (the case where we have a tag to base off):
"use <n> digits, or as many digits as needed to form a unique object name"
I'm not quite sure whether the uniqueness is including anything about
the tag-relative prefix, but if not, then we have the same problem.

At least, that's my reading of the situation.

Brian
