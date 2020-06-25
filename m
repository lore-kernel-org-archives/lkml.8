Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99C1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4BA1207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593046499;
	bh=kdoW3ZbrTihUALBuiMAKKbb9URe7K/Bvl+W1DjIulXY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gjE/+Y3E7kOux6jd4km/w3QY54gmwyk8UGiaaVxgPX91+gKDs7Y26fZbBCyHwozUy
	 RQwnRmJR1H6euTk9WIXY1GbnGjSTNiQGS9qxP199wxwz2NFHZZoupgp49dFC5cnggl
	 5Ls0218ZlKvYCyTl2pGUfxx9SLVk4YqwkqkQdmS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388930AbgFYAy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 20:54:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388679AbgFYAy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 20:54:57 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07A10207DD
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 00:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593046497;
        bh=kdoW3ZbrTihUALBuiMAKKbb9URe7K/Bvl+W1DjIulXY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=afXZ0R3/vtQAEeX2i5XtKZkx54edf8Ff1mVOhQjYlX6DNL78UKVDwGmQH3cIdZhNr
         8XVwY7489okp+zEz3HtRGexCt6Y9FBOw99LAtq9297AU3xdK0/zGnA8vPfT19kOjyj
         8Yl5OwFps6dR/qGknNRGbcVtJQ0ml0g1GmPIpfQM=
Received: by mail-wr1-f41.google.com with SMTP id k6so4095647wrn.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 17:54:56 -0700 (PDT)
X-Gm-Message-State: AOAM531nubRAUuxwyNEN3WmVJn+Ex/xhgEayIzYDQqWFN7cAPMjGbLvv
        8DuaNkIhvR2X+7WY/tBJtI79GyH0L6KgQCH1Q9B/1A==
X-Google-Smtp-Source: ABdhPJz779otjB6UxvyYvSXLD7JYSNvc4tABAzaUcTzP0k+xqpqli569bbWMPVtlrvFJ5vuLtwuPo1ly5qadFzkLTiw=
X-Received: by 2002:adf:a111:: with SMTP id o17mr33492651wro.257.1593046495607;
 Wed, 24 Jun 2020 17:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593038991.git.luto@kernel.org> <23ac26a4d3a58cbfbc5816e2b00baec753b7e0e8.1593038991.git.luto@kernel.org>
In-Reply-To: <23ac26a4d3a58cbfbc5816e2b00baec753b7e0e8.1593038991.git.luto@kernel.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 24 Jun 2020 17:54:44 -0700
X-Gmail-Original-Message-ID: <CALCETrWXKUPbECLcZp=0Ja5Veqni3=tB1WAM=B67VcuqOyihhg@mail.gmail.com>
Message-ID: <CALCETrWXKUPbECLcZp=0Ja5Veqni3=tB1WAM=B67VcuqOyihhg@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/ptrace: Fix 32-bit PTRACE_SETREGS vs fsbase and gsbase
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 3:50 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> Debuggers expect that doing PTRACE_GETREGS, then poking at a tracee
> and maybe letting it run for a while, then doing PTRACE_SETREGS will
> put the tracee back where it was.  In the specific case of a 32-bit
> tracer and tracee, the PTRACE_GETREGS/SETREGS data structure doesn't
> have fs_base or gs_base fields, so FSBASE and GSBASE fields are
> never stored anywhere.  Everything used to still work because
> nonzero FS or GS would result full reloads of the segment registers
> when the tracee resumes, and the bases associated with FS==0 or
> GS==0 are irrelevant to 32-bit code.
>
> Adding FSGSBASE support broke this: when FSGSBASE is enabled, FSBASE
> and GSBASE are now restored independently of FS and GS for all tasks
> when context-switched in.  This means that, if a 32-bit tracer
> restores a previous state using PTRACE_SETREGS but the tracee's
> pre-restore and post-restore bases don't match, then the tracee is
> resumed with the wrong base.
>
> Fix it by explicitly loading the base when a 32-bit tracer pokes FS
> or GS on a 64-bit kernel.

> diff --git a/tools/testing/selftests/x86/fsgsbase_restore.c b/tools/testing/selftests/x86/fsgsbase_restore.c
> new file mode 100644
> index 000000000000..70502a708dee
> --- /dev/null
> +++ b/tools/testing/selftests/x86/fsgsbase_restore.c

> +       if (false && syscall(SYS_modify_ldt, 1, &desc, sizeof(desc)) == 0) {

Whoops.  That 'false &&' shouldn't be there.  Want a v2?
