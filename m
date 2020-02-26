Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8154C4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 20:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885A424656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 20:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582747661;
	bh=2tf+v+V/MEP5NY0l77q6mS4Qi+if4Z6bmYcsxvTFlAc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Z9NnnuEIMSe376nNgultAvvMW22L0ZKuH6eotiiydP9j/fyMBpCXVx+KH25JhoIjE
	 5Uha+ki1x48T6eQPBpPNLvg+gyd4c9ujwT+AiG0iW5Sjy/S/jeBW4pufiXwlj4UAeb
	 Ugzl8+6mAq+i8zDNuVWl2qTM9VPqQMvwKRlYHP5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgBZUHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 15:07:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:45660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727277AbgBZUHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 15:07:40 -0500
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47E562467B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 20:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582747659;
        bh=2tf+v+V/MEP5NY0l77q6mS4Qi+if4Z6bmYcsxvTFlAc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mZTOKyU+WQgw3ipa87OcIONruGF8lXSPHNfK6vxs1YiMXkFU4RSEhmo4DX3jeKSd2
         s6Z784fQqqqdSejTvFQ5wccgKxcAzRxn95no3RRCiUKnMmKpCx2ygr5RKyu23mWBQF
         1F9fXskzs7DqmtY26t7NV+vuVaJiac3Na8JPqJO4=
Received: by mail-wm1-f50.google.com with SMTP id m10so5351118wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 12:07:39 -0800 (PST)
X-Gm-Message-State: APjAAAWMJiEu6cihZIyoslair5Dc0wGX5qIrA8/Fmsh0O/E7arAlJc5Q
        CUKmtO7V1uV/IRgE7/I12X7gZ28CYwHRjx7vJ1/UMQ==
X-Google-Smtp-Source: APXvYqydt/Oh8QkTZnRNoZdpsRzIaN0b+vNS6r2LtaU+Apd2hTWAsK9m6W8ElX/YxITonykdhHJhL4iTuWZZv/5PRuQ=
X-Received: by 2002:a05:600c:2207:: with SMTP id z7mr580415wml.138.1582747657704;
 Wed, 26 Feb 2020 12:07:37 -0800 (PST)
MIME-Version: 1.0
References: <20200225220801.571835584@linutronix.de> <20200225221305.919875257@linutronix.de>
 <db063edd-f1de-bbb4-3c8b-465904308aad@kernel.org> <87pne1azvt.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87pne1azvt.fsf@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 26 Feb 2020 12:07:26 -0800
X-Gmail-Original-Message-ID: <CALCETrV4=1X3MO+HsgxSvJo_Rjw4tr1E7XCY4xHNGA=bhvq7NA@mail.gmail.com>
Message-ID: <CALCETrV4=1X3MO+HsgxSvJo_Rjw4tr1E7XCY4xHNGA=bhvq7NA@mail.gmail.com>
Subject: Re: [patch 7/8] x86/entry: Move irq tracing to prepare_exit_to_user_mode()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
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

On Wed, Feb 26, 2020 at 11:54 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Andy Lutomirski <luto@kernel.org> writes:
>
> > On 2/25/20 2:08 PM, Thomas Gleixner wrote:
> >> which again gets it out of the ASM code.
> >
> > Why is this better than just sticking the tracing in
> > __prepare_exit_from_usermode() or just not splitting it in the first
> > place?
>
> The split is there because prepare_exit_from_usermode() is used from the
> idtentry maze as well. Once that stuff is converted in the later series
> the split goes away again.
>

Okay.
