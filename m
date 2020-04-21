Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5658AC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2942C2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587489294;
	bh=UmehcnRAU2amoI3M7SGFKD6NSYe1yAMop1qizjSw/rA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OWvu8jBeGHBMs3tt9OCsfZMZf1V3tine1xAjiXEhdEEosX7rOZ+ku7sMXMWmA4C/c
	 9tWJDjvfpvPJ+CkU3roaXxrPxCXRzVwC4dbhAFqcTAO4Y5xRasJxJQiHI3Zjl+jsHr
	 +CPok+hWhMN+C7Gb7QHcZ+DAotKq+6lEqgCoeCfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgDUROx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 13:14:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728956AbgDUROx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 13:14:53 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 774A52073A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 17:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587489292;
        bh=UmehcnRAU2amoI3M7SGFKD6NSYe1yAMop1qizjSw/rA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0hvlkZqpfIwSIeFcXVKODUVetxaauCAjkIEB1klhITcXCxIKp7c3sRMGguw5Ymjwg
         9w/7qPjM28WOSTNLMMMjVkrHEojr9f4yyWegOUlXKFRjp2kzExyiMlROX2FmkHA0eD
         QuxqkiSv29mfECaz4o0yfrFE1XcFvyIN3QogDcRM=
Received: by mail-wr1-f52.google.com with SMTP id j2so17303990wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 10:14:52 -0700 (PDT)
X-Gm-Message-State: AGi0PuYbgFuxQ3ge8bkb7gsG6U8y7sXXKMpYwYvtC4elJ2biISp7z82P
        Al491hutwLHsyt4F9AC5As7SyiqWvtlt+XYcY9ZN6w==
X-Google-Smtp-Source: APiQypIfHqFq9fQRA/gsIJQe6zLBKSsHS3vFeJmlqXHVL5FbK1BuC7WMLzJxUPl3QcCS+3mRevBiFq0PSsdVtpvpasg=
X-Received: by 2002:a5d:62cc:: with SMTP id o12mr24469697wrv.75.1587489290888;
 Tue, 21 Apr 2020 10:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200420183256.660371-1-dima@arista.com>
In-Reply-To: <20200420183256.660371-1-dima@arista.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 21 Apr 2020 10:14:39 -0700
X-Gmail-Original-Message-ID: <CALCETrUx6mrLX1bwPG=23ihFgZRiTpdh-p-a4q_PgCvdR=EeZw@mail.gmail.com>
Message-ID: <CALCETrUx6mrLX1bwPG=23ihFgZRiTpdh-p-a4q_PgCvdR=EeZw@mail.gmail.com>
Subject: Re: [PATCH 0/3] x86/vdso: Little clean-ups
To:     Dmitry Safonov <dima@arista.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        X86 ML <x86@kernel.org>, Andrei Vagin <avagin@openvz.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 11:33 AM Dmitry Safonov <dima@arista.com> wrote:
>
> Resending some patches those weren't needed after timens series evolved,
> but still make sense. Nothing really important, just 3 nits here and
> there.

Acked-by: Andy Lutomirski <luto@kernel.org>
