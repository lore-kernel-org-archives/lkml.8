Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1496BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8C482177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598552136;
	bh=sStVGbf/ZV0Q0C8eLwbjT2TAJyzfU1tkFgn6vdFRu4Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZGBlN2pEbfNobcNy6pd0m4kl9Ls/RHZlysjn2opCK/8gWyqiTApGx/cUmauxK5uOq
	 VcmwD2Q5B0jgeBC3HruzkPDWM7hNlXZOIof1L43yWKrhanAVlhWWkV63kgITIOWPTd
	 mHL5vzZTSOd3i4jHb87JnnS4IxX1OH11byGx81kE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgH0SPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 14:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgH0SPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 14:15:33 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF49C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:15:33 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id g6so7469813ljn.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Ln4YDv+McQTrVSBLkYMyzgo5ffLr7W4nh7mUMFYOZo=;
        b=GjsK/u6ib7N+ctD2EUfS3Yg2gOjkfLasSaGCU/YbFFT4pm7wC/mAUjkvSP+UBZidUg
         P75Y7Q+9vqNQMjHTBy6Jwr30jghzFLvVdhlC7Nn9Ui5WCs2KOmFbugeMsgtI/Xw61N8K
         QeupHGovYgcCrHWAn29zkzD17dqNMKZTBIjAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Ln4YDv+McQTrVSBLkYMyzgo5ffLr7W4nh7mUMFYOZo=;
        b=KajpsfE1YryTlfGYiBdReD1VbkCycHLUKXhcTmj9SWJ9mJnq4La5MuN4Lq5kHk1oZH
         LA9MHyJ6DpY4nCdEcraj5MIhE09RS5QMLJOZeQCUjCwY7+pgTz0v3uqM5hOETRICBFnV
         Bgws4u097tik7qyxLg05bAPNnSLYQJqgpkMg91cBFD4P5WZINsKTuwIbBZ1PCkK0arZ3
         At+m+UlfEOBNsLuPLJcEDuu7gv56Vgzd4j3Ng7Fh3l+bHC3bliQXUOOZeO3Mma9x/E/T
         uuKf7dP+SJs/N854hAUAk01dqnO/lhVbbh5IATWe1b6vx8uMX6A8jySqhORbxqFpy2xU
         YplQ==
X-Gm-Message-State: AOAM531ppRPQeTEQNHs5HjUN00hYiq7UkjtHCllnB8YPB+FS8j3m4Vxe
        KFll1UkZw5NrpFFRc27itiUzn5JFsO9GLQ==
X-Google-Smtp-Source: ABdhPJx8VYoAVsPdK6P9nSZp+V3lpQhsxr/shI4CIal+cqOj8hGKmCMStM7XNTT0VjUwx6xxiDilYw==
X-Received: by 2002:a2e:920c:: with SMTP id k12mr10723334ljg.29.1598552131428;
        Thu, 27 Aug 2020 11:15:31 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id d2sm632048ljo.126.2020.08.27.11.15.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 11:15:31 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id h19so7481835ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:15:29 -0700 (PDT)
X-Received: by 2002:a2e:92d0:: with SMTP id k16mr9604351ljh.70.1598552128279;
 Thu, 27 Aug 2020 11:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200827150030.282762-1-hch@lst.de> <20200827150030.282762-9-hch@lst.de>
In-Reply-To: <20200827150030.282762-9-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Aug 2020 11:15:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjxeN+KrCB2TyC5s2RWhz-dWWO8vbBwWcCiKb0+8ipayw@mail.gmail.com>
Message-ID: <CAHk-=wjxeN+KrCB2TyC5s2RWhz-dWWO8vbBwWcCiKb0+8ipayw@mail.gmail.com>
Subject: Re: [PATCH 08/10] x86: remove address space overrides using set_fs()
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 8:00 AM Christoph Hellwig <hch@lst.de> wrote:
>
>  SYM_FUNC_START(__get_user_2)
>         add $1,%_ASM_AX
>         jc bad_get_user

This no longer makes sense, and

> -       mov PER_CPU_VAR(current_task), %_ASM_DX
> -       cmp TASK_addr_limit(%_ASM_DX),%_ASM_AX
> +       LOAD_TASK_SIZE_MAX
> +       cmp %_ASM_DX,%_ASM_AX

This should be

        LOAD_TASK_SIZE_MAX_MINUS_N(1)
        cmp %_ASM_DX,%_ASM_AX

instead (and then because we no longer modify _ASM_AX, we'd also
remove the offset on the access).

>  SYM_FUNC_START(__put_user_2)
> -       ENTER
> -       mov TASK_addr_limit(%_ASM_BX),%_ASM_BX
> +       LOAD_TASK_SIZE_MAX
>         sub $1,%_ASM_BX

It's even more obvious here. We load a constant and then immediately
do a "sub $1" on that value.

It's not a huge deal, you don't have to respin the series for this, I
just wanted to point it out so that people are aware of it and if I
forget somebody else will hopefully remember that "we should fix that
too".

                   Linus
