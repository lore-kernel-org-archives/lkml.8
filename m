Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D29AC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46D442080A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I4oOZtQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731952AbgIHSls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731672AbgIHSlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 14:41:23 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8262C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 11:41:22 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k15so11680234pfc.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 11:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4D/aBydAA1LQTR6RAnjefSXva1fBhHAgDj3nNAcVY8w=;
        b=I4oOZtQZOez0KddVN7dcksQoTwbdyJ4OxlmiCG5XMety1n6ClKEETrC0Mu6j69oojo
         stSVa0WCmNiybsE3lhIPzIe140XnltOX87QuxwhmqeK31Rlj3Lr3L15m3ZaIeYN3+rGx
         4vRD+i8ONfe9NUCmyF0fFWG/+x1lIQnTMI57s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4D/aBydAA1LQTR6RAnjefSXva1fBhHAgDj3nNAcVY8w=;
        b=KLzfP1PxPTJatg2k5B2EJEz3Iys6QeNUIziKYHN2WptWjGYSc1wz4GcwaMivLg+hNi
         VsItEE4+QadsP/YDrDccVzCSs7JQjlZURGce3Gtt2WIFfX2gcPzlNWSeg7cO4Kg02tuu
         ghU0iO6uGQV9tmjFUKsOATRtLV6LVZSuGo6jFlfvm9YDDvJMCiCMpZx3XpO4MtQ0HN8t
         AEmG74lCstDop0j/YHjgzW9ztYIQh+bxMNGJblc15JCJvShelT8BhLgEUk2QCqFWUcFI
         Yo1VzY+fRM5XfVZrzociRuFxOjY5E0VYpLG7yI/FfgkzdIf+TWLUNDRu8IknPHkQr66P
         UBgQ==
X-Gm-Message-State: AOAM530K/WKrhRMeBGmu1Tzt7uI4tt5bX5MZpatDh5oRqHSiOg9tW0Ks
        dtjXmQAnmvNEF1b4gEj6egF00w==
X-Google-Smtp-Source: ABdhPJzBKbpQeJoUh8RreO5Yj8Dbux3oRM8iP1DbIG8FXrvBlSwVaq6nVzmBWzDYPKBUbXgVFwrAjg==
X-Received: by 2002:a63:a55e:: with SMTP id r30mr88910pgu.61.1599590482423;
        Tue, 08 Sep 2020 11:41:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s68sm148767pfb.91.2020.09.08.11.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:41:21 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Kees Cook <keescook@chromium.org>,
        syzbot+3ad9614a12f80994c32e@syzkaller.appspotmail.com,
        "Tobin C . Harding" <me@tobin.cc>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] seccomp: don't leak memory when filter install races
Date:   Tue,  8 Sep 2020 11:40:57 -0700
Message-Id: <159959037666.1186953.15847741084926154331.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200902014017.934315-1-tycho@tycho.pizza>
References: <20200902014017.934315-1-tycho@tycho.pizza>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Sep 2020 19:40:16 -0600, Tycho Andersen wrote:
> In seccomp_set_mode_filter() with TSYNC | NEW_LISTENER, we first initialize
> the listener fd, then check to see if we can actually use it later in
> seccomp_may_assign_mode(), which can fail if anyone else in our thread
> group has installed a filter and caused some divergence. If we can't, we
> partially clean up the newly allocated file: we put the fd, put the file,
> but don't actually clean up the *memory* that was allocated at
> filter->notif. Let's clean that up too.
> 
> [...]

Applied, thanks!

[1/2] seccomp: don't leak memory when filter install races
      https://git.kernel.org/kees/c/a566a9012acd
[2/2] mailmap, MAINTAINERS: move to tycho.pizza
      https://git.kernel.org/kees/c/19d1d49f2a8c

Best regards,
-- 
Kees Cook

