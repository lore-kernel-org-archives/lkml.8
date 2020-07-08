Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629D5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 02:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41DFB20772
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 02:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MBlkOOaM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgGHCAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 22:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729181AbgGHCAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 22:00:17 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE19AC08C5DC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 19:00:17 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id 72so6936759ple.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 19:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u/NB405Z1TGjtZAiReLViP52ut2JNiZUpUX2+/hS9zQ=;
        b=MBlkOOaM9paH9hQQovavkqmNpn6kimzpHHW9Rwxu1Xw10PwIN6ecI8JMDcOm5bBlx8
         qOUmSzTCMHcjWpgEzImM9swC8CZYizzpva6FG30NPA0Dv7w4ua+e0bMfQk0lHKswaiXi
         3+kInOqVKYo5kxRGcrRBgpq+DRw/nsEPL2dzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u/NB405Z1TGjtZAiReLViP52ut2JNiZUpUX2+/hS9zQ=;
        b=jMXesoUaF6A+4vpzt4OehydEitwT1T/HOrCuq8B6Twawk72McqfkvKcDqaJu3HH3VK
         C+D+V2ZwHyxwDO9SEk0i2+ceQvoFwHm9bzjtL7w1cCyYfT/zuyMq41CT5O0YNpiLOS2i
         sSB4rsGLGWNhj8qWeFwqb+B1/j16CMAMKgAwLciYJGzltGwtBOu+z/q/c+cuarrNYGdo
         RBgZ0dly6vxvfgJKPMib7ayVZPxIrxBCxXcQ2dGc3OJ+h9MDRPjgBMfF6VaJQNhygukS
         5vJvD7TLk47zmyUIPkTSLOOOxY/mBOs5Ae/ZhKjF2aF6m82WrPVwvJzubys619VLQ2uq
         iN0A==
X-Gm-Message-State: AOAM530J7vITOuM0odvkrpynFVK+eRdarfcUqkxeMkGeN9p8tP047S2g
        z4xiGn8Kn8hGy0JVCyCrsfQYhxJKV80=
X-Google-Smtp-Source: ABdhPJyVs8uL4JfAJM6teEQLGRWubgP5mIejizDNiDtnt96R+c31W82MjetFIVRVBWrWSp/WQJPLIw==
X-Received: by 2002:a17:90a:3002:: with SMTP id g2mr7353479pjb.68.1594173617292;
        Tue, 07 Jul 2020 19:00:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 73sm23957949pfy.24.2020.07.07.19.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 19:00:16 -0700 (PDT)
Date:   Tue, 7 Jul 2020 19:00:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Shuah Khan <shuah@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: linux-next: manual merge of the seccomp tree with the kselftest
 tree
Message-ID: <202007071858.C097D869BB@keescook>
References: <20200707145720.02636577@canb.auug.org.au>
 <202007070125.ECBAB9E7C3@keescook>
 <18b266d0-a116-7201-6cd8-6e11f809e753@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18b266d0-a116-7201-6cd8-6e11f809e753@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 01:27:59PM -0600, Shuah Khan wrote:
> On 7/7/20 2:26 AM, Kees Cook wrote:
> > On Tue, Jul 07, 2020 at 02:57:20PM +1000, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > Today's linux-next merge of the seccomp tree got a conflict in:
> > > 
> > >    tools/testing/selftests/seccomp/seccomp_bpf.c
> > > 
> > > between commit:
> > > 
> > >    9847d24af95c ("selftests/harness: Refactor XFAIL into SKIP")
> > > 
> > > from the kselftest tree and commits:
> > > 
> > >    aae7d264d68b ("selftests/seccomp: Check for EPOLLHUP for user_notif")
> > >    11b4beaa0d31 ("selftests/seccomp: Make kcmp() less required")
> > >    ef332c970dfa ("selftests/seccomp: Rename user_trap_syscall() to user_notif_syscall()")
> > > 
> > > from the seccomp tree.
> > 
> > Har har -- a collision of my own creation. Yay lots of trees. ;) I'll
> > make this go away; the cause is a harmless cleanup.
> > 
> 
> Thanks Kees. Let me know if I have to do anything.

Yeah, as it turns out, I could only minimize the conflict, and I think
I'll just mention it when I send the seccomp pull request for the v5.9
merge window.

Thanks!

-- 
Kees Cook
