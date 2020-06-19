Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923EBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 03:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65EC6207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 03:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmeOPYSr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgFSDK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 23:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgFSDK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 23:10:57 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9352CC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 20:10:57 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id e11so7991795ilr.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 20:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k6ZI9jEu4UoQH8Ofl7MpW97yrlCPyVzQQV94+qZWb8U=;
        b=UmeOPYSrUN6dlw88r+8c68vMbFTyxQl6BKY8HqajIj3Sme5eyzgZxI6XNv9w+bX2yf
         eTGtBbP5c/irV2OpdZkBfW/ZJjYWe7rpNUVp5/MuURcsnF6ypJbPATL5BziQKbcmrvZj
         3UhVHcp8BGGRdpvOi/3Mbtl2s5lnxd5N+kxvFLJvGNUVFhq9RfHI/XNNHcr3LPqcB4ni
         xKiZalhKBcCd2YjJO8PbK7f7l4l6agKssZ+hw1qaClquF0pH0mp7GZFFm7FN2jgX4xx2
         bwHqKweMQXBYkE7KdSAOHA1Zm3fpuQMtxU0esomvQqQ9dqsZbM0FnZcrhCnZoPHe8mgx
         sfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k6ZI9jEu4UoQH8Ofl7MpW97yrlCPyVzQQV94+qZWb8U=;
        b=bcc9p8GuKmqjtKAXHYJ9k98tUfXWD2LmBpV348N1W9jMElcKRs8dHmb8MSnWCSqkTx
         F6/LkKJrdShTidBO5Yr7A25uw/TrD2e9Vg3TPz0lNpuH9vAUNY0KqSgMRMYBB5IJtP9N
         4fsCajkyKuMWCcRKOGWDWoImsMhSGQ1fA0UZBxGrjw1Gd9haQQkMFjcfseJqRGqeVIGs
         gQjmervb/riA82x4NoTskfFL6pXoRMplTPo+XjO9C5N5wXduwxW2pC1yPxZuYovxCkqX
         zn6uJotBZWuHZefEkVLCEZWRgiXq73qyYb1+CSZcYTf10x1YIfbmjt/LmpKCRXcxJdqh
         va9A==
X-Gm-Message-State: AOAM533YSk7lG8bVVxhjBUazIxI8+FN39eEo2HWOyykypl1vuQPszyXB
        dr2FuzbPrfpR7AajxoHo8ydEuWMKTqhbegDVw4Bw948jPKI=
X-Google-Smtp-Source: ABdhPJwaUPUjh5iP87WvfjlRzBJaBXuIHA1S2VNCspN7rX/fwOAwsPRg3xTDXsriK5rJAHcob414hklhrUmGrj8CjtA=
X-Received: by 2002:a92:c941:: with SMTP id i1mr1565588ilq.94.1592536256993;
 Thu, 18 Jun 2020 20:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200618144407.520952071@infradead.org> <20200618144801.819246178@infradead.org>
In-Reply-To: <20200618144801.819246178@infradead.org>
From:   Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Date:   Fri, 19 Jun 2020 11:10:45 +0800
Message-ID: <CAJhGHyDFoZq993uj7A8UAmiK-vvScFnyiOwWEFS0SOG2h3-VWg@mail.gmail.com>
Subject: Re: [PATCH 4/7] x86/entry: Increase entry_stack size to a full page
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        dvyukov@google.com, elver@google.com, andreyknvl@google.com,
        mark.rutland@arm.com, mhelsley@vmware.com,
        Steven Rostedt <rostedt@goodmis.org>, jthierry@redhat.com,
        mbenes@suse.cz, Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 4:37 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Marco crashed in bad_iret with a Clang11/KCSAN build due to
> overflowing the stack. Now that we run C code on it, expand it to a
> full page.

Some of my experimental code also once got crashed due to overflowing
the stack. I'm glad to have the stack expanded, thanks.

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

>
> Suggested-by: Andy Lutomirski <luto@amacapital.net>
> Reported-by: Marco Elver <elver@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
