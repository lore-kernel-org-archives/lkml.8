Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6561FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 18:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3575B2064B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 18:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mawsonlakes-org.20150623.gappssmtp.com header.i=@mawsonlakes-org.20150623.gappssmtp.com header.b="kIoUmfTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgGOSPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 14:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgGOSPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 14:15:38 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6793FC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 11:15:38 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id a17so1602990vsq.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 11:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mawsonlakes-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kAFl+DqF89DNYLjkrXzmzyou9Pj04wC0lb1YzxY1Y44=;
        b=kIoUmfTsfweFbDarPmcloVR+c8kioaGVXMtHAobLbfEKJc2jKFnC6fT1Zdg1pbDwe9
         CgRpV/BNaVFHSztO6O7olIQTBVtXTBSxDVCWgNryoMg+vRYu3VlpS3jJGhEuwf2n1Jpy
         udFk8H7N29m8q77DcgJLvRrmmTMcBBhPSiIbHKaXbnqyUJqghCQnkr5UR7bDRrVLxQeC
         w0e/ZLB/yTpY75VSvgIbs5FkEKm0J5ighVu6aaNDKEL2Gdvc3fqLRbmtJvGw8suONht2
         ltlgQMme6Jt+5/zTsOlJmRcAB/bGLTbi9l7O94oA5PHLubOIzCKfQkAoBEmv2qTR6FSl
         jwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kAFl+DqF89DNYLjkrXzmzyou9Pj04wC0lb1YzxY1Y44=;
        b=E1g6wO2HfNF4MzHre8qlmRH4kKZcxGznmhWff4ZSHSA8deTlkZvk/tABIsi1IexqJl
         x6jbdhAqKiusqMat+cEWn3CkiwLWK5K3NXSSaLFxnAvz/C3wvcbFsahpHBdgJ38Gjz6L
         ZCX8TuqNg2wh5TS9BCcyyOrQjsu8pSMqaHxCknZ+iSWN+WzNJSu3z40wPwtv9UM+LgLB
         oEJFGhPB0rQtziX32xPYMw4/RQs901+CpNdQkG8tY8b7kXhwTiE0W75qAL64arJPIlwN
         wnnwXhSwLusw6hzM4SCXjkDqbznw6ZLeo7IwZ+5u2ut4A3QUJlu2MLsIsuaq5PJ27O5c
         ntdQ==
X-Gm-Message-State: AOAM532QBrXDC6z8BCTQFeKsOFnyaG9EWjlTW88NqLJNUKY+IS2ipbC1
        bEcDGy/XBqVCihuEjwpcNndJ+WyIMohxQEIWpwBeIogr
X-Google-Smtp-Source: ABdhPJzBvwWsKWOIJG/XPzJprm+fHKP1Zhc06SYEvhK7S70JfjH9hUFd7Hze9t1s1AxxJaa9hH0d5Es61Wd1s8o67ek=
X-Received: by 2002:a05:6102:3233:: with SMTP id x19mr398867vsf.112.1594836937393;
 Wed, 15 Jul 2020 11:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200715162204.104646-1-paul@mawsonlakes.org> <20200715114032.057fd63d@lwn.net>
In-Reply-To: <20200715114032.057fd63d@lwn.net>
From:   Paul Schulz <paul@mawsonlakes.org>
Date:   Thu, 16 Jul 2020 03:45:25 +0930
Message-ID: <CAGt04nb7Z436TWRWGuphQO2MzfwbZch3kUFqK4jy-9ib+JF2EA@mail.gmail.com>
Subject: Re: [PATCH] sound/pci/hda: Changes 'blacklist/whitelist' to 'blocklist/allowlist'
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yep. +1 for logic

On Thu, 16 Jul 2020 at 03:11, Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Thu, 16 Jul 2020 01:52:04 +0930
> Paul Schulz <paul@mawsonlakes.org> wrote:
>
> > -static bool pm_blacklist = true;
> > -module_param(pm_blacklist, bool, 0644);
> > -MODULE_PARM_DESC(pm_blacklist, "Enable power-management blacklist");
> > +static bool pm_blocklist = true;
> > +module_param(pm_blocklist, bool, 0644);
> > +MODULE_PARM_DESC(pm_blocklist, "Enable power-management blocklist");
>
> This will break any user specifying this parameter now, which isn't
> something you want to do, methinks...
>
> jon
