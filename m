Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E83C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D396320656
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a/bS0RLh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgGNViP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgGNViO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 17:38:14 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BDAC061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:38:14 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o13so8344452pgf.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kBZyCcCmpqlqMqsIRaCWhuIM19zS4zfakl+jOrhjE68=;
        b=a/bS0RLhvJ42yObBQpWU7RQa+G5uNb2e0zU2vIxVYbKgCuhuVCePOZGoJtjvmwd7iN
         xmKjxlDlfNIw1CAvsEm1szrJz74LLht0/WrPFkETS5x0dnr7wky6Use55EWzyo1YbgMf
         wB0RHcDtBRksPGUwkP02h4mG8W2IaiPO+VB6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kBZyCcCmpqlqMqsIRaCWhuIM19zS4zfakl+jOrhjE68=;
        b=Hf5Mdkx1cYMevVJ/Q9fJR6+Hhs7+2c59/hhwgF3zskarbeIiEocjcoASp93J9+o6TJ
         smRo6oamnpkIIFU2iAnzh8MaHGGouE9d7RAtdm+vhyN5D62hhLcZDSztvAXKB5cGWZbM
         V97wQk0XFTv9D1Kqk0SF36FlAvSMLqg6gakfJ1Bhpj5/WMShNf2es764fsRpKVk+lS4D
         T8epUZZZBTEJ75br+C5ygSYK4h5QxET0R+AxlbK43z/lz8SSvnnr6tFe71Xhif/V8l3x
         JkZZMUbZY9yrYT10G+1NB2rMXgoqwBrSy2dIkevRSFnpij63JgUTNn9+EpKW3o3D8dYy
         4awQ==
X-Gm-Message-State: AOAM532ynKKhyAFid1a1VQLpIW7ThFRCylen6k+k57t+qWGtZggtBLAb
        HACrSvH7b/mFSpNc47QGKxZQQw==
X-Google-Smtp-Source: ABdhPJwFFznkEcbi8FULWjz22UCjJ7P9pQh+fwuMJMUGDuP9MkVzkem4ifewJtwGQEQdhFq/4ppcLQ==
X-Received: by 2002:aa7:818e:: with SMTP id g14mr6043210pfi.27.1594762694075;
        Tue, 14 Jul 2020 14:38:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i128sm123203pfe.74.2020.07.14.14.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 14:38:13 -0700 (PDT)
Date:   Tue, 14 Jul 2020 14:38:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/7] exec: Remove unnecessary spaces from binfmts.h
Message-ID: <202007141438.68F0CEDCE6@keescook>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
 <87v9iq6x9x.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9iq6x9x.fsf@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 08:28:42AM -0500, Eric W. Biederman wrote:
> 
> The general convention in the linux kernel is to define a pointer
> member as "type *name".  The declaration of struct linux_binprm has
> several pointer defined as "type * name".  Update them to the
> form of "type *name" for consistency.
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
