Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BE1C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54DB120719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="wrz5U+Ks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgCZVHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:07:16 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52564 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgCZVHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 17:07:16 -0400
Received: by mail-pj1-f65.google.com with SMTP id ng8so2990186pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 14:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=8rtaFDP8GcbTj75WszhswVptWti542U0uRqtEvpMYC0=;
        b=wrz5U+KszfyvzOwAYp3Gf18jn/Xeao85K4yJb8urPG+rm1TTTkZllKhGv5h2WHufR7
         ymbUM3O+u5VWMWfUq5OO47Nhq50DZrHzqwooB+iF+gcZScTh9H0domCk00wWi0Hrc1ch
         FeBbo8o+ZAFAr9W6VKSQy4lGNJCaWC5cnrCztMOIN5E3D/9nyZ9Yw0rhrthbkT+b6Fk6
         Be2Xy4iid0n6O+2y3Q6/XsMiUC0gG8TX4sE448AHs8nyY2waDMQBkgLL+jp7ZmGRYGF7
         roJPR5Zxxvgs1ZTzHgqi2dOujPvltZ5YqaDWnYjMLArpaMhqQvYdhLoyEu1RmX1soPlO
         XXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=8rtaFDP8GcbTj75WszhswVptWti542U0uRqtEvpMYC0=;
        b=HG0n5CkRbodRRpCTkPYfl/K+RdwQSt4zO2VkIxuk6ajEBgXOzJpnmb/dT0ETc0PwPh
         yKtcglE4B3+WQ3jOBzVU1LncMbfdlyTDXxFP/hZuLrYiy5ageE49Yb9OeqkmjGfptikI
         uhdxksmxIAun8WMEFAH0ZNPcgq9suU3f8Myi/f6Jzf8kylMkbsobveXIQ6S/pd4x1dfg
         NkaHAtUfrLAhmOpbnh5c3nXEbgcINy8GQ6ZYaS3IMreItUc+otO5ERetBgc/nFe2Ye9h
         Labc6A8OgjU3Oi08ssrqBOtUdTeOgA2V0HYMEj3xaJKCepADdimAge/hGyKFpXokdoiW
         Fbtg==
X-Gm-Message-State: ANhLgQ30FDn47v2bJ731X3zAHkLkLISz3XkD6IHU61aLgJjsqBj+VbX1
        lGFzpIjKiTjz1JQUE+PW33A+uw==
X-Google-Smtp-Source: ADFU+vs/gQt7DwnC89BguUGR8gw6uoQQFuwimrUa4QgFnh3ARc6uPbXH4A7q5Ab/5x4QvwGqzjCkSg==
X-Received: by 2002:a17:90a:4809:: with SMTP id a9mr2118171pjh.73.1585256833989;
        Thu, 26 Mar 2020 14:07:13 -0700 (PDT)
Received: from ?IPv6:2600:1010:b02d:4a43:b951:4512:59f9:ba7d? ([2600:1010:b02d:4a43:b951:4512:59f9:ba7d])
        by smtp.gmail.com with ESMTPSA id y9sm2537232pfo.135.2020.03.26.14.07.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 14:07:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 00/12] x86: Trenchboot secure late launch Linux kernel support
Date:   Thu, 26 Mar 2020 14:07:10 -0700
Message-Id: <BB670F86-9362-4A8C-8BE6-64A5AF9537A7@amacapital.net>
References: <CACdnJusd7m-c0zLmAjSq9Sb9HxyCkhyyp5W=4FMdysgu7_g=Sw@mail.gmail.com>
Cc:     Daniel Kiper <daniel.kiper@oracle.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-doc@vger.kernel.org, dpsmith@apertussolutions.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        trenchboot-devel@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>, leif@nuviainc.com,
        eric.snowberg@oracle.com, piotr.krol@3mdeb.com,
        krystian.hebel@3mdeb.com, michal.zygowski@3mdeb.com,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        andrew.cooper3@citrix.com
In-Reply-To: <CACdnJusd7m-c0zLmAjSq9Sb9HxyCkhyyp5W=4FMdysgu7_g=Sw@mail.gmail.com>
To:     Matthew Garrett <mjg59@google.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 26, 2020, at 1:40 PM, Matthew Garrett <mjg59@google.com> wrote:
>=20
> =EF=BB=BFOn Thu, Mar 26, 2020 at 1:33 PM Andy Lutomirski <luto@amacapital.=
net> wrote:
>> As a straw-man approach: make the rule that we never call EFI after secur=
e launch. Instead we write out any firmware variables that we want to change=
 on disk somewhere.  When we want to commit those changes, we reboot, commit=
 the changes, and re-launch. Or we deactivate the kernel kexec-style, seal t=
he image against PCRs, blow away PCRs, call EFI, relaunch, unseal the PCRs, a=
nd continue on our merry way.
>=20
> That breaks the memory overwrite protection code, where a variable is
> set at boot and cleared on a controlled reboot.

Can you elaborate?  I=E2=80=99m not familiar with this.

> We'd also need to read
> every variable and pass those values to the kernel in some way so the
> read interfaces still work.

Indeed.

> Some platforms may also expect to be able
> to use the EFI reboot call.

Reboot is easy-ish: idle all APs, zero all but one page of text and the page=
 tables, and call reboot. There aren=E2=80=99t any secrets that need to stay=
 in memory when rebooting.


> As for the second approach - how would we
> verify that the EFI code hadn't modified any user pages? Those
> wouldn't be measured during the second secure launch. If we're calling
> the code at runtime then I think we need to assert that it's trusted.

Maybe you=E2=80=99re misunderstanding my suggestion.  I=E2=80=99m suggesting=
 that we hibernate the whole running system to memory (more like kexec jump t=
han hibernate) and authenticated-encrypt the whole thing (including user mem=
ory) with a PCR-sealed key. We jump to a stub that zaps PCRs does EFI calls.=
 Then we re-launch and decrypt memory.

Kind of like S3 implementation wise too except with an encryption step.  And=
 if we support secure launch and S3 together we probably have to implement t=
his.

>=20
>> I=E2=80=99m not sure how SMM fits in to this whole mess.
>=20
> SMM's basically an unsolved problem, which makes the whole DRTM
> approach somewhat questionable unless you include the whole firmware
> in the TCB, which is kind of what we're trying to get away from.
>=20
>> If we insist on allowing EFI calls and SMM, then we may be able to *measu=
re* our exposure to potentially malicious firmware, but we can=E2=80=99t eli=
minate it. I personally trust OEM firmware about as far as I can throw it.
