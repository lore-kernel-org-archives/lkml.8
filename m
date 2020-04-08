Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD04C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B272074F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AtfViQT1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgDHJsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 05:48:52 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43590 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgDHJsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 05:48:51 -0400
Received: by mail-lj1-f193.google.com with SMTP id g27so6872835ljn.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 02:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eEezST1RXJ88ybnVOwFKxlJ6+MPqHS1LvuVkjRbNDs4=;
        b=AtfViQT1klZEFep9wTrnlBNvl75uK2hyUO/WqUNRXSA41ipnxHC6/JdTZ3LZ2pYsiD
         aVWUeYmPUfXymIYFRcLAfKqAtXhxI+0x8F71hJj3VwT8OA2db3sAhZcSKfJdwPs33Jdm
         ebi6utBvs/stkR0zNal8RJLdCUJdcqw56v97JaMJ4h1bgaiSQAzOSbUGbLJ+c5tQnb2f
         gp6kz/XUdx2fc8Nq4gRN9GAzGAtdlLOEChwhCUBlQ5q6OMPNHqw2tKWqI2YcCq8exhku
         4UumWQGM+wUD+m2N6hhQYDG5WC9E5o0NH2k0LGeMMn6+O0BGBEeEQugb4L+3crwWu09L
         a/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eEezST1RXJ88ybnVOwFKxlJ6+MPqHS1LvuVkjRbNDs4=;
        b=K8Mn+cLezrkfyXcHDjAPL93BR6i67lbwW05mi6EF0UsRrKIre7qUFiHR2QMfFeijb9
         kz07WF5KiI9Q9sqHxvFmZc3iVFVay6ZDe9+4hev0y55/CUplolZ+R8beRgr8AkdkzEKB
         wdCd9VpYO1rQhSN04Nbvx7z+ljxeQpr/McuwpzmuKr0NNWBr7p+NrfeB0ZioUBii9vOL
         dVYfAsn0gXICUu20QBAET+KYV14X0jdxFGJdShA9PMNRQ7fmiNQmEV0jHRBTlc4yOHyo
         huO6e0IxLVPSEt6BbqK9QJcFjlj9ZVxXWsrQV6cwkRzHxzNbeUaaT6ze5PPTtis4Tf9R
         eW3g==
X-Gm-Message-State: AGi0PuatEBA7VJTx+7l/QvJN8xtQg0KG5Y/gFNn8VZFqXbaJqlnftB3Y
        354syK9gILWQeprWu4rJkKjAmotibmzniZ4IHfkujQ==
X-Google-Smtp-Source: APiQypKzRT3tjcthaIy1IYrParD4m/MJGtYTGgck/20gGjrf0nKgcCSDB9gBB+Pbu1aw6GTj8C+5BqYtxFna/wpkfJg=
X-Received: by 2002:a2e:5048:: with SMTP id v8mr4074814ljd.99.1586339328475;
 Wed, 08 Apr 2020 02:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200318205337.16279-1-sashal@kernel.org> <20200318205337.16279-30-sashal@kernel.org>
 <CAG48ez1pzF76DpPWoAwDkXLJ01w8Swe=obBrNoBWr=iGTbH7-g@mail.gmail.com>
In-Reply-To: <CAG48ez1pzF76DpPWoAwDkXLJ01w8Swe=obBrNoBWr=iGTbH7-g@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 8 Apr 2020 11:48:22 +0200
Message-ID: <CAG48ez29d-JJOw8XMp1Z=7sDj8Kvmt+9KXC9-ux-0OBhUP02Xg@mail.gmail.com>
Subject: backport request for 3.16 [was: Re: [PATCH AUTOSEL 5.4 30/73] futex:
 Fix inode life-time issue]
To:     stable <stable@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@Ben: You'll probably also want to take these two into the next 3.16 release.

Sorry, I forgot that 3.16 has a different maintainer...

On Mon, Mar 23, 2020 at 8:18 PM Jann Horn <jannh@google.com> wrote:
>
> On Wed, Mar 18, 2020 at 9:54 PM Sasha Levin <sashal@kernel.org> wrote:
> >
> > From: Peter Zijlstra <peterz@infradead.org>
> >
> > [ Upstream commit 8019ad13ef7f64be44d4f892af9c840179009254 ]
> >
> > As reported by Jann, ihold() does not in fact guarantee inode
> > persistence. And instead of making it so, replace the usage of inode
> > pointers with a per boot, machine wide, unique inode identifier.
> >
> > This sequence number is global, but shared (file backed) futexes are
> > rare enough that this should not become a performance issue.
>
> Please also take this patch, together with
> 8d67743653dce5a0e7aa500fcccb237cde7ad88e "futex: Unbreak futex
> hashing", into the older stable branches. This has to go all the way
> back; as far as I can tell, the bug already existed at the beginning
> of git history.
