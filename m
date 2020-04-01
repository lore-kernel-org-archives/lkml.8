Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5EAC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E840206CC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585774535;
	bh=WgvUllKbdzkHuBcqj0tgVsmBaHnFd2p8IYH7S3ydN4A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vft3HIQys29znVZQR7wIOeQD5lZZFW2CQD6h5qEpsFxhyFBbQ5TMMMoz/gDBBmS8t
	 bNb7ZHb4ZHHiZIhpBypg6KdmR/hO8kPMjq5eXv6HB6QCEw5uiNuJ1kVl3qhj/Wh8ub
	 nmNaisPWTG5lIyWPa3V7l2za9ixIr8Jylr9qy/Wg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732977AbgDAUze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 16:55:34 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33971 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732793AbgDAUze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 16:55:34 -0400
Received: by mail-lf1-f65.google.com with SMTP id e7so935163lfq.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 13:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yuHnHVGl5Hl/LCLky/lKRjfVSplQ/H5ogoCU1HMx1e8=;
        b=WWbKUEBx25usiEQ2sOtMr/aJGGNl/SWad/qB+6BBXRmLdbbOPDw+0Em7vvCLC8KHwE
         L0cmqvLGhMWA3DKwcIP/ALfr/FFFkSk9t8gs4fHWuRB/MEmppOKWwLyW0SIfro25/I7O
         JCyragl/0Fvlx0Ib8Kr7EkEmR2XWHQ4+fVTn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yuHnHVGl5Hl/LCLky/lKRjfVSplQ/H5ogoCU1HMx1e8=;
        b=CrTA14XQ0++K7Cn++trb9Zvm3UIekHYWJEs4rKmAhTAX1vqSR/QrG+HeN2j89avFBS
         cw/fWIvhwcmqtZhcBrLyHxsFkTOhvWXSIFCCyIBuQQ7pJ0q2Aiu3gsDVcymABmTDvgtX
         vH7ZjMRVp0AxfS4QdBQaVJ7m937N/C6VIU1coAPR8uK43e63Q/9LBZGAtzepJRqMhOvn
         x6Zgz+XO6V5r+XwOaAHCiAEkc+5nevPMM4ReEG8ceQSQFFq10Tk1GLOdcBsVU/oLrvrI
         KN4WpO3iPxGpLDsirog8EDIAGi5a4g/7DE9E5CNHzGF6aaN6PNcWVlckglq+6AfWLDzV
         xp3A==
X-Gm-Message-State: AGi0PuZJmO/Wo9T2gkprwuvMFkzxE758//LscLPJV3OkwneO9wW5Qx+B
        X9LiHO0j6/KwEd5xVTAyPQQGYze8ldo=
X-Google-Smtp-Source: APiQypJ/WoFBXN7SMiwMuQ6UaTAWLuNXQCryCVvYc3IYFYCcQnIVrNe+UNRHveIs5v4Ezew7bKtyxg==
X-Received: by 2002:a05:6512:3189:: with SMTP id i9mr43969lfe.178.1585774529140;
        Wed, 01 Apr 2020 13:55:29 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id q22sm1909898ljh.3.2020.04.01.13.55.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 13:55:28 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id r24so974792ljd.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 13:55:27 -0700 (PDT)
X-Received: by 2002:a2e:8652:: with SMTP id i18mr62644ljj.265.1585774527625;
 Wed, 01 Apr 2020 13:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200324215049.GA3710@pi3.com.pl> <202003291528.730A329@keescook> <87zhbvlyq7.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87zhbvlyq7.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Apr 2020 13:55:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wihrtjjSsF6mGc7wjrtVQ-pha9ZAeo1rQAeuO1hr+i1qw@mail.gmail.com>
Message-ID: <CAHk-=wihrtjjSsF6mGc7wjrtVQ-pha9ZAeo1rQAeuO1hr+i1qw@mail.gmail.com>
Subject: Re: [PATCH] signal: Extend exec_id to 64bits
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Adam Zabrocki <pi3@pi3.com.pl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 1:50 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> I have updated the update of exec_id on exec to use WRITE_ONCE
> and the read of exec_id in do_notify_parent to use READ_ONCE
> to make it clear that there is no locking between these two
> locations.

Ack, makes sense to me.

Just put it in your branch, this doesn't look urgent, considering that
it's something that has been around forever.

            Linus
