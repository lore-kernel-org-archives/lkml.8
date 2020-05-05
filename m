Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E8EC47258
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3685206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WaVGgy4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgEEUq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 16:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728356AbgEEUq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 16:46:58 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F72C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 13:46:58 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t11so73260pgg.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 13:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Cf6vM9jESf9i80uLNJEG7Wy6/PA2gfS+11yY91l4C9I=;
        b=WaVGgy4JYd1RrK4347/7gV+LxtVa8vgUfpBud1rqRWoLPH1F6yr5WshwQUcgRX8Gvr
         5bxoKCQ7fk673Dle31PX4qmBW0XLqXlrzR4RCfXqCVUSnk2Tj6JZspFHlE3RZXY7VzzW
         YNlD5/u2GQN4bk92Zt1AR279/8VzdCYl/swwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cf6vM9jESf9i80uLNJEG7Wy6/PA2gfS+11yY91l4C9I=;
        b=EnL+SpsUqCZ0cR257jvkCCD7EIBMdEKrXbg5ba6m1pV8dTffmvovsARksU8z4TZdIc
         A0tQKfppViWUwLHkKmeGM3OSz3Op/LaWg0EGEDwNtz5js4UAaGMjTZL1CKclh9Or9aEm
         1tQ0pFH+YbfeDGIogNH98zTQ2Ohuf6KCTyBZaMmaOXy3LnGcYxj1yBPwqfJ3Kxx6/8cM
         W3leNiZlr0HPU0VDZJRMsvvlLLHW2t8L5WhL69f0c3t/VcRoV/ik22L1vZ9DOvMKKlM8
         LtpCBo/VPQGfQlodYfOgCSPupkQVlUOm2LXGuyZX/zk3hMZFq5ThcQOYRDQ7uk/wssay
         mTHQ==
X-Gm-Message-State: AGi0PuYm6mdvWnZv7E/4gyWdOE3mW5CJgPFrJJ/iz3L7M4eeTyrvqvBU
        vKTsP5raP8NBFft5RK6CppsvLw==
X-Google-Smtp-Source: APiQypIEOWpl227xWyWsBkD73jjEUHZZB6dRX6mndNGiWNGrJBu2r/mZdD4ojy2/zK2bxDc5DoaIqA==
X-Received: by 2002:a65:6094:: with SMTP id t20mr4545692pgu.220.1588711618222;
        Tue, 05 May 2020 13:46:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b16sm2799596pfp.89.2020.05.05.13.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 13:46:57 -0700 (PDT)
Date:   Tue, 5 May 2020 13:46:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/7] exec: Make unlocking exec_update_mutex explict
Message-ID: <202005051346.B4752035A1@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <875zdajhj8.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zdajhj8.fsf@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 02:41:47PM -0500, Eric W. Biederman wrote:
> 
> With install_exec_creds updated to follow immediately after
> setup_new_exec, the failure of unshare_sighand is the only
> code path where exec_update_mutex is held but not explicitly
> unlocked.
> 
> Update that code path to explicitly unlock exec_update_mutex.
> 
> Remove the unlocking of exec_update_mutex from free_bprm.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
