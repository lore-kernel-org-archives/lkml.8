Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B0BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B602204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uKqv+S2F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731332AbgFRPGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730950AbgFRPGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 11:06:12 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877AEC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 08:06:12 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id n6so4796602otl.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 08:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l2w5iTdi6pjAzijl7Bc7YhZ6+y+qiHcAmJvuLO19co4=;
        b=uKqv+S2FuImmiuJOy8hZFJRZW0IbmUHdc3pzKLWsElMRzEIfB8Dmat6FhfQHbQDXMV
         zaNY62+U/oXQonZrN9Y9e20vfNRQuYJEKPpMiTvoBq7VCTtoebGjebK0ZDeH4W55Wmd2
         sZ40DQcu7wpBiE+ejR8UN/nlwkzMkpv3AuXt0DcSuQQ9nq3xfgnS018C9wdO8vkmT39c
         1a9Hp0pZZi0h+cmXA1W/NhPASOUS8kRtKWetnoLN2fqtGigyg3O9qb/hw8D1XkBWtyvC
         BswPOGNAU2Sy5tWTbp28S0VaW7wlKuN1h2Tz+FYM45G4KATczAU5h4YNKFuRehHgdEWo
         e7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l2w5iTdi6pjAzijl7Bc7YhZ6+y+qiHcAmJvuLO19co4=;
        b=biGD3XBYzjusR4fd3dRl9djWLSCuE3hRilLXmQemEnRhaltQhR453yx3x2qHZimyHs
         8zpOzo24x70BER1yscRxzi8TDYjSGvnyu4/1uampTq9YBgr80soGLqUfb790unZySdrF
         BRzoZwjyI8uO09uXlW3rU1l+uutsCoKK3QIKIRcVdbz02BCvyCg9gaeOEDoSXAHD6FmH
         sv0av2Uunlvx0sDze/utuooKoC5+CR/62DdLMQM2/gqyQt6ANebJ+Y5eStkmk0bNv55o
         jQkThaDZCqISW4Q9IuLxfziBSZi+45kitnuUUHNdqtEsFUuZVVtXNQCd6FFgLqGIirut
         WlOA==
X-Gm-Message-State: AOAM531cls2y2CABEhWZWuF56Vjzg207Ufq/CZDap0b+j6bVkRUgRBLh
        sa7PMTaXGIfo2lJwTNQkOIyBWF+rqRzR4s1EjtlIpQ==
X-Google-Smtp-Source: ABdhPJzFPc1NdRB73G1tM7LvNF+rN3FrlkyYZp5Y/15SFFi5XKr8i7Hp6GOLUfOfs2/lOt5NXmv2FO+R/e84mctWF9M=
X-Received: by 2002:a9d:58c9:: with SMTP id s9mr4074802oth.233.1592492771742;
 Thu, 18 Jun 2020 08:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200618144407.520952071@infradead.org> <20200618144801.819246178@infradead.org>
In-Reply-To: <20200618144801.819246178@infradead.org>
From:   Marco Elver <elver@google.com>
Date:   Thu, 18 Jun 2020 17:06:00 +0200
Message-ID: <CANpmjNNpnW2AyzKOQ8tuXvhs04Kugjuj0y+j4wMxA7YfDyOwxg@mail.gmail.com>
Subject: Re: [PATCH 4/7] x86/entry: Increase entry_stack size to a full page
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <mark.rutland@arm.com>, mhelsley@vmware.com,
        Steven Rostedt <rostedt@goodmis.org>, jthierry@redhat.com,
        mbenes@suse.cz, Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jun 2020 at 16:50, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Marco crashed in bad_iret with a Clang11/KCSAN build due to
> overflowing the stack. Now that we run C code on it, expand it to a
> full page.
>
> Suggested-by: Andy Lutomirski <luto@amacapital.net>
> Reported-by: Marco Elver <elver@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

This fixes the unpredictable crashes.

Tested-by: Marco Elver <elver@google.com>

Thanks!


> ---
>  arch/x86/include/asm/processor.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -370,7 +370,7 @@ struct x86_hw_tss {
>  #define IO_BITMAP_OFFSET_INVALID       (__KERNEL_TSS_LIMIT + 1)
>
>  struct entry_stack {
> -       unsigned long           words[64];
> +       char    stack[PAGE_SIZE];
>  };
>
>  struct entry_stack_page {
>
>
