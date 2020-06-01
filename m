Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B4EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A1692065C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="1bLBHx5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgFAPg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbgFAPgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:36:23 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FCCC05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 08:36:22 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id f7so9613547ejq.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 08:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cOzQOgAom9rQmo+hpj4LfsaeGdzJ+MyyfqV630jExfM=;
        b=1bLBHx5st11CPvmuw1qF7oVF/nb1PuAaZA7ttMfQ1MyvrYzkm731V4kRUPXILYRKKC
         5NfkPsUADXF2HPIdvyN28mwZHEQ3nkTSzZ27V9iZfWAg3XHOTa8X1xQKMwkp695Y13QH
         2Smu4mVJhZfsHtwSuZdYRIodJIL2rpekpi2dmEPabrOH4CEXK1t8wOQpPx1b0hBeeAlN
         GdfGYBuvJsHSqhwnh1IeBNk8DE0JNHtSdANFWsawCCWEJR4E6mSVMwtOQXq2ogwqLmYU
         8mxDCg/gb3jy7hx4Drrn5SS1O996fBKfw3Jnr9pl6C4Qir45umMDXsYcrNsXHv03m2mL
         SvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cOzQOgAom9rQmo+hpj4LfsaeGdzJ+MyyfqV630jExfM=;
        b=l7a0IphmIqJp9IbKd93idaiSK7h6NQq23duH3qxz24LM0/9FZxp+IUrCOaS7pr2VZi
         P0sI5vLabkiEKa1WqrVDnezMSev8TRpdLzMX0XawilxBm1oxScDhO7CIND1YCqx+oJ87
         wHeDmGtYyJ63DjwONXu9PHkkoQkbAUOHGJSJhXEkvta91e7L8Vz8K6g7HJ9ffKe9gnew
         CwzCBFq0CbfmjS2jPbZcqulsN93E4ircGy11QoelNpKbUfCd3woImMItOfEXBYJhqyS8
         MbZh/1uE3eh9TP3RA2YBy4ifRliYZgudyDaz0CGkOWRh/R/KRZs/Kj46yVbQEG3OkWtv
         0jsA==
X-Gm-Message-State: AOAM5304yuOBHRUs6qkcM+UCQvdrSZdIZ73m1d2AXiB9QrM1d7ZWc+ae
        4WSUMztc2ojg7mFGdAqcuxlzxweX0CmMUpRenBKi
X-Google-Smtp-Source: ABdhPJxVaLECnW5ysWNl7aGrxxD3Sa6GGI54d7azZ3A9R39oQ9z6eiacAbvYKZ6DiQ+k7L+7xyOd2//IcuQOaHPJrQo=
X-Received: by 2002:a17:906:f1ca:: with SMTP id gx10mr2336087ejb.542.1591025780793;
 Mon, 01 Jun 2020 08:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200524205238.GA17576@embeddedor>
In-Reply-To: <20200524205238.GA17576@embeddedor>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 1 Jun 2020 11:36:09 -0400
Message-ID: <CAHC9VhRcpqs6TGoqK_soTz8Jo5BCDfhq1kqKGGJeJpbXhWZRsg@mail.gmail.com>
Subject: Re: [PATCH] audit: Use struct_size() helper in alloc_chunk
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 4:47 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>
> struct audit_chunk {
>         ...
>         struct node {
>                 struct list_head list;
>                 struct audit_tree *owner;
>                 unsigned index;         /* index; upper bit indicates 'will prune' */
>         } owners[];
> };
>
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
>
> So, replace the following form:
>
> offsetof(struct audit_chunk, owners) + count * sizeof(struct node);
>
> with:
>
> struct_size(chunk, owners, count)
>
> This code was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  kernel/audit_tree.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Thanks, this looks reasonable to me, but it came in too late for the
v5.8 merge window (I dislike taking changes past -rc5/6 unless
critical).  Once the merge window closes I'll merge this into
audit/next.

-- 
paul moore
www.paul-moore.com
