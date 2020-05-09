Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C497DC28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 05:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A32802083B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 05:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xa+u0P6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgEIFDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 01:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgEIFDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 01:03:05 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE8CC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 22:03:04 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id z6so1640803plk.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 22:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/AENFOpTjGHR02cL1kgiq9GWV1My/wAsjJBe1VOhVZI=;
        b=Xa+u0P6IAVg8Cqpns68XcVm1URkmY2rSFhaSgvn42NcL6IorVKtLP/pPqNddqaZwi4
         hyecJMJHW//EZMy34y2Ou/Ppuk28Q4Os3wCA9Mqtt5mgbC83jKnlC8VOjmCrLSqn+3FL
         XyNwHFFtg5Y/19RzcqHh4kkFp84mbach2CBRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/AENFOpTjGHR02cL1kgiq9GWV1My/wAsjJBe1VOhVZI=;
        b=fApJ8BkCMZ6+JDgA55pBB6oYEreKXgQMYgwT7ODHomMiNWL4KZf4y9Ru2IwftH6TR/
         saRC2/sWd3yb63tGtGWxEcyA0/gbl1tXGoS9n5vXxuqUxgiRvzzrmpKpTrELdBD238kq
         UYYpvDhXwP79yW1UCo9GglpYB15GkTO46Xw1x5vsAblmjPecpzeObZ35hQ2OFeScxn79
         yZy8dcyPGKjfSee7lc/g7PuEl+8RxCT6XeXDL2/8m+c0FwWc/sXPfnfFJXRjSe8EqHda
         iW8idVKExDwa1gDNPFAYUbo2nrY2sfnWmmQfa3d0vz8sobDLKWYohkuKbmlMFU6EUzRO
         tLAQ==
X-Gm-Message-State: AGi0PuZfGU6ayuzXkInkDpI4VH21tyxzjXrgT+1AAt906PKPOCF60sRU
        qoPP7md5vxU/HxA0AHprWJjt/Q==
X-Google-Smtp-Source: APiQypKW+Opy6mPlgNDF55OnSt0CqJPvBIxWqCykHAn+1QO6N6FkGQw5hLxGdYVG8qzolJ9wH1qBOQ==
X-Received: by 2002:a17:90a:da05:: with SMTP id e5mr9981232pjv.140.1589000584491;
        Fri, 08 May 2020 22:03:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y63sm3391530pfg.138.2020.05.08.22.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 22:03:03 -0700 (PDT)
Date:   Fri, 8 May 2020 22:03:02 -0700
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
Subject: Re: [PATCH 2/6] exec: Fix spelling of search_binary_handler in a
 comment
Message-ID: <202005082203.585C2F6@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87h7wq6zc1.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7wq6zc1.fsf_-_@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 01:44:46PM -0500, Eric W. Biederman wrote:
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
