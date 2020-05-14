Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460A6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E85920575
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589431209;
	bh=GGyNlQrp0t+6QwLTq0FcLwx/k+tFBzGP67M/8ZFOxV8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YsB5DMxorDEHtORiu3Wfto8UJYzNu863kxgYwPjlxXDzc58gLnH5Tni8B+YgAPsfa
	 En2Knu9EaRM0kbGUpXIBSSuKM4MIdPOCHOnvlYxNxOOejMUKO0S3OR+NzwDXymCIUQ
	 ysrSk3FbiIKglKr/Elbqjp+h69NT0bmwGMWQAm60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgENEkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 00:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgENEkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 00:40:07 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BFF820760
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589431207;
        bh=GGyNlQrp0t+6QwLTq0FcLwx/k+tFBzGP67M/8ZFOxV8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EHbUOoO6wHZN3YtO1lqycP941rIQxQ3f3baPD0Q03VdhiaGCfEMLbh3xFN87AAPr8
         GShTOkPfzJY6RDydm90LS+M+c93EksBbfCzKCHjclh0HzINIPaJ8adLueMGPKyho6m
         yFnn7D9xGYUq46vNEYzjBGfFDXjrWBGzlI5yqm0Q=
Received: by mail-wm1-f51.google.com with SMTP id k12so28687668wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 21:40:06 -0700 (PDT)
X-Gm-Message-State: AGi0PuYA0i369DsGrZH4lyMhxST7bDNvSCnv4d17KOx83GgP6m5obONG
        dKIETE9tPnlmfpAcP2IeFoaqu7RSKk3WQTBIUdHaJw==
X-Google-Smtp-Source: APiQypJgT/5+t2DcYhDF4qzk/q27oqTWieFgn2IastzQDOMNIUL+sfN/xWxjRGCOdE3vsXnTTSTTgXWljavxMX2/CzU=
X-Received: by 2002:a05:600c:2299:: with SMTP id 25mr25599619wmf.138.1589431205486;
 Wed, 13 May 2020 21:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134354.774943181@linutronix.de> <20200505134904.771457898@linutronix.de>
In-Reply-To: <20200505134904.771457898@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 13 May 2020 21:39:53 -0700
X-Gmail-Original-Message-ID: <CALCETrVyJkmjd9zsanNb0OVK=KvPV=GUUxa2qcdhSJ8bVUgM2w@mail.gmail.com>
Message-ID: <CALCETrVyJkmjd9zsanNb0OVK=KvPV=GUUxa2qcdhSJ8bVUgM2w@mail.gmail.com>
Subject: Re: [patch V4 part 3 15/29] x86/entry: Convert Overflow exception to IDTENTRY
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

On Tue, May 5, 2020 at 7:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Convert #OF to IDTENTRY:
>   - Implement the C entry point with DEFINE_IDTENTRY
>   - Emit the ASM stub with DECLARE_IDTENTRY
>   - Remove the ASM idtentry in 64bit
>   - Remove the open coded ASM entry code in 32bit
>   - Fixup the XEN/PV code
>   - Remove the old prototyoes
>
> No functional change.

Acked-by: Andy Lutomirski <luto@kernel.org>
