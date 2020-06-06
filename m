Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D26AC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 01:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0EBF2065C
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 01:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hZPAno3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgFFBpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 21:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgFFBpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 21:45:41 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A23C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 18:45:40 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 185so5958872pgb.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 18:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EYATkoDd/DlTVvMSnKtKT7ZrCQbghipgNSfif3PPTdQ=;
        b=hZPAno3Zqe8dlYsL2LzWn8Cqbw5Cy5a1a5fGUH7kjV6Aa8+ckDOu3YxIijiEO9YlRg
         pTgQlBFXKXs/hWsbaLmVRsuzPAujEobi8t/Y9ydG3Jz0HbuKrJinEMzu4mf2CsSC2QY2
         8KgrfNit1c2PnHzP9N69IE2PvHFFPWPNxYRfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EYATkoDd/DlTVvMSnKtKT7ZrCQbghipgNSfif3PPTdQ=;
        b=qjwtxBr4JwsbccM7CWiN3gW72ASXte71x2pF+mKcEct6dx3qlHOZdcwD6y/c3I8lb5
         2IsqCiSMoVPANZ99c0G6iaYKM1B5w6wOVlXNR/cA+aULpjTYc9DDXB5V/FBKEpcWvO2J
         +CivEsNN1vPIOjVj90bv8uhXb5mM2gvMiaUSVj0Qiabr99i44ub7jePL2BiiLX3U6uxS
         ovgr/ZiUEnEHt/Mnp8tcrBKw0N+Uuxv3vtkKL3TzZ0yudXWsAyqrGR/gms4hIUzeMoTh
         UgnBVXYXiOCm0hggztY3xj6RpuE9waH5oXcHp/iEa3E4wYqMe+KN8dMY25KzL0lQ2s8t
         l6Sg==
X-Gm-Message-State: AOAM533mGzoHtZ33QHl2b4u7R+xwXIWi7CpvASJ2xdFf7/APW1cCtzYY
        geC9HUkcoDJiNoTZCwKEaB1bZw==
X-Google-Smtp-Source: ABdhPJxjBK6bdJJIde1SuASUwSUrqHloLqXlowG4H6YmCkN1UfVnFk8Oo7dg72GZPLT/Vb2F4UEmuw==
X-Received: by 2002:a62:c185:: with SMTP id i127mr12889207pfg.132.1591407939582;
        Fri, 05 Jun 2020 18:45:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m4sm531153pgp.32.2020.06.05.18.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 18:45:38 -0700 (PDT)
Date:   Fri, 5 Jun 2020 18:45:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers3@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Relocate execve() sanity checks
Message-ID: <202006051844.2EBA35A7@keescook>
References: <20200605160013.3954297-1-keescook@chromium.org>
 <20200605174053.eea9557878d81024d2519e47@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605174053.eea9557878d81024d2519e47@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 05:40:53PM -0700, Andrew Morton wrote:
> On Fri,  5 Jun 2020 09:00:10 -0700 Kees Cook <keescook@chromium.org> wrote:
> 
> > While looking at the code paths for the proposed O_MAYEXEC flag, I saw
> > some things that looked like they should be fixed up.
> > 
> >   exec: Change uselib(2) IS_SREG() failure to EACCES
> > 	This just regularizes the return code on uselib(2).
> > 
> >   exec: Move S_ISREG() check earlier
> > 	This moves the S_ISREG() check even earlier than it was already.
> > 
> >   exec: Move path_noexec() check earlier
> > 	This adds the path_noexec() check to the same place as the
> > 	S_ISREG() check.
> 
> Thanks.
> 
> These don't seem super-urgent and they aren't super-reviewed, so I
> suggest we hold them off until the next cycle?

Agreed; that's fine by me. It's mostly clean up and preparation for
performing future checking through the MAY_EXEC path.

And I'd love to get an Ack from Al or Aleksa, nudge nudge. :)

-- 
Kees Cook
