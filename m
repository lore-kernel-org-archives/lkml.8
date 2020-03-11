Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E33C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A024D21655
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="byWNOnaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgCKKqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 06:46:24 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33788 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgCKKqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 06:46:24 -0400
Received: by mail-qt1-f193.google.com with SMTP id d22so1183246qtn.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 03:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q8RSBQ1awf7J0+pbXujt6gnSJdQq7hBnAow/IoAFi0c=;
        b=byWNOnaBSpcX4NgglDMaAl/iu/+Se3lc7hoi0h+nNEWULQmNMK1lsgjxTzb82gp/VF
         5cJCyhQrSwzYySv1MAkIjiotOuSnlZY1qtUV8cX5+o7aPYgFXBbgO1WCcDTn0gWrgmxI
         1cGW9tx0SckKW9lrIHfxte/TacXzDe/6zNeA8LjEEUWUVFUgehnf7irKNs3/piBl5Te3
         r8HV5dSUvdYp0qFBuXosUVXhlewJ4EBkzJxGHxrn1IdlERUO26R0Sa4U01MSYYOXqRsE
         a9ItxmXAH+fbjeibEqTPho121UE/eTz8r/SHy2CMuzJfodDlCXCO+eD2/Nb6kpl3Ge+2
         xi/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q8RSBQ1awf7J0+pbXujt6gnSJdQq7hBnAow/IoAFi0c=;
        b=FPbL79z2hDACWjRZ467zEFuakJflx79FOt25EP0HNO1K9BqTOV4oxaaGOSbmr4P4QE
         KwCGEYscnVofX0o2rvyWATKZeRYA/ZDCw4qZbpTyRpz417hmrqfxgQWJ1Hi99S+uTDIx
         WW07hrKmEokt+qPQ9X3MXr6NOpi+yJhlgrQIPwmsQMCAL4JA86zSsKabVIHdPAr7a0Nt
         /9O+a5ZU0GRBapv/81bIQCsDrzzxvbu/ePMYUJdz9xswVKTtE3pV0WqbhSc6RSfHPZxs
         mgy+pxpVB6hlWFgGCbIFeKi3l2+nzw+vaz4P4jlYBE+FVPEsf7WaAW+CZi+PHMjx2i9A
         tjBA==
X-Gm-Message-State: ANhLgQ3C3AzsxCSkqoESgDUfUVKKIOZljy2TEgKJG1b3rfZmP+rl6+at
        j8g2PhkVGurSeQmxtAjTMamEcXjkUvPb9TcTbpuAbA==
X-Google-Smtp-Source: ADFU+vvPq796XwuNZCzNOH45PgR6QT2y52wU+cBX8IJQOGhpAaAOnl3rh8/h047At8I49vKAmG414LX/0zWfixX7xJQ=
X-Received: by 2002:ac8:6697:: with SMTP id d23mr1966498qtp.257.1583923582471;
 Wed, 11 Mar 2020 03:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200226004608.8128-1-trishalfonso@google.com>
 <CAKFsvULd7w21T_nEn8QiofQGMovFBmi94dq2W_-DOjxf5oD-=w@mail.gmail.com> <4b8c1696f658b4c6c393956734d580593b55c4c0.camel@sipsolutions.net>
In-Reply-To: <4b8c1696f658b4c6c393956734d580593b55c4c0.camel@sipsolutions.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 11 Mar 2020 11:46:10 +0100
Message-ID: <CACT4Y+ZypjEidZQ6E8ajY1yBU6XA2t6eVz56sJ1JaBjCniRMUQ@mail.gmail.com>
Subject: Re: [PATCH] UML: add support for KASAN under x86_64
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 11:32 AM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> Hi,
>
> > Hi all, I just want to bump this so we can get all the comments while
> > this is still fresh in everyone's minds. I would love if some UML
> > maintainers could give their thoughts!
>
> I'm not the maintainer, and I don't know where Richard is, but I just
> tried with the test_kasan.ko module, and that seems to work. Did you
> test that too? I was surprised to see this because you said you didn't
> test modules, but surely this would've been the easiest way?
>
> Anyway, as expected, stack (and of course alloca) OOB access is not
> detected right now, but otherwise it seems great.
>
> Here's the log:
> https://p.sipsolutions.net/ca9b4157776110fe.txt
>
> I'll repost my module init thing as a proper patch then, I guess.
>
>
> I do see issues with modules though, e.g.
> https://p.sipsolutions.net/1a2df5f65d885937.txt
>
> where we seem to get some real confusion when lockdep is storing the
> stack trace??
>
> And https://p.sipsolutions.net/9a97e8f68d8d24b7.txt, where something
> convinces ASAN that an address is a user address (it might even be
> right?) and it disallows kernel access to it?

Please pass these reports via scripts/decode_stacktrace.sh to add line
numbers (or any other symbolization script). What is the base
revision?
Hard to analyze without line numbers.

> Also, do you have any intention to work on the stack later? For me,
> enabling that doesn't even report any issues, it just hangs at 'boot'.
>
> johannes
>
