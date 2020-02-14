Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7ACC352A3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 01:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F82A20848
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 01:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFpHZ5je"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgBNBH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 20:07:58 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37294 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbgBNBH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 20:07:58 -0500
Received: by mail-pl1-f194.google.com with SMTP id c23so3052930plz.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 17:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3CPCapu1GC3zKeozUVk/96Rk3HOBQ2hayAYwRebPM/Q=;
        b=HFpHZ5jey714qrgQOWFv5LsO1c0xeYgTZ6kfhpdZ5Et0raLU1SaiBPFLShRc/8A/1R
         sTjlilcCAlpFlegVgoq8H7ksteFvpS15E2LVmoGkXb6rAdMIum8M22TTqjddmuvRQ5II
         8SznGO6UmaLebdD0335Ff16adN3Ad7DoVGULlf33PCKQ/EnyFbL0IQFzpOH9CKDJLb/7
         74qfpc+EGryGmVB4bw+eTXU12t4aiEYPdzaDUoMJXVTDLjUgdv/+VP4GSUn/JPTHtX9V
         9TUD7s99AzmksXTxEUGoJv7HOpRa8pPW4AyV2ujGGd1SC5zKTgor12o+0B2w5JJ9TpYQ
         4oSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3CPCapu1GC3zKeozUVk/96Rk3HOBQ2hayAYwRebPM/Q=;
        b=DscaczdBatZHohBhnN4Z4vh6Q9nvcfW5PyStZFQ9n9JRUtSITK64n48AYhh1T+2R71
         9UKOm0LLxDKu/MGWkNhzYVCH9Wn0Q2l8ECYCyRDljtdyLlsc3NVFK6Lhh93nRiJ4kJQr
         scz1L7j07E9L3Ru5ICY1X34Wn8jGEISoFrZWsMIjJsgQqxpP0hAFnc6ZguP6pbUmp3jc
         /HM7p3PEm283S76d0K7qNLGJp6vyndEF68l72bxZiIFVHPSzq49wH/DYZ2Fkk2ve4I6V
         WvQn7olAEI1ZjrLc3t9Pr0zoGktig6r/kdPk3Hd+W2lbkedIYbgDCeFB45EzDzieRrug
         hqEg==
X-Gm-Message-State: APjAAAV+jKaGk/m7vc48OUZkM7BMS959KaTeh8uRda/z48bzLDz33gr2
        9PMIXywjWrYls2Bc3SxIzFPa/jxU
X-Google-Smtp-Source: APXvYqwfqxrXmr5gzsXHXHDZ/siiAgsJ3md5k3TstMkBABjkXqBrfETvfO7gRdCR0gz4XtHzr/NFDA==
X-Received: by 2002:a17:902:694b:: with SMTP id k11mr693763plt.334.1581642477752;
        Thu, 13 Feb 2020 17:07:57 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id 3sm4468953pfi.13.2020.02.13.17.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 17:07:56 -0800 (PST)
Date:   Fri, 14 Feb 2020 10:07:55 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        lijiang <lijiang@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] printk: replace ringbuffer
Message-ID: <20200214010755.GA13877@google.com>
References: <20200128161948.8524-1-john.ogness@linutronix.de>
 <dc4ca9b5-d2a2-03af-c186-204a3aad2399@redhat.com>
 <20200205044848.GH41358@google.com>
 <20200205050204.GI41358@google.com>
 <88827ae2-7af5-347b-29fb-cffb94350f8f@redhat.com>
 <20200205063640.GJ41358@google.com>
 <877e11h0ir.fsf@linutronix.de>
 <cd7509a5-48fd-e652-90f4-1e0fe2311134@redhat.com>
 <87sgjp9foj.fsf@linutronix.de>
 <20200213130720.j4e5qv37am2bapup@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213130720.j4e5qv37am2bapup@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/13 14:07), Petr Mladek wrote:
> On Wed 2020-02-05 17:12:12, John Ogness wrote:
> > On 2020-02-05, lijiang <lijiang@redhat.com> wrote:
> > > Do you have any suggestions about the size of CONFIG_LOG_* and
> > > CONFIG_PRINTK_* options by default?
> > 
> > The new printk implementation consumes more than double the memory that
> > the current printk implementation requires. This is because dictionaries
> > and meta-data are now stored separately.
> > 
> > If the old defaults (LOG_BUF_SHIFT=17 LOG_CPU_MAX_BUF_SHIFT=12) were
> > chosen because they are maximally acceptable defaults, then the defaults
> > should be reduced by 1 so that the final size is "similar" to the
> > current implementation.
> >
> > If instead the defaults are left as-is, a machine with less than 64 CPUs
> > will reserve 336KiB for printk information (128KiB text, 128KiB
> > dictionary, 80KiB meta-data).
> > 
> > It might also be desirable to reduce the dictionary size (maybe 1/4 the
> > size of text?).
> 
> Good questions. It would be great to check the usage on some real
> systems.

[..]

> I wish the dictionaries were never added ;-) They complicate the code
> and nobody knows how many people actually use the information.

Maybe we can have CONFIG_PRINTK_EXTRA_PAYLOAD [for dicts] so people can
compile it out if it's not needed. This can save several bytes here and
there.

	-ss
