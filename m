Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0005FC5ACC5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 22:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C727C207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 22:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="MWv1EDOU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgBSWsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 17:48:39 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42485 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbgBSWsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 17:48:39 -0500
Received: by mail-pg1-f193.google.com with SMTP id w21so845206pgl.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 14:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=hFIv1StvrYt32L4fBBEwiqxcPu8uBLsOVOmRLAcoxK0=;
        b=MWv1EDOURdMl/D7ic1YawBXtbCGgZxtevJol7GrUX3fSqC0Vb/U/T3uBDsZfr3MXaU
         ZE5wxwixOYDXz0O7f5ZbS9tLYAA+EGNtzogzXWNr5oZUQeQhV//uAZyNYZDXMH/nDCl0
         tVYYDbMvt8vZ33lutbQfbvquqkLOekWzFz1/V14tpdltCpMLBoC1Bl3lU7WaN0SXYBJ3
         kGbenwI/7Y9SzOcGKas2vwrTORPq4gNolWqoEo1fD48QIolBbKMhQoDP27rl6Ds8feSx
         QGr+Bbur5OL0T1YEYF7yS+ro4fdlw3MQmfjpphDMX5rvVnxfE4SO5WtmhJrcYWlAwO4/
         u21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=hFIv1StvrYt32L4fBBEwiqxcPu8uBLsOVOmRLAcoxK0=;
        b=F48XEHfynRrg5kZQBU5Uvnbt5XdpzJTCGfa74KpUKUWtkQaIkqZIFeHeodhkLm86Ij
         Z8oN8ci5zk/UPBeyqN+cByHA32ZzV0jOey4hmk00PgsTx0cNnqPz4WgqW4GKkLwfZEi4
         9Me4wr7ND1l3Vuvz6C9eU8wfSAhCHp6vnheLlNuEdgI9bDCVxuKtG/BtNxfDoVz+onLJ
         fscl6yAQ7T7Isjyc5jxM/X+wDIIDS59wY1wyrBB+oTfO9Njxpd6ZoXhcvD0nGq70cd3b
         qVLk3zs2AN04qAjaEhgOcTwzLno8HnjZuPqaxn7o+nFGpWeuNu9VQbzWRrdoR7nziBKA
         9twA==
X-Gm-Message-State: APjAAAUNYGDj2cad/gG7IPyRooPbsVmeyHB55mlgDkO8N6kP/NKSj9ae
        /2QvXH4jK4GFpHr9hVjEW4AQAg==
X-Google-Smtp-Source: APXvYqzBf2O4QDn3AFb6u7w8cG8mDmrbIQi6UwBUORhqwOYnt3ioZ7hZuJ5u/RG5y+RvgWCcb9WOmg==
X-Received: by 2002:a63:d0b:: with SMTP id c11mr26559314pgl.296.1582152516957;
        Wed, 19 Feb 2020 14:48:36 -0800 (PST)
Received: from ?IPv6:2600:1010:b02b:5157:50c5:fd84:b9f3:f00f? ([2600:1010:b02b:5157:50c5:fd84:b9f3:f00f])
        by smtp.gmail.com with ESMTPSA id g2sm719582pgn.59.2020.02.19.14.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 14:48:36 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 02/22] x86,mce: Delete ist_begin_non_atomic()
Date:   Wed, 19 Feb 2020 14:48:34 -0800
Message-Id: <772ACE2A-FD8B-492F-960E-981ECC72E283@amacapital.net>
References: <3908561D78D1C84285E8C5FCA982C28F7F57E302@ORSMSX115.amr.corp.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F57E302@ORSMSX115.amr.corp.intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Feb 19, 2020, at 2:33 PM, Luck, Tony <tony.luck@intel.com> wrote:
>=20
> =EF=BB=BF
>>=20
>> One big question here: are memory failure #MC exceptions synchronous
>> or can they be delayed?   If we get a memory failure, is it possible
>> that the #MC hits some random context and not the actual context where
>> the error occurred?
>=20
> There are a few cases:
> 1) SRAO (Software recoverable action optional) [Patrol scrub or L3 cache e=
viction]
> These aren't synchronous with any core execution. Using machine check to s=
ignal
> was probably a mistake - compounded by it being broadcast :-(  Could pick a=
ny CPU
> to handle (actually choose the first to arrive in do_machine_check()). Tha=
t guy should
> arrange to soft offline the affected page. Every CPU can return to what th=
ey were doing
> before.

You could handle this by sending IPI-to-self and dealing with it in the inte=
rrupt handler. Or even wake a high-priority kthread or workqueue. irq_work m=
ay help. Relying on task_work or the non_atomic stuff seems silly - you can=E2=
=80=99t rely on anything about the interrupted context, and the context is m=
ore or less irrelevant anyway.

>=20
> 2) SRAR (Software recoverable action required)
> These are synchronous. Starting with Skylake they may be signaled just to t=
he thread
> that hit the poison. Earlier generations broadcast.

Here=E2=80=99s where dealing with one that came from kernel code is just nas=
ty, right?

I would argue that, if IF=3D0, killing the machine is reasonable.  If IF=3D1=
, we should be okay.  Actually making this work sanely is gross, and arguabl=
y the goal should be minimizing grossness.

Perhaps, if we came from kernel mode, we should IPI-to-self and use a specia=
l vector that is idtentry, not apicinterrupt.  Or maybe even do this for ent=
ries from usermode just to keep everything consistent.

>    2a) Hit in ring3 code ... we want to offline the page and SIGBUS the ta=
sk(s)
>    2b) Memcpy_mcsafe() ... kernel has a recovery path. "Return" to the rec=
overy code instead of to the original RIP.
>    2c) copy_from_user ... not implemented yet. We are in kernel, but would=
 like to treat this like case 2a
>=20
> 3) Fatal
> Always broadcast. Some bank has MCi_STATUS.PCC=3D=3D1. System must be shut=
down.

Easy :)

It would be really, really nice if NMI was masked in MCE context.

>=20
> -Tony
