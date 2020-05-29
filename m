Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3064C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C213920721
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N2lJ9F/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgE2OtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 10:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgE2OtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 10:49:18 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A0CC03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 07:49:18 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id fs4so1419498pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 07:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IteRcXXajwbtNBJuddDZT526vs0ZDhNnSpFmn8yamV0=;
        b=N2lJ9F/4/3HpzR/J93sxrFdqGlVz2QNhGMFIycNuy00m6veP+w2xnnditHihQIFXnL
         XCqnug4fq5fbhUlWxzOjXXHpHuSdsRGl38B/e6pOTxpS3O0ArAhFReLuF1TrhT95SEC1
         m9Mxjr53v0I0p+Z26i7nqIoQoQyWYIDSUoGm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IteRcXXajwbtNBJuddDZT526vs0ZDhNnSpFmn8yamV0=;
        b=QiBeKOjlqoEWBRsvEM9nyKn+vmJKs7SLh+S0COiYQ1zqiDrh+HjQAmk/LBVtemxIHU
         fvqaYEQNB4NyvqejiEfBM8IpkBlaSvgfmuK8n3AYlXYjQ4wgOFxLFhB3OUoim8hj1/EB
         eyLa9oDtMG8e1UXXEsgxALmHR0JPNmT9Df6L4ocmFuGA1DJjwpQ7Ip7j/fZW+EZm2wC/
         d6MOgnovzufR9cDd0sYf/ko6BKoyM7xUoGKNh4S8NUPLRJ7RgvoqtTqugdxoeYJ9l3Kb
         /pHhvdKa05OzxDFefWrM5OkjRJBrJ9bRhnczVLtOHGZVHamytHqlTFjKfL/DV/MPJ1N+
         3gHA==
X-Gm-Message-State: AOAM532lynrZBFqUL9irPU89Q7Gae9aboBwgFZHkn/h44jUi15T3Atg1
        g9rijGaRfUv5AG5D/m3rODn64Q==
X-Google-Smtp-Source: ABdhPJzFHib1KyRD9/QyczMF6fwrQXT/kFQagYx7n1WCZ6zEYqL92DxL1gm98yo73HrZ3ypBekLGug==
X-Received: by 2002:a17:902:ab8b:: with SMTP id f11mr9427824plr.145.1590763757769;
        Fri, 29 May 2020 07:49:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w185sm1049497pfw.145.2020.05.29.07.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 07:49:16 -0700 (PDT)
Date:   Fri, 29 May 2020 07:49:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     jack@suse.cz, rafael@kernel.org, airlied@linux.ie,
        benh@kernel.crashing.org, amir73il@gmail.com, clemens@ladisch.de,
        dri-devel@lists.freedesktop.org, joseph.qi@linux.alibaba.com,
        sfr@canb.auug.org.au, mark@fasheh.com, rdna@fb.com,
        yzaikin@google.com, arnd@arndb.de, intel-gfx@lists.freedesktop.org,
        julia.lawall@lip6.fr, jlbec@evilplan.org, nixiaoming@huawei.com,
        vbabka@suse.cz, axboe@kernel.dk, tytso@mit.edu,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, ocfs2-devel@oss.oracle.com,
        viro@zeniv.linux.org.uk
Subject: Re: [Intel-gfx] [PATCH 06/13] ocfs2: use new sysctl subdir helper
 register_sysctl_subdir()
Message-ID: <202005290748.043EFFA3F@keescook>
References: <20200529074108.16928-1-mcgrof@kernel.org>
 <20200529074108.16928-7-mcgrof@kernel.org>
 <202005290121.C78B4AC@keescook>
 <20200529114912.GC11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529114912.GC11244@42.do-not-panic.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 11:49:12AM +0000, Luis Chamberlain wrote:
> Yikes, sense, you're right. Nope, I left the random config tests to
> 0day. Will fix, thanks!

Yeah, I do the same for randconfig, but I always do an "allmodconfig"
build before sending stuff. It's a good smoke test.

-- 
Kees Cook
