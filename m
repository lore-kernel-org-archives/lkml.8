Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB4EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9C162081A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ocallahan-org.20150623.gappssmtp.com header.i=@ocallahan-org.20150623.gappssmtp.com header.b="Pk+mVIcO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407742AbgFYXPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 19:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406243AbgFYXPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 19:15:10 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D76EC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 16:15:10 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id o2so4540952vsr.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 16:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ocallahan-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=5o0jgcCQjFP2QLOrgYjdybkZG09dTeT1+zi5a4htMIk=;
        b=Pk+mVIcOsA49tZIaEKmqBWlpY0IrdejkM8JzCSyCIwoOU2MP22GqFUBOxtE2kqEXUB
         WvBsmAELjUa85Ceu/F9gaXqJpUmozC+7A9qjRtYawF/dmXzEmxKeJnRxakPrabzsLQE9
         YA803mqR9TPwVbLE/t3rPZ17yz6/skGM4MgkjvH0De1u8n/XDV/NPt4PyRgy8WjSIF7g
         VlPr4xospmepc89uZZidSCB1MwH7VmoCftLEm4ElsraXrLRFDg/DOuoCfhRNy08mS9gk
         bT7t3o+qsE3by2491TMhy7TjL7fBm1WnFg4KbwIxoQdNeVCJVdC0GqZmdKcYAgiU8+k2
         U8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=5o0jgcCQjFP2QLOrgYjdybkZG09dTeT1+zi5a4htMIk=;
        b=eNwUpQGJIFVQKmN1f/6XshgtOzuT8YB7ifqL4nJYg+D6HEjTy2c15IK5fc46tE2fYv
         V267j/VgvPI0hdGJCvRQLa14Wr1EH9SRBuJeGUyH9k2/JmVCoED3GNj3snQvJIPo9wb0
         Kdj09H0HcIKnW878vXeeDYdRv14dfJvgtrCwxLBKXk5s+MUBtTCry2vfd8BTQwh5fIGT
         7b7y1vXsAtyhu8VB8OP2KpJPGkgu9aAtTVyIkBDvFHgNgCrx750dmNWE2pzyn2X/1eu7
         9I4cRtC/jpF0E8XGXNsiNXiWtSwuatqRFlKtu5UgylVyI58vw7RhwsQwd4WF2Eq6jCdB
         uTwQ==
X-Gm-Message-State: AOAM532StCxqX6fvyL8Ll1zw6vvoMN2m9i4z69COw++bw5+pRjkSrROU
        LRVQB7JQxbcGbP5Pf784/j0TLNAaXPp528M3dkE=
X-Google-Smtp-Source: ABdhPJwVRb1/Dcbjis0OEkRQ+bTDVT2cJSlPKmnXkKhQoWxbjPISlIJalZaHVnY9ZT4UT4gwpSZvDrxukGacH2VyDgU=
X-Received: by 2002:a67:26c2:: with SMTP id m185mr467694vsm.39.1593126909772;
 Thu, 25 Jun 2020 16:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200530055953.817666-1-krisman@collabora.com>
 <AF65147C-15DB-4BA4-A08B-55676B489BA5@amacapital.net> <85367hkl06.fsf@collabora.com>
In-Reply-To: <85367hkl06.fsf@collabora.com>
Reply-To: robert@ocallahan.org
From:   "Robert O'Callahan" <robert@ocallahan.org>
Date:   Fri, 26 Jun 2020 11:14:56 +1200
Message-ID: <CAOp6jLazKdQ4U8Zyuqf3Zj8DgBnq0QGCbpk3f46dnyLDr69upg@mail.gmail.com>
Subject: Re: [PATCH RFC] seccomp: Implement syscall isolation based on memory areas
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Gofman <gofmanp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rr (https://rr-project.org, https://arxiv.org/abs/1705.05937) grapples
with a similar problem. We need to intercept commonly-executed system
calls and wrap them with our own processing, with minimal overhead. I
think our basic approach might work for Wine without kernel changes.

We use SECCOMP_SET_MODE_FILTER with a simple filter that returns
SECCOMP_RET_TRAP on all syscalls except for those called from a single
specific trampoline page (which get SECCOMP_RET_ALLOW). rr ptraces its
children. So, when user-space makes a syscall, the seccomp filter
triggers a ptrace trap. The ptracer looks at the code around the
syscall and if it matches certain common patterns, the ptracer patches
the code with a jump to a stub that does extra work and issues a real
syscall via the trampoline. Thus, each library syscall instruction is
slow the first time and fast every subsequent time. "Weird" syscalls
that the ptracer chooses not to patch do incur the context-switch
penalty every time so their overhead does increase a lot ... but it
sounds like that might be OK in Wine's case?

A more efficient variant of this approach which would work in some
cases (but maybe not Wine?) would be to avoid using a ptracer and give
the process a SIGSYS handler which does the patching.

Rob
-- 
Su ot deraeppa sah dna Rehtaf eht htiw saw hcihw, efil lanrete eht uoy
ot mialcorp ew dna, ti ot yfitset dna ti nees evah ew; deraeppa efil
eht. Efil fo Drow eht gninrecnoc mialcorp ew siht - dehcuot evah sdnah
ruo dna ta dekool evah ew hcihw, seye ruo htiw nees evah ew hcihw,
draeh evah ew hcihw, gninnigeb eht morf saw hcihw taht.
