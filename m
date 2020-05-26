Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A8AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 04:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1795A207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 04:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbF+cGhh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgEZEbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 00:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgEZEbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 00:31:12 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD04C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 21:31:12 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id u23so7481119iot.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 21:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KZk5fcSv9Qwnm1QT1FKciYUt5QDn07bJvX1OyCBPDnA=;
        b=gbF+cGhh5i3Kho/bSYAcxGqY2Z2UN4emYq2A+7lnLEZNF9x/39FYuoQmxf0t3QTKs0
         T8S6+9gVDr7jDkNxYLSbG6JWi1qjipNckcqe6jD+dPJsklf2aD+w2TBmGILy4xoMpkrs
         Um9ZjWchzdgGDL58/Ft81tu9WrpoenaEu5LDWWpDtUBvZDeBYPFyYIs+VlxMlZ3YMVai
         v9EKDtQjXQd/ru/Wkiahx+9jZGedPOjnu/hSTy/9GxQteRoxsj4Ed77y3mj8kH7QR9DG
         Sx6dqTRXHIPtYv1I/DGWPBMFlDU7GJd6OL6gunhuqo7kkCyOBAR+FNnYtttELAYr+4vg
         5hrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KZk5fcSv9Qwnm1QT1FKciYUt5QDn07bJvX1OyCBPDnA=;
        b=FobOMeNFRwepia2+2O3o2OQgq0Py/cQnxTQfwv6ADJQ1IJIVn+wD2nZkKz40XVx2cm
         nmIRZj1L0LtmjnMjC+smTRm+bbeBdiiWEx0eVP6mhJJrNLaEY7nRUmTwJlfX3WLgldAk
         QaGPLt0OExskCr8X6VZ4v/P5RANQ/MukC8Ad+Xb60shjyoB/tpxoRCUpQKsnA+IbUrgG
         FuZnoiOAWJajQaKlyz5ghxOzv2GVb/HRzAXWIEiL2T/7Z0hybY6JEmk1288FQaOv0TlL
         S1PS9Sl3NoCsW/1qbRVj3zs0EegcMrE3G6YbKoLnpffPEH5YZjyNDG4LLidG+GWPvhwI
         JEGA==
X-Gm-Message-State: AOAM532mvL9YTZomDmVBmEpQQhTHPPAFec9EvJkA9uyJTwz3mbTiwRuG
        0YnFA3Z6mV78WFJ3n3blJftxfHuQRpKiZe1QqODaMK6r
X-Google-Smtp-Source: ABdhPJxSkYKJ2YM9Hcd4TH6OMPY58v91TOHkxcw8ki8j/a1aW167PKFFNg0zUrm6PtyTDKF6Yzsp0H5dYuwFR98ie5s=
X-Received: by 2002:a5e:8305:: with SMTP id x5mr6552781iom.47.1590467471432;
 Mon, 25 May 2020 21:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200525152517.GY325280@hirez.programming.kicks-ass.net>
 <20200526014221.2119-1-laijs@linux.alibaba.com> <20200526014221.2119-5-laijs@linux.alibaba.com>
 <CALCETrWyMY-0Z_NJ7DnF4PsSnhnbNsgt14X1GWkajcms-ZUSQA@mail.gmail.com>
In-Reply-To: <CALCETrWyMY-0Z_NJ7DnF4PsSnhnbNsgt14X1GWkajcms-ZUSQA@mail.gmail.com>
From:   Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Date:   Tue, 26 May 2020 12:31:00 +0800
Message-ID: <CAJhGHyC82f+=YXYmv8zC=zPxZmk+TW_n+5pjcBE-2T8S9t5K0g@mail.gmail.com>
Subject: Re: [RFC PATCH V2 4/7] x86/hw_breakpoint: Prevent data breakpoints on user_pcid_flush_mask
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 12:21 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Mon, May 25, 2020 at 6:42 PM Lai Jiangshan <laijs@linux.alibaba.com> wrote:
> >
> > The percpu user_pcid_flush_mask is used for CPU entry
> > If a data breakpoint on it, it will cause an unwanted #DB.
> > Protect the full cpu_tlbstate structure to be sure.
> >
> > There are some other percpu data used in CPU entry, but they are
> > either in already-protected cpu_tss_rw or are safe to trigger #DB
> > (espfix_waddr, espfix_stack).
>
> How hard would it be to rework this to have DECLARE_PERCPU_NODEBUG()
> and DEFINE_PERCPU_NODEBUG() or similar?


I don't know, but it is an excellent idea. Although the patchset
protects only 2 or 3 portions of percpu data, but there is many
percpu data used in tracing or kprobe code. They are needed to be
protected too.

Adds CC:
Steven Rostedt <rostedt@goodmis.org>
Masami Hiramatsu <mhiramat@kernel.org>
