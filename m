Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5A8C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF8120714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M6cg4sv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgCZV2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:28:38 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:42521 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgCZV2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 17:28:37 -0400
Received: by mail-il1-f193.google.com with SMTP id f16so6842985ilj.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 14:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Btlqx21eu40zUkcej/V6liXdJs8HK+Dpn/OJAl+X7mA=;
        b=M6cg4sv8ajLQueUJZXq4N/kjX221+tiJF3yQSbWclKBVnWsv+Ff2zDfM6Bxb6emo97
         LQ1F9sPt3GWYLMPIdeL4dgPAXK5i4ESgbkSvjnUj5ytNaBhoyXlsz6x5It7brFjgReOv
         n3MYFBCKdFqDEPs2O4hZKMy8DL1bmo9gMFqgPuJ/hsxgK/RcKyParZEVp1UdPgnkc0NK
         ypUXfY0uVphJ5BknZRjb/x1FhKKT3ZFlCaklkosor2ursaMGsd8dvOP3HzYYhh7Juy2F
         ayKp0BZ7fvweMRKcyB6i+xLNqNgAu+fvFuiwQOPjis10vBxB9LI0i1il4vufxE3hZufc
         TXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Btlqx21eu40zUkcej/V6liXdJs8HK+Dpn/OJAl+X7mA=;
        b=PqGdELvy36ZE27J5vWvvklFP47m+WmETZXbNtWc48J+YdRhQMD+09FVcpgHLpPe8/o
         4358gRnHyMI+6Mqm62WzE6VALp0FZzZ4no51Phca0ZH4Ax93E4EMhaWPUgTzmjg0hGEH
         Omgz9OpUK85j44rsKTO6DdS+lkSvH0yduQ+tYSF5hJr++xO+lGA8trl34H2fYwyFeBt6
         jgwDaqjMRqgtnCRQNxL7e8om0wobBGsMNLn6OVA6YbhWMrBVZy0wn5voS7RazJTwiUbU
         WTfKSlpp2qGU3eyiYiIkAB1vFOqZxNVMVVnAofBFk1uVibR3DU359lLonAENrbSLVq2b
         hFkA==
X-Gm-Message-State: ANhLgQ1Hv0+mlq1DTczhaB3ohEMFVdnfQ4UVNpMrLKLo8leRxXcCD5Uo
        ACdODpWt2LyOG3Pxw6LcOEBsjlC54HmtqHuBQqmFMQ==
X-Google-Smtp-Source: ADFU+vtLzOd32bY6WCTbTFgGTLvCSJZvih2LXQlPgGOADfvm83VghlrezAbG6LvoVKJt3DkATZXqLyP+LNg02NhPwmE=
X-Received: by 2002:a92:8384:: with SMTP id p4mr11224795ilk.16.1585258116250;
 Thu, 26 Mar 2020 14:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <CACdnJusd7m-c0zLmAjSq9Sb9HxyCkhyyp5W=4FMdysgu7_g=Sw@mail.gmail.com>
 <BB670F86-9362-4A8C-8BE6-64A5AF9537A7@amacapital.net>
In-Reply-To: <BB670F86-9362-4A8C-8BE6-64A5AF9537A7@amacapital.net>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 26 Mar 2020 14:28:25 -0700
Message-ID: <CACdnJus6H3LQww8hkTMpPKN7u_sb1PXmgPwQOCSVZR_fi7GMrA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/12] x86: Trenchboot secure late launch Linux kernel support
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Daniel Kiper <daniel.kiper@oracle.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-doc@vger.kernel.org,
        "Daniel P. Smith" <dpsmith@apertussolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        trenchboot-devel@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>, leif@nuviainc.com,
        eric.snowberg@oracle.com, piotr.krol@3mdeb.com,
        krystian.hebel@3mdeb.com, michal.zygowski@3mdeb.com,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        andrew.cooper3@citrix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 2:07 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
> > On Mar 26, 2020, at 1:40 PM, Matthew Garrett <mjg59@google.com> wrote:
> >
> > =EF=BB=BFOn Thu, Mar 26, 2020 at 1:33 PM Andy Lutomirski <luto@amacapit=
al.net> wrote:
> >> As a straw-man approach: make the rule that we never call EFI after se=
cure launch. Instead we write out any firmware variables that we want to ch=
ange on disk somewhere.  When we want to commit those changes, we reboot, c=
ommit the changes, and re-launch. Or we deactivate the kernel kexec-style, =
seal the image against PCRs, blow away PCRs, call EFI, relaunch, unseal the=
 PCRs, and continue on our merry way.
> >
> > That breaks the memory overwrite protection code, where a variable is
> > set at boot and cleared on a controlled reboot.
>
> Can you elaborate?  I=E2=80=99m not familiar with this.

https://trustedcomputinggroup.org/wp-content/uploads/TCG_PlatformResetAttac=
kMitigationSpecification_1.10_published.pdf
- you want to protect in-memory secrets from a physically present
attacker hitting the reset button, booting something else and just
dumping RAM. This is avoided by setting a variable at boot time (in
the boot stub), and then clearing it on reboot once the secrets have
been cleared from RAM. If the variable isn't cleared, the firmware
overwrites all RAM contents before booting anything else.

> > As for the second approach - how would we
> > verify that the EFI code hadn't modified any user pages? Those
> > wouldn't be measured during the second secure launch. If we're calling
> > the code at runtime then I think we need to assert that it's trusted.
>
> Maybe you=E2=80=99re misunderstanding my suggestion.  I=E2=80=99m suggest=
ing that we hibernate the whole running system to memory (more like kexec j=
ump than hibernate) and authenticated-encrypt the whole thing (including us=
er memory) with a PCR-sealed key. We jump to a stub that zaps PCRs does EFI=
 calls. Then we re-launch and decrypt memory.

When you say "re-launch", you mean perform a second secure launch? I
think that would work, as long as we could reconstruct an identical
state to ensure that the PCR17 values matched - and that seems like a
hard problem.
