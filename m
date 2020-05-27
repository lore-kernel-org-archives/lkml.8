Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387F9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A09E20899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="C/tu9AK+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403796AbgE0RhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 13:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403778AbgE0RhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 13:37:10 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481E6C03E97D
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 10:37:10 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id q18so3784315ilm.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 10:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Bb47SNpC8nAMYYf5+T+wlcMsWyDpF8XWYXCAN0BKUjs=;
        b=C/tu9AK+skYnBsqBz7Pwvu2g7Wp9+/BxXz1uIdqFBBpcXFFiv/ygab3Kor0nIRBhT8
         Pyp0xucc+FgZrLRDDneySuUOM8d+f0jnjpErSBgKMpfPhYjNMFbMxQuizdQGBNyBOJPc
         aSMyGILYXWdfk1syMgA8b8F5vRe+VJ6ScfPhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bb47SNpC8nAMYYf5+T+wlcMsWyDpF8XWYXCAN0BKUjs=;
        b=UrdSoAsPzExir2/DdNi1xCHQ6JaFrR2+0jWWut2dUj7+D0jVzURd9bnmZkTPE1ftlk
         9YrGkuzxCm5INbnJLIqp3diuPzpo98NGIXgAkf+jzSkaxqTASHVHnA+5jS+xEF83WoDf
         9FGiV5Gb5W4xIWMtY53lFCZj5Qi3kOObipVDhLv97r+f9mktvn7uhtSB7ZqFZOAsNtVa
         6WUOeGoKC0aPcukq0JRjZgKLRucfHTu7cklUWFzIfTUmb2fWvFykMIg0XPoTx5zLaLxa
         AJ5s6qX6knyOjTvl92KrI/UPA/WzNuQeguS2gLmaoBZI7aF3KagC1sz2k5dYEoOKMxG7
         JSgA==
X-Gm-Message-State: AOAM533oh6/tk5LABdWDV4BfP6agPdOyGSeqXJq/LkM/1DXvmnCmZxpa
        tcJBb2e+IFIicjZgrKMp4EVzdw==
X-Google-Smtp-Source: ABdhPJyQtWlxjd2XpARn5G1n+6BrwKbUi6ICW/a4kzgno/g5fYpF6PlaY5NB9muNV1MQw4ROMLhrYw==
X-Received: by 2002:a92:988a:: with SMTP id a10mr7130204ill.301.1590601029131;
        Wed, 27 May 2020 10:37:09 -0700 (PDT)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id d11sm1485101iod.11.2020.05.27.10.37.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 May 2020 10:37:08 -0700 (PDT)
Date:   Wed, 27 May 2020 17:37:07 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Robert Sesek <rsesek@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH 1/2] seccomp: notify user trap about unused filter
Message-ID: <20200527173706.GA1242@ircssh-2.c.rugged-nimbus-611.internal>
References: <20200527111902.163213-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527111902.163213-1-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 01:19:01PM +0200, Christian Brauner wrote:
> +void seccomp_filter_notify(const struct task_struct *tsk)
> +{
> +	struct seccomp_filter *orig = tsk->seccomp.filter;
> +
> +	while (orig && refcount_dec_and_test(&orig->live)) {
> +		if (waitqueue_active(&orig->wqh))
> +			wake_up_poll(&orig->wqh, EPOLLHUP);
> +		orig = orig->prev;
> +	}
> +}
> +
Any reason not to write this as:
for (orig = tsk->seccomp.filter; refcount_dec_and_test(&orig->live); orig = orig->prev)?

Also, for those of us who are plumbing in the likes of Go code into the
listener, where we don't have direct access to the epoll interface (at
least not out of the box), what do you think about exposing this on the RECV
ioctl? Or, do you think we should lump that into the "v2" receive API?

Either way, this seems useful, as right now, we're intertwining process
tree lifetime with manager lifetime. This seems cleaner.

