Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554E9C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 05:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22FB32083B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 05:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K0XYe8pN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgEIFCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 01:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgEIFCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 01:02:55 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECD5C05BD09
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 22:02:55 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s20so1648929plp.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 22:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PblejXFYFxaChyYzck5O6k4FzOta65rmQVFP7KD8dDg=;
        b=K0XYe8pNJk7c0tNMRMrjfQ0YToPM8NiUVzaX3KFDHke/snEmuq7h/XsZYu2ll9ki92
         6O7Wyzy0mbCS1pKi8Nv1vZHVLMOGsxEd6/5/Hat1vvegmDz6COknREZ/Ni/eX21S4YIi
         wVAoeWLD9ljworD0PqPubniB5hZ/u3V3GAbdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PblejXFYFxaChyYzck5O6k4FzOta65rmQVFP7KD8dDg=;
        b=VoKkl+JvDklsuRkxPwwVp954R7mQj4olsplV6u9KffvEi+ziJRF0PGQuSsbSfMu6Bg
         qZ+vtKrCPfGg1PfbVWFlmCPL9bvR6uIFwMGbbDEiZj9eVJEhzkMjHDjNCNRB4Q4mm3Tf
         dyx5IULZZ7h4Vq2dbb3imNgRzC5GAvZa1lJ79H5OcZwGvDrxbxbLJN/BWDFSiU3koxpw
         J1dhyZsW27ca71JhLeDL3virxjn6l2W9pD4nugJOYmWU9fIVP9D3F70T+PoSfBJ1yaJs
         kBT0wr8t/3qInN/31uzhy06a3xmc/sQpSjQd8e5PLobGdqVNBylYe85zrXTMGV1Hd22S
         Deww==
X-Gm-Message-State: AGi0Puapq6kth8aY1WIug6N3D2rEOEJrhAr1F2kLxPVkdCCTQkWFoIOg
        k5nzZU6HaOMGx7AyOGrxfvdCFg==
X-Google-Smtp-Source: APiQypLAaU8j2dfgoyTjdwUvgAM0rOftnLGVHd225WjjckGYvGjxKTrMgfHRMjG612pO3IvZcFj6bg==
X-Received: by 2002:a17:902:59cd:: with SMTP id d13mr5390945plj.329.1589000574672;
        Fri, 08 May 2020 22:02:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c15sm3415031pfp.34.2020.05.08.22.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 22:02:53 -0700 (PDT)
Date:   Fri, 8 May 2020 22:02:52 -0700
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
Subject: Re: [PATCH 1/6] exec: Move the comment from above de_thread to above
 unshare_sighand
Message-ID: <202005082202.567DED45B0@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87mu6i6zcs.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mu6i6zcs.fsf_-_@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 01:44:19PM -0500, Eric W. Biederman wrote:
> 
> The comment describes work that now happens in unshare_sighand so
> move the comment where it makes sense.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
