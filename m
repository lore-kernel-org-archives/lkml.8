Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D0FC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 10:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C622206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 10:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoYqHkBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgDFKkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 06:40:40 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34153 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbgDFKkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 06:40:40 -0400
Received: by mail-io1-f68.google.com with SMTP id f3so5162079ioj.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 03:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+wHLle163nkPCKxLaEKL4MOVhBjBpBTiH90GC4QUefI=;
        b=hoYqHkBlAP3yzC6Ax41RDOjWG6bKsaXL4GZTad8hAvcE4NPCiWL49B6lzU4RIygC3c
         hO4AqNj/LR0OqrLfNL1lDb8ANa31FsuCaBSrfSxkxDV4cXX9DHTvOTAqqgVD7e7g7W6r
         MR9LS0yjNYjXCM3oHHLYK7OYdIHt6Be6gTjJUI6GzpTLalpnV2Vfhhujc3aFI0k6ql/N
         D0CtjAPulIY11QdXBktliVIrbQ7oaBT5YJ4gl7DjmsQ49PBZp8Uas6U7spvC5sobzN+n
         b2Mq4OUTj2RZ6yLKqVMCiuXnp1qPvP2wp2LdpiQ1EEmTBlfzwkLkdn577I7UAvB0Bw25
         g0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+wHLle163nkPCKxLaEKL4MOVhBjBpBTiH90GC4QUefI=;
        b=MsBrR4kLxnL+PRF7ig8xQ6Dv0B/bBFlEq8Nob9ekXlZgjCdAjKTj1iqwWDh7ct/Iyd
         LMI710/oNvyC4cN6VCq8LfouW77Zt0pQaMFhNwczroFbkCK5kwC6jQB9PwqrBObcsW4W
         CNxunIOl6w32pMnSf/yTU0K7WSY+FSzXdkLnboYw+E46k4ymK0yn/pO5in8/RSA5noTH
         n4ySXFmPa0VfxydglVf7IRY3QPSFS4ykkfEGyHx1qNE7CT2ioKKGE29aRmJbk/8wZWqI
         nWXiu6NHy1Ux7O2nZpdYLgBkSvlKpHwEiVAin8TyETqlJTJW91W6SiElwH2NugzBtAXn
         pc/A==
X-Gm-Message-State: AGi0PuYS+zBttkt6S86MwnPqqTM0z3GB56PMHU/i4PhuOyAmqcm/4SZP
        pT28bbMlAQSp9hvgHONQvAYmjZp0kFrbqE5t7hU=
X-Google-Smtp-Source: APiQypK+D0ZxNWKyr83bCZwm/3YZVNeBMXaEj+jDxkqWJWTDse5JQhfSnegHQy/MNeoNr/GFyb1ec4efKkthPaHSlho=
X-Received: by 2002:a02:a49a:: with SMTP id d26mr19822230jam.117.1586169639420;
 Mon, 06 Apr 2020 03:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <d4a96597-6704-3030-b936-6282f0994f09@web.de> <CAJRQjofnnhzOp4yis=sL85ESDvNApXHL3dpv6T1NJL-Wh0OOfA@mail.gmail.com>
 <CAOSf1CGLZ5H1cUsv6atZ7hNpQ+PDyyAjp6dzJjXMwC5XoUOVQQ@mail.gmail.com> <d8334f5d-403f-941f-abcc-2714d297082b@web.de>
In-Reply-To: <d8334f5d-403f-941f-abcc-2714d297082b@web.de>
From:   Qiujun Huang <hqjagain@gmail.com>
Date:   Mon, 6 Apr 2020 18:40:25 +0800
Message-ID: <CAJRQjocCfuT4k3fvMvzQ4Yf9RUaybggNGqwYdR9He+XEctcj6g@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc/powernv: add NULL check after kzalloc in opal_add_one_export
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     "Oliver O'Halloran" <oohall@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 6:02 PM Markus Elfring <Markus.Elfring@web.de> wrote=
:
>
> >>>> Here needs a NULL check.
> >> quite obvious?
>
> I suggest to consider another fine-tuning for the wording also around
> such =E2=80=9Cobvious=E2=80=9D programming items.
>
>
> >>> I find this change description questionable
> >>> (despite of a reasonable patch subject).
>
> I got further development concerns.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?id=3Da10c9c710f9ecea87b9f4bbb83=
7467893b4bef01#n129
>
> * Were changes mixed for different issues according to the diff code?
>
> * I find it safer here to split specific changes into separate update ste=
ps
>   for a small patch series.
>
> * Will the addition of the desired null pointer check qualify for
>   the specification of the tag =E2=80=9CFixes=E2=80=9D?
>
>
> >>> Will a patch change log be helpful here?
> >> I realized I should write some change log, and the change log was mean=
ingless.
>
> Will any more adjustments happen for the discussed update suggestion
> after the third patch version?
>
>
> > The changelog is fine IMO. The point of a changelog is to tell a
> > reader doing git archeology why a change happened and this is
> > sufficent for that.
>
> We might stumble on a different understanding for the affected =E2=80=9Cc=
hange logs=E2=80=9D.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?id=3Da10c9c710f9ecea87b9f4bbb83=
7467893b4bef01#n751
>
> Would you like to follow the patch evolution a bit easier?
>
> Regards,
> Markus

Thanks for the reply.
I should study the documentation first.
BTW, happy new week
