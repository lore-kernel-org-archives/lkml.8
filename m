Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C4CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 981CA2065F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589520491;
	bh=ClA2IxxG1MI3wu7KclT20O32qm2052KEbxXrz8qkzGk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Pwxq/Sb3gVGhaD4TYX2GEaiaKoA0zOvVRWYL8BrsMACrexYjNOMJmsWXLLYGbd0or
	 QI63BTydZOLsO17fA6oqFEffHnNy7r0hEUXueO3wmI2N+6fURXbLESyO+h9cxgMl2d
	 7FMKrw5XTMqf4Wbxjj2OL6V/MRrDjWVBW2nuOsK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgEOF2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 01:28:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgEOF2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 01:28:10 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC092207BB
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 05:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589520490;
        bh=ClA2IxxG1MI3wu7KclT20O32qm2052KEbxXrz8qkzGk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E1xaEDe8UYBtBcg42VRwGPuBUXICT2YNh5HG8EhImeNfv8dm7U5VeAWQ89d+yPXri
         ziLC/nLMsQUy1A25HMdBYMrAqoiOilv4Ap6wmcVlkAfhsoXQ5KP8v7TWGcb0Kw5YaP
         DGdQjhfCcQVHIB7bWNVt+qaJRYGagStD7glhQkiw=
Received: by mail-wr1-f49.google.com with SMTP id w7so1874925wre.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 22:28:09 -0700 (PDT)
X-Gm-Message-State: AOAM531bCHswhuYpuzULkndS3KX2Jv0OPmRoWhEy5oEveN53kmkmf2HS
        PDzrHA546Tx6jUdVlaRZuuo3kSgi3uBWGewDrBejfQ==
X-Google-Smtp-Source: ABdhPJxVtg+KNox8nSHMLbESkZEIfk4gI+H7v05x6BOtJWiNA7kEiZ5xGkM/HqE44OjQMYdHzEhHZyXEO5gL0vBChxs=
X-Received: by 2002:adf:fe45:: with SMTP id m5mr2112386wrs.257.1589520488390;
 Thu, 14 May 2020 22:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134926.578885807@linutronix.de> <20200505135314.992621707@linutronix.de>
In-Reply-To: <20200505135314.992621707@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 14 May 2020 22:27:57 -0700
X-Gmail-Original-Message-ID: <CALCETrWN-SXT+3zzofSu1nwVNZO-FqYv7u8w9HcVH245JV8y4A@mail.gmail.com>
Message-ID: <CALCETrWN-SXT+3zzofSu1nwVNZO-FqYv7u8w9HcVH245JV8y4A@mail.gmail.com>
Subject: Re: [patch V4 part 4 17/24] x86/entry/64: Remove error code clearing
 from #DB and #MCE ASM stub
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 7:16 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> The C entry points do not expect an error code.


Acked-by: Andy Lutomirski <luto@kernel.org>
