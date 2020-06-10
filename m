Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67560C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 19:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 467242064C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 19:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T/bw5Wnl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbgFJTph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 15:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbgFJTpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 15:45:36 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6ECC03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 12:45:35 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b5so1549909pfp.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 12:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n0HyvUu4I8/Tk1QZlxgaik2t+t1oOltizttrT4rEXFQ=;
        b=T/bw5WnlXMhjbRkHFHu2+YA12ULZrzFF9wV+ez7jTxHqPfYHAmfIE6TnelBqB4jg30
         Jy+N0DSNfUbyG+VbQIy3OYzJhFzb6mRdLhRAQfgfhUo21aanTsUJ31Z6jJG0cIGs4uFo
         Y3a1qpTQ+syktszuJrAqIw3ZhZJsCh2qIPh0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n0HyvUu4I8/Tk1QZlxgaik2t+t1oOltizttrT4rEXFQ=;
        b=lwvKim+db1tWwyJTwEKAVXT2b5I2t70nBfPwqvBFb+1BQL9VMJ0B67rEPMUqbfkuKm
         aOJ6BL9W7EAm10UAZN+aZ7k3wQJ3AlsnejrMQ3P4Z+/eUKwS642ZWOI4kGk/iELdO/kJ
         TH7BMUTpjIso31Sz7bk8l261xiN7qINgoL6W3saDNhSIvgERdCqFGyD8vIcO2YmSsxNW
         chnyOCF0wO6dhWa+OK1tlxv54OWPE0kbcaOvD4rXZEjchr2/B3AY2jgPoWhkV0qxDrRC
         9/x8R9e4MmDIR6GBgNzZofq+NchY9dm1y+Qiun+rlSMG0pHJAZvlhkXHrFGb6+7X2G+V
         qgeA==
X-Gm-Message-State: AOAM532G7bNdlDk8mYnk7CFY8jhAITLKDFsJ9ytwj1ivxtjADwGyzKtc
        lry0mT5Oz9up1r0WMWQ6OhPTeA==
X-Google-Smtp-Source: ABdhPJxQazKAaDQdrS3kMhaPahisDHZnR720ERs2fv3PGWdFox4bysbcjyaTdO4nNWLofCje+hi9Cw==
X-Received: by 2002:a63:2216:: with SMTP id i22mr1705849pgi.31.1591818334976;
        Wed, 10 Jun 2020 12:45:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o20sm488717pjw.19.2020.06.10.12.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 12:45:34 -0700 (PDT)
Date:   Wed, 10 Jun 2020 12:45:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Sargun Dhillon <sargun@sargun.me>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Use __scm_install_fd() more widely
Message-ID: <202006101245.DED83052@keescook>
References: <20200610045214.1175600-1-keescook@chromium.org>
 <20200610094735.7ewsvrfhhpioq5xe@wittgenstein>
 <202006101001.6738CA0@keescook>
 <20200610113800.5d7846ce@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610113800.5d7846ce@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 11:38:00AM -0700, Jakub Kicinski wrote:
> On Wed, 10 Jun 2020 10:03:03 -0700 Kees Cook wrote:
> > If 0-day doesn't kick anything back on this tree, I'll resend the
> > series...
> 
> Well, 0-day may find more, but I can already tell you that patch 1 has
> a checkpatch error:
> 
> ERROR: "(foo*)" should be "(foo *)"
> #149: FILE: net/core/scm.c:323:
> +		(__force struct cmsghdr __user*)msg->msg_control;
> 
> total: 1 errors, 0 warnings, 0 checks, 131 lines checked
> 
> And patch 2 makes W=1 builds unhappy:
> 
> net/core/scm.c:292: warning: Function parameter or member 'file' not described in '__scm_install_fd'
> net/core/scm.c:292: warning: Function parameter or member 'ufd' not described in '__scm_install_fd'
> net/core/scm.c:292: warning: Function parameter or member 'o_flags' not described in '__scm_install_fd'

Yeah, there are a few more problems too. I'll get it nailed down
hopefully this week and send a v2.

Thanks for looking at it!

-- 
Kees Cook
