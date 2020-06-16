Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D611C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C06A2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dgp70rXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbgFPShw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 14:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbgFPShv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:37:51 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DB6C06174E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 11:37:51 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d8so8761822plo.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 11:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LbWK89MuCvj1Sl4N39K4jNgkLJl8ySKC6ZW5gbfqTIE=;
        b=Dgp70rXHX7fnmUeMFYCfX+qP4dQ0ouFW9JvgEAXf8RQjWuosjN4K2kcoDDx3X6EGCd
         gqfzfT1evQX/H5CFii9INhsHzWc/0QRxoWNvDEje7IgWDjZAqzWwG4SFM5nnDGXrCvGq
         oYg/+EWEPEqiUnTNTUA8nUAAYg8FfdFtj7PQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LbWK89MuCvj1Sl4N39K4jNgkLJl8ySKC6ZW5gbfqTIE=;
        b=uHxtgvrK9UdKM5NMz7i5EMSBchqEdoLCW7b2nzgB1B4BKNf5EjyfmSe3w025/vAmPd
         f6nBPJGjDCmX7VV1R9piTO+jpR+yOpPOCPseAYY4ai8mzUc/owXmpcf6blA67Li/+jTv
         SdClEbcz/USZvgqtPB1H5mjBNXC3sE5ICVmjoeB9rClxZqGOm3rMq9ZSKVYzB770Bohn
         Ae4uOFvbwYk6MXQ+HgINpa5UW/JGHszSclct2qXKAGyUPWxOIbojmWWxJ9BjoEIVP0PA
         Og94/6b+KIB2MS4SwHYSQMHtkhfm+CINKDxn+WUF+HqsSpdg6MliTVYYfowHVu/XQ1Bf
         7Lrw==
X-Gm-Message-State: AOAM531+IqfNf36Wu9hja4BOYYKM60tAh7CTB0rk1bEgjOAJm4EdPVw4
        oDTNEaaGPAIQt119pTHBA7m9yg==
X-Google-Smtp-Source: ABdhPJzfKYAOTTy2Indkj4vuMYGO+9jnZ8oJ5woe6pxlS8gYmHIPPkUqYdSfRMXeUnQd3cx/XtTqWw==
X-Received: by 2002:a17:902:b58f:: with SMTP id a15mr3308489pls.106.1592332671017;
        Tue, 16 Jun 2020 11:37:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a83sm17453213pfa.146.2020.06.16.11.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 11:37:50 -0700 (PDT)
Date:   Tue, 16 Jun 2020 11:37:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        "zhujianwei (C)" <zhujianwei7@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Hehuazhen <hehuazhen@huawei.com>, X86 ML <x86@kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 6/8] x86: Provide API for local kernel TLB flushing
Message-ID: <202006161136.524AA1C@keescook>
References: <20200616074934.1600036-1-keescook@chromium.org>
 <20200616074934.1600036-7-keescook@chromium.org>
 <CALCETrVSnLAkWN_b7rNY1mbF16qXavbXYtv9fVZA-Q4ZVnTXhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVSnLAkWN_b7rNY1mbF16qXavbXYtv9fVZA-Q4ZVnTXhQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 09:59:29AM -0700, Andy Lutomirski wrote:
> On Tue, Jun 16, 2020 at 12:49 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > The seccomp constant action bitmap filter evaluation routine depends
> > on being able to quickly clear the PTE "accessed" bit for a temporary
> > allocation. Provide access to the existing CPU-local kernel memory TLB
> > flushing routines.
> 
> Can you write a better justification?  Also, unless I'm just

Er, dunno? That's the entire reason this series needs it.

> incompetent this morning, I can't find anyone calling this in the
> series.

It's in patch 4, seccomp_update_bitmap():
https://lore.kernel.org/lkml/20200616074934.1600036-5-keescook@chromium.org/

-- 
Kees Cook
