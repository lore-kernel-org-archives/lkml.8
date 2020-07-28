Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF30C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04C01206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k0OoYPGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbgG1PXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730586AbgG1PXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:23:05 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B8CC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:23:05 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id v22so9178525qtq.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HmI/sv0QX+R/BppNr1xfIVqkHjAsa6rJb/xBjwtMkO4=;
        b=k0OoYPGsrWcDnJDBrtDmMOXYH44154lhl2vIeXr8cWPeZzoXZLk2WW6vIXJ98+h3ym
         YXk1rSXRDQZr/I7c6a/DHGfGSA1C5HSOhBi+daQvX2YeGhJMuGLvxBfWRHxacovePjDH
         bbij7yp3WQjUUFmBRKVbsFJl3bFQYGA1D2QXaN9UN2hZJfEFZfXx763I+d/xikQ7Ginu
         Ekev7ePE0gI3+wb3d1Su+VeLeYfQaWFdwfRpXfvfd00e0zwRFWSyVQLPI0fnggduiKKe
         1z92CaOAS0bFKlnPfkg0pMqLlqjZM1bfhNRXZVhP2E2Jc8seQfTU3uwZiLFLn1ujvEAB
         c9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HmI/sv0QX+R/BppNr1xfIVqkHjAsa6rJb/xBjwtMkO4=;
        b=JaJCwvNW588Kw8a3n3k5fz4D3lEVrdo4+Cx6RGXE0xQ0CLJKfPCmkuTOeF6kPY976I
         aLjlA607Ww02a734hQ7wT/mNPkj3GKew4qmSBEPBHCdEfYjRaOoQ4feoU4euQS27fnF6
         g4vUH0TuWmird1jrzgQpWw8VpT3xqE4RxBNmPw7GXoBNH127wk1o5Yrw4ObhC19BtYQD
         ou0tXyU/fW+ASvY3yrXkux72AcpQ3VJqDRqVWd0pgvFO1+R7598q+C4LowAPKTRzFviP
         moIOq/YpMwGc9X82Oum9yoh+Hwg7Mq3SEvRXep7vGI7wXufgut47nvKb8P2cMT0et0dq
         gXoQ==
X-Gm-Message-State: AOAM531/YLT1Aye4L1CkAQen0e4cSNavPotUXSNSDyvSgZosDS7lhs2Z
        bM/Fz9d90clUj0nVdE2fSdbKqqu5xctopyd8SIT4Jw==
X-Google-Smtp-Source: ABdhPJyahQHLn2+4zTnx8Mcd9s+rEe2J50gkBT9tNcMY2WW5C7XyJ6/yCqwA5veYW5IgF6r8oKpot6NiZHQAYBqp5J8=
X-Received: by 2002:ac8:660f:: with SMTP id c15mr10023288qtp.34.1595949784633;
 Tue, 28 Jul 2020 08:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200724091520.880211-1-tweek@google.com>
In-Reply-To: <20200724091520.880211-1-tweek@google.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Tue, 28 Jul 2020 11:22:52 -0400
Message-ID: <CAJWu+orndyKTVTO-StUxnPsQ-TkbQHU5WxzOJ35EhckGfUzD1A@mail.gmail.com>
Subject: Re: [PATCH] selinux: add tracepoint on denials
To:     =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc:     Paul Moore <paul@paul-moore.com>, Nick Kralevich <nnk@google.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 5:15 AM Thi=C3=A9baud Weksteen <tweek@google.com> w=
rote:
>
> The audit data currently captures which process and which target
> is responsible for a denial. There is no data on where exactly in the
> process that call occurred. Debugging can be made easier by being able to
> reconstruct the unified kernel and userland stack traces [1]. Add a
> tracepoint on the SELinux denials which can then be used by userland
> (i.e. perf).
>
> Although this patch could manually be added by each OS developer to
> trouble shoot a denial, adding it to the kernel streamlines the
> developers workflow.
>
> [1] https://source.android.com/devices/tech/debug/native_stack_dump
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> Signed-off-by: Joel Fernandes <joelaf@google.com>

While I am in support of the general idea, could you change my SOB to
something like Inspired-by?

This is really your patch, but I did demonstrate the idea in an
article where the intention was to apply a patch out of tree to do
stack dumps / tracing.  SOB on the other hand is supposed to track the
flow of a patch (the people who the patch goes through) when it is
sent upstream.

Thanks,

 - Joel
