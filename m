Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D304C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7EF2187F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579038565;
	bh=rqyZafPFZRqkROc1Ga5Eq2IlfusISwavKDfDX0y1fGY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GTPhAlNsYmJmjkjx774FbdhpLG2PiMn1nda5hZerI09Onn5WEqXkcRLNKZF7HRgkC
	 F9LODjT8/G8N0LVzyAG4UMr0X7wBSoLb0dTgC3YJwwe//xt9eNQKzEAA0CKTehYwkl
	 kTCGYs5EJzxENLIKyHtt7Uartv08IVYCkRUSEAbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgANVtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:49:24 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41096 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgANVtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 16:49:24 -0500
Received: by mail-lj1-f196.google.com with SMTP id h23so16129640ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 13:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vctch71naqEGLrugWbqoCH3ToLlQlQB3yrVoOl+SPvs=;
        b=KZsiFFqPOkrryEiWdCUg5hoXCgV2OLEIU5JBuDM284Mh6WRn/AjOiD1HtsNJRqviVx
         9kKzxAmtgZreU18bWEW2HXaM6Ao4fNRodAVWs6R4i29I6H6YakNGcUy2JKOXR0tVereO
         66FAx40w7vVtGWNG+UhiUq933mXri6+ihEilQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vctch71naqEGLrugWbqoCH3ToLlQlQB3yrVoOl+SPvs=;
        b=V5mRjTi2nufpRLACuA+XNavXwCzY8mX5MHHq3kLfMdw9+ugB5EYjSTWZ3g7B6puSUX
         MfuCySJ7Fv+H1Te59mYp4Z22VWwHEs+X+2tFUvOqyl1GPJVGecAMQJPLQedLCuDmg6bQ
         HgkWcXMlaSA9BFPLd2QhlSttPnqFl7oHCtGeH1Ux3HmSdbEMRJX02JBnB0PFrwF3FFFF
         CO/2X81fnFQP90AXM0g0ukLZaqp+QhDy/PaYyRupqFVWJXyMITs9O9UDi/hUNuTG9tJm
         1s6hrJHejZx/Yo1vglp4YKqjmMHJoolNg6uz5l/J+IdXGoo7LAXCnIvNQ8xDpNrSHPQb
         Ilng==
X-Gm-Message-State: APjAAAXYi6/EvQt5u5JlTowsuRF/Eyk429yCeuHCBhlXJYLEGGatfX00
        dx0rmhz3rmoCW3zd8P5ICeIDKPSkOxk=
X-Google-Smtp-Source: APXvYqwJqNtUMrFlqLmo3je2ydLgJdhBWrYKz5F1/+76vXvV7dWONcLmI/8BGrrUmP479iu/9N1WgQ==
X-Received: by 2002:a05:651c:204f:: with SMTP id t15mr16374836ljo.240.1579038560631;
        Tue, 14 Jan 2020 13:49:20 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id n11sm8070638ljg.15.2020.01.14.13.49.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 13:49:19 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id n25so11075695lfl.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 13:49:19 -0800 (PST)
X-Received: by 2002:a19:48c5:: with SMTP id v188mr3185145lfa.100.1579038558938;
 Tue, 14 Jan 2020 13:49:18 -0800 (PST)
MIME-Version: 1.0
References: <20200114200846.29434-1-vgupta@synopsys.com> <20200114200846.29434-5-vgupta@synopsys.com>
 <CAK8P3a2GUqmcA_q33=20OrK1+cU4f3mCrgci_bO3ho4B5PRODg@mail.gmail.com> <3734021d-1756-3a09-6595-14ca58c64bf9@synopsys.com>
In-Reply-To: <3734021d-1756-3a09-6595-14ca58c64bf9@synopsys.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Jan 2020 13:49:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjX-c9YpPhbQ073UPnTvELNQCN49vqK1yY7JGuHSn5-ew@mail.gmail.com>
Message-ID: <CAHk-=wjX-c9YpPhbQ073UPnTvELNQCN49vqK1yY7JGuHSn5-ew@mail.gmail.com>
Subject: Re: [RFC 4/4] ARC: uaccess: use optimized generic __strnlen_user/__strncpy_from_user
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 1:37 PM Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
>
> On 1/14/20 12:42 PM, Arnd Bergmann wrote:
> >
> > What's wrong with the generic version on little-endian? Any
> > chance you can find a way to make it work as well for you as
> > this copy?
>
> find_zero() by default doesn't use pop count instructions.

Don't you think the generic find_zero() is likely just as fast as the
pop count instruction? On 32-bit, I think it's like a shift and a mask
and a couple of additions.

The 64-bit case has a multiply that is likely expensive unless you
have a good multiplication unit (but what 64-bit architecture
doesn't?), but the generic 32-bit LE code should already be pretty
close to optimal, and it might not be worth it to worry about it.

(The big-endian case is very different, and architectures really can
do much better. But LE allows for bit tricks using the carry chain)

             Linus
