Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F562C4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 05:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56912222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 05:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="y+uqSX++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgBZFNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 00:13:50 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:51967 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgBZFNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 00:13:49 -0500
Received: by mail-wm1-f46.google.com with SMTP id t23so1529194wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 21:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1LXaH0AM3Y8GiQ0BYBKweRDuIK+vMIEbOzZHxCDE2mQ=;
        b=y+uqSX++4Ivf1iMMHR1UFkx0uYgStxTyy7DpqLMlvSMlRAuxDIcSKs9EKlOVpkClcu
         yNKZgxbgGEOrqF/0A9k1SRYb7WoJd93Vb85dftJLkmOk3wnxGzdc2ScO9g+CroIlAwKQ
         B8zbhNAJ2Iez++5RYB/f+TbwBdkiQDxSd4LaXMW42Tkl69wAnTd82BDaYMVy8jGfftew
         CB0VHBDHwAuD965da+DtIAdWbsSDyRKY//b0P9MfXjTAqr2Y3UpoqAHy5YHnwy4R8dlW
         ulqpa96TVF6Chdfw/UyJQ36uGTW5oqDJeZNbzIvViVTIWdnBro7CKqyyLLuYD4UsgDYb
         NKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1LXaH0AM3Y8GiQ0BYBKweRDuIK+vMIEbOzZHxCDE2mQ=;
        b=YdAu6QLEi8i9GnV2G/bkB6qrLHd/gXkxj/iSZRwE6/vvCp6ABSZggRYphj/JPAZ8Ew
         HjRTHjuVCY+wPJOJv+xAy+1l3jmDsWvc+c+Z/UxtwmIs0qwSCBM6wA4v18Wfzbkl3+xb
         o8q5bjOI4k0JZqDsiMJB8HFKSTkojpizyflqapLG8zanwsP7I7whZ/QtpKI5i4Svz31o
         1WZT6XxebKT8HrNIPedRIOsGwN0l4n08wy9GWF+2JmnXAnLoQcXPIENoUW7LI3ifvDs/
         v1ll4f+wKifEzs9YcbijUh/fzGFG5lKK5JkJUu3Z0f3OxEVZW6WrCPFi3ny57/EUUBWd
         u58w==
X-Gm-Message-State: APjAAAVxuDZjLMrgnqJJEapbo6SJ0ZSqe2CWCI48RvXj14Wz59w7PgCq
        sBzt5dTHTo8+oUXaujZaP+7hXRvTTVeJa2ysif8FQ3df
X-Google-Smtp-Source: APXvYqx15SLULhQklAMvtGs2hdrxdR+OJaY0G/tXRXx0B/1owTSkEtvLIdVXHxWbFDpwSu4t+Ez5ujsON9xr267btS8=
X-Received: by 2002:a05:600c:2207:: with SMTP id z7mr3108536wml.138.1582694027620;
 Tue, 25 Feb 2020 21:13:47 -0800 (PST)
MIME-Version: 1.0
References: <20200225224719.950376311@linutronix.de> <20200225231609.000955823@linutronix.de>
In-Reply-To: <20200225231609.000955823@linutronix.de>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 25 Feb 2020 21:13:36 -0800
Message-ID: <CALCETrVEvz4njpOy-qF8_pHAMKCgp6oDqk8E1CzM-TeAd1br3Q@mail.gmail.com>
Subject: Re: [patch 01/15] x86/irq: Convey vector as argument and not in ptregs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 3:26 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Device interrupts which go through do_IRQ() or the spurious interrupt
> handler have their separate entry code on 64 bit for no good reason.
>
> Both 32 and 64 bit transport the vector number through ORIG_[RE]AX in
> pt_regs. Further the vector number is forced to fit into an u8 and is
> complemented and offset by 0x80 for historical reasons.
>
> Push the vector number into the error code slot instead and hand the plain
> vector number to the C functions.

Reviewed-by: Andy Lutomirski <luto@kernel.org>
