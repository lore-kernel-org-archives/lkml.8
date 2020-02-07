Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE88C35250
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 17:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BDC3214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 17:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zEKd6yGS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgBGRRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 12:17:40 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39927 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgBGRRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 12:17:39 -0500
Received: by mail-lj1-f193.google.com with SMTP id o15so94587ljg.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 09:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+3Iqkt4MVXjWZGBV015Jcs9RMmQrhCpmKzo2XOdRy6s=;
        b=zEKd6yGScHa2K0iECeZbhO0XjWI99X5SJjftT/fmqcLVLMycCQJ+7QU2JFU/KEmSym
         xV3/luzzPlLjt/pCbk9ATk8QEahfIkoGWHKpAMAYcSlIyH9PJrvXsFoiJlAnW+9KFkyL
         Hm6k8LS5YXlk43jRVp0OCuV8DWva5V5Egqq92jZ2rC4pYON9frYAaPqc1Xnz9pY64MU0
         H45p0C579NYh/nxhJ1B2VKLVMaBkdtTyqAR21G06y8664XAn8/lBqTBDFOhBGcKBcFW8
         LiadacqrX/7RaTlE8AfMkldn/alfMwoEvcKzbMx2YnZmxsyzrg50ldS7n7RFXP7ZF3HA
         Aa0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+3Iqkt4MVXjWZGBV015Jcs9RMmQrhCpmKzo2XOdRy6s=;
        b=C/XiMI+qRVfnn9qWQ61dhqaqEzXeXZNBqwlDqdBlZ+OBM0qSUafjkbPuN5UIK0DF21
         HmXg+vbB0EHrP9xMoubWRH2GnlFhi9Yi7mPKwsx8qZs0tPFuFrjUTmnKlDJVkKUlC9Rd
         UXeno7OYw2MOlRmGZG0nFT32XXhe4NjDSHszUE/vpWh3IkhPlAbI3uHoxGZEJalsLm3y
         ubU6EQaQ1283PCleKRPmQrxMsnmlHhY+uUj3Av+UU3p5vRzxhcxdSBt2DSn2rFUywCqu
         CurnsMoQnsvfuA/Ize06zebw34XQt+K//85hM1gMJLEdnTvNF8fsJZS8xiJGTTXAGZfO
         5rQw==
X-Gm-Message-State: APjAAAVnQZwqeE4HLl/7d0KsygL6GBAgyLeTfpCF+KqPe5Ni8SpP/ANR
        fbzwYL/2Lhgfnpf2RMOHzThHceDKpacTtTqw68+j8g==
X-Google-Smtp-Source: APXvYqyzv/j2Eu5b+5c1brAZEyAJvaN5OVlyXbW5amY0PgYq0jfxHZX/4J5eB7zvR7Ut2RgG4CuzIXEW9LjxaMgTG/4=
X-Received: by 2002:a2e:7d0c:: with SMTP id y12mr155054ljc.39.1581095857258;
 Fri, 07 Feb 2020 09:17:37 -0800 (PST)
MIME-Version: 1.0
References: <20191211214852.26317-1-christopher.s.hall@intel.com>
In-Reply-To: <20191211214852.26317-1-christopher.s.hall@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Feb 2020 18:17:26 +0100
Message-ID: <CACRpkdbQ-o0NOLzQK3Jb06wx2u62ik2xv1Q8UNpN_SMmGhgVXg@mail.gmail.com>
Subject: Re: [Intel PMC TGPIO Driver 0/5] Add support for Intel PMC Time GPIO
 Driver with PHC interface changes to support additional H/W Features
To:     christopher.s.hall@intel.com
Cc:     netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        jacob.e.keller@intel.com,
        Richard Cochran <richardcochran@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, sean.v.kelley@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 7:40 AM <christopher.s.hall@intel.com> wrote:

> The TGPIO hardware doesn't implement interrupts. For TGPIO input, the
> output edge-timestamp API is re-used to implement a user-space polling
> interface.

It you modeled it reusing the GPIO subsystem (which I don't know if
you can) you would get access to the gpiochip character device
/dev/gpiochipN and be able to read timestamped events like
the tool in tools/gpio/gpio-event-mon.c does.

That said I am still confused about what this driver does or what the
purpose is.

GPIO pins in or out? Network coming in or going out using PTP?

What is the use case?

Yours,
Linus Walleij
