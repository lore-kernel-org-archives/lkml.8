Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C08DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CCA7207D4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="eWDAuFvh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgE2TMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 15:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgE2TMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 15:12:02 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F4AC08C5C8
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:12:02 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id fs4so1911974pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=decs9gKQoFUz0IqtIufOW8Or3y9LkMuKp232OBe14mU=;
        b=eWDAuFvhZ08VeODhDiZrHCV0mEXsZEFVfJD5PJVxkwOzzUNwXhVnUBgtQQ6rFLGkSr
         /8YSN7+sVQCXA2mmJX/69E3rHjwJpjXHfCugaFZpsVtF4wlgic/bCNL/bp6qKO3cEc0R
         uX8OsB7tnNqNPrnf6hOoxDQ/nbd7AChkqmjV8JuycZQdlxORs9TYPUtZASzVlWPKxeCw
         tj+QZhCzKcnCy/D6NI39VojxtI9UGo7jm9HYLBww1TbgvxGYCPrmxY+F6St48W8P8bCb
         PNqp2lVnzbBnos/ITs+YF3TYIIfHpBrzDvdZ0vXfwj03poUCA4/atK9kfYGNulkPx8nv
         nRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=decs9gKQoFUz0IqtIufOW8Or3y9LkMuKp232OBe14mU=;
        b=NXNZ72sDN4sck0lAgmS3Gw1U4ev/X9YAsun95YkGu89CbcxkiUT1JhxmmvPsvT5MQP
         4jZgKBg25pzmIuYTpzTNOF/HT8GI4dNbL+ZiMmwTmAc94fTDcP6Daydp5MuNvVIYW++0
         hyCYYGY2mBAybo1NSmrLu16dBsk3TVxnASteoT1IWmJS7xQIVyf50F/3Kt+md3DJbzFy
         zM27vRZct8w3EbrIb9bAcbfej+Khns0w3oUvZ6LlzX9QP5bG0h4SsTbpfonsSXgn7ny+
         DI3aknfBIyip4iYQ/15izJWEMDCcjjCT9uYOxAuaebWUqg7nBY6KhvA3/bwBGJlntkqM
         CbSw==
X-Gm-Message-State: AOAM5322aWuG+QoYV49vw4HNHgjXZC4HUS0cxZ2I8qU1zTd8ST08ItG3
        2vv04brp1x6Xh6nFND9CyS/MqA==
X-Google-Smtp-Source: ABdhPJyjcpckoDOu+R8Tw54TKJ153mJx2NUPVJpN+KQZyoYpj515kO0ch3WUU9bN7eI+lTMS2Jjt5Q==
X-Received: by 2002:a17:902:9a08:: with SMTP id v8mr9901638plp.90.1590779520978;
        Fri, 29 May 2020 12:12:00 -0700 (PDT)
Received: from cisco ([2001:420:c0c8:1001::961])
        by smtp.gmail.com with ESMTPSA id y65sm8038790pfb.76.2020.05.29.12.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 12:12:00 -0700 (PDT)
Date:   Fri, 29 May 2020 13:12:07 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Kees Cook <keescook@chromium.org>, christian.brauner@ubuntu.com,
        containers@lists.linux-foundation.org, cyphar@cyphar.com,
        jannh@google.com, jeffv@google.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, palmer@google.com, rsesek@google.com,
        Matt Denton <mpdenton@google.com>
Subject: Re: [PATCH v2 3/3] selftests/seccomp: Test SECCOMP_IOCTL_NOTIF_ADDFD
Message-ID: <20200529191207.GH429721@cisco>
References: <20200528110858.3265-1-sargun@sargun.me>
 <20200528110858.3265-4-sargun@sargun.me>
 <202005290036.3FEFFDA@keescook>
 <20200529184606.GB11153@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529184606.GB11153@ircssh-2.c.rugged-nimbus-611.internal>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 06:46:07PM +0000, Sargun Dhillon wrote:
> On Fri, May 29, 2020 at 12:41:51AM -0700, Kees Cook wrote:
> > On Thu, May 28, 2020 at 04:08:58AM -0700, Sargun Dhillon wrote:
> > > +	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
> > > +
> > > +	nextid = req.id + 1;
> > > +
> > > +	/* Wait for getppid to be called for the second time */
> > > +	sleep(1);
> > 
> > I always rebel at finding "sleep" in tests. ;) Is this needed? IIUC,
> > userspace will immediately see EINPROGRESS after the NOTIF_SEND
> > finishes, yes?
> > 
> > Otherwise, yes, this looks good.
> > 
> > -- 
> > Kees Cook
> I'm open to better suggestions, but there's a race where if getppid
> is not called before the second SECCOMP_IOCTL_NOTIF_ADDFD is called,
> you will just get an ENOENT, since the notification ID is not found.

Ah, I see. The goal is to test the -EINPROGRESS here.

If you use write() instead of getppid(), and write to a socket, will
that work? The parent can block for the read, and once some thing has
been read it can test for -EINPROGRESS.

The user_notification_signal test does something similar.

Tycho
