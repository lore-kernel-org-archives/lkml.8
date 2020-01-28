Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE3BC32771
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 00:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDC52064C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 00:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580172346;
	bh=XnIT7n0BsNwWTi0jYkzDUPCDuKAKG2Q9ZI4Bh9AiXps=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0MZ1Jr+gg89TJFxYR6WMW2O9fVqsXXl4r+eB4IV7mOgy4kz/9ZPssL0I0EOwVchmf
	 JiLcZLYaGIn+XybI4eNfoVR4bSliU5X1Z9PkSUJmifbUej9QIOtD7M0HTcH0CuqTJu
	 UqxFo7WaRyfeEYUiJ0QNzUxVRYP6NKwN+A9CMziA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgA1App (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 19:45:45 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45537 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA1Apo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 19:45:44 -0500
Received: by mail-lf1-f67.google.com with SMTP id 203so7712183lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 16:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E7M0vcp9YogKd4X4x+TIfPxOZ/euFR9ot2NpG6ELc48=;
        b=gSXrA3WD8q0cd4IiPU422Cf0E4A5re9NtnaNtW5mwWIVh781/QJoWfJx76H2tdl5qs
         O3woHaOSZANGtxdHG+Fmi2YQQ+Eo2BhU80gvQ014AOqyMcWc+SWD147RH0+6aMQ9yCDK
         gnDfr4B5yKflE7xElOKPQK+v7rpPFdxkhk/co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E7M0vcp9YogKd4X4x+TIfPxOZ/euFR9ot2NpG6ELc48=;
        b=Bq6gar96TjKg/JFT+D6wgaF74LslgtT1KB8o2Z8oHF6D9Du9EbBzxeGemsdulW6heJ
         mgXbt9IG6AeRoqDKh45zRvGmYaaMr8G8PAGeuJe6xHjRZLzWHMyvQ+GJxn+6sAY/TQ7Q
         ZR4wYSsmH8TVVCLZWigHB+NbdD4Bfzzn2se8F4M3hgQS3sE1lpVtaK+zR8V/5WRQhEqY
         uUCCdVpRJwWok8h9ceP965uSEdlJRVdDJu7yrSchGYhJlXXzLTxeTLFwgiNAP0GloD2E
         ZN9ZAJn3AHVxX8BqP9Ng1xo5x/uH6oMV7CyyQ8QAPl/1SNyD2Xuv/UqFh/WSvt999u2l
         fWbw==
X-Gm-Message-State: APjAAAU4aCZ2OeJq8/2CVvLalS6J5fKCY4c8Cv+pAuY9WwuErrLtyZHR
        mO70OFihn31ZFk2uE8T+Kz+/38w3zeU=
X-Google-Smtp-Source: APXvYqxxUZwHko+hFZBaOuClfpf9OlQlS6yGg7Cpiv9PeK6NvdB3p/G0b4sFTp72EpNGK6oRfJ2v5A==
X-Received: by 2002:a19:f811:: with SMTP id a17mr755497lff.182.1580172342082;
        Mon, 27 Jan 2020 16:45:42 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id k12sm8868135lfc.33.2020.01.27.16.45.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 16:45:41 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id v17so12915018ljg.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 16:45:41 -0800 (PST)
X-Received: by 2002:a2e:97cc:: with SMTP id m12mr1286611ljj.241.1580172340821;
 Mon, 27 Jan 2020 16:45:40 -0800 (PST)
MIME-Version: 1.0
References: <158016896586.31887.7695979159638645055.tglx@nanos.tec.linutronix.de>
 <158016896589.31887.11649925452756898441.tglx@nanos.tec.linutronix.de>
In-Reply-To: <158016896589.31887.11649925452756898441.tglx@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Jan 2020 16:45:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjL8j-8FSO-JyvK=wjiZmAmrAFgqLuyg2oH9bfgHV2cZQ@mail.gmail.com>
Message-ID: <CAHk-=wjL8j-8FSO-JyvK=wjiZmAmrAFgqLuyg2oH9bfgHV2cZQ@mail.gmail.com>
Subject: Re: [GIT pull] core/core for
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 4:06 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-core-2020-01-28

Hmm. Maybe this is related to the subject line after all.

I think that your tag naming has some bug in it, and then that bug
causes problems for the subject line?

"core-core" doesn't make much sense as a name, since it is about
watchdog logic.

My guess is that you automated this and something escaped through the cracks.

Again, not a big deal - everything _works_, it just has some oddities there.

            Linus
