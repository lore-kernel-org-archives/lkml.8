Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3BAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 10:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1107220721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 10:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgEUKbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 06:31:53 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:56471 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgEUKbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 06:31:52 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MVMNF-1jRW2T0fNn-00SMTz for <linux-kernel@vger.kernel.org>; Thu, 21 May
 2020 12:31:50 +0200
Received: by mail-qt1-f178.google.com with SMTP id v4so5064288qte.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 03:31:49 -0700 (PDT)
X-Gm-Message-State: AOAM533Z57TNnwl/J4/kriK/3tIwGaGtKiKOEqi202qIL8P/rtB/3y6g
        ejCo3Xkts8WInmPIyWR9k1NNU2qf6UA1+hurCYQ=
X-Google-Smtp-Source: ABdhPJwchc6f5+9k206SLSnfoFenzvhxDbq6spSQmMaQz2Elq2egNsF2fR59Bs9Mydr7En0Lzg2n4asxBiotUtGD9yc=
X-Received: by 2002:aed:2441:: with SMTP id s1mr9921937qtc.304.1590057109012;
 Thu, 21 May 2020 03:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200518091222.27467-1-sudeep.holla@arm.com> <158999823818.135150.13263761266508812198.b4-ty@kernel.org>
 <CAK8P3a0bx2eOFSqM7ihNkJBWU_KKSh0vGJZZdvpkH=1nppingw@mail.gmail.com>
 <20200521070629.GB1131@bogus> <CAK8P3a1h1MR4Mq2sSV_FDUodrfaKRFtyOuOOGPWAbPYbzjc4YQ@mail.gmail.com>
 <20200521075755.GA4668@willie-the-truck> <20200521081055.GD1131@bogus>
 <CAK8P3a3dV0B26XE3oFQGTFf8EWV0AHoLudNtpSSB_t+pCfkOkQ@mail.gmail.com> <20200521101422.GO1551@shell.armlinux.org.uk>
In-Reply-To: <20200521101422.GO1551@shell.armlinux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 May 2020 12:31:32 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3cPPiprEpF_k-GWAgWSZiP3Qp3v++jvS_8W17Ns4_HGw@mail.gmail.com>
Message-ID: <CAK8P3a3cPPiprEpF_k-GWAgWSZiP3Qp3v++jvS_8W17Ns4_HGw@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] firmware: smccc: Add basic SMCCC v1.2 +
 ARCH_SOC_ID support
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steven Price <steven.price@arm.com>, harb@amperecomputing.com,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:5QEY1jlnWSAcO6isBmAiH/9bRt7OMve8PYThQnbaPI0W8GV5wH4
 ZZUkI3q413DxNPpFlwglYLxLwbSf54eAO08AsT7HIB/37caTNUxCtKLRpI05Za423g/KoL2
 yJRpj4H3tOR9dtlZM30tVXu+Mk5waeOpXuPeHh/8/+YTAjH7s9m7MfTv91PHrafdd9R7zMT
 Zd7qTtK3gTe7js9z/Vz1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EldDG6czeqU=:2rFrIWMYPM+OTUi1TrbETw
 LZEmTNaVLtLeePFFpOf0tahsMnJTqUsQsm037ZBT8cnGJvK+sNsSY3qh1fjYYwTL/6KrpXbmY
 LU/RZydiSsc5n1RYyS+WOi/pWXoOZr1gfM2OchKw4BnFysQTQZOYNfJf4Apil0llRZcOUyvvz
 l1ScT8e/jZW80h7PtrJUmaLZIx+hb+gPw9qgqtSTU3HFycCi4u9rntVkJte4lcO1F9EbYVYjD
 v/I34xJRLjqzoEH2yBbcRFZfM/+h9uXQMnr1ODNNLVPo/i4AQZZNLHFXYP0tGwz9Rr5IF5t7A
 z8qg427POp5vLo3g6CEjL8s7TR/icHK7BGwCkqTUvKgBALlzSfS92rzlUtPzD/t/FjLgEz38y
 sMPi/Q7oNauFAI+/0H4eXiRbkB7JhLImMYwruWqHyBktyz4vrHnEsJMF2iIACsNikIHs/k9W3
 DtYi0X7uG2RV1DVWK5jix400K93ekA/nNqnsZkUoM82n3xL7xIjfKj75jkpl3PTTWp92k2XxP
 pVYqR4gzojk76Oz+3qm0wKzMxLYp46LYTftKQt0jgKL/2dWVkvQuB/cGcNdid9G4FjbGklxYX
 M3UTxeYA1w1RZsHf4xavEVv2wXXKhSP1M6j3A3B9Vzg/kpdgrF5+7zZ2CBzgODJ+lYqTxONy8
 a9flxjQ/YdxHiIuDXj9ApRPgJliB+rH69yC2hbj3XTQeLklD7aA/6sAmD2KFjrMKe6EMR4u6i
 d0O+2M6S4kIZZ6fjLe0ND+aSVpnfCz6uCDB4gOAzBbmceE3Xx0sosnxBa4ubboxdZb6US2Ew9
 DXRFtDZWz3DwsqEENSegWVf1BkjxNqClnjAmZ6lZ1awzua2t3Q=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 12:14 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Thu, May 21, 2020 at 11:06:23AM +0200, Arnd Bergmann wrote:
> > Note that the warning should come up for either W=1 or C=1, and I also
> > think that
> > new code should generally be written sparse-clean and have no warnings with
> > 'make C=1' as a rule.
>
> No, absolutely not, that's a stupid idea, there are corner cases
> where hiding a sparse warning is the wrong thing to do.  Look at
> many of the cases in fs/ for example.
>
> See https://lkml.org/lkml/2004/9/12/249 which should make anyone
> who sees a use of __force in some random code stop and question
> why it is there, and whether it is actually correct, or just there
> to hide a sparse warning.
>
> Remember, sparse is there to warn that something isn't quite right,
> and the view taken is, if it isn't right, then we don't "cast the
> warning away" with __force, even if we intend not to fix the code
> immediately.
>
> So, going for "sparse-clean" is actually not correct. Going for
> "no unnecessary warnings" is.
>
> And don't think what I've said above doesn't happen; I've rejected
> patches from people who've gone around trying to fix every sparse
> warning that they see by throwing __force incorrectly at it.
>
> The thing is, if you hide all the warnings, even for incorrect code,
> then sparse becomes completely useless to identify where things in
> the code are not quite correct.

Adding __force is almost always the wrong solution, and I explictly
was not talking about existing code here where changing it would
risk introducing bugs or require bad hacks.

However, when writing a new driver, sparse warnings usually
indicate that you are doing something wrong that is better addressed
by doing something different that does not involve adding __force.

      Arnd
