Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C581C433E5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 15:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D8B720789
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 15:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595778593;
	bh=ogmWDHQdsd7ber682CinTThcHqFrAYTEtk+xlidxPV8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dtJJuy382ysKMHU+RkrthKRSEiZIkteNDNC+NbbgbXSQ/C4OsoxnUvy9UKC/mtrX+
	 5QY23284gC2j89X1FXfkTGi4dirjyXD54xyDOBoSavoEjeqKzcPe46QWxk4degAhAZ
	 uhnuUsvgGlgrXFhWcUKxluURUDrtsO3h0E5WMA+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgGZPtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 11:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgGZPts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 11:49:48 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61A2C0619D4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 08:49:47 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v4so4937009ljd.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 08:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I+JgIZ8XfCVppOLBrKaCfrOJgti4dCoQC3LmXNgyBOk=;
        b=YKwnn8UwB1kyyPy7SGhOqEHVh3ir85jWVNvGHsICQkfXCfHpp08JaYZO+rmkz+r+4H
         a8PGGYXhKp4ik66+nOyiykRRF8GkhBtxTG58y01F0XwJ0PDRSUZIKrcxNdZZrYj/LaW0
         LanUodOh2id6DDdrcBqqolyXpt0XJy8o+3CEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I+JgIZ8XfCVppOLBrKaCfrOJgti4dCoQC3LmXNgyBOk=;
        b=XEbVPyYreLuoraCEFA0O68XHTUQmqPa0YTsZxAOY258nCWUbk8MHQzfBOxlz9svBhq
         00xiTtpqpPvXG1GviMB2B5m++NmaZBq6t4plLW06tJRBR7oY0ayqAw7uKtypd5MAd6Pq
         u3wci4FVJ/GE9zV5sBEPwQvF+q9AsMBGWB03/7fod04ZS0TYs3KP3M1veXXhGM3Xg9ii
         OvbdTWPVlnC5js4uz4NtE2BsZRGDJeIRzfqxoEnr61JL62XImLtbrx+B1WN1bJS+gZpZ
         c7hNTex722sH7Ob0qR3MxCDQTCd6zv/P8u1hcQSJQdklhAID1MpGzr0BN2piLlB3/QCl
         TLBA==
X-Gm-Message-State: AOAM533nkDFIn5TjrBqPhOVahN1L1WX/URCT4WVQaQE3DTTL1C5ytFlB
        AxbqLNX5gq4PxxvSIzqmcZHTJS1Z5EI=
X-Google-Smtp-Source: ABdhPJxD6QRh+XCiWtBbxTnNGn4hVW80R6BfsGqB9fMhM9zuSsiBYVlYOnOjNuwHYpdgjUT+0OoTBg==
X-Received: by 2002:a2e:9a4d:: with SMTP id k13mr8740828ljj.283.1595778585783;
        Sun, 26 Jul 2020 08:49:45 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id q22sm2398561lfc.33.2020.07.26.08.49.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2020 08:49:44 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id h19so14588260ljg.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 08:49:44 -0700 (PDT)
X-Received: by 2002:a2e:9c92:: with SMTP id x18mr7676040lji.70.1595778583932;
 Sun, 26 Jul 2020 08:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200726071356.287160-1-hch@lst.de>
In-Reply-To: <20200726071356.287160-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 Jul 2020 08:49:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgq8evViJD9Hnjugq=V0eUAn7K6ZjOP7P7qki-nOTx_jg@mail.gmail.com>
Message-ID: <CAHk-=wgq8evViJD9Hnjugq=V0eUAn7K6ZjOP7P7qki-nOTx_jg@mail.gmail.com>
Subject: Re: add file system helpers that take kernel pointers for the init
 code v3
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 12:14 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi Al and Linus,
>
> currently a lot of the file system calls in the early in code (and the
> devtmpfs kthread) rely on the implicit set_fs(KERNEL_DS) during boot.
> This is one of the few last remaining places we need to deal with to kill
> off set_fs entirely, so this series adds new helpers that take kernel
> pointers.  These helpers are in init/ and marked __init and thus will
> be discarded after bootup.  A few also need to be duplicated in devtmpfs,
> though unfortunately.

I see nothing objectionable here.

The only bikeshed comment I have is that I think the "for_init.c" name
is ugly and pointless - I think you could just call it "fs/init.c" and
it's both simpler and more straightforward. It _is_ init code, it's
not "for" init.

Other than that it all looked straightforward to me.

                Linus
