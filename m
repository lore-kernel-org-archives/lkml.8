Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6A5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 10:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 026A9206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 10:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lj0c4vLN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgFKKk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 06:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgFKKkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 06:40:24 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA66C08C5C1;
        Thu, 11 Jun 2020 03:40:23 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 9so6314692ljv.5;
        Thu, 11 Jun 2020 03:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dz3aUaUs54r2lsiJR4IRURryLwMtxeGK9xCbr4LAEjs=;
        b=Lj0c4vLNMOILvwONQPphC+4IWkhT1L9qMgviyXpd/CSOH7tNBlMvB47R2+gBXo/cLi
         WAUzTMODWBgUSO1rH/IJZV5p3EtOHu1VbyGIuQQ2yKGMoyJV8tSGuE+NwsgyerUPftsU
         a92q0w/5rZh3YHY+IRb7CZSKtHY1cNnOK7XKTc3R5Dso3tgQTBwquk1AAT5xpXy1v+WI
         lYuyy+iDWeQt9LBUNSVl8I4hnAgiLq4Yk2lq82GfcAAY1A0rATen6v62CbjD4hYDqaG+
         m/UBDaIqU0Y15F8Okc7py/kzHVi63pJypCmXM4IUsNq70nYKMlLRaXtkR47HafUH6MDC
         YEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dz3aUaUs54r2lsiJR4IRURryLwMtxeGK9xCbr4LAEjs=;
        b=EpvVMchwCKpCnH+SAkXIMdqReK4jpuxNQDLb6UZp7Ytv1LP6nNarhlP1uf/Nr37uFi
         v7IvQ3FqnicObKVY8sNjqX3mFjA0wZhnSbcSR6BqGz5fl5GVMTbUU/z1Vx55n+epNuC1
         txTjnUNXKbxKxtvpRV4/qLnrrQlYyOLNL76tIC3QC/55C7bDmHmjwPcwnfT7s5WYDBTV
         ne7Sz+zG2uz8usfTgAOJNeiCSlqLgp/Xni/HsO+2N68ZqCVPSnbw0bHSbwVzN8OrKQRM
         Lv2WAmttki9qoVf5HLZ/w9T88+BeVFBtPF2GD37kJZ6k4DwTru0u9Rt/AGNygUJK+FY5
         bX6Q==
X-Gm-Message-State: AOAM533HdieS7oD/KfZOzGGwVbIIjQm4Tr3bWn3ic7vwDOgbvMxCPMT1
        QXaRyBlwk1lbmHopkVk1icfpdUaK3WgyF0tXm2k=
X-Google-Smtp-Source: ABdhPJx7LKPXrQ+PO8el4oa2cUBLNY4uhdZlrykXXpsvthU6lYBRzWmLPQmCXDml+PgXy5kN2ysl/PPfyR9GMp427fM=
X-Received: by 2002:a2e:9e86:: with SMTP id f6mr3637491ljk.95.1591872022118;
 Thu, 11 Jun 2020 03:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200609201241.81518-1-grandmaster@al2klimov.de>
 <4235548.LvFx2qVVIh@harkonnen> <cd260d03-27a4-7794-f58f-21e8e0be9755@al2klimov.de>
 <202006102009.CB14D7F@keescook> <8ee16c38-e28b-b4e6-ed30-55a59e216b49@al2klimov.de>
In-Reply-To: <8ee16c38-e28b-b4e6-ed30-55a59e216b49@al2klimov.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 11 Jun 2020 12:40:11 +0200
Message-ID: <CANiq72n50OVRtFAQkAmqjaj=dJTP9VqYYHN7++8O_t4cbfaJgw@mail.gmail.com>
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: Documentation/translations/it_IT
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Jacob Huisman <jacobhuisman@kernelthusiast.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 9:02 AM Alexander A. Klimov
<grandmaster@al2klimov.de> wrote:
>
> Is any of you familiar with Golang?

Don't worry about that! I'd expect seasoned C programmers to be able
to read Go (or near languages) -- at least to have a general idea of
what an algorithm does.

It is not APL, after all :-)

>
> @Maintainers Would any of you actually review like this? If yes, is the
> pseudo-code not enough?

Well, Kees already mentioned he would like to see it :-) As he said,
it is usually the way for bulk patches to present the
algorithm/semantic patch/etc. that was used.

It is also useful to have it around so that it can be reused/reapplied
later on, too.

> I didn't log that link-by-link. Maybe because I also didn't follow plain
> HTTP redirects while opening HTTPS links. Maybe it even matched, but was
> added after I made the changes.

It would be nice to have a list of links which cannot be converted,
since nowadays they are likely to be the exception rather than the
rule.

> * Linus *didn't even respond* (at least I didn't receive anything) to my
> catch-them-all patch at all, not even like please not as .gz attachment
> or please split by subsystem

Please take into account that LKML volume is huge and Linus (like
everybody else) only reads a small subset. Further, as a general rule,
Linus shouldn't be picking individual patches to begin with because
that skips the review tree.

Cheers,
Miguel
