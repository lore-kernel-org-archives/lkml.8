Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA9CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FF8B2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YNNvSaAN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgEZQPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 12:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbgEZQPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 12:15:07 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79628C03E96E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 09:15:07 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id a13so8873680pls.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 09:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IdTmx5bvE+V1cAcFJI98GnDSoP0mb5MfVH5Axb1TejM=;
        b=YNNvSaANvznznsq6NwzIsZWeDzc27QMCyU/RLQFt132rryBivrtEuaFvxLjynP9vOC
         lrwK6MQNyNlvBZmT/WVxhaRyPcDs+pAsTRKf58LrEcBxV4nseo6f1t3PdSvmHFV4uf0H
         g1OP43Bipju2hrlrFmsJXumIB96rviCx8CjEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IdTmx5bvE+V1cAcFJI98GnDSoP0mb5MfVH5Axb1TejM=;
        b=Wi4qgcqfbFlZ6HAXx8IF5LwKlwd1GfUjDbXs8/evYRNLkP8qWRZ35Bj0tJJY5JXDGa
         XW9iC3ueTAgrx6Wztc+/aggBDF/5PBf/caenIDQ/+ARDn/24zJJCYQyqH6VTdEMc4jQG
         jGs+a5chFGmNc2Q27ANuxaVYF6EhbGlcgtrzlM0sFG8uFMFtG1hfhzE6CpeeNRqbC1Cs
         lKH8IHlbF8I6fJOBHAqBohKXNh7XLjaHKnHqdEy1sidLjgOgFlx5p5JLKGFXRGUp1NPP
         vMb9Cu/FtjXDDtCbCHiydmXrLHrzsgQuIZPOyw/NIe5FaXD1e5bPb3R+gSt6UJOWK0oq
         yZOA==
X-Gm-Message-State: AOAM532PrMYhKwG3cIV2XGuvfrZ29MWa3pyMSQT5iwNmGlzSd7f8pVeS
        RYHPg8K/NogDP31lgvoo6owKhw==
X-Google-Smtp-Source: ABdhPJzdYWXboruOLBkXnWjJPQ/weKAztCxQPCSyM3XiKpaGg2ZHsjoGl/AuQAdP804jyn88zCCNbg==
X-Received: by 2002:a17:90a:2a8e:: with SMTP id j14mr21920pjd.136.1590509706847;
        Tue, 26 May 2020 09:15:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g18sm33078pfq.146.2020.05.26.09.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 09:15:06 -0700 (PDT)
Date:   Tue, 26 May 2020 09:15:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andi Kleen <andi@firstfloor.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, sashal@kernel.org,
        Andi Kleen <ak@linux.intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH v1] x86: Pin cr4 FSGSBASE
Message-ID: <202005260912.8867B3AA@keescook>
References: <20200526052848.605423-1-andi@firstfloor.org>
 <20200526065618.GC2580410@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526065618.GC2580410@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 08:56:18AM +0200, Greg KH wrote:
> What about those systems that panic-on-warn?

This is (modulo the general discussion about whether it's the right
way to check) the correct use for WARN*(). It's an undesirable system
state; people choosing panic-on-warn want this:
https://www.kernel.org/doc/html/latest/process/deprecated.html#bug-and-bug-on

-- 
Kees Cook
