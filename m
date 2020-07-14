Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F47CC433EB
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 00:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 688112082F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 00:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YokhtjvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgGNAbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 20:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbgGNAbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 20:31:49 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1824DC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 17:31:49 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id s26so6798233pfm.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 17:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gXbjibloex9Ej+zvMmkc1BuBo3R6ne3Ak5/Lh9pJjV8=;
        b=YokhtjvWK5lS/sLfJ5xhsRSh6IyLiPfnYDAiHCG56+ILQFhx9HodQ8MWRyOBrygjg6
         Ox+sFg7dDJyoeMhkOKW0KkYsxpdn2kicIZAMbqcKGjCm+SUDb+sUWv33QXGJIKgi1FUK
         XAEeKRVde/NYaJUz2Wi2YuE23xPdfJOH09m0t1ls/WXIntS2mgqptA5EBfLLOgS1OIWY
         nISJBjgHgayBa8IgE6TEcUAamvNwOdlGioge1s40u7eaz+d0geDtD5TTAeNYAOeLjEVX
         i3HDT0DYZO7Vy2CBrKGjvlS2ujXV+C4oZ5S9eISyRVQFHpe8+CpXxD8dhPPKiQMgyXGY
         Wmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gXbjibloex9Ej+zvMmkc1BuBo3R6ne3Ak5/Lh9pJjV8=;
        b=H6ckuHErjDPtvZCns/iDf7OjBwUVT/h0laIMAMBf5qPmts1WpBrGEha7DAHa4ypTVQ
         nDV18wnpSUVVqo9ufev30ktAAMWAzlBjjHT7rv4uHAiWdbmd3B1Nn3d7jKraxmm4J+ks
         jUI0AqBHGbJOXiD7rIsWZDBwm5foSCzlTuXIcfOhgrET7nJ62AwKaASYuwu1LegillLI
         E1b5xFrj2Et+PQMe9sMB4IBkabiSSP+tqYYKgesLCbnLm7tEnex81bs+LU3A7N41oYNm
         MlSza1TKEXrCVF23gYodzjWCkM7/0dnesuY+ggR9OCNyiydUAMB670kFH24btI/r4ggT
         UeQw==
X-Gm-Message-State: AOAM531Z4OKBWvkdJbbdyRKhSvecA3ZUE37dWprSh68tVPaKhDQDO15F
        4bqT3RCiGBwEhaafQbN11be/QHCdDr5XlDvNIEK2wQ==
X-Google-Smtp-Source: ABdhPJwExx/+v0HQ9UujXzN1qS0hhiTOr3T+GdPLLocygye0pnHmYcbCEi3LFrpV1Yt0tZaXf3m5wy9zruYKvYx2p3w=
X-Received: by 2002:aa7:9303:: with SMTP id 3mr2091857pfj.108.1594686708106;
 Mon, 13 Jul 2020 17:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200530221127.459704-1-brgerst@gmail.com> <CAKwvOdn7Ugu_687b9CnOnL8RA9hbi+ONCb10gS=3VqtkTsmduw@mail.gmail.com>
 <CAKwvOdm4gMe_-DcB_H4mDGm8Yy++_7G20sg9xuZoom-rF2j1Sw@mail.gmail.com>
 <CAKwvOdmGtZtqF5f-5x0n4GNCWLOnrk2r6e3X2XHGmoOL7f7u0g@mail.gmail.com>
 <CAHk-=winDAeDTAe33QVoRvTJELMDjQpYPqSPcNwSk+SwPrav=g@mail.gmail.com> <CAKwvOdmsap8iB+H5JXiHYwSJFrtQ_krjNH7eQCGe7p-LjK7ftA@mail.gmail.com>
In-Reply-To: <CAKwvOdmsap8iB+H5JXiHYwSJFrtQ_krjNH7eQCGe7p-LjK7ftA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 13 Jul 2020 17:31:35 -0700
Message-ID: <CAKwvOdm4Pc6J8_SurAwgHhG2bY7rALaUXo=fSeCLom+nSPw+4w@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] x86: Clean up percpu operations
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>,
        Dmitry Golovin <dima@golovin.in>,
        Alistair Delva <adelva@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 3:58 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Jul 13, 2020 at 3:40 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Mon, Jul 13, 2020 at 3:24 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > Otherwise, is there any additional feedback on this series or is it good to go?
> >
> > I've lost sight of the series. I'm sure it is fine, but maybe you can
> > resend it to me (in private, if it's already been going out on the
> > mailing lists and everybody else is completely fed up with it).
>
> Is there a fast way that maintainters amend ACKs to each commit in a series?

For future travelers (more so myself, since I don't sync my shell
history between machines, and I'm a big fan of aggressively sharing
knowledge. See also the section "Information as Power" and the
anecdote about tank manuals:
https://www.meforum.org/441/why-arabs-lose-wars). `b4` has a pretty
cool feature.  When I was fetching this series, it was warning:
```
NOTE: Some trailers were sent to the cover letter:
      Tested-by: Nick Desaulniers <ndesaulniers@google.com>
      Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
      Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
NOTE: Rerun with -t to apply them to all patches
```
So I did:
```
$ b4 am -t https://lore.kernel.org/lkml/CAKwvOdmsap8iB+H5JXiHYwSJFrtQ_krjNH7eQCGe7p-LjK7ftA@mail.gmail.com/T/\#t
-o - | git am
$ git filter-branch -f --msg-filter 'cat - && echo "Signed-off-by:
Nick Desaulniers <ndesaulniers@google.com>"" $@";' HEAD~10..HEAD

>
> >
> > And no, pointing to the "plus this hunk" with a web link isn't what I
> > was looking for ;)
>
> So you're not accepting pull requests yet on github? I jest.

Actually, looks like a lot of merged PRs come from github!  Grizzly
Adams *did* have a beard! https://www.youtube.com/watch?v=pdwJC9HvKLU

Sent as a series of emails via:
$ git format-patch -o linus_i386 HEAD~11
$ git send-email --to="Linus Torvalds <torvalds@linux-foundation.org>"
--suppress-cc=all linus_i386

Though, I'm sure a pull request would have been more formal.
-- 
Thanks,
~Nick Desaulniers
