Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9822C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FAA212CC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585681914;
	bh=QZgMPYXMhvs+dSRPByWsoxSmYBKfYHN9ck8j3d4jbFk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xHZH4v+PskC5p2avPQvxbrpOYlYSDwEzWoJUBd0Ox75nYrdwRnx2gEh9hr071rui0
	 FTUUl0SBfYFEUzN8FR3mhTkc97Cf9dCyANzH+2JA2WSks51Ibkngf9kW/JA66pG6G5
	 YTllTzMHwDyDLiEKeAstEhBgPEgt9IQnpvsb767g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgCaTLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:11:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40723 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgCaTLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:11:53 -0400
Received: by mail-lj1-f196.google.com with SMTP id 19so23172184ljj.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 12:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mIpylwyiRjL29X7CX/c0xTRukBTeFJKPllq5utn9uOA=;
        b=AVaJMvho7ivjU0W8YZXIako+kNuDi5IZTa6u4Z20f/RS7jqAfm1xIKfpAML9PM7jsN
         w3kbrs6fLUkUcc8HXpMvVoYyscn/QPwusQDlQEiGgm1JaCUTjN0vZ+WFP0ZBr+d/VzYy
         V9WQeuiPPS96Zvrebk9xM/jA0dki669UGlUx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mIpylwyiRjL29X7CX/c0xTRukBTeFJKPllq5utn9uOA=;
        b=AwP3asI1r1Koe3GAQP5tX4YURCXkzz+STheabRCZJn8AiiBNYCVqgLgHUs7I7QQ/+2
         4GAnHN8Af6nbsGemk0yE/ROSsTZwZC6bzuZl0ssTiK3UeHBrozIrlvJw5AvoC4o7i+/L
         waCIP1YEFNbNxSvpzg5jMlhQ68GG6laDOGrBPgi8Hwery57twBDnDlerZ2rqIpTMeWZe
         wWVi46TMr7z/369U7kb5bxUY2uZi0Ha84fJnlwWWUk4OD4Vj20Im4ppj94jz8in4sW3O
         iC6yDzj53FAmR1rMwBiDs44Sgb1QKRyllQsFy7sAUhATeceI4ZrP9B6rbbpmLFYGTS7o
         kgXQ==
X-Gm-Message-State: AGi0PuaU1hhb4Ez8qfW+H4NyNuJdl7Az8EIfC6b2B2GQ7KE/+qWvlJzr
        WAxDHrpxtV4QGzmgR66slP8Q1lzWvZA=
X-Google-Smtp-Source: APiQypIQ0LCa1iv24BaMrTEoEgaUtiNV+ofVLA6xExw3EvXFl5p/wFTTGoT0eTJb0t5og7VE75Rycw==
X-Received: by 2002:a2e:96c4:: with SMTP id d4mr3294611ljj.19.1585681907106;
        Tue, 31 Mar 2020 12:11:47 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id b1sm5624292lfb.22.2020.03.31.12.11.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 12:11:46 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id v4so18246362lfo.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 12:11:46 -0700 (PDT)
X-Received: by 2002:ac2:46d3:: with SMTP id p19mr6607736lfo.125.1585681905605;
 Tue, 31 Mar 2020 12:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200331100353.GA37509@gmail.com>
In-Reply-To: <20200331100353.GA37509@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 31 Mar 2020 12:11:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wim0vZMxgxmu=eW4pCqExbcJqswEvK=VYuyqkB-40koTg@mail.gmail.com>
Message-ID: <CAHk-=wim0vZMxgxmu=eW4pCqExbcJqswEvK=VYuyqkB-40koTg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/vmware changes for v5.7
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of this series from Ingo pulled.

Looks fine so far, my only reaction is that "Ho humm, now Ingo is the
main -tip user who doesn't sign his pull requests". Both Thomas and
Borislav have started doing so.

Ingo? It shouldn't be that much extra work, it's an added "git tag
-s". You can even automate it, and just make the tag-name be the
branch name plus a date/time thing, and it will probably fit in
whatever scripting you do now.

Yeah, it does result in that password prompt, so it's not _entirely_
invisible, although that might be minimized with pgp-agent.

I know you have a key, since I have it in my chain. Of course, the key
I have for you is from 2011, maybe you've lost it.

I'd love to be at the point where all the major pulls I do are signed.

But no, this still isn't a requirement for kernel.org users, more of a
"please consider it".

Thanks,
                Linus

On Tue, Mar 31, 2020 at 3:03 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> Linus,
>
> Please pull the latest x86-vmware-for-linus git tree from:
...
