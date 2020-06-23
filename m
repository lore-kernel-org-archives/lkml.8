Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAA9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67A1F2072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rEBKHwpi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733182AbgFWSFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 14:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgFWSFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 14:05:20 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DEEC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 11:05:20 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id k15so17563743otp.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 11:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9GN+8WTXztbPfYorYujs4eOD7e69NJjv7MfYuASwATI=;
        b=rEBKHwpizm7Ptg3MSiXYR8mzHuu8RnTRZP8VL1dAlWFQOKnDktMPA1IyFJQjPiGpVV
         pZtSkYGqqTynz7BB9YYOfux0/mCdLQUUuL5D9URSyWPmiAQdidnZGAXkNAHLusVZml+h
         tdXMNHUpXyFOBTzoS9rjOpikizamG9FpjxatFwZwfaDFHVhMa3Eod+t4ZoSJ6N2uSboN
         8uMmhJGzX/7JhY6Mz70d0UIlj4Gont7X2CTkAkBjeqYQPjIzrH6E7TrHR0q0OkU3Xolg
         jAjVBE6d7j++wjpVoK0Thw4OCHr1pU6jLh/0Xw3gcuvhucCis9iZ/0yiIYW2TpdRTu/z
         1DvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9GN+8WTXztbPfYorYujs4eOD7e69NJjv7MfYuASwATI=;
        b=EFnboJYJj9ZJj2UOUUnamjYbp+856lTWFkzV5em07TJkr2J9dy0unkjvl7aaVoYzZG
         kZgyxHJjBzJ1C68ZKHVcd5vJnbXvtqUzEQdlPkeYtZsvgF8+6NsNe4N4r0uTBbsWa2FE
         jDIgIO74iQocufX4qsC8ihjsdVq7847sFc7hcQ6Gl3YYiqdiFvSG2eqnkQQlrBPMpWAQ
         WyTb80hY2knlFOKYmO/1ZCh0dBARuy2sA6X9z0+SURgDrFlve3QEWSaqmKjO/qqGH+su
         osWvtZvI6QKyy0o0803b0poTtmp2UAUJodJZlz1YaRZuiIKLlkqJkpVDmgQpEr2Fgijg
         LS2Q==
X-Gm-Message-State: AOAM532zMm9dSLYtUUP3XOLZ/Ddw2y6OLyawtEuE49kxLWNPgz3d3Bno
        s+h+OR7fIptYr9tOo0GrX4EBom6q71VUvwB9ShgEaA==
X-Google-Smtp-Source: ABdhPJx+g/sUUdsTYxZOwpinRxMoNVeLqgTGnTNLSG5BjKxv4gWdiz5xp9V6RR8ykHO/RAqJZw++35u6gPTMVvxts0c=
X-Received: by 2002:a05:6830:8d:: with SMTP id a13mr19304773oto.91.1592935518913;
 Tue, 23 Jun 2020 11:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200617123844.29960-1-steven.price@arm.com>
In-Reply-To: <20200617123844.29960-1-steven.price@arm.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Tue, 23 Jun 2020 19:05:07 +0100
Message-ID: <CAFEAcA8Myn_QEjfk4Ka604PDAUAWXs6dLUY5bEQ98C__oMsmhA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] MTE support for KVM guest
To:     Steven Price <steven.price@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kvmarm@lists.cs.columbia.edu,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jun 2020 at 13:39, Steven Price <steven.price@arm.com> wrote:
>
> These patches add support to KVM to enable MTE within a guest. It is
> based on Catalin's v4 MTE user space series[1].
>
> [1] http://lkml.kernel.org/r/20200515171612.1020-1-catalin.marinas%40arm.com
>
> Posting as an RFC as I'd like feedback on the approach taken.

What's your plan for handling tags across VM migration?
Will the kernel expose the tag ram to userspace so we
can copy it from the source machine to the destination
at the same time as we copy the actual ram contents ?

thanks
-- PMM
