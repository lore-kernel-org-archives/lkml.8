Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F00C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BFBB205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="x2IC35Ep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgENPAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 11:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgENPAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 11:00:15 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F18C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 08:00:14 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x2so1416487pfx.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 08:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=LKDhIqkg4dk5I2yUUB4YPd6c5Rk5/qL/3S3piqwGyfk=;
        b=x2IC35EpcFxlDYphsQmsNFlsVgrnCmW3WwfF+86HN8Vu4f4gIl+8CqbVDxTq2+iNgF
         UrOjdI5l3xWeXpO0peEVbLIX+a3DLBpGvc6wFqIX93NJp5Wm6R/lnRETx3hH+UVi7ikL
         3xDZRiYopAj81rMzzpVMBs/hJAcoYsCNns5tLG76h9peIIt22xuQZCVTNN8b3dLuG9Qd
         7rohVQ/rYeO3qh/P2OEUP0QbQcrix3aedQ2+wE3iVo9MQ2O1ssPKldtwXHv4c3WUGOrW
         Gjs1CmG3RA1gCwgo3NHMq53Mc8tma1Cel99g15t1bN+so7bVZOWNMeffS2B+tuFlOjwA
         +wkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=LKDhIqkg4dk5I2yUUB4YPd6c5Rk5/qL/3S3piqwGyfk=;
        b=pVqXh4WPCJjo1BDJuHOWgLAlG8652aVMFTTOlH7QQ91LTvOnJxyRGwYMyWEPQD8deA
         Q4e+rTwbOnNwzHIhqHncVNf56IE/H3dM3Hk+T96ETr9XiRkz/pGwRabRnzQ4H86UDKch
         5Lz1GdvFj3AFaljgP3F/IicfOswDAQPaZbBBFkAFG499sx7d9fkdTLRD7zvkiZTWhMd2
         1++1zK6rHiNZrxOTKPMQH2cL5ZnC9IwxHgruZaego/KaqrvHC/0qFkSVepqilbhXpadQ
         IO1Mym8s2HzArvbTf9afgxvm5rgmzrPqlRrUFCN3TiXAcKlNx38f/VAhL8OBflFhaKdw
         6DTA==
X-Gm-Message-State: AOAM53117REBAqjuJmMO16cipNnle4MDlovDc82k7jVgdP7aKMbdDl63
        wkoOxbTKYALkIeZabhlD0jKgZw==
X-Google-Smtp-Source: ABdhPJyRTSE0r5gMqWqJxmqE4NqOtiMEEKpZVrZdtEsirDOPcCvaAAIa0Y9/QfR2PDuhl2x0DK1r5Q==
X-Received: by 2002:a65:5287:: with SMTP id y7mr4211486pgp.86.1589468414210;
        Thu, 14 May 2020 08:00:14 -0700 (PDT)
Received: from [100.80.46.139] (9.sub-174-194-209.myvzw.com. [174.194.209.9])
        by smtp.gmail.com with ESMTPSA id h26sm2546754pfk.35.2020.05.14.08.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 08:00:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [patch V4 part 3 17/29] x86/entry: Convert Invalid Opcode exception to IDTENTRY
Date:   Thu, 14 May 2020 08:00:10 -0700
Message-Id: <D75719A6-44E5-4F6F-8308-58DD2E74374D@amacapital.net>
References: <87k11ezog1.fsf@nanos.tec.linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <JGross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
In-Reply-To: <87k11ezog1.fsf@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: iPhone Mail (17E262)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 14, 2020, at 5:33 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> =EF=BB=BFAndy Lutomirski <luto@kernel.org> writes:
>=20
>>> On Tue, May 5, 2020 at 7:15 AM Thomas Gleixner <tglx@linutronix.de> wrot=
e:
>>>=20
>>> From: Thomas Gleixner <tglx@linutronix.de>
>>>=20
>>> Convert #UD to IDTENTRY:
>>>  - Implement the C entry point with DEFINE_IDTENTRY
>>>  - Emit the ASM stub with DECLARE_IDTENTRY
>>>  - Remove the ASM idtentry in 64bit
>>>  - Remove the open coded ASM entry code in 32bit
>>>  - Fixup the XEN/PV code
>>>  - Fixup the FOOF bug call in fault.c
>>>  - Remove the old prototyoes
>>>=20
>>> No functional change.
>>=20
>> I think there *is* a functional change:
>>=20
>>=20
>>> --- a/arch/x86/mm/fault.c
>>> +++ b/arch/x86/mm/fault.c
>>> @@ -567,7 +567,7 @@ static int is_f00f_bug(struct pt_regs *r
>>>                nr =3D (address - idt_descr.address) >> 3;
>>>=20
>>>                if (nr =3D=3D 6) {
>>> -                       do_invalid_op(regs, 0);
>>> +                       handle_invalid_op(regs);
>>=20
>> I suspect the old code was wrong and no one noticed because no one has
>> a F00F-buggy machine any more.
>=20
> I don't think so. It's really just the same thing. The old #UD C
> function was:
>=20
> void do_invalid_op(struct pt_regs *regs, long error_code)
> {
>    do_error_trap(regs, error_code, "invalid opcode", X86_TRAP_UD,
>                      SIGILL, ILL_ILLOPN, (void __user *)uprobe_get_trap_ad=
dr(regs));
> }
>=20
> after expanding the DO_ERROR() muck.
>=20
> The new one does:
>=20
> void handle_invalid_op(struct pt_regs *regs)
> {
>    do_error_trap(regs, 0, "invalid opcode", X86_TRAP_UD, SIGILL,
>              ILL_ILLOPN, error_get_trap_addr(regs));
> }
>=20
> which is exactly the same except for the error code being hardcoded to
> zero in handle_invalid_op() because #UD does not have one.
>=20
>> So maybe document that you fixed up the F00F bug, too.  Otherwise:
>=20
> Not sure what to document :)

Duh, right, never mind.  Here I was thinking the old C handlers did all the e=
ntry/exit work.

>=20
> Thanks,
>=20
>        tglx
