Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F01C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A35520663
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hx9avRTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgGXOB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:01:57 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31017 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726483AbgGXOBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595599314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h58gw7R+GfsXhRxRgYaoVnY4fYCgBX9KOXMmOVyWW4s=;
        b=hx9avRTOYRMrkeY2dU0Sbq+bibfJv0T8y4jn/jBJrlDShaVfI+S9765F9NA7dqRrSYDzFy
        TdegdD5EvlMPKR82dp1QLt/RUpYTwfZvqQ33xEGDqtzzsBHBM7NWx/wrq6y1tdLEZWVais
        gafqM4UeSiUn4ByZ2RAXtFGrzYIocP8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-WVLJrF1qMZi1Vgk6ot4VNg-1; Fri, 24 Jul 2020 10:01:51 -0400
X-MC-Unique: WVLJrF1qMZi1Vgk6ot4VNg-1
Received: by mail-wm1-f69.google.com with SMTP id t26so3399428wmn.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 07:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h58gw7R+GfsXhRxRgYaoVnY4fYCgBX9KOXMmOVyWW4s=;
        b=ILjj1z95ohpKHmpYpbHQjFZ/1fEhU09dwwmwR6h8+PF79L8rkC8iYuhGSrRGy4CRDX
         Zcyq5eyq1UZ23vGTR0CNAbSo74Z0gqbCzG5bcM8BEQeOHb4Zrfhj5NL3neKmwycZFpj/
         vQlhpcIVvfrCvzQUGLXG2F4ZeJOaEd+GoG02jx5ZJ8D2iDs0ssWfPl10jy1TKY5Dvz/B
         VYcraNFfcrwjLIogHTClIO9nvtIfvprWJyf/WIoV0uAKqF9rRUcjeh8fArv9F+OcPkU3
         +g+SHQKm6nw/L4D6Qha9dy70w4Ad2bVA4HDO1z6T8FTJqYHE2zuS8rbEG1DDLGn3yeBO
         3Y1Q==
X-Gm-Message-State: AOAM5313Qv4bfhMUPIwpEJJdohVxljYwcxGVrhGguB5EJ41b4N7EZm71
        7AJOCKm8drOkXP2ozoIhub/eyy7fZsc9FThUZw3SaSFGQKKzDmAPdBdwZGKUEhP131l+KGKumT1
        aYfw1YHXAVXOCsD8aKysSrwyx
X-Received: by 2002:adf:eb89:: with SMTP id t9mr8591806wrn.65.1595599309227;
        Fri, 24 Jul 2020 07:01:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8AE5R6S+b+buLU+LUHHWuTW7BnkD+owPh/6nz7iYv5AbEV6g3oBIiNG04DOXBaoxxqeb4JA==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr8591766wrn.65.1595599308952;
        Fri, 24 Jul 2020 07:01:48 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
        by smtp.gmail.com with ESMTPSA id x82sm2136323wmb.30.2020.07.24.07.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 07:01:48 -0700 (PDT)
Date:   Fri, 24 Jul 2020 10:01:44 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>, Shaohua Li <shli@fb.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, timmurray@google.com,
        minchan@google.com, sspatil@google.com, lokeshgidra@google.com
Subject: Re: [PATCH 0/2] Control over userfaultfd kernel-fault handling
Message-ID: <20200724094505-mutt-send-email-mst@kernel.org>
References: <20200423002632.224776-1-dancol@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423002632.224776-1-dancol@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 05:26:30PM -0700, Daniel Colascione wrote:
> This small patch series adds a new flag to userfaultfd(2) that allows
> callers to give up the ability to handle user-mode faults with the
> resulting UFFD file object. In then add a new sysctl to require
> unprivileged callers to use this new flag.
> 
> The purpose of this new interface is to decrease the change of an
> unprivileged userfaultfd user taking advantage of userfaultfd to
> enhance security vulnerabilities by lengthening the race window in
> kernel code.

There are other ways to lengthen the race window, such as madvise
MADV_DONTNEED, mmap of fuse files ...
Could the patchset commit log include some discussion about
why these are not the concern please?

Multiple subsystems including vhost have come to rely on
copy from/to user behaving identically to userspace access.

Could the patchset please include discussion on what effect blocking
these will have? E.g. I guess Android doesn't use vhost right now.
Will it want to do it to run VMs in 2021?

Thanks!

> This patch series is split from [1].
> 
> [1] https://lore.kernel.org/lkml/20200211225547.235083-1-dancol@google.com/

So in that series, Kees said:
https://lore.kernel.org/lkml/202002112332.BE71455@keescook/#t

What is the threat being solved? (I understand the threat, but detailing
  it in the commit log is important for people who don't know it.)

Could you pls do that?

> Daniel Colascione (2):
>   Add UFFD_USER_MODE_ONLY
>   Add a new sysctl knob: unprivileged_userfaultfd_user_mode_only
> 
>  Documentation/admin-guide/sysctl/vm.rst | 13 +++++++++++++
>  fs/userfaultfd.c                        | 18 ++++++++++++++++--
>  include/linux/userfaultfd_k.h           |  1 +
>  include/uapi/linux/userfaultfd.h        |  9 +++++++++
>  kernel/sysctl.c                         |  9 +++++++++
>  5 files changed, 48 insertions(+), 2 deletions(-)
> 
> -- 
> 2.26.2.303.gf8c07b1a785-goog
> 

