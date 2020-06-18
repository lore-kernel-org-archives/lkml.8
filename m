Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F14C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1D0020739
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="pU+0BBTG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgFRO6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgFRO6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:58:15 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2F0C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:58:15 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id q22so165131pgk.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=4qs1f+nEe+7yGSY8KM4aiMoUDIO8E4RIV0sa26ps+ig=;
        b=pU+0BBTGDjhgzS7MORx2UBJYd1V1GV3AY5eYBkSNXDxA3/HkDxzgK4oMRlbKp39Nb4
         WVWITjoNoIHJGAN1YJfR7Vm58fRv/lXLn/UO1zORKHQiUOwcxgOM9Hnytx6/AJA+P9ot
         6B2ExtON8cIZz7ZkmEeoLHRM2bv+J2TZvX4SvqPQDV3DAocw8Os5DIPwB1fcrUe8ts8y
         k3veyDs/fZlHJsjoRwxSKyRhT6oywSLCxYPj3AsvAYVsfx8Szgy7RxAl3a41WJ0kEv1M
         nvxW889+aAlkexajR1koYJboqCHTB/GMsgBVvPvH16YU2V6TuhicnZiJdfPqzw29185+
         4h0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=4qs1f+nEe+7yGSY8KM4aiMoUDIO8E4RIV0sa26ps+ig=;
        b=WJpGkf9+TAmvZ/McYDPaU/xsoAcQdDg7KcbkSeAweDwhwKE27cp6JqkoiCLTCmnNay
         iPXDymSXjNOglDWQ/cg2na3iC2jotfkM5cqV+t9jfudKPOmXcNTNOWfdJG8I8TNfah7Z
         RFcGPllWpGtnPi7/w+XekbZif3WK8ieNirvl5O5yYqVtyFjBtjF5plv/2X3P5QJj7fcd
         alvsK6KvQ/J9QlwT9FU35igu9+dUc+BBMBIoZ+2bEbmnJfgGYa7IFsYgWmQu435vtTuH
         F5oRJ+dxMVzloo5ase4fnALX2JgYPAMuWcljQfaCl+3Lb22gYgQFIHfrD5As73zw1Ht+
         mL3g==
X-Gm-Message-State: AOAM532UnVMcmKjVvhPw4uMwW1Cm6sTidtApnCWQWfh9HAHQ8DpS3LU9
        Pkfn8BhCHwq/0ZBUY2eARb4zlg==
X-Google-Smtp-Source: ABdhPJzmWFzetzrUjWoQl+iciUZGJdkpoqxsOVcagOPo7ftOU914TFT4uydv7V5nrip4qzV6434C7w==
X-Received: by 2002:a65:52c8:: with SMTP id z8mr648997pgp.266.1592492264654;
        Thu, 18 Jun 2020 07:57:44 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:b1cd:76d5:31d4:cc5d? ([2601:646:c200:1ef2:b1cd:76d5:31d4:cc5d])
        by smtp.gmail.com with ESMTPSA id q39sm2722958pja.30.2020.06.18.07.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 07:57:43 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/7] x86/entry: Fix #UD vs WARN more
Date:   Thu, 18 Jun 2020 07:57:35 -0700
Message-Id: <70455B9B-0952-4E03-B2CE-EEAE1E110C5B@amacapital.net>
References: <20200618144801.642309720@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, dvyukov@google.com, elver@google.com,
        andreyknvl@google.com, Mark.Rutland@arm.com, mhelsley@vmware.com,
        rostedt@goodmis.org, jthierry@redhat.com, mbenes@suse.cz
In-Reply-To: <20200618144801.642309720@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 18, 2020, at 7:50 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> =EF=BB=BFvmlinux.o: warning: objtool: exc_invalid_op()+0x47: call to probe=
_kernel_read() leaves .noinstr.text section
>=20
> Since we use UD2 as a short-cut for 'CALL __WARN', treat it as such.
> Have the bare exception handler do the report_bug() thing.

I think you should consider inlining or noinstr-ifying report_bug() too if y=
ou want to make this more bulletproof. I admit the scenario where someone in=
struments it and it goes wrong is farfetched.

>=20
> Fixes: 15a416e8aaa7 ("x86/entry: Treat BUG/WARN as NMI-like entries")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
> ---
> arch/x86/kernel/traps.c |   50 +++++++++++++++++++++----------------------=
-----
> 1 file changed, 22 insertions(+), 28 deletions(-)
>=20
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -216,40 +216,34 @@ static inline void handle_invalid_op(str
>              ILL_ILLOPN, error_get_trap_addr(regs));
> }
>=20
> +static noinstr bool handle_bug(struct pt_regs *regs)
> +{
> +    bool handled =3D false;
> +
> +    /*
> +     * All lies, just get the WARN/BUG out.
> +     */
> +    instrumentation_begin();
> +    if (report_bug(regs->ip, regs) =3D=3D BUG_TRAP_TYPE_WARN) {
> +        regs->ip +=3D LEN_UD2;
> +        handled =3D true;
> +    }
> +    instrumentation_end();
> +
> +    return handled;
> +}
> +
> DEFINE_IDTENTRY_RAW(exc_invalid_op)
> {
>    bool rcu_exit;
>=20
>    /*
> -     * Handle BUG/WARN like NMIs instead of like normal idtentries:
> -     * if we bugged/warned in a bad RCU context, for example, the last
> -     * thing we want is to BUG/WARN again in the idtentry code, ad
> -     * infinitum.
> +     * We use UD2 as a short encoding for 'CALL __WARN', as such
> +     * handle it before exception entry to avoid recursive WARN
> +     * in case exception entry is the one triggering WARNs.
>     */
> -    if (!user_mode(regs) && is_valid_bugaddr(regs->ip)) {
> -        enum bug_trap_type type;
> -
> -        nmi_enter();
> -        instrumentation_begin();
> -        trace_hardirqs_off_finish();
> -        type =3D report_bug(regs->ip, regs);
> -        if (regs->flags & X86_EFLAGS_IF)
> -            trace_hardirqs_on_prepare();
> -        instrumentation_end();
> -        nmi_exit();
> -
> -        if (type =3D=3D BUG_TRAP_TYPE_WARN) {
> -            /* Skip the ud2. */
> -            regs->ip +=3D LEN_UD2;
> -            return;
> -        }
> -
> -        /*
> -         * Else, if this was a BUG and report_bug returns or if this
> -         * was just a normal #UD, we want to continue onward and
> -         * crash.
> -         */
> -    }
> +    if (!user_mode(regs) && handle_bug(regs))
> +        return;
>=20
>    rcu_exit =3D idtentry_enter_cond_rcu(regs);
>    instrumentation_begin();
>=20
>=20
