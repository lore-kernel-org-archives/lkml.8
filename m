Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F163EC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 02:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C55D3206D4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 02:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d3cstiY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgEQCoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 22:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgEQCoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 22:44:21 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487DEC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 19:44:20 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x77so3069819pfc.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 19:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hxqibz6u//AudMT2I1ARGsf1Me7UhpEYD8y+pnhWIpY=;
        b=d3cstiY6gDBn4aMz8bpUhxxoMwZGVOHwN8YofmIdJRCHvyLUctClFeHYQOcqqBJFvR
         G8YNmf06SK9P79w1RZojxbv8wsLCoyhs969+9o2C/XmI3PTSno2Rgr8Rsil1KFZ5l/s/
         azsLDeoU7EiBDYz4zxzLKClh0LKrQA8N/j6eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hxqibz6u//AudMT2I1ARGsf1Me7UhpEYD8y+pnhWIpY=;
        b=mFF3hJXPeTFSRqj/bf+yg1xhuXnBm+Hkpl5pXH4MZjpnlgYmqrWcabVzANRmiYdAjE
         IGxOVhmQXbxcdxLkHU4tPIz7X+8Gj6ApLmIpp9IRZelBwwyq8Ja/0Po3MTHkaZ+3121f
         9iYj4DFzAFfWKiYtNTdA9Y2rRdG337X8Rb2KS7UvKW9EdjndGcLabUyg5ofHig2kkG8I
         P4/hfgFMTD4veZjIZ7wXVvY3eqvwDRJa39DiZ4TTXqTh9kQtj+TPdEmKBMz0+IVr87Vh
         02iKUkB05sGHp8FTM6PmhnGxi7hRP2WloaTlOKEzIB2bujFKvYS/+691luyLULlGQtcW
         3KcQ==
X-Gm-Message-State: AOAM5306GkzeIes8aJNubUbPRjuyZLb6zkmVx+ACpy8i0wFLRHIfVEPg
        HAWvnOInO/qCWpsKhkLJZzENxA==
X-Google-Smtp-Source: ABdhPJxehxf7fk4k860rUeZr0MjMnear8BYSqBn6G0ZjDSi6Z0+EPk+E1jqMWIogilie0gXavfMpMw==
X-Received: by 2002:a62:2fc4:: with SMTP id v187mr10683638pfv.312.1589683459911;
        Sat, 16 May 2020 19:44:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z6sm4662345pgu.85.2020.05.16.19.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 19:44:19 -0700 (PDT)
Date:   Sat, 16 May 2020 19:44:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     mcgrof@kernel.org, yzaikin@google.com, adobriyan@gmail.com,
        peterz@infradead.org, mingo@kernel.org, patrick.bellasi@arm.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        Jisheng.Zhang@synaptics.com, bigeasy@linutronix.de,
        pmladek@suse.com, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        wangle6@huawei.com
Subject: Re: [PATCH v2 4/4] watchdog: move watchdog sysctl interface to
 watchdog.c
Message-ID: <202005161944.75CFAD8@keescook>
References: <1589619315-65827-1-git-send-email-nixiaoming@huawei.com>
 <1589619315-65827-5-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589619315-65827-5-git-send-email-nixiaoming@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 16, 2020 at 04:55:15PM +0800, Xiaoming Ni wrote:
> Move watchdog syscl interface to watchdog.c.
> Use register_sysctl() to register the sysctl interface to avoid
> merge conflicts when different features modify sysctl.c at the same time.
> 
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
