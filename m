Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F93EC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C4DA2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="mry5H3Uh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgDTLZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725886AbgDTLZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:25:22 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8203AC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 04:25:22 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id p16so2411938edm.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 04:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I4SypYI7tKk3MOyDrVcIOhbzofpHJxw1kr3NsPWFunY=;
        b=mry5H3UhLVDFuJyXHzkG2xn5Ac0Norh5KK5wehDbdoTllyDQL62OsdYF7piaV0mPPP
         W1sig72TR2lrXc1YYfOUb5QFgN6A/vF7O1VXRKxjKe6RPNLPv1Ise/GsF9Ait6AG+HLz
         1CiP3Zl0DDz2xHRuTok6fZ56/tW0lDQePJ+jQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I4SypYI7tKk3MOyDrVcIOhbzofpHJxw1kr3NsPWFunY=;
        b=P8zNIEPf0Hp1UUETEISGZFCW/0NsBxem2GsbVz7URC5kuEH9ZrSLCvxwSPksjJpgDJ
         bRWR4TvSCQJQtPBvHldsYUhailuz5ltCpVTV4Ra0OX06POoJU71dlaYHQDemfQnNDJmb
         BbwCVAiT0+AsJFf8bcxPge+Jm3H4aRu/RGc/p0OUre0uEzAsH4SjgeZoVxRVo9XU761m
         lroBh/WvDN2FI0nlUO6FLxBRMdxpSgQCQUivwTTQkuLnUfLbimPT6pLdvDOKGBCDw8Yh
         ZCAiuZCbr8Bc1TfRdtvSmIRKmPqFg8dVYZU5ijdFvdW0oPsYqIV/BTLZ4HYfQSjyKA8E
         /6/Q==
X-Gm-Message-State: AGi0PubtBwRo6ODUJxSjGakOC4eoTORTCa70pRRTGXOcIEIhC8qTya9N
        7ACgP2J6xm/IC/b+SOAKWl88Qdyat73+9zTEczP1gA==
X-Google-Smtp-Source: APiQypJVUo43ECX1ny9uSU72A1WZav7rKM9Lxy1VagL35X9dAgr/GJJF7Ykv8uKOQzZQEnMZonxM7APFfsyv6BgPccQ=
X-Received: by 2002:aa7:c312:: with SMTP id l18mr14432359edq.161.1587381921220;
 Mon, 20 Apr 2020 04:25:21 -0700 (PDT)
MIME-Version: 1.0
References: <1585733475-5222-1-git-send-email-chakragithub@gmail.com>
In-Reply-To: <1585733475-5222-1-git-send-email-chakragithub@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 20 Apr 2020 13:25:10 +0200
Message-ID: <CAJfpegtk=pbLgBzM92tRq8UMUh+vxcDcwLL77iAcv=Mxw3r4Lw@mail.gmail.com>
Subject: Re: [PATCH] fuse:rely on fuse_perm for exec when no mode bits set
To:     Chakra Divi <chakragithub@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 11:31 AM Chakra Divi <chakragithub@gmail.com> wrote:
>
> In current code, for exec we are checking mode bits
> for x bit set even though the fuse_perm_getattr returns
> success. Changes in this patch avoids mode bit explicit
> check, leaves the exec checking to fuse file system
> in uspace.

Why is this needed?

Thanks,
Miklos
