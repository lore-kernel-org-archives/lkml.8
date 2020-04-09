Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D456C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E798B2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586462139;
	bh=w8kOwNf8SSxiuY6rSlwM6iiARoUIlHsuXczFkoIS32I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WcR7uWMUNqSROhKCWOPNCovYq6MKlyxrCv7cqRl7cmdQXG+eFxhg2hg8zJFzTdCao
	 tMR2SQN+rVl7xkFQV74Ol+rqWDXrV97NVSjtc1mzV7R6+9YFx98LAHjzxArCQ528ip
	 7KMI92RpMX7kfReCuKcTbOE50VFM+YqlaKXEzvHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgDITzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:55:37 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37415 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDITzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:55:37 -0400
Received: by mail-lj1-f195.google.com with SMTP id r24so1032191ljd.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 12:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FWqxa7IgEF9kjblzeGUACdh2V+Kc1/x9y1BsC32Ew80=;
        b=aGkY8jiS6vcqO54+MzZBq6t09AZ9z9nNDAnW2XAwn+SlblvC8sObX5Tr+07IwPurpA
         Tuaoiydplp3y51TfJ36L1C78h376noZYZ1tlNKwp67EXunNuIaFgvF6lyQsDZtvXg3TS
         yiPcAguS17DgYZhWDB9geFPpXHoUef6RG+gCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FWqxa7IgEF9kjblzeGUACdh2V+Kc1/x9y1BsC32Ew80=;
        b=PKFDGz7eKJn32FMVMqWmRjBFaQ/5UkLvbTaNp5zIDHYXPf0mp9QvUjkL3q7cDM3Ej+
         xbNO1G0YWnW1zidduS4bwM9arzuT4Qj7Mrubvuo5J5/oVyhEsUwvp385LKt5cKynmbI8
         xZBgEYt6tvyZQnDWKtABX3rBh5srRI9cRvPzaiFqkEQMlFarhx1dUNelJ/dQ8TudyZdb
         EnciFrTApumj149WWVy2UZB0tEH2aQsLKJ51yFF9cRySMG4VprS08l7sZjQ8JVz6EtdX
         vRzbgNweCzCITp1w/rwpTpf4yGIVkt+MBxGWJN0MZsswpbSz+2CUVmH0cUv64jVqOJdm
         a8RQ==
X-Gm-Message-State: AGi0PuaUgTxzgP+8F8LvnToAjZ3WeOo8JuABf+PRre3u1GjIzQy+OcUQ
        ITYyoV/7A2hRpz8vAQ6rS+LRm/+hzsM=
X-Google-Smtp-Source: APiQypJ4I5TKqO4xPnShJirGJZpd8ibsjbD15EuyxOm7t+ZNB0Mvye2Zlrhyt3x8tbZi7S6Coa26qw==
X-Received: by 2002:a2e:a176:: with SMTP id u22mr913260ljl.84.1586462134669;
        Thu, 09 Apr 2020 12:55:34 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id o6sm15239060lji.15.2020.04.09.12.55.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 12:55:33 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id i20so1020163ljn.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 12:55:33 -0700 (PDT)
X-Received: by 2002:a2e:8652:: with SMTP id i18mr901347ljj.265.1586462132767;
 Thu, 09 Apr 2020 12:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200409071133.31734-1-mhocko@kernel.org>
In-Reply-To: <20200409071133.31734-1-mhocko@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Apr 2020 12:55:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_vgcq6R_JXUq0+GXuSLFV8tvfSTzFWjGTimJN1pjF+A@mail.gmail.com>
Message-ID: <CAHk-=wg_vgcq6R_JXUq0+GXuSLFV8tvfSTzFWjGTimJN1pjF+A@mail.gmail.com>
Subject: Re: [PATCH] mm, gup: return EINTR when gup is interrupted by fatal signals
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Hillf Danton <hdanton@sina.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 12:11 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> ERESTARTSYS is also quite confusing because the signal is fatal and so
> no handling will happen before returning to the userspace.

Ack. Except I'd rephrase that as "no restart" rather than "no handling".

We do end up handling the fatal signal, it's just that the handling
doesn't involve restarting, it just involves dying.

That said, I'll leave this to the usual channels, since it isn't
exactly the same kind of urgent fix that I picked up directly..

              Linus
