Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A74DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FA9720679
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W6zzf4n1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgFZVFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgFZVFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:05:14 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D11DC03E97A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:05:14 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 207so4949589pfu.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wZoxiP0mTeiu9+lN0In23h0uJGDaqzSh/2yHrJcG0vY=;
        b=W6zzf4n1FJ+jbypcb/n75nQ9f/qgNuv1aMFledULOSq+3p7GtFYtHvD+jWVHob7zij
         Oi0GziKAhh9/2WERpXPcNsYysb41CMLrjmgII0ZRcxG0QjymJwmMX5cvNVzyBh/DJ/D+
         XVZxAvq0ePQdTnXIAJqa7f4ekDTEqtW3W52cU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wZoxiP0mTeiu9+lN0In23h0uJGDaqzSh/2yHrJcG0vY=;
        b=E23OVMtgn49ok4jr1UE+pbdR4X7amebIIZZY0WQjEfznSoOa8BZpSWPvm7iVT562os
         64Y5DnCVbbP1+V7JPZYv68Fg3k3shHlCu1KCB6zicUgYeeAL2UWt42v1fLlv3J06Rb13
         HLkwbH6JwlSkKnnfKTbp+MqhM11tDTxe45YgaxOo+IOuxaX9lH4i33Pi6sCs7WUXuPdw
         nlZ2mWx29dfNErjhy0yemTXcvka/1t982qHiptsbb9emx9YRWWNOIo+rSHrbZ1KwF7AR
         kt3Wj1n4wE4gmGrmXsbgU3TlRrDOIwrVFb9mDIKHIX2AGoHQRQVemXbGEUU0ZiByYjKz
         UUfw==
X-Gm-Message-State: AOAM530FvS/oTMftDrkqSW+Ff1ttpOf1Y3of3AFYASNNvGneA0hOW0ou
        LNne5THQwkIxJ6+Spffzf4r3Cg==
X-Google-Smtp-Source: ABdhPJy3s8sc/ERwXoxJsr+XLKL9bz5tQ5UtuzDRNXOvRBhYMKE4oIsAIGdPPetiSVb8MYDyRT/BAg==
X-Received: by 2002:aa7:8681:: with SMTP id d1mr4531191pfo.230.1593205513960;
        Fri, 26 Jun 2020 14:05:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y7sm11572394pgk.93.2020.06.26.14.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 14:05:13 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:05:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 8/9] fs: don't allow kernel reads and writes without iter
 ops
Message-ID: <202006261403.3E1397040F@keescook>
References: <20200626075836.1998185-1-hch@lst.de>
 <20200626075836.1998185-9-hch@lst.de>
 <20200626135147.GB25039@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626135147.GB25039@casper.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 02:51:47PM +0100, Matthew Wilcox wrote:
> On Fri, Jun 26, 2020 at 09:58:35AM +0200, Christoph Hellwig wrote:
> > +static void warn_unsupported(struct file *file, const char *op)
> > +{
> > +	char pathname[128], *path;
> > +
> > +	path = file_path(file, pathname, sizeof(pathname));
> > +	if (IS_ERR(path))
> > +		path = "(unknown)";
> > +	pr_warn_ratelimited(
> > +		"kernel %s not supported for file %s (pid: %d comm: %.20s)\n",
> > +		op, path, current->pid, current->comm);
> > +}
> > +
> 
> how about just:
> 
> 	pr_warn_ratelimited(
> 		"kernel %s not supported for file %pD4 (pid: %d comm: %.20s)\n",
> 			op, file, current->pid, current->comm);
> 
> also, is the pid really that interesting?

Yes, pid matters, especially when there may be many of something running
(e.g. rsync).

-- 
Kees Cook
