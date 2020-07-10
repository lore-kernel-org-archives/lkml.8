Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889A4C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E4512065F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594421044;
	bh=016dFnug2fKc/w3bSkiGB5S+kVrXvzzD9ms2E0fwUTI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dIHKr+zgEVtF+UzdqOKcJPhhcUlyhqAAnKIPJBzQQ0jRnZidHhn57zLN/JBnFqWvK
	 QV3JFGR8pQvfFl53JxhyNxUYoqWQ6yHd5d/xCnvF9EVyz2x3lVnWTVleYn+UkvdIs0
	 i9Cafmsb71axNiPcNmgOEUiHc1gdsfgFpbEv8Gvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgGJWoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 18:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgGJWoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 18:44:02 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A8EC08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 15:44:02 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h19so8109928ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 15:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+thtRKJEj4DhIkEI6p+GkkTjAsDSYTDkX8oKURyOcGc=;
        b=EGO2snRnxuL6RoH27XeBowczxmsAaLfO6uLpBlMOy45LATMKOWSFFk1IrSjjsXFz2v
         rNlXSeDKRIbt38tUxq7xLAWLsXI6Wf+wbETMPA63v2Z/YsrZH01CZAC5MYeCWgJOletJ
         O9AL8l7WpdulV3yDBrfd+PUo1fjJNcFW5TnuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+thtRKJEj4DhIkEI6p+GkkTjAsDSYTDkX8oKURyOcGc=;
        b=A96HFNL0X+qaq+Yri9ILmKOUwAmAEzx7VrlaL4JepvCUtLo591dOMuzhiIRWu+q5ad
         ipGLGFLqa46Izixgvaoz/D8gUMsY8u4/mMZCXyVndxqKFBPMxNKGlLmpqZ1HqKuObs0t
         /T3D7l9fIlrRx1F/1WRIvZvSLI0QCFxFTQJumJPhDun9BOguImq/SArrseMsp4HxgaY0
         z8+W9mygWjYJECIG2K+LJTuY9e+e5OvDDr6TxTzaQycuFCv5AYBIegUbApFiTelp6aHS
         x6l9hiPMU1ihn+hf2VHBpRvnXgX9n29tINRxm/wSGCDU+hw2jVFQ3B6FM9oVKNu82eS6
         qAuw==
X-Gm-Message-State: AOAM530FW1y7cENbpzPFvNtMHIQtaskWb7rf33wOeg0BkWVBBmAQAqeg
        m8CAHRekrPBHqt1FzXk9gdEajiRS+HA=
X-Google-Smtp-Source: ABdhPJxTXCYByR9YiZGmfeQ2xxlNDDiXY4yJIXIvRtZtIHKLrWoU/wqtZ1glBAOms6JNBOfVekpimA==
X-Received: by 2002:a2e:954c:: with SMTP id t12mr40834896ljh.287.1594421040640;
        Fri, 10 Jul 2020 15:44:00 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id q1sm2338750lji.71.2020.07.10.15.43.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 15:43:59 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id q4so8180355lji.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 15:43:59 -0700 (PDT)
X-Received: by 2002:a05:651c:1b6:: with SMTP id c22mr36397087ljn.421.1594421039353;
 Fri, 10 Jul 2020 15:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200709221102.323356-1-cesarb@cesarb.eti.br> <20200710223441.756320-1-natechancellor@gmail.com>
In-Reply-To: <20200710223441.756320-1-natechancellor@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Jul 2020 15:43:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjb_WVt2Dxe6GUVcMzgms1od7Qt83dOShQ1-ux+tp1RsA@mail.gmail.com>
Message-ID: <CAHk-=wjb_WVt2Dxe6GUVcMzgms1od7Qt83dOShQ1-ux+tp1RsA@mail.gmail.com>
Subject: Re: [PATCH] mips: Remove compiler check in unroll macro
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cesar Eduardo Barros <cesarb@cesarb.eti.br>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 3:34 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang 8 was chosen as a minimum version for this check because there
> were some improvements around __builtin_constant_p in that release. In
> reality, MIPS was not even buildable until clang 9 so that check was not
> technically necessary. Just remove all compiler checks and just assume
> that we have a working compiler.

Thanks, that looks much nicer.

Applied.

I think we could probably remove the (unrelated) clang-8 check in the
arm side too, but I guess I'll let arm/clang people worry about it.

            Linus
