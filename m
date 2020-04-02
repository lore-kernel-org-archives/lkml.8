Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B22C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 687DF20719
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cRMdri6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389746AbgDBQLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:11:50 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39902 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389695AbgDBQLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 12:11:50 -0400
Received: by mail-lf1-f66.google.com with SMTP id h6so3209521lfp.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 09:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yt6zWERiKTCjDwTG56J7PYbCEtxdXxHidONUlaX/0Js=;
        b=cRMdri6VXL1PrIKwuy81gkl35L7PPDq29lpPSc9oxeCIc5SGIiqZg8pZqrkDDLnVb9
         ATIfA6ph4AX+mgQJ2g4xFtlTed8dXG9kFXpWDDmRmc9iZRJ/VvaCXIYwKdNcvGxYya9T
         JrvodRpKIVTZYh5OZgKCQvDiX1x+OBqYoVfSEje9Sjp+wrWHzZu7VuCxoB8n27O7DS7K
         m2VuRbXpPfA/c2K3BAp3HojSyhNMlssuF//ntu3Mv5fMltgcizzbIz2Hwvm4Rl5RrTh7
         db1ESdeqzHZCuVNlj451tRQJnKHTM+fat+l1dFjPYun9ATeoy3nvp7eWR1J38Wv435Ab
         BUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yt6zWERiKTCjDwTG56J7PYbCEtxdXxHidONUlaX/0Js=;
        b=ZO+kNInl5aAeZ9fgX+GtJVnju+SXuFH0RsysLk1gKW0E8TjV/vsOmhjn5GCqWlIVsM
         iYtCiMWZz2T+/+wZY9YHmENhz69KbLmcO7tUtscvpaX//QEigJbUOQIW6JPBoJLe0xQR
         W9+hHpyiPpfzCtPX3U9Ch0Bd5u/d/ZLiI1bf/Im2bQspY69iuiiekBOeNaYT2jWuCfp3
         IUt+hDZYxKo0Znikb+KHUH1ZUZGWBJmG1qxpY4PKKh+b5d6Jjp1Xxi2PNoZ00A4vaW96
         RTvNAMWJCkw+4sosiBhUtBydG/S+8/AdKcPy+SJbmSlaAFvBuw0LB+9ZvGXc3k7CfzV4
         lG7A==
X-Gm-Message-State: AGi0PuYXCyqiwxPD7v252tjeJAoI2pZh+tgSLF28+X/2Dc/fVk4862oG
        OpPdJMwyXLrGbr+n8ulKEoYx0+LT9Ux3zYp429xzYA==
X-Google-Smtp-Source: APiQypIY+3gHVfOON959mT3BWUZJaXvVOSvN8K0EQOmiQuny69JdN42ugLz+DORki8l/0FvOcEvx2X4tgIn4sOhB9vA=
X-Received: by 2002:a19:700a:: with SMTP id h10mr2752575lfc.184.1585843907063;
 Thu, 02 Apr 2020 09:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200327172331.418878-9-gladkov.alexey@gmail.com> <20200330111235.154182-1-gladkov.alexey@gmail.com>
In-Reply-To: <20200330111235.154182-1-gladkov.alexey@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 2 Apr 2020 18:11:20 +0200
Message-ID: <CAG48ez2L__TODzwQW0MjYim6rh=WjkU__xvAoi2CtBCkNP2=Fg@mail.gmail.com>
Subject: Re: [PATCH v11 8/9] proc: use human-readable values for hidehid
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 1:13 PM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
> The hidepid parameter values are becoming more and more and it becomes
> difficult to remember what each new magic number means.

nit: subject line says "hidehid"
