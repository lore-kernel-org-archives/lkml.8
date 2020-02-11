Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8CFC3B188
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 23:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDDE32082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 23:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JnjsbJjr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgBKXO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 18:14:29 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33193 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbgBKXO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 18:14:27 -0500
Received: by mail-ot1-f68.google.com with SMTP id b18so57978otp.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 15:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XYjvLHVV907LS6rizJ9ULRVH4X6ax5Sri5cvG4NYaz4=;
        b=JnjsbJjrdrrIojmvFgroniN5i1GKnfaaT41kAs8h31h6aBdobmBv21NJ2AzZKmxCBP
         MLWB5g13J5W8UqhsPL3tkNWBlVkv2fMJvtzHJTRoKrnj9kRQm+/c8N2K1xWT2LY/OYSx
         XQxsLHqLwj2HHw5KWDL+QSv1aFa1L0M9vxqJxO/pOlrh3EmVsXzZ3vmQtjazz5j6vTWJ
         SrEXDDoofENJcJjikoZ4j8O+gppW5E/0x+GsaioBQ7qBFCo2QsnV0+RB7feb6mToWr6H
         I9WaclXthNe0rF86nMTezsx9mt6IWT1Ito8+T/DCMoi1KiS9SKlGYu65G9W9mc38TfO+
         p3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XYjvLHVV907LS6rizJ9ULRVH4X6ax5Sri5cvG4NYaz4=;
        b=V102KIMtBcdJ8adDpaFkllq3+YqWpA1447S1VhC+raeKyqLKXH4qAFL2wLloOWxZvW
         hxXCQUc/pdYqIGobtJ6vL611268dhDVsrM1jwponhTDz8cjensTiSXc8IQ6MvTKXQyks
         /Mr0w1eLByi5UNszGOTTLnR19XfIY55Uy+E2q8mN4+qQGhnFMeuAR+yW+mt5Plwnyyzw
         +p5xwr/JDI1eksVqrXBdZInjmey3gwTC6jckUEq8iMUFKZiPJQ+EW0/zjrlFKkRhNc2a
         vC+oDgyhqGJCir8AKfCzpRIH3USYPJ9xzsUxUhmky3gCd2KLxTXmpk4JKzhzP/tHKS5M
         y+pA==
X-Gm-Message-State: APjAAAUr947vPamISAQIeDM9XWxnZhHo1r7uOuS6799kgcLPagg4+jD6
        hy8O4Zulk1t+HRqU4yGzUJNOXzGFjaXo1nRmPQ3JGiva
X-Google-Smtp-Source: APXvYqz9EWpfGLbEs5AK+/WJ0/mxibycFaZAE07fbZ/nDsYp7lqhs+YIUL7BBzfpyAJmBhJC0v6OyQOxX4ZEsV+c4ns=
X-Received: by 2002:a9d:34c:: with SMTP id 70mr42778otv.174.1581462866714;
 Tue, 11 Feb 2020 15:14:26 -0800 (PST)
MIME-Version: 1.0
References: <20200207201856.46070-1-bgeffon@google.com>
In-Reply-To: <20200207201856.46070-1-bgeffon@google.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 11 Feb 2020 15:13:50 -0800
Message-ID: <CAKOZuevHH1pamEKy5n5RLWDP=tHk6_9bR+g3G+HKnqm_srHvrw@mail.gmail.com>
Subject: Re: [PATCH v4] mm: Add MREMAP_DONTUNMAP to mremap().
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 7, 2020 at 12:19 PM Brian Geffon <bgeffon@google.com> wrote:
>
> When remapping an anonymous, private mapping, if MREMAP_DONTUNMAP is
> set, the source mapping will not be removed. Instead it will be
> cleared as if a brand new anonymous, private mapping had been created
> atomically as part of the mremap() call.

The left-behind mapping (the "as if a brand new anonymous, private
mapping" map) is immediately writable, right? If so, we need to
account the additional commit charge. What about making the
left-behind mapping PROT_NONE? This way, we'll still solve the
address-space race in Lokesh's use case (because even a PROT_NONE
mapping reserves address space) but won't incur any additional commit
until someone calls mprotect(PROT_WRITE) on the left-behind mapping.
Imagine having two equal-sized mappings and wanting to use mremap() to
swap them: you can implement this swap by carving off a third region
of address space and making two mremap() calls. But without the
PROT_NONE, you pay additional commit for that third region even if you
don't need it.
