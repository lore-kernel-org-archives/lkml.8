Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CAFC3F2CE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 17:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00D720719
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 17:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584380013;
	bh=noJiYeNxO1vTklOyBmJZQU4z5U+Vfo1ntvqKH/nE5Q8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QuTAtpGO/ItOD1ufaAeNJrghzZhgxivvJwFS+Aam3WspXgXNW57hko3aHFCXOM4xo
	 PaIkYT7iInpR+0ncQ+XdI0iqxBckuyXUPY4wGhwGPyIVq8n+ylZhdbJEKEsnGSdBhY
	 KmebwQNUZYTn7h01B4YfouGIH9Vf5qU6aXtbBRWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732070AbgCPRdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 13:33:32 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39781 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732008AbgCPRdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 13:33:32 -0400
Received: by mail-lf1-f65.google.com with SMTP id j15so14833169lfk.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 10:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7PTWvIyjfvgfI+AbbkM8uGjoiifhnlvV3GafuV1Cqc8=;
        b=RZOkHoG6bG5PRXDItscgc46suq4mTsbo6XPWhssqKTvVMozW8s73T/8weflqCoPnVx
         C8H0wKeZkrSpnte2xq3Tsr4CPOzNfEwBOJoITgL7KLHhVHVo5nXZqWFHvfIOvkmjRiXo
         tq5QazNudSYv+mfvtxTGlkoupzplWXGDDix6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7PTWvIyjfvgfI+AbbkM8uGjoiifhnlvV3GafuV1Cqc8=;
        b=h+dW+teXJC6k2AhMyST5uhxfNFB820DEwpuoLGcAC2P9M02FXlRblJLJeF8RGqRjHr
         tZ+u7ScLBIyDEOnUsNFaDkE/gznNW+8XlEZnNRt9o9DnMsJLzNWaDxlNZfIR7BW2czVE
         pFLeHUMb8GuVn0qD1g3d073Vx0bsuINlDUyQRLt74oUSjyXEv7CYq2oaygSNgLWjgWhs
         57/aJopH1A9XGLz5vdkGDfcif0624REy4Shh5rhJMz+4HhRm/Xr3185OD+J5aqejxF2l
         lSWlzyZ1adMGL3Ice3BaU0dEyIyyoK4Jk2lwwJ7HbOtWw1gGQErgvpWiIQFjEjYwQpyX
         uvpQ==
X-Gm-Message-State: ANhLgQ2+oymd54DkC30E5a0wq4+uWXERBsh/Av5IdWluV69P2qjMVYt4
        cCG1HiLWhu7dAN/4gMUGg/gRaENfQ7w=
X-Google-Smtp-Source: ADFU+vs/4qcFL+LVTCtAlz2NjTYmsbdTKDdGmhTGaY+3HbTYzPaEnO4r5lRSUNXh5N1edssPZntRww==
X-Received: by 2002:a19:4cc2:: with SMTP id z185mr314829lfa.0.1584380008824;
        Mon, 16 Mar 2020 10:33:28 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id l22sm319600ljc.32.2020.03.16.10.33.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2020 10:33:27 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id b13so14788329lfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 10:33:27 -0700 (PDT)
X-Received: by 2002:a19:c7:: with SMTP id 190mr316101lfa.30.1584380007220;
 Mon, 16 Mar 2020 10:33:27 -0700 (PDT)
MIME-Version: 1.0
References: <1973193.1584373757@warthog.procyon.org.uk>
In-Reply-To: <1973193.1584373757@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Mar 2020 10:33:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wih0Uq8CB+wk1heOobmS3Yuehnp5bqx=4fj=chzAHJoLw@mail.gmail.com>
Message-ID: <CAHk-=wih0Uq8CB+wk1heOobmS3Yuehnp5bqx=4fj=chzAHJoLw@mail.gmail.com>
Subject: Re: To split or not to split a syscall implementation from its wireup?
To:     David Howells <dhowells@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 8:49 AM David Howells <dhowells@redhat.com> wrote:
>
> When it comes to creating a new system call, do you have a preference as to
> whether the system call implementation should be in the same patch as the
> wire-up or is it preferable that the two be split into separate patches?

It depends.

If it's "new code that has no other use than the system call", then
splitting it up is pointless: you'll just have a commit with dead code
first and no test coverage, and then a commit that adds the system
call. If it results in the problems, the new system call commit is the
one that gets fingered as the problematic one, but it doesn't actually
really _do_ anything.

However, if adding a new system call is preceded by first
re-organizing existing code so that you have the infrastructure set up
for the new system call, then that re-organization should be done
separately, and then one commit that just adds the new system call
that uses the newly organized code.  In fact, in that case if the new
organization is at all subtle, I'd prefer not just splitting it, but
waiting a bit before adding the new system call - because if the
changes cause problems, then the reord may be fundamentally broken and
maybe the new system call isn't even worth the pain at all.

So the difference is that in that second case, testing the
re-organized code on its own is meaningful (and arguably more
important than the new system call, since it's a potential for
regression on its own).

            Linus
