Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2427C2D0FB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 00:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89B072078C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 00:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="e8zHmwJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731672AbgEMATw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 20:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731604AbgEMATv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 20:19:51 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB05C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 17:19:51 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id h15so10369295edv.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 17:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZJQDVP0NTLzp1pMoSvccNQtV7irlK9esrQ+2J19JgPA=;
        b=e8zHmwJw7d1PENdzcZs+QTZEYcCkP7w/G7qPhR2QMOfvxy3ubzWiXBFVaV5dFiAK6S
         bMcwc0hZvbJKBswC21DxY+eb9gLkYDIVx1316d5KvRGiXBY66kNrmAzkNQJLPBR2jMHR
         JUZcW1U1jRBkioI/yE1oZI9po69ZhEwLHk24gdSfMEDaPz/BH2HiSUv7ytkqonEqpKoV
         pXpfKJXHSTK+Y07/WmElRVF6EuFWcP9fwF6iBffZmX3vi9Uv1aoI7T2bytJABJQdXFbf
         TOgFz5CqNJ0idoQddvX8e09i6tKutdKLv9UEpg2aEwSdCElq9fQHbrUaaU9X2+gRoel9
         +hfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZJQDVP0NTLzp1pMoSvccNQtV7irlK9esrQ+2J19JgPA=;
        b=A9EtUlYnLEOP1BOP5li+8FZLwaQyvwRVgUXzHpz0Hu+JulkV0S3uIQH5njszROR0Nj
         Hh0B+PK+usauAXjgrR/B933gTiCbq5xs3/AlC7oMI2B8UIhpAPmiN/+vqzuyYbc83EbG
         0o28u9QjRfyzJY7vcxpZx7Q+zWuAxKKb6WX3XU2g4lq5ZCW2Nnlx+jayfRxeoBncnIEo
         dIUE19M2GNZer+yqXoy+yKBnFlRLPEsPTnYucO3o0sXRfsWmHSYLQ/hGp/myIZ/KMJnx
         SaZiZHD/e+fjVaTQs1bP8hDCiHcJOGijTXUEt9wtL2rvCIGRFhFrNO0A1JNZh1qlxcAW
         aLSQ==
X-Gm-Message-State: AGi0PuY5gZf4GibRzuRYUyHK5WAPJmlx1xF8Nu5nrm8sj7/g74oP8hBM
        kHcWibjINzUMg9xnhiW8hk9QpJg9ODxdjaowaNdcV9k=
X-Google-Smtp-Source: APiQypKdMjK0XWowk43GU6bihKqkbeOChmOVpiS3FVfoIUj3emgPGbk9F6f41b7RLKyQCdkJUL9ZmHJ7WqZzRPBrB3c=
X-Received: by 2002:a05:6402:1adc:: with SMTP id ba28mr20168196edb.12.1589329189703;
 Tue, 12 May 2020 17:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200509111852.29812-1-yuehaibing@huawei.com>
In-Reply-To: <20200509111852.29812-1-yuehaibing@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 May 2020 20:19:38 -0400
Message-ID: <CAHC9VhTcBGUzEo4_aw15jM7kZNWzNktBA2iBNOAbdP1dHZLb5Q@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: netlabel: Remove unused inline function selinux_netlbl_conn_setsid
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, tglx@linutronix.de,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 9, 2020 at 7:19 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> There's no callers in-tree.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  security/selinux/include/netlabel.h | 6 ------
>  1 file changed, 6 deletions(-)

This appears to go back to the original SELinux/NetLabel hooks.  Wow.

Thanks for the patch, it's now merged into the selinux/next branch.

-- 
paul moore
www.paul-moore.com
