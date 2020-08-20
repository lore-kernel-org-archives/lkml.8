Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F99C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C36AF207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="hnZHzQ2B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbgHTQnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 12:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbgHTQnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 12:43:21 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0598C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 09:43:20 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k13so1177030plk.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 09:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=ttIJlviXRqZxAxtxH+hG4+ubv+c8HQ+vfLAQx8qV+I4=;
        b=hnZHzQ2BR/E+yCoxiSBCD2IJOqDiEM4mKjMBV0OQwzT0KRlvjCInTeC5DFqjCoDsuv
         gXj3jxSSwtJMdbxQajsJnvSQl1mT/lbPELXwWK3uHPxJ8x8L2x7l1/6FnXZ4Kagwhsom
         hYEaR6K69e/fqRjVqCejptSi6S8U4lnGpYcte7zEeeDQviEO3z2+pNOcJfI3qst7uks/
         rVXPIRG4o+ka5FOi3Ua8nLrhNco5LDMgq0ncmJkzJ8tg372e+qqJBWUus8MLJUsL80v9
         Y6Rng43LFKpwukaRBAZWFvTCIQ8ArRAh87K4G82ruUeN8dIgSsS3h5jzFnkcWt89dyh5
         Npkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=ttIJlviXRqZxAxtxH+hG4+ubv+c8HQ+vfLAQx8qV+I4=;
        b=N49WbvWzXXWRM8rsJ4lTghE9b1dG94YwBUPf2g2nCdtf2ybWkDMlGj5ELLUbeIjtiC
         GUTpcwj8WVKQCUTYWoMm7OUcBdz6FJN87XCSP39Pg1xsmlV/e6Slm4xQxkjvXduGvrPh
         +2i7SV9P97IZL87r20p2K4GH80AwR5aeTpovDynV8HG2QVlWUTYnE1d4SNIuFokvNJEK
         CSEHoMK73hELobMC1eZGpkpbMyvFNhyTl8g1ibTpvMDXh2Q6eJaRAWoFYE5dN/Noxy0f
         M7aLGRW+H74+3t/cy47Pi+pdghp+N5/WxXc5It6HkuD+n046Fnp6R5ZdWiDkHWwB6etz
         YjiQ==
X-Gm-Message-State: AOAM5318/5JMpHSgKzkFk3E/pXM/Uxg5qffIvuiFpUJj09KIFmBX44H5
        t4/HsB15sIHAMyFXX8EA7skwhg==
X-Google-Smtp-Source: ABdhPJzY8cmN9eMzA4jmAjsBZb7sHtkCLIMHV1CKSh5jdip7r0T6J/k2QxlarQzP9CkfTHTjvO/QKw==
X-Received: by 2002:a17:90b:1c06:: with SMTP id oc6mr2976623pjb.182.1597941800346;
        Thu, 20 Aug 2020 09:43:20 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:f533:b597:23b4:ec96? ([2601:646:c200:1ef2:f533:b597:23b4:ec96])
        by smtp.gmail.com with ESMTPSA id b15sm3150569pgk.14.2020.08.20.09.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 09:43:19 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC][PATCH 4/7] x86/debug: Move historical SYSENTER junk into exc_debug_kernel()
Date:   Thu, 20 Aug 2020 09:43:15 -0700
Message-Id: <156769F5-0BCC-4FB8-A56D-0E92601F558A@amacapital.net>
References: <20200820163453.GE1362448@hirez.programming.kicks-ass.net>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Brian Gerst <brgerst@gmail.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20200820163453.GE1362448@hirez.programming.kicks-ass.net>
To:     peterz@infradead.org
X-Mailer: iPhone Mail (17G68)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 20, 2020, at 9:35 AM, peterz@infradead.org wrote:
>=20
> =EF=BB=BFOn Thu, Aug 20, 2020 at 11:17:29AM -0500, Josh Poimboeuf wrote:
>> On Thu, Aug 20, 2020 at 05:21:11PM +0200, peterz@infradead.org wrote:
>=20
>>> qemu-gdb stub should eat the event before it lands in the guest
>>=20
>> Are we sure about that?  I triggered the warning just now, stepping
>> through the debug handler.
>=20
> Not sure at all, that's what seemed reasonable, but since when did that
> stop virt ;-)
>=20
> Also, can you trigger that same with upstream? Because I suspect this
> ought to tickle the old code too.

I=E2=80=99ve lost track of how many bugs QEMU and KVM have in this space.  L=
et=E2=80=99s keep it as a warning, but a bug. But let=E2=80=99s get rid of t=
he totally bogus TIF_SINGLESTEP manipulation.=
