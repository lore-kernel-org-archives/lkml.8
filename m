Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D03C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47AD122464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="pG17K27r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgGNMxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbgGNMxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:53:06 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BF2C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 05:53:06 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id f12so21633850eja.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 05:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=02YT1Lj8tQBcXYWYQpvUg3R7oFq3J1/SDbHKgSEViOM=;
        b=pG17K27r/eh9uS5LUykan0qzoLSeXs0OsFRdIMBC599dtjKqobI6aXecAu+D4I3vrs
         VlOgdWyjwcBqGzGSXtVR+I7+Lgkd+G4Ihk5N1cBYftfzWFJBq4o6wWt9nU5E8+XkpYYi
         BSvk0drNpPK2i0jyJHwa6r4ZUQroktho/OPvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=02YT1Lj8tQBcXYWYQpvUg3R7oFq3J1/SDbHKgSEViOM=;
        b=F2dLca5QrieCTEeCBsdX0u0bhQR6usZPA/rRjS8lD+xZ8uTJcvg0Z74SVUe9BkTtjx
         vTUJsNB86cf5D32vMrWoRn8XNcgRv+udd7jKA6eZOS6gu6RrPQHB/b+8IJxUisR7PauJ
         LM3SUJyk3VS785s714ic+kyO7/R6qFGMvFUabHxriqJnOp4WUEF6B6vvo2ap3ivbg8I4
         B3xAwLCD9vb1vkAzauDY09DngzyNkDM71EiqB0xs3uRi/bgmtjN3GMjh4H90kUY4S5X1
         v8O+IqJKln1vmhNJ8a0zCiQaBqr3SWGHKmqf62uPDnzKhKiB9MzLFSfmL+qAD1DrdTNZ
         pYMg==
X-Gm-Message-State: AOAM531U9WJGKnsveYs7uhk2oDWpe1pkYBvmh7URbWl9n4XEfy0qwruy
        yxqVpX+B7I4qpZvBwdVXdlu8WXoSUndrpYVMByw13A==
X-Google-Smtp-Source: ABdhPJw6m1Bx4tTAVd5qna1UJXIjSt0ecpLxk7rReLLIYcM3qVVI8xAtQJZfQj1z1jmrWaiu4SPAVmgH8PSnUdWmFRE=
X-Received: by 2002:a17:906:1c05:: with SMTP id k5mr4199021ejg.320.1594731184628;
 Tue, 14 Jul 2020 05:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <2733b41a-b4c6-be94-0118-a1a8d6f26eec@virtuozzo.com>
 <d6e8ef46-c311-b993-909c-4ae2823e2237@virtuozzo.com> <CAJfpegupeWA_dFi5Q4RBSdHFAkutEeRk3Z1KZ5mtfkFn-ROo=A@mail.gmail.com>
 <8da94b27-484c-98e4-2152-69d282bcfc50@virtuozzo.com> <CAJfpegvU2JQcNM+0mcMPk-_e==RcT0xjqYUHCTzx3g0oCw6RiA@mail.gmail.com>
 <CA+icZUXtYt6LtaB4Fc3UWS0iCOZPV1ExaZgc-1-cD6TBw29Q8A@mail.gmail.com>
In-Reply-To: <CA+icZUXtYt6LtaB4Fc3UWS0iCOZPV1ExaZgc-1-cD6TBw29Q8A@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 14 Jul 2020 14:52:53 +0200
Message-ID: <CAJfpegs+hN2G02qigUyQMp=0Ev+t_vYHmK5kh3z+U1GkSuLH-w@mail.gmail.com>
Subject: Re: [PATCH] fuse_writepages_fill() optimization to avoid WARN_ON in tree_insert
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Vasily Averin <vvs@virtuozzo.com>, linux-fsdevel@vger.kernel.org,
        Maxim Patlasov <maximvp@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 2:40 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:

> Did you sent out a new version of your patch?
> If yes, where can I get it from?

Just pushed a bunch of fixes including this one to

git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#for-next

Thanks,
Miklos
