Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECE7C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCF6020721
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D/nZet2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbgEEUpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 16:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726593AbgEEUpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 16:45:22 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4AFC061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 13:45:20 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id h12so1575479pjz.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 13:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PwgvJhTVGN7aq20X1Hb7QG5i5YRhZZ77AIj5mgyusSM=;
        b=D/nZet2+qNxTUTj+LLTvOT2EYhCwDnhb9QENQrfcXrYgx4gxQ63ZBjh+ufC+HiNJ67
         6lLV4Oa1++q6m/PwAJFQSsVtdy3ut8+8zPARcQ+6n3d5wIrNBUFBeFfMSQG/KCnxGzyA
         KHyb3ERW7OFoHTjLecNb8hvxS0gnWOn5CluVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PwgvJhTVGN7aq20X1Hb7QG5i5YRhZZ77AIj5mgyusSM=;
        b=E1SRIr6HZI6O9uh8VzwM9sW4W0AhJTk/C09wJV/Wofu1km6jP+JN0wqH9L9ebr2Vhb
         mzS9sUM6U78WVZLqo1kYWOmeQCFnOM1xweok8Wrnh37C6jF9KJg8oJYZI1UAYZEkO7Bt
         NzFVVis4nh8cQCddOVKNxrDuQKaLCVUPvSAib/7qY8sdbohn+cg4urseqsBD0T8TlQDW
         +EAztsxY3XGKNp7gk3tcjayc2S2WXTEkpy53NUCRXcKT8J9l3ttIWs011FmWPFbXMb28
         PDMTuXIXcA9bmkzrXPRZoh9ADLGatLs9yGWWXHMekMBtlqtHhIxqL0D0awabBjfv2MYI
         uv3A==
X-Gm-Message-State: AGi0PubrqzyQiJwhnkk+mRsxntEN4lV/DZNOD57uTvU5K/eE0Hm6pFF6
        HcnoCH7meE8R4n8SJ0fT8NDrpg==
X-Google-Smtp-Source: APiQypJelCbpz9Zyh1p8qR9xlzlqaRKqZbtcgKDa1zdHqrwx8Ea5nhY2TYzFLhCW5cMgdS79nUBwPA==
X-Received: by 2002:a17:90a:71c3:: with SMTP id m3mr5049962pjs.17.1588711519740;
        Tue, 05 May 2020 13:45:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s4sm12481pgv.78.2020.05.05.13.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 13:45:18 -0700 (PDT)
Date:   Tue, 5 May 2020 13:45:17 -0700
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
Subject: Re: [PATCH 1/7] binfmt: Move install_exec_creds after setup_new_exec
 to match binfmt_elf
Message-ID: <202005051345.8280CC0E@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87bln2jhki.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bln2jhki.fsf@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 02:41:01PM -0500, Eric W. Biederman wrote:
> 
> In 2016 Linus moved install_exec_creds immediately after
> setup_new_exec, in binfmt_elf as a cleanup and as part of closing a
> potential information leak.
> 
> Perform the same cleanup for the other binary formats.
> 
> Different binary formats doing the same things the same way makes exec
> easier to reason about and easier to maintain.
> 
> The binfmt_flagt bits were tested by Greg Ungerer <gerg@linux-m68k.org>
> 
> Ref: 9f834ec18def ("binfmt_elf: switch to new creds when switching to new mm")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
