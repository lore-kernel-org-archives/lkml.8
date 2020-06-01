Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7890DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 574A6206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jOxFQL+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731343AbgFASnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731415AbgFASmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:42:42 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89ABC00863B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 11:33:39 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y17so285288plb.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 11:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EIL54tsN/ayDunKEmeYsCGlcywdHCKj045U3CdpH9ek=;
        b=jOxFQL+A2MHB3MmYXIfp5bt//vP9QMt4cukvW3gYDoxx//QLK387ou4V+W6qUZSUV1
         /l0n4kgQjss2PX0sS8FBQNXyuxSqG+2gitU3EQHQodFBp5IsJb6qM+Eju2aaI8qlMNna
         92Zj43RlWcilhzfkFJRTW4I4P+Jh5b3K9Wp0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EIL54tsN/ayDunKEmeYsCGlcywdHCKj045U3CdpH9ek=;
        b=qFxWUyLOW6Ufd/GsOQLJ67DtuBnXF5/jBD7WPHnNZ8/c7LyUmdwBZydqMVdGAYhstI
         jmlE3Gu0HsOYVFeOpwDnakRccZjfHT7hwmpSU2y20cB2B5HzPC8tz6Ei+/G4tjNUX747
         CdSSTHyFdKu+0DAsDNbQJdQ5F+ZKKQ6Ikwd52Mz4+hLUVQpAksL/vimcVPISPVnjeVYa
         RK5f2eP+l/0S8S0nTDIKFbqUoZN8M93yiyORsF2hLpduqnVPjjuVApWjY6Li4aFFyuBh
         9M1/1l7DbSOxEtLwEpegP9Q4xwiVoitMBMZiw+SeAuqaSAqciGeufkiVRhhpjT+TCgfc
         QQ3Q==
X-Gm-Message-State: AOAM532Hnh0zzayJ+lJPLI/55Dtrfjax1ZrjK3cjJYjMQh0zQZzPydpJ
        52d9B9uNwoM2eIlbHr9ABvbNTQ==
X-Google-Smtp-Source: ABdhPJzAJRWsupYp6piUM3gjsyTomoOnz1Ou5O8IYQ8kz+KAgZt03gQm3IhXp8yi8oUcv1YZqCT+Ww==
X-Received: by 2002:a17:90b:3d4:: with SMTP id go20mr840756pjb.208.1591036418912;
        Mon, 01 Jun 2020 11:33:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u1sm171288pgf.28.2020.06.01.11.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 11:33:38 -0700 (PDT)
Date:   Mon, 1 Jun 2020 11:33:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Robert Sesek <rsesek@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH v3 1/4] seccomp: rename "usage" to "refs" and document
Message-ID: <202006011133.543C6A8@keescook>
References: <20200531115031.391515-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200531115031.391515-1-christian.brauner@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 31, 2020 at 01:50:28PM +0200, Christian Brauner wrote:
> Naming the lifetime counter of a seccomp filter "usage" suggests a
> little too strongly that its about tasks that are using this filter
> while it also tracks other references such as the user notifier or
> ptrace. This also updates the documentation to note this fact.
> 
> We'll be introducing an actual usage counter in a follow-up patch.
> 
> Cc: Tycho Andersen <tycho@tycho.ws>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Matt Denton <mpdenton@google.com>
> Cc: Sargun Dhillon <sargun@sargun.me>
> Cc: Jann Horn <jannh@google.com>
> Cc: Chris Palmer <palmer@google.com>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: Robert Sesek <rsesek@google.com>
> Cc: Jeffrey Vander Stoep <jeffv@google.com>
> Cc: Linux Containers <containers@lists.linux-foundation.org>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Thanks! Applied to for-next/seccomp.

-- 
Kees Cook
