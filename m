Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFB6C11D24
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 23:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACD1206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 23:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582239637;
	bh=npUvA3Z4rYmLdHA5oXZiFkJuo1vKCyirh+g/aJDCmjc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VuKkvw4AN0FZgkUgPPpJrxNWx7Nobhg0QsrOFN8Hj++GB4N73UDCHrbf8g9Zo44X6
	 8Y7WWXKlBNH7uukjBezCcwJjroN6Pyw+RuxbJnMstEV5bIcaq8uigYmgMnbgKlH3Hf
	 nOi09hpdqJQ2uTeBahMP1PsnDI7AiQ+Acd2aGwXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgBTXAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 18:00:36 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45299 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgBTXAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 18:00:35 -0500
Received: by mail-lj1-f195.google.com with SMTP id e18so166436ljn.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 15:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oW+dHyuXcdgcpFOp9rkCYNNzyvxL/1mmVUWMW1tVkn8=;
        b=HsJYplXHj9WIosfuyYDxgCIpizr4Q2QTncG0r8kQoBcqx1jdtsR9fFVeYAPGlhnI5Y
         7UWBHhKU9LT9oEd08VowjnmWRULPbdq+faWGzRjHU4lCzwffnnc4X3O8+YTbupxrOXam
         he3lTa6POmGxUb6ylyx451mYPhWfQQq6/MfdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oW+dHyuXcdgcpFOp9rkCYNNzyvxL/1mmVUWMW1tVkn8=;
        b=geEL0LwjBGWKCMrDMeQOR2XMIkhrN97TRkl3NDuhGBtskzpwwpxLPS9f03RzCmTDgs
         wz06DXUNwybEpiO4CRS3Hn5PBUEhkg0VRd2iOT+Ko1afQvuCiGc0tAtKnbI8u7ElexwG
         36hFV8Jie/hwnTleBYmfAjcfYf1Qg66xCvHRry/YbKV5ibA9EJWFx/MurXLBQUSX0Bq3
         cTOA6Nbw4Yk+AsMNdEvEsdRNuiuHUBu4TNQz/v0hV4Pk6ZH557Oli0ESDf+0NICag0Ju
         3vEJhm/zB9DYvdSuy5ZgPK5FMAGDTEYKhNAU3w2Nlk9QmOYt97yJjeuc4P/ONUUMaJDB
         GoHQ==
X-Gm-Message-State: APjAAAXOIgfp7Y9y1DJ0ogN/0MLN3U8e/hy4UTyaxzdzwMrvaXql8OCs
        MEkm4foDd7qORuqPiEGrkItdz78KsLQ=
X-Google-Smtp-Source: APXvYqwxeEgopvmtBbMD+4ih7zX46XAmpH+f+d2wde+BlCccq0CSLIIAJU2dgwSoTOvLtiI1dUnOdw==
X-Received: by 2002:a2e:b4f6:: with SMTP id s22mr19041327ljm.218.1582239632310;
        Thu, 20 Feb 2020 15:00:32 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id m21sm492516lfb.59.2020.02.20.15.00.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 15:00:30 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id q8so172693ljj.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 15:00:30 -0800 (PST)
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr20496205ljk.201.1582239629960;
 Thu, 20 Feb 2020 15:00:29 -0800 (PST)
MIME-Version: 1.0
References: <20200212200335.GO23230@ZenIV.linux.org.uk> <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
 <20200212203833.GQ23230@ZenIV.linux.org.uk> <20200212204124.GR23230@ZenIV.linux.org.uk>
 <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
 <87lfp7h422.fsf@x220.int.ebiederm.org> <CAHk-=wgmn9Qds0VznyphouSZW6e42GWDT5H1dpZg8pyGDGN+=w@mail.gmail.com>
 <87pnejf6fz.fsf@x220.int.ebiederm.org> <871rqpaswu.fsf_-_@x220.int.ebiederm.org>
 <87blpt9e6m.fsf_-_@x220.int.ebiederm.org> <20200220225420.GR23230@ZenIV.linux.org.uk>
In-Reply-To: <20200220225420.GR23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Feb 2020 15:00:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=whPwMTTaGtphubBXeiKitKigutddx9Fcp4Sf1sw4tpyeA@mail.gmail.com>
Message-ID: <CAHk-=whPwMTTaGtphubBXeiKitKigutddx9Fcp4Sf1sw4tpyeA@mail.gmail.com>
Subject: Re: [PATCH 4/7] proc: Use d_invalidate in proc_prune_siblings_dcache
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 2:54 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> s/no inode.*/it's a directory inode./

That actually makes my worry go away too. We don't allow aliases for
directory inodes, iirc.

So then it doesn't depend on some /proc implementation issue any more,
then it's fundamental that there's only one dentry.

            Linus
