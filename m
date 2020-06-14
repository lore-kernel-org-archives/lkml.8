Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6191DC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 19:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4139820739
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 19:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lsz5EOC7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgFNTMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 15:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgFNTMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 15:12:54 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257CEC08C5C2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 12:12:53 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id w16so14575192ejj.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 12:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MrLddIkcot8tNQvLVw0AtZLgQi2l5giGkwxDkf5jFnc=;
        b=Lsz5EOC7hGOW3kxIqpRHQK9XYomqtcYtwkxyKDnKHLrGTno3HnIozqjt8oQ0rd90aa
         m3vQZ0CA2ghaSZPkK1dHC/xQnqR1ZxnqoFuTQr4c7fmX5nH0oymvG1jyRUNw+stxbpqO
         2WmWDCtVGHJxYPR8xfXEcuAaBH6CsokuEgAEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MrLddIkcot8tNQvLVw0AtZLgQi2l5giGkwxDkf5jFnc=;
        b=tMcM8/6xjIhxU61k0avBzLT3WqFZjbo70uk1N+jHaaDLGBAcFUWW4VcbLoO5AfxdU+
         4pKNI9KgiVqwvxxwwWmFpUYct/yf7wcs+QTndSGFyKtYlpOwCHSrP9Bcqyhb5ehAmZpt
         jVDOURtzYOohbArfupFjqflJD9CfLjJGORGzXQ5yO89A31M2SQE9tUQUkBVxoSzZPCyr
         ZRuJh/eIeIIf4EOhqJ/yxY39AdXb7KHQvR435Q7qY5jYSZkeJkFFBboNmLT2mlZWP1JC
         R7vYkh89Z1U1JnRTe7M2gbnqifUfENQFp90wbZJzk/fOa6+TiIiVnLJ2xNYBH3SmNsum
         CKEA==
X-Gm-Message-State: AOAM531Mi9MmAbFSoC6e7owGcIgDaYknQyZY/e8FrDJj8em/jGkB8Onp
        bWEuUsLTho15ek+nXVhX3dfpZUHIrHDXT6nUo07y/w==
X-Google-Smtp-Source: ABdhPJxpSt8E/kV4o2MEhoil4h5Nijfxto783DKTZtexB+8uLOfIJGg0jA34qWrwtLfgvxi0lPizqI23J/L6G2zHstw=
X-Received: by 2002:a17:906:7e50:: with SMTP id z16mr23294118ejr.277.1592161971719;
 Sun, 14 Jun 2020 12:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccOy4qDpbfrP5=KH40LSOx1F4-ciY2=hFv_c+goUHLJ6PQ@mail.gmail.com>
 <CAHk-=wiLXXR1+o4VAuw5MM3V1D8h6C6te3y8VMvW8iAJw6noJg@mail.gmail.com>
 <CAJ-EccPGQ62yMK1Nmvie4qWzproSqb4POwAD4_0Nt62KLbGhqg@mail.gmail.com> <CAHk-=whZz_E+Bu1L6YTxtDQu_piBjUBoULW7vkKxNux54kwFAA@mail.gmail.com>
In-Reply-To: <CAHk-=whZz_E+Bu1L6YTxtDQu_piBjUBoULW7vkKxNux54kwFAA@mail.gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Sun, 14 Jun 2020 12:12:40 -0700
Message-ID: <CAJ-EccP-MW3MZ3n=u-CoPD1nL73paLUSP3v5dQu+iiQLAtaZfQ@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID LSM changes for v5.8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 14, 2020 at 11:39 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Jun 14, 2020 at 11:04 AM Micah Morton <mortonm@chromium.org> wrot=
e:
> >
> > I amended the author on the lone commit in this pull request. For some
> > reason I was thinking using the "From:" line in the commit body was
> > how I should make things show up as Thomas as the author and me as the
> > committer, but looks like that=E2=80=99s not true.
>
> That's how we do things in email, since you want a separate author for
> the emailed patch than from the author of the email itself.
>
> But git itself very much has that difference between "author" and
> "committer" internally, and all the usual email application tools will
> take the separate "From:" line from the email, and make that be the
> author in git.

Ah makes sense, thanks!

>
> (And then the sign-off chain is where we describe the whole path,
> because git only has the concept of those two end-points: the original
> author, and the final committer, but no concept of the path in between
> the two, nor does it have the concept of the copyright and license
> agreement implications of the sign-offs).
>
> > I also removed my own Signed-off-by line from the pull request body
> > and included it in the commit instead of the Reviewed-by line.
>
> Good. You will get credit for the pull request in the merge commit
> itself as a "Pull xyz from Micah Morton", so that path of history gets
> encoded that way.
>
> But the sign-off chain is supposed to be there for each individual commit=
.
>
> (I don't always notice those things, but afaik there is automation in
> place in -next that should warn about commits with incomplete sign-off
> chains. Did that not trigger for some reason in this case?).

This change hasn't had any bake time in linux-next. I didn't deem it
sufficiently risky or complex to warrant such integration testing.

That said I'm a little fuzzy on where to draw the line for which kinds
of changes really should be required to have bake time in -next. If
you think this is one of those cases, we can hold off on this until we
have some bake time for v5.9.

Either way this is a good reminder for the v5.9 merge window when we
plan to have more featureful changes going in for SafeSetID (although
those will be completely internal to the LSM, so low chance of
breaking anything outside the module).

>
>                   Linus
