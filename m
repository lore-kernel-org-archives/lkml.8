Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8E6C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B516B2071A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="uMrNO+B1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732511AbgDASMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 14:12:01 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42194 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732121AbgDASMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 14:12:01 -0400
Received: by mail-ed1-f67.google.com with SMTP id cw6so999619edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 11:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ARlJ0pEC0Ng76rfhEHLx5JjVfuJY5nlMFNNVSJ+jUak=;
        b=uMrNO+B1qxFu7JfKw8TXzjs7ZjufUVzE/AJSn/vrcxPqfI1ZN1orV7zpIH+sQEXQAX
         l1y2GuN7K5zDYMXRyRF8fSJesg+mYDXF7YpuCPjY/oNsnt3f4uchr70H2l6GXRrQcG6W
         g+w8mYbmLc7TZ+U8S9qpyR5fkmiCDwpW+WdP0RS3Gs0JXuVCpkXLFCBTV/fhU7nDF9x4
         XhL4MVMyxORtvzAMDi1nYeuvAWwCLFcpysBAB7KoBylcc5kPS5aBh5e0K23/J1t/ZkOb
         IR9HHi1rMbd/IL2Y4lKWKEhPaewWXQllQQJCX+4vQy6Mqwv7CVAdcQ6zRwKsM/3Y0rNy
         FXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ARlJ0pEC0Ng76rfhEHLx5JjVfuJY5nlMFNNVSJ+jUak=;
        b=VREDRIDwbMg+FotoKHsaTHczR6sGR177yRtA8n6PYqsgTLeMcvUpSR3eaSYsysmL/G
         +EP/Kbx9yBhsAE/WbcOAYUX2QQ84hKDAbTAjZHCZOpeTEsKaNKuDthAKBJP8SD9e7Vqh
         VVlMSPYlJ804bm3tRZRR7IAjFoIPO2X4RNigojyLYonCUG+26TB6QylD1kQTsFF4S6NO
         m7J4FVr6Rc0mwSi4hPnqxlHl1aNiCtdFNEKEJKWiLj+e0TzaTUKw2VIh0vFcbgfyuhW+
         F2biFI8lEpSCJWVIYONJc+VBOprXguEHmjiLQ3MsEpoioaZxOZ7hYII0KnojCMqg07Ig
         0JaA==
X-Gm-Message-State: ANhLgQ1BalVDc3vsgayJwQ89xk5PJDhjxV6HTyYPSUYnKJhCmc0MD2KT
        5O6g13iu7dCef72XrFUcqPECKpoNbezmcfghz5QB
X-Google-Smtp-Source: ADFU+vsii+wte8KdQiUDO7oSGQEtbM+AJCzPR1eIDISrIygraxkwgH6reXFPmkD7foLio+C5xeoqc9j50sylSya+Jas=
X-Received: by 2002:a17:906:583:: with SMTP id 3mr18945544ejn.308.1585764718468;
 Wed, 01 Apr 2020 11:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200401180920.4655-1-sultan@kerneltoast.com>
In-Reply-To: <20200401180920.4655-1-sultan@kerneltoast.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 1 Apr 2020 14:11:47 -0400
Message-ID: <CAHC9VhQzfJhioQ6sHkyTAmn1MKWYgBoEA6s9rzTNx3FLBnZXrw@mail.gmail.com>
Subject: Re: [PATCH] selinux: Fix all those pesky denials breaking my computer
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 2:09 PM Sultan Alsawaf <sultan@kerneltoast.com> wrote:
> From: Sultan Alsawaf <sultan@kerneltoast.com>
>
> I'm sure many of you have found yourself in a position where you've
> tried to increase the security of your system by enabling SELinux, only
> to discover that nothing worked anymore because of those darned 'denial'
> messages. It's clearly an overlooked bug in SELinux!
>
> With a bit of investigation, I discovered that the avc_denied() function
> would erroneously return a non-zero value when I saw those denial
> messages. After slapping in a `return 0;` at the top of that function,
> all was well and my machine with SELinux enforcing was working again!
>
> Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
> ---
>  security/selinux/avc.c | 1 +
>  1 file changed, 1 insertion(+)

This is clearly an April Fools joke, but still.  No.

> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index d18cb32a242a..b29f19471871 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -1010,6 +1010,7 @@ static noinline int avc_denied(struct selinux_state *state,
>                                u8 driver, u8 xperm, unsigned int flags,
>                                struct av_decision *avd)
>  {
> +       return 0;
>         if (flags & AVC_STRICT)
>                 return -EACCES;
>
> --
> 2.26.0

-- 
paul moore
www.paul-moore.com
