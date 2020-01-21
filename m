Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4254FC33CAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 21:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D9F24653
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 21:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckrjIxG7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgAUVLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 16:11:39 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33966 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgAUVLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 16:11:39 -0500
Received: by mail-ot1-f67.google.com with SMTP id a15so4342608otf.1;
        Tue, 21 Jan 2020 13:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vbYnFtSV7P55A+Hcn9+5BPe8w8FZVi5oIFLwqhXqdqE=;
        b=ckrjIxG7IMhIM3XSxTUmaUbqKeb3b5zq6j5/jldlzpEkSt7SQiD7moJom9c/0BCHUc
         TdTIW84Oqd6EPXM4txIqk3n5xvsQn9Bm+OEIhoQ1NjqRSo+5w39Q8pMUerZsz3jVarL+
         c0QHOvILzbEoTPlF4on8AwbtxsRdUmvuDinhve8gG4JROBWIoRHINn6w6hhKW4k0hFup
         biTxFRJd4Szq7RuXQcj+HPDfGjFWttHDhDERAg0Jiz3WnrnTdEZNN+2R6mjPMg9yzqyq
         W/n1R3NdJ4iSLYORd9Tq+20KE4RrL47QsWomOZTbFSunB/4PAx5Jvi1DVwe+7QQQHCZ5
         miFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vbYnFtSV7P55A+Hcn9+5BPe8w8FZVi5oIFLwqhXqdqE=;
        b=M7H4L6LWLY1I+8TKmcyBXoK8mrMurpZogzDO16A4X9O+Ax43sSOVDlL667h04GaKFR
         cEB35l6PHX/SYSO3fRI8wlr2GcI7/CKZi0QLy/f7QmTQIS1Rl18AyddYiv66zopUxt3/
         51kPJxpTJUkapkmuUlHB6bsVDxx5/H+F3F4/qUTryUlhvYw1MGzkA8BtdRmNChQlLnds
         R6bPneHn7D1PMwlrJEqh8l68Hz95GdHPBS4JguhEh5fX+/Ef1CyZEC8sv2hW2MDM+jbx
         sCvTRc6gmykXaYAaPmZMCgpE/dhN1CTkFPClWyju7gDewbdFf+/6EEfOaTUoNOqncsy9
         JskA==
X-Gm-Message-State: APjAAAWXuaJdnQ/cxSRVJ5qNB2i5K8r/FZCVM8Rn0zgWTR+puU+JM6qV
        65NU5WMoNeIDeS0YaIno4FPK4WUUS4QjSyY3TNM=
X-Google-Smtp-Source: APXvYqzbJ9qP3++wzEBiVIoeCdGaKJgJC76vfmRXBZrtkxmGB4r6uPC6vqq1Q7xHLWy9ykOyPTvCL08xHLKe+qPA5oU=
X-Received: by 2002:a9d:70d9:: with SMTP id w25mr5216661otj.231.1579641097958;
 Tue, 21 Jan 2020 13:11:37 -0800 (PST)
MIME-Version: 1.0
References: <20200115171736.16994-1-christian.brauner@ubuntu.com>
 <CANaxB-wOJCc_Z3YXiokMeTLi2=rPf0-=7-bwAJnEjX-bDvTPEg@mail.gmail.com>
 <20200118011701.ciqiuutgyyvtk5a4@wittgenstein> <20200118124653.k7exqcu4fyojd63e@wittgenstein>
In-Reply-To: <20200118124653.k7exqcu4fyojd63e@wittgenstein>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Tue, 21 Jan 2020 13:11:26 -0800
Message-ID: <CANaxB-xD31cx8yfH-JnLS4n8Ta9Teka_GO9fhchODv8gAizc0Q@mail.gmail.com>
Subject: Re: [PATCH] ptrace: reintroduce usage of subjective credentials in ptrace_has_cap()
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Serge Hallyn <shallyn@cisco.com>, Jann Horn <jannh@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Eric Paris <eparis@redhat.com>, stable@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <adrian@lisas.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 18, 2020 at 4:47 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:

> > > The criu process is started with all capabilities in the root user namespace.
> > >
> > > I don't have time to investigate this issue right now, will provide
> > > more details next Tuesday.
> >
> > Yeah, we've detected the issue. security_capable() indicates success by
> > returning 0 for whatever reason whereas has_ns_capability() returns 1.
> > So the logic was inverted. This is fixed in the new version. Sorry for
> > the noise!
>
> So, I just finished compiling criu and running the test suite on the
> criu-dev branch. The test-suite passes fine after the security_capable()
> braino in my original patch was corrected to security_capable() == 0:
>
> ################## ALL TEST(S) PASSED (TOTAL 178/SKIPPED 16) ###################

Thank you for doing this! Not all CRIU contributors can run all tests. You rock!

>
> Thanks!
> Christian
