Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD5EC47258
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E767206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kve8F3BK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgEEUud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 16:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729297AbgEEUub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 16:50:31 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B02C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 13:50:31 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o18so1567139pgg.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 13:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gZPmqP7f0zZq0i6x3n5wYzmjgYaqHaT+GySyTpMlPTE=;
        b=Kve8F3BKs4sbH9Cpna7uFNaJN6fCv7xO+sFp9md+JOMcsVfxcmaVv+88JYyYgsbnag
         0FzzthJndg1UHG0uNLxFCD/9clIuGjzGfBzXIXCe3hfI6On3CzGWs6h9BcirTJNBTv00
         Dg1wvkjA4PIhmWOgtfNoLbSky1vPGQBSqYD/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gZPmqP7f0zZq0i6x3n5wYzmjgYaqHaT+GySyTpMlPTE=;
        b=gwwDR1ldqjaxJRAmofbtRCSCYxNB21Cer3ejj8CkY/u/09uRVBUl44eOY8118b/QjL
         72YLmtJKh+3llh2n8RVDSd/pT3+NwVm6m7cOjopYaN5ZadWRwgm5YBPZN/Jop66eer7/
         hoKl1kYlYZu2nZfZTmPXMEo4I9hMdpCLA8ZU+rCNuE//XQ9H6km8rbG2wh4MTWfVK33a
         LGBWqqcMs9koLzkAC1/hptx3OJlGUcQAofijzNFaQem/p02I7OziO7GdEN54YzgO//AO
         oDe7bMzpnPDetPIwT7H4NS1OlqcSP2Hn1tmF2NXhc7I7KdTkt4xnbQpBjA1F22V6bCms
         v4Ww==
X-Gm-Message-State: AGi0PuZPZKU2KCSn0HIPloV6E+Rzt67kFWTfoRh1ToMcjBYcWqyXbwBN
        zllfIa8RYoLwjag8kD6AvodeYw==
X-Google-Smtp-Source: APiQypIUB2lMuWPuFNQUARBx41SRb0quETrjJOgDQIFQl6CnLZPg+Mzu4paMDk2eFPwm6Fc+UAIOEA==
X-Received: by 2002:a65:460f:: with SMTP id v15mr4347488pgq.24.1588711831209;
        Tue, 05 May 2020 13:50:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c4sm15795pga.73.2020.05.05.13.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 13:50:30 -0700 (PDT)
Date:   Tue, 5 May 2020 13:50:29 -0700
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
Subject: Re: [PATCH 4/7] exec: Merge install_exec_creds into setup_new_exec
Message-ID: <202005051350.FBB43BE@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87tv0ui2w2.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tv0ui2w2.fsf@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 02:43:25PM -0500, Eric W. Biederman wrote:
> 
> The two functions are now always called one right after the
> other so merge them together to make future maintenance easier.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
