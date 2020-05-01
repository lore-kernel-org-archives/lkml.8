Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33544C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 01:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F97220787
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 01:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="ZLa2+csE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgEABKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 21:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727114AbgEABKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 21:10:12 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBB7C035495
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 18:10:11 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id h12so4179236pjz.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 18:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=k15OpOeoQ3rmzh87tU7V+M2stfR65Ddwc7t7jeSZ6rI=;
        b=ZLa2+csE7C3ftsRmz/3+xOMLvS/uMepf5whKkn8d0OzfNoAxs3NYCmP/f16enqaROD
         JXZtPTYe1UyUJ/8SMeBi91XE6HWT6NlMiR35fFnnS7pvY3G7mtAEbbz5XTC/gox9CeWD
         eiReEYv/wwrQc3YopVZRokis2rX/nm1PfgdSC4RCTLPAgTawOYwjMf5cvk1BtVdwvXJ8
         uGNOUfjzRolRhppVNHd4kWTxIHehl5ULT1jNZb1WnV7sL9d3eiUzPkPD4f6tnuQ14q06
         +fnZlk8TLV+1KRT0DC5j0jC9LPU+s7Jmfx/bn3uiN2FV8qzlbJXUjdcVZKGkx7i8RNOE
         URiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=k15OpOeoQ3rmzh87tU7V+M2stfR65Ddwc7t7jeSZ6rI=;
        b=glIRZQtDfdXfNGkVpDZyhARwadgYRgj9Tf6gKWJ5t+wWxXMVzYOKSvu8T4ihIBn9T7
         PP33exeGqQcwADxTnD2CPfrMKw7AdmskQDv1SFg0tnuMMrEmoqOmjlsmz3wq8IVpzKja
         M8KO4bHRBg8miZJmqZeeAXGk0ITB54dZk611uDHJSs/oRPs3b5gl28KpI3rcMnb4BLfu
         GrS6WZ2brSirhz+EkYq6w4Uw8DDKMFJupphqv165CsZ4/1beEDc9u7nMc0VqAm/3AzID
         VzKmFxOSws1/4epTngNQ8Rv7yxLTXF+RUct8XH6OnCuzICyc+mfRPYzoy2uSJWfBum6l
         mj+Q==
X-Gm-Message-State: AGi0PuaBlzpoYBiST5fMvrN0YaPNVkYTZQknFtcxtfo3bREV487rHsXZ
        SVWRw7Q/lFv+dgUKsxZ4X8aK9g==
X-Google-Smtp-Source: APiQypLTNhaQKdhVNhLmaUuI3eQ6yUGYMyMvnDjWA4wLYl43Zk7iNftpbdYKFJfHjKaWZp+OVuHDLQ==
X-Received: by 2002:a17:90a:2526:: with SMTP id j35mr1791482pje.98.1588295411228;
        Thu, 30 Apr 2020 18:10:11 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:d495:581b:d692:e814? ([2601:646:c200:1ef2:d495:581b:d692:e814])
        by smtp.gmail.com with ESMTPSA id y13sm818856pfc.78.2020.04.30.18.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 18:10:10 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
Date:   Thu, 30 Apr 2020 18:10:08 -0700
Message-Id: <1AA57F55-0361-4230-82B3-B432C40C0DBC@amacapital.net>
References: <CAHk-=wgeMRm_yhb_fwvmgdaPMYzgXY01cYvw5htHUCTwSzswqg@mail.gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        stable <stable@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Erwin Tsaur <erwin.tsaur@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <CAHk-=wgeMRm_yhb_fwvmgdaPMYzgXY01cYvw5htHUCTwSzswqg@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: iPhone Mail (17E262)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 30, 2020, at 5:40 PM, Linus Torvalds <torvalds@linux-foundation.org=
> wrote:
>=20
> =EF=BB=BFOn Thu, Apr 30, 2020 at 5:23 PM Andy Lutomirski <luto@amacapital.=
net> wrote:
>>=20
>>> But anyway, I don't hate something like "copy_to_user_fallible()"
>>> conceptually. The naming needs to be fixed, in that "user" can always
>>> take a fault, so it's the _source_ that can fault, not the "user"
>>> part.
>>=20
>> I don=E2=80=99t like this.  =E2=80=9Cuser=E2=80=9D already implied that b=
asically anything can be wrong with the memory
>=20
> Maybe I didn't explain.
>=20
> "user" already implies faulting. We agree.
>=20
> And since we by definition cannot know what the user has mapped into
> user space, *every* normal copy_to_user() has to be able to handle
> whatever faults that throws at us.
>=20
> The reason I dislike "copy_to_user_fallible()" is that the user side
> already has that 'fallible".
>=20
> If it's the _source_ being "fallible" (it really needs a better name -
> I will not call it just "f") then it should be "copy_f_to_user()".
>=20
> That would be ok.
>=20
> So "copy_f_to_user()" makes sense. But "copy_to_user_f()" does not.
> That puts the "f" on the "user", which we already know can fault.
>=20
> See what I want in the name? I want the name to say which side can
> cause problems!

We are in violent agreement. I=E2=80=99m moderately confident that I never s=
uggested copy_from_user_f(). We appear to agree completely.

