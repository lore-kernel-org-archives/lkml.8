Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD09C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 18:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B17B92075E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 18:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587322634;
	bh=ni/0eH/ywrWNJYnXGyTZz5JCXad2CkPYSASARUPMfww=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Wiyve3RwA7rrkEhu6nP+LHGw5pjxGv+bQmLLMYt69e0lGAq5XWx5FLEnqJPyyJQav
	 zDakEsN9NEeHXkC6oi1EA0DiPZIRekrmeaMrjvk9fvvDy6qdVZZPUKH0/iYsy1Y1PD
	 BWOsv0bXib3I+SqJy0wqgIkfy+NPdQouh6lnEm18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgDSS5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 14:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgDSS5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 14:57:13 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8799FC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 11:57:11 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id y4so7499784ljn.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 11:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IQGFf6GUXaELxVhxsKDlcjcN7pBxRsCXh1fLZmXh3rA=;
        b=OwaplmH3qWX8NOVhuFz70qe/hsZ6v6ofCS6EtfOX1dNsiQ0Ht8SSXw2qD3NUFRO6WD
         Oqn5rlSqPGOjjTF+uHg0o50i+j/ng3BOfjz/nHIXDJY+dQSrxoVpRqlM2hWzN0coOI10
         RLGiZOnTJCWGsg2Jz2MIducCE4wiocHUx1FYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IQGFf6GUXaELxVhxsKDlcjcN7pBxRsCXh1fLZmXh3rA=;
        b=CAqc62cdHS0os2tJItiaMElMFw0/RNKBmBR00lEvIg1J00nPx6w2SW1zX04je5Yhjf
         CRlG1BBp3gvoTkR15aL1ePq3pWyj05TzNHsTzlOClwoE2hzXiHRgRrKwXAWSu+6phDwI
         vf4ZK96AXkQwsiPBbDKbYSrUifVcmRjLG1lx4rw9TiCCREx3RwaQeSwwC7MRut7gdJEJ
         qk/HgY7LQVXX37YI2NWfkI3PDUzpOwQ0i3PmEL43aN48B2e8LIUzxTYg6Ieuih3mcUFE
         uYPEvsTP1+JuT2nXsUs0/rgjuZnA2lQtPhpK0q72IFIj+PYmd3NBhKTANxBK9TF4E/5s
         PKEw==
X-Gm-Message-State: AGi0PuZ3LgoiOiPhyJjcKftQAe0Llyv8H72Uk/D7w7fqBnGzT+J2pTH6
        avcQWMUazPPzfmUUt2z9RBxhqmnLcHQ=
X-Google-Smtp-Source: APiQypKrXe0FjbAwk6bErrCBvhWCae2xE3eD4glhVJjYZO0Xl2lLvUmsw952FettVUfpNWOiZK1NCQ==
X-Received: by 2002:a05:651c:48a:: with SMTP id s10mr7524250ljc.226.1587322629290;
        Sun, 19 Apr 2020 11:57:09 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id q22sm20284822ljp.105.2020.04.19.11.57.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 11:57:07 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id n6so4156380ljg.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 11:57:07 -0700 (PDT)
X-Received: by 2002:a2e:b619:: with SMTP id r25mr8215701ljn.150.1587322626804;
 Sun, 19 Apr 2020 11:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <158730459860.31269.9496277256253823777.tglx@nanos.tec.linutronix.de>
 <158730460101.31269.5005570498545135614.tglx@nanos.tec.linutronix.de>
In-Reply-To: <158730460101.31269.5005570498545135614.tglx@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Apr 2020 11:56:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjUS9b-B1n=OCBdqq3mdVTNGz0zqhGnrtMijoB5qT+96g@mail.gmail.com>
Message-ID: <CAHk-=wjUS9b-B1n=OCBdqq3mdVTNGz0zqhGnrtMijoB5qT+96g@mail.gmail.com>
Subject: Re: [GIT pull] perf/urgent for 5.7-rc2
To:     Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 19, 2020 at 6:57 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> please pull the latest perf/urgent branch from:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-04-19

So this one took me by surprise, because it only touched the 'tools'
subdirectory for the perf tool, and then when I did what I thought
would be a trivial test build, it re-built the whole kernel.

And that made me go "Whaa?!?"

After looking at it for a while (longer than I really want to admit),
I realized that it's because the headers are also shared with objtool,
and it all kind of made sense.

I say "kind of" because I would have wished that objtool wouldn't
necessarily rebuild everything.

So I'm wondering if there any way that objtool could be run at
link-time (and archive time) rather than force a re-build of all the
object files from source?

This is not a huge deal, it's not like the occasional full rebuild is
_that_ big of a problem, but since I was surprised, I thought I'd
ask..

              Linus
