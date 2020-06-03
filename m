Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F334C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 23:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27C8B20678
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 23:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R1yFr4XR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgFCXul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 19:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbgFCXuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 19:50:40 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965F9C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 16:50:40 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x11so1385519plv.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 16:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qWmO3ZI8i34h9spdSprmL/lLpf4pLXBU0GLhND3KfTg=;
        b=R1yFr4XREkxA1bB2hqYvzIUBtxCs1vZIy0cnBVKz0myX5vr3P/GSYKxW0Xa+sf37mP
         /VuUg1uHwTafwgsP+SQzdx7YT4Oasy7xq0+WRj/wTzjO5VNm15xYHBYvMWzFjE6qvg7a
         aZddWLPKSotja6u3++neDjsDBoONFZbpP6+/521zrL+nnkaedJRdwsTDFtLOE9GEs22y
         xgmhLNIk6lcUHuOsUBBO1osiNcfdV30RaJYnnRYb/TmSO7u47lTSB36ogFSjWrbu+bRp
         ati812L7XCvpZchmNPpYHYkmZ8JNtB1/rSBgRaVMEB3nrqDBlDsDEqf0ZQsD9oc6Ns4z
         2lSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qWmO3ZI8i34h9spdSprmL/lLpf4pLXBU0GLhND3KfTg=;
        b=n7Ba845/XLCqeptLcOniVjUpS+Yz2XWlQ8E4mkvqMJgnT6Mh6dcSiFpdBPzNZyuiHc
         kB+ywoUiHzFiLGJyWZCzU2jafeT4Ix1BZqSihEqu8xgUO7MQHQwLfaaBpLlXQBLkJpc6
         q7kzW9NQEoFvU3BTV6siWYKbqcaxl8J4dyEHBLS5xaqvCQ+sqR0ZCG8vH4iZ8gV45dmW
         N5OpzBpQd885SRQRgZiUJi/BUhKegcnW1INfqSAZnUF4aPsfwJcXAa12q5rk2U/Pl4+q
         bhs0isDD5V9mj7FrL2ldkB+SQgOlD+RL+Q22dKp/tE7xizgq4mqVA6NnT0yKeYXRMSqL
         mE3w==
X-Gm-Message-State: AOAM533t7ZbKD9CgFP8pr4QMtxFce/cuxv448U7qk6JBslBkTiIAXvYM
        fTZICxAJjjxzOufKjCqM3XtlPsKYmnQgJDs4ZQXRQg==
X-Google-Smtp-Source: ABdhPJxYMlqmtJr6n44lON3zggDCyc84sr9IzOD/y+VKuFDMECw0ky+AF4mv+pO6Ml+GrQLSEtOgdCnwcZFd1xT+MG0=
X-Received: by 2002:a17:90a:4802:: with SMTP id a2mr2479012pjh.25.1591228239667;
 Wed, 03 Jun 2020 16:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200205005054.k72fuikf6rwrgfe4@google.com> <10e3d362-ec29-3816-88ff-8415d5c78e3b@c-s.fr>
 <20200207064210.GA13125@ubuntu-x2-xlarge-x86>
In-Reply-To: <20200207064210.GA13125@ubuntu-x2-xlarge-x86>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 3 Jun 2020 16:50:27 -0700
Message-ID: <CAKwvOd=JYqzJthPqTjRZkE+8dDKDqVig-nb7=iYDS_UEKn3+Qg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/vdso32: mark __kernel_datapage_offset as STV_PROTECTED
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Fangrui Song <maskray@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 6, 2020 at 10:42 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Wed, Feb 05, 2020 at 07:25:59AM +0100, Christophe Leroy wrote:
> >
> >
> > Le 05/02/2020 =C3=A0 01:50, Fangrui Song a =C3=A9crit :
> > > A PC-relative relocation (R_PPC_REL16_LO in this case) referencing a
> > > preemptible symbol in a -shared link is not allowed.  GNU ld's powerp=
c
> > > port is permissive and allows it [1], but lld will report an error af=
ter
> > > https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/com=
mit/?id=3Dec0895f08f99515194e9fcfe1338becf6f759d38
> >
> > Note that there is a series whose first two patches aim at dropping
> > __kernel_datapage_offset . See
> > https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=3D156045=
 and
> > especially patches https://patchwork.ozlabs.org/patch/1231467/ and
> > https://patchwork.ozlabs.org/patch/1231461/
> >
> > Those patches can be applied independentely of the rest.
> >
> > Christophe
>
> If that is the case, it would be nice if those could be fast tracked to
> 5.6 because as it stands now, all PowerPC builds that were working with
> ld.lld are now broken. Either that or take this patch and rebase that
> series on this one.

So do we still need Fangrui's patch or is it moot?  I'm doing a scrub
of our bug tracker and this issue is still open:
https://github.com/ClangBuiltLinux/linux/issues/851
but it looks like all of our ppc LE targets are linking with LLD just fine
https://travis-ci.com/github/ClangBuiltLinux/continuous-integration/builds/=
169379039
though it sounds like
https://github.com/ClangBuiltLinux/linux/issues/774
may be a blocker?
Though I don't see Cristophe's
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/5f97f7c921ffc2113ad=
a0f32924e409bccc8277a.1580399657.git.christophe.leroy@c-s.fr/
in mainline or -next.  Was the series not accepted?


>
> Cheers,
> Nathan
>
> --
> You received this message because you are subscribed to the Google Groups=
 "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/clang-built-linux/20200207064210.GA13125%40ubuntu-x2-xlarge-x86.



--
Thanks,
~Nick Desaulniers
