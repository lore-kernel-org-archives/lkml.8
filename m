Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF59C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 22:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 877C62071C
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 22:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587854915;
	bh=kP398qOE5TjgjtbpA5y6DmoQlCCioUw7MqXaxIp9uwo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=X8jnU4bwVlFRRNO9SFiNMJrPpceKCfxREBL0600+1PP1lkEwamhgtQingmG15yk5X
	 rNako/88SAiub9L8r+U4wVFFBK+FIG92nBMnTiNR2Vxi8o51u009dwDEMlhVpq66//
	 JukgMd2e2dhhZNYR57UMxm2RYaqV9D3A/oqr8e2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgDYWrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 18:47:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgDYWrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 18:47:10 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4E7220A8B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 22:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587854829;
        bh=kP398qOE5TjgjtbpA5y6DmoQlCCioUw7MqXaxIp9uwo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ulgRM1YhUOtxRzw2IZxk1rB0axcCCPgM49Zp7qlH6jYYLSPtFR+uc7rh7DZ9RMEzP
         DWAz5ZQ0h3Pn+0nryfnsch1UEStrVh5NaN9LnkgSLykUMSDtA+Copit56NCjF6+30M
         LFu4xJIjiZZ4D9laFjljRNc6kYrgBQrCG1GNdbbE=
Received: by mail-wr1-f41.google.com with SMTP id t14so16007377wrw.12
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 15:47:09 -0700 (PDT)
X-Gm-Message-State: AGi0Pua3u2eGNFaymfrZcCRu0VJQZiI1t//9MH6iQFN3yT+rptukpsje
        q85Q1Z5DvAPgj5HaVkJAFyy1Ekfc2zyvOFkhsvkyaQ==
X-Google-Smtp-Source: APiQypJBe5w5ATIGX6dPy0zJE0Iwy3T3y7dQ6+8R3hIiXeQpE1yqlkocnlySmjf2RR2jHi/E+9ZopuE1pt94FlO8A+U=
X-Received: by 2002:adf:e586:: with SMTP id l6mr18787167wrm.184.1587854828036;
 Sat, 25 Apr 2020 15:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200423232207.5797-1-sashal@kernel.org> <20200423232207.5797-2-sashal@kernel.org>
In-Reply-To: <20200423232207.5797-2-sashal@kernel.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 25 Apr 2020 15:46:56 -0700
X-Gmail-Original-Message-ID: <CALCETrUdmN3az78Aqfcta+waUOfW1=DXxw-M-t4m1zGdBnHGmg@mail.gmail.com>
Message-ID: <CALCETrUdmN3az78Aqfcta+waUOfW1=DXxw-M-t4m1zGdBnHGmg@mail.gmail.com>
Subject: Re: [PATCH v10 01/18] x86/ptrace: Prevent ptrace from clearing the
 FS/GS selector
To:     Sasha Levin <sashal@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 4:22 PM Sasha Levin <sashal@kernel.org> wrote:
>
> From: "Chang S. Bae" <chang.seok.bae@intel.com>
>
> When a ptracer writes a ptracee's FS/GS base with a different value, the
> selector is also cleared. This behavior is not correct as the selector
> should be preserved.
>
> Update only the base value and leave the selector intact. To simplify the
> code further remove the conditional checking for the same value as this
> code is not performance-critical.
>
> The only recognizable downside of this change is when the selector is
> already nonzero on write. The base will be reloaded according to the
> selector. But the case is highly unexpected in real usages.

After spending a while reading this patch, I think it's probably okay,
but this ptrace stuff is utter garbage.  The changelog should explain
why common cases work with the current code, what you think the point
(if any) of the condition you're removing is, and why it's okay to
make this change.

Certainly the current changelog is wrong.  You say "The base will be
reloaded according to the selector".  The code you're changing calls
x86_fs/gsbase_write_task(), which is, effectively:

task->thread.fsbase = fsbase;

This doesn't reload anything.

Maybe what you're trying to say is "with this patch applied, as is or
with FSGSBASE disabled, if the tracee has FS != 0 and a tracer
modifies only fs_base, then the change won't stick."

--Andy
