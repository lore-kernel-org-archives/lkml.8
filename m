Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C87CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 19:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECE9E2076E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 19:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TRDwzjpv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgHRTqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 15:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgHRTqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 15:46:43 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA961C061342
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 12:46:43 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id kr4so20490pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 12:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ylBQHIGj+jC+wMGAW+WiPoCXXWUQK9WgH6fcVkJtSBg=;
        b=TRDwzjpv9nxBnOSNPospJ+g2+lM26x7LrfAWZDm2gvCsnlrIhyGQMvVZ+nN+hu7WkX
         O/oo+OEjbZ2O9PmpH/HltGohEtaT4mQAuhz2mTIFpqD9eXrS0bAzADnlvGV+CZhjlU6D
         56u72kcTdOBo0I+2qXN79Jwyll3yLdhk3jnEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ylBQHIGj+jC+wMGAW+WiPoCXXWUQK9WgH6fcVkJtSBg=;
        b=YJdz8tN81AZYgY0HKIEwFosENEshKX2QOv6XtIRnKaHp3W5zrGU8JggYye/XWyiIuy
         7kuIReoA0elv/vAAVRko0NbblrXe5cOZjIYYZZE4JSk9e0bEgBzZTfdWCNgRni5IJd6M
         72K039zeqQHIwo/k21IT4he88VU/FXywdv+malVA4iIigzIeulo7xmodkwTpRWkSi/zV
         zXAaAnZ6JNtccCMdxyI1la7gN6KOhcm6Db3KXlv4Cug/l4/09Ab1gAg1Dw62IYlSgOu+
         7lgl0AFh19k5DwRBm0c2UInkM2fP2JT/L9LXexTxfVTaQYEtRjYXy/fzr2iiFgxCZoiT
         NWhg==
X-Gm-Message-State: AOAM532CP41K5nnruv+oFjiiEmD6J95nWqmRJaqU3UWorXvoA3DD4ycz
        8Tqhc41WfPw4BsjanpFLus+cpA==
X-Google-Smtp-Source: ABdhPJxQpoCNUK9oxMIJWJCcBhsLXV3qhwZ1vk6NlnSPUfnJzoewH/BG+Ra1OO11qvGzKQ2Um0GcDw==
X-Received: by 2002:a17:90b:148b:: with SMTP id js11mr1261981pjb.234.1597780003259;
        Tue, 18 Aug 2020 12:46:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j5sm25754806pfg.80.2020.08.18.12.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 12:46:42 -0700 (PDT)
Date:   Tue, 18 Aug 2020 12:46:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 09/11] x86: remove address space overrides using set_fs()
Message-ID: <202008181246.A03BB9CEA@keescook>
References: <20200817073212.830069-1-hch@lst.de>
 <20200817073212.830069-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817073212.830069-10-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 09:32:10AM +0200, Christoph Hellwig wrote:
> Stop providing the possibility to override the address space using
> set_fs() now that there is no need for that any more.  To properly
> handle the TASK_SIZE_MAX checking for 4 vs 5-level page tables on
> x86 a new alternative is introduced, which just like the one in
> entry_64.S has to use the hardcoded virtual address bits to escape
> the fact that TASK_SIZE_MAX isn't actually a constant when 5-level
> page tables are enabled.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Awesome. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
