Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD956C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 02:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3A1C2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 02:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLVAyGoW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgHQCPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 22:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgHQCPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 22:15:21 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B201C061786
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 19:15:21 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id bo3so15885622ejb.11
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 19:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f92aQcnFdOsFoLLk4gmJBbx2VhwC8iwgWSP97DQXYBg=;
        b=CLVAyGoWnb7Q7BSkYtTG3AOJTgUbOf1lQkbc5COm8iMCxobicPkOd0BcmplpOzgohF
         Pr/LMcBa5MT11d4qhZHq2RiIqy3gG+Wqz8QkRnqM6WTQ+W4uUpzyngc8DjR9cNf6zAVG
         Hto5VhmcuQ8djmfNk5615ocJ3rD1aJDfmKwPPY9irh9rqUtZP7RYEw+FazO9kxQ+j89k
         lUn39TX4W0DNBMQP5dRFtKTS8ppDvDsQ5rKrrS/Pc+p+Yj/YrVabuIckFp9rRNk7v5jk
         4/vbXcYEFvy8kSbPbnv8Aip/x0rx1db7TXRatERrVPyqI03l7+E8IAcxBr7OGoU71mNG
         YVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f92aQcnFdOsFoLLk4gmJBbx2VhwC8iwgWSP97DQXYBg=;
        b=MCdFdlTOM4oK7AVXUn7Ai6+mOIRlAqPsiooUtfS6Z6eDCknoBQBKSPb0pn6vuMbpG9
         J/Op3QMGvNegzk7Zh5udcb/x+pwehd4/btGSNP3fJ1UBNi+238nSVvk7adwIC45X8hf2
         v89o65BoyCa3zGNqYBG1s34XbKQw/LmCV7Ss+dd/bgDfvBNIahMJk+Jz00TQsRWFiyKw
         wnmhSiuiY1yjPyhf25lBsZsOLZFqOW+Kf5Aq5R4wbsDaU5zGshG89GLgBXMVdCVRAjSU
         XlqhhyOj+xxXQk89HNi1bKGSAuGKpH/YrCu7ZrjJRYlVWy/dsVrgJIIn/9pj0CFjoYR2
         /VIg==
X-Gm-Message-State: AOAM531Dm0fhphFE3kTD6GtNE+eNevrAZL1+YTG5rdrZaNGL0jDUqNB9
        ORcmk0IQRDDFpeydAG+EYHc2uQSdr6o=
X-Google-Smtp-Source: ABdhPJwKT9wCu6GwPewakfFt96GIZCY9Luv4I/HA4p4JGJWN8uMN6mDcem1D+IUVZM+EOJ7SkcuU5Q==
X-Received: by 2002:a17:906:d209:: with SMTP id w9mr12725584ejz.93.1597630520336;
        Sun, 16 Aug 2020 19:15:20 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:9c9f:b37c:49dd:cd66])
        by smtp.gmail.com with ESMTPSA id j11sm12645315edr.71.2020.08.16.19.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 19:15:19 -0700 (PDT)
Date:   Mon, 17 Aug 2020 04:15:18 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>
Subject: Re: Linux 5.9-rc1 (sparse? kernel/time/timekeeping.c)
Message-ID: <20200817021518.q3petwc277m3uqxz@ltop.local>
References: <CAHk-=wiwfkKp93C+yLqKWAU0ChBdeBDUhgOk09_=UQ8gOKbV3w@mail.gmail.com>
 <83b35552-d1a2-e4ce-9a41-2b5cf688ccf0@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83b35552-d1a2-e4ce-9a41-2b5cf688ccf0@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 16, 2020 at 06:35:26PM -0700, Randy Dunlap wrote:
> 
> on x86_64, allmodconfig:
> 
> $ gcc --version
> gcc (SUSE Linux) 7.5.0
> 
> $ sparse --version
> 0.6.2
> 
> 
> I seem to be having some problems with kernel/time/timekeeping.c,
> including a segfault.
> 
> a. Is it sparse that segfaults?

It's most probably the one fixed in:
  eb6779f6f621 ("generic: fix missing inlining of generic expression")

On the main tree there is a branch with a few fixes since the last release:
  git://git.kernel.org/pub/scm/devel/sparse/sparse.git maint-v0.6.2
 
> b. what prints this message?
> make[3]: *** Deleting file 'kernel/time/timekeeping.o'

It seems like a typical message from make when a command fails.
 
> c. I would prefer to be able to tell the source of warning/error messages,
> i.e., gcc or sparse. Especially when they are intermixed.

You can use the option -fdiagnostic-prefix[=PREFIX] for this. It will
just prefix all messages from from sparse with the given PREFIX or
'sparse: ' if none is given. You can pass this option via 'make CF=...'.

It may be a good idea to directly add it to CHECKFLAGS.

Best regards,
-- Luc
