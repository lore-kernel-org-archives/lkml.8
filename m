Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482F3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17356206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LOEy3o4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgHCKPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 06:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgHCKPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 06:15:18 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1566C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 03:15:17 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id jp10so11460048ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 03:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jkw2/EmVNCjRVxtadc/w9Al3qslsL1S9Hi4Qs74qTxI=;
        b=LOEy3o4VZahFXFtZNHaUDERDe9gXJFDuIURw84jtpCz2oCjzqatjdxi85ruUk216Rv
         v1hJrrxqx8zLrfY9r1ihrTmN4sgTnxd05WcEdMfRaOyKXOp4b1gmudzZ/v+M3UkTRYbw
         aBOfrlcwOIbQ//4dguLte5uNTppdI99KZ26kA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jkw2/EmVNCjRVxtadc/w9Al3qslsL1S9Hi4Qs74qTxI=;
        b=KUDuWCK282g4vgnoxKI73hsmP5NWldlFepSmWO7EL/nMT/Ww8J0Ubcp8yfgpfMR1u0
         7Daz4BYAAWQh5YDcsONOcKuXN7Ob/kEr2Ts4PeFmoCAxgcXYqa0PAjLd9QnZIrh++j0w
         tJ9UHd18gtVT6vJNn4D5+h0xfjj79TcFaHAZQxx0A1Hyp+BKlFQFk7+YcojoF18sH7YX
         xWUIGf9eqqOb/Y227jzTqqwH8orNV9gNr8lYPh+UaWwBGImiJhL8WKHA0NdEw7gjoARU
         MrmojdUcQ49P7FdlVLhd+C0aNjfWLCIApQ4SMnwKnrBFnZnGnjqowH49+XOCVp7ds77t
         gQyA==
X-Gm-Message-State: AOAM533SJnZ1iLdMFWxE9dKBruooEN4BwUFMa6AczgYftHz6kIy4mIay
        5xwpN6/ZK+UIbgDfXl2e/cFRo8qYRRI8OutmP1VOeg==
X-Google-Smtp-Source: ABdhPJxldC6i2ZnyBDDSZP0XTrPLNJsfOi7DQqJ4v7/Qk9xwwbpA48xl/6f5v/lX2ThB5om64KLM7AUyrmnk4DKrzxU=
X-Received: by 2002:a17:906:3c59:: with SMTP id i25mr15537030ejg.202.1596449716662;
 Mon, 03 Aug 2020 03:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200723164311.29169-1-andrealmeid@collabora.com>
In-Reply-To: <20200723164311.29169-1-andrealmeid@collabora.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 3 Aug 2020 12:15:05 +0200
Message-ID: <CAJfpegtXfEQFhwV4MEOf6zQa3KCPmFzffDgDDMJ5=1n+irV7qA@mail.gmail.com>
Subject: Re: [PATCH] fuse: Update project homepage
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        kernel@collabora.com, linux-fsdevel@vger.kernel.org,
        Nikolaus Rath <nikolaus@rath.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 6:43 PM Andr=C3=A9 Almeida <andrealmeid@collabora.c=
om> wrote:
>
> As stated in https://sourceforge.net/projects/fuse/, "the FUSE project ha=
s
> moved to https://github.com/libfuse/" in 22-Dec-2015. Update URLs to
> reflect this.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>

Thanks, applied.

Miklos
