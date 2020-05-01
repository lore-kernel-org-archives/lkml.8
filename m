Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750A6C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 05:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27D222073E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 05:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588311259;
	bh=SZo3DVsZ0TuxJuX2Z5shMnylT7+yzknrxW3MToG5NxQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=usTcSabiCF9sC3+CFsgjOO/a71uY3udgNeo7Em3Z7kbc6v1OOCAVpvbpVgP9Xajh6
	 IqL+swPz8eb6AHtXBMM2Omrn+BIsdkuhFf+BG8nOa4MKOglWpwV2FpVstu7IX6qVHJ
	 tV6VRJIyDm82phdJQGs7PeL8lQM19lxTUxhKLQyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgEAFeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 01:34:18 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:58019 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgEAFeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 01:34:17 -0400
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 0415Xv7h011238;
        Fri, 1 May 2020 14:33:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 0415Xv7h011238
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588311238;
        bh=oOUTjHbglUckIEy8WVvMgD3ZhjrrhESz7wu9wTM0qt8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jPIC9BRAIB9gWJZqCfy5olbgMzB5gtYjxvxZV8vB3/20I/w8YksC++qd7vBvzEYh2
         GsSeFMclrVoYAkD8WZp0qlc+Vt5QAOYHhfjsRAThxSshwDkpgEw+12TwbY0TULiStT
         qh6hnfD+fsDsOgsC8Uj3GgXmkwAVvbDrYWYn8RejYsv1eagVwJaMC0DQ+ThW+57Nqm
         m94prNdcVoeJDpAa9zEcWxJwytj26VVPuBzvJ00iY/v6x2bmW518NNA3g1So15R8yz
         TDZne2D0mkUFepXrZulc9eYmuzAQZuDhoeNNSHAhVaMAjwXsUzDZV8qZbnbgogh62e
         TJxfU16w4E4yQ==
X-Nifty-SrcIP: [209.85.222.43]
Received: by mail-ua1-f43.google.com with SMTP id b6so3411581uak.6;
        Thu, 30 Apr 2020 22:33:58 -0700 (PDT)
X-Gm-Message-State: AGi0PubUFw4YbTpGHwci+bFRfhI7fZ27+FzGl2BWlCe2Y7X6I235wfmG
        v+U+8FEpf+U07m1s2n1S2Z/XTmXhRZXqI3BkY+c=
X-Google-Smtp-Source: APiQypIt+xGZssmIimHEiLPklzB0CvviZARI0GxQsMAFDkLql6zAbzBItxLWUDKzY8bQva8cbq5ggd2pjqqU32QwpLM=
X-Received: by 2002:ab0:7298:: with SMTP id w24mr1787087uao.95.1588311237065;
 Thu, 30 Apr 2020 22:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200424161502.656103-1-masahiroy@kernel.org> <009101d61a6b$71f93a70$55ebaf50$@codeaurora.org>
In-Reply-To: <009101d61a6b$71f93a70$55ebaf50$@codeaurora.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 1 May 2020 14:33:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR+PjvE3yQS7xdKo5Cf_K1xDg+NijistAqWX7Ob=_irWg@mail.gmail.com>
Message-ID: <CAK7LNAR+PjvE3yQS7xdKo5Cf_K1xDg+NijistAqWX7Ob=_irWg@mail.gmail.com>
Subject: Re: [PATCH] hexagon: suppress error message for 'make clean'
To:     bcain@codeaurora.org
Cc:     linux-hexagon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 4:06 AM Brian Cain <bcain@codeaurora.org> wrote:
>
> > -----Original Message-----
> > From: linux-hexagon-owner@vger.kernel.org <linux-hexagon-
> > owner@vger.kernel.org> On Behalf Of Masahiro Yamada
> ...
> > 'make ARCH=hexagon clean' emits an error message as follows:
> >
> >   $ make ARCH=hexagon clean
> >   gcc: error: unrecognized command line option '-G0'
> >
> > You can suppress it by setting the correct CROSS_COMPILE=, but we should
> > not require any compiler for cleaning.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
>
> Acked-by: Brian Cain <bcain@codeaurora.org>

Applied to linux-kbuild. Thanks.


>
> > ---
> >
> >  arch/hexagon/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/hexagon/Makefile b/arch/hexagon/Makefile index
> > 4c5858b80f0e..c168c6980d05 100644
> > --- a/arch/hexagon/Makefile
> > +++ b/arch/hexagon/Makefile
> > @@ -30,7 +30,7 @@ TIR_NAME := r19
> >  KBUILD_CFLAGS += -ffixed-$(TIR_NAME) -
> > DTHREADINFO_REG=$(TIR_NAME) -D__linux__  KBUILD_AFLAGS += -
> > DTHREADINFO_REG=$(TIR_NAME)
> >
> > -LIBGCC := $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
> > +LIBGCC := $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name
> > +2>/dev/null)
> >  libs-y += $(LIBGCC)
> >
> >  head-y := arch/hexagon/kernel/head.o
> > --
> > 2.25.1
>
>


-- 
Best Regards
Masahiro Yamada
