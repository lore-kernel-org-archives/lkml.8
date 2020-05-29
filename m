Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAE7C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D280208A7
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F0HxDleJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgE2IPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgE2IPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:15:12 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E3EC03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 01:15:11 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p30so1063017pgl.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 01:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vO7oMyHAmtFgCk2sYz6KxFOeu6MNzidQmmJ2G/1pEM0=;
        b=F0HxDleJOoUvcttpU1UIgZwwGo1qsAu0SBmow0w21SBCMiqJuBybCtCeetr2YSSb4u
         +fkjyKNAyrdR6LI67eZ9RazJfkaoRWRSfWH45gbXJFqdNmob97+GWbiwux22WJi7UR4k
         7hajvHhSt2gRzwMsACsyTc1hVkQyehLvyrnLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vO7oMyHAmtFgCk2sYz6KxFOeu6MNzidQmmJ2G/1pEM0=;
        b=CmxtypCf8Tf0kxh97d3ht/6EHt58Yh75d/tKz9cfbRFHwGaA8qzH4xRSZWqWMbvT0m
         2xro388HkC2kUlcMNcs6oPrwHhwyWqqsyYYWNnYfxYbtupi97lb60pprc4Lx6Ms8zBN0
         KMsmkSX7DBcMMZ7TJKWJ1P7AEzUKrDdhyZ+XGXGNmGp0VmAMxSXYVdKFsvFaCkYRSamh
         lGQT5ijX6boiWpR5IzdMO6VzqZNFv4WpPI/XmqVDhfB9z/j1qRcO+wMFTYWvGFnU9G+T
         4EdZ1buGzQ1yYCt8R23V+Vk6UMpeoLr142Egu0d2WLE95GNFPbl53yzMnNkAjWlCeeAJ
         9icg==
X-Gm-Message-State: AOAM531CMOqpZxul3cCpoaTZ1TAaRUSU4ejTy62XiOfxICqzucOZrR8M
        7YdrWhKmWpbZ6Kv5qgySL9UnCA==
X-Google-Smtp-Source: ABdhPJyNTEBK6lvlRch0b3eSKkfLXX3ub632bw+/rFINA2CK9LgJdaFmN+AJlEWxtJSWAZIJVMFXUQ==
X-Received: by 2002:a62:1e84:: with SMTP id e126mr7611560pfe.67.1590740111285;
        Fri, 29 May 2020 01:15:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k194sm253258pfd.26.2020.05.29.01.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 01:15:10 -0700 (PDT)
Date:   Fri, 29 May 2020 01:15:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     yzaikin@google.com, nixiaoming@huawei.com, ebiederm@xmission.com,
        axboe@kernel.dk, clemens@ladisch.de, arnd@arndb.de,
        gregkh@linuxfoundation.org, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, benh@kernel.crashing.org,
        rdna@fb.com, viro@zeniv.linux.org.uk, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com, vbabka@suse.cz,
        sfr@canb.auug.org.au, jack@suse.cz, amir73il@gmail.com,
        rafael@kernel.org, tytso@mit.edu, julia.lawall@lip6.fr,
        akpm@linux-foundation.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linuxppc-dev@lists.ozlabs.org,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/13] sysctl: add helper to register empty subdir
Message-ID: <202005290115.487C95B@keescook>
References: <20200529074108.16928-1-mcgrof@kernel.org>
 <20200529074108.16928-13-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529074108.16928-13-mcgrof@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 07:41:07AM +0000, Luis Chamberlain wrote:
> The way to create a subdirectory from the base set of directories
> is a bit obscure, so provide a helper which makes this clear, and
> also helps remove boiler plate code required to do this work.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
