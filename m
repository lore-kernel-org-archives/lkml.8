Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54291C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B9AF2151B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IxPsPhPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgE2H4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 03:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2H4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 03:56:54 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952DCC03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 00:56:53 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bh7so782325plb.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 00:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wJKviGSb43r8OkB/UuBQJYAmIC5ksJ6sk1a0IEQBhN4=;
        b=IxPsPhPF1DMT5JvG0j3sGdEm+IOPQ/T1kpC7GZnJnOA/XG+/4MJ5nPfLUapQbKWQnh
         NfsMGbLgPZMjNu+yrdoSA6iSQLHxXoy/YOf9K64vR/dSZfEkqGFYsNQjEwtNux72fkv9
         VM0KdWvwZKo/wE4kQcBDJ1QnzsjXb+Og+hSPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wJKviGSb43r8OkB/UuBQJYAmIC5ksJ6sk1a0IEQBhN4=;
        b=QEI5oEGsQW9N2OxpkgJT7o9flx+oaxlQJL0vV6apu8e/ZLdIkfrXdjybFQzzoSe+8Y
         INmCVz9GHQrMg6AtXo7bF8MW4+jK+lFOs0da3HIfT2K10ay0vtARdISOyHZP+tbDMbKz
         QfBB4gcCbViDVPLCj6v24N8y1DvX8uO7xHP+9MAbjo0nN++De7GD/L0J2jv0Mb9WuL+H
         6BF+KpY2iGAiATgmN+VP5jL5EyBHUECRNgQAfQbZ1U0dOVf6AoZe6ZqzrGyY7yve7Hq9
         2lvZvmVWUv35j9FX35xcAWncc1SLiGakS93hWFAzjyRXHIChS8w5wLy9913toG9DdfAR
         FcwQ==
X-Gm-Message-State: AOAM532tPpW4kuqw55TRsRp453hnDlcGVILi2VL2F9X5aRP+i56n/pQk
        pLXAjh1ru2RG6i5seJTQH3uc8Q==
X-Google-Smtp-Source: ABdhPJym+TATv6yq9jovCy0uCG/yiKv4jhzdg1qp/JnCt4OmlzVxYYGoQ9A2hiLOC7vF4h7jrSZPBg==
X-Received: by 2002:a17:90b:b0e:: with SMTP id bf14mr7866997pjb.98.1590739012472;
        Fri, 29 May 2020 00:56:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r31sm6986939pjg.2.2020.05.29.00.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 00:56:51 -0700 (PDT)
Date:   Fri, 29 May 2020 00:56:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jann Horn <jannh@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Chris Palmer <palmer@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Robert Sesek <rsesek@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH v2 1/2] seccomp: notify user trap about unused filter
Message-ID: <202005290055.D6E777A@keescook>
References: <20200528151412.265444-1-christian.brauner@ubuntu.com>
 <202005281404.276641223F@keescook>
 <CAG48ez0k23qM2QEi42VTjCbnoY9_nfTH09B_Qr2zu+m3KWWUiQ@mail.gmail.com>
 <20200529075137.gkwclirogbe3ae2a@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529075137.gkwclirogbe3ae2a@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 09:51:37AM +0200, Christian Brauner wrote:
> Aside from this being not an issue now, can we please not dump seccomp
> filter contents in proc. That sounds terrible and what's the rationale,
> libseccomp already let's you dump filter contents while loading and you
> could ptrace it. But maybe I'm missing a giant need for this...

The use-case comes from Android wanting to audit seccomp filters at
runtime. I think this is stalled until there is a good answer to "what
are you going to audit for, and how, given raw BPF?"

-- 
Kees Cook
