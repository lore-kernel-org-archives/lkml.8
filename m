Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A430BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 750FD2074B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gGlTwgs4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbgFIPkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbgFIPkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 11:40:40 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3A0C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 08:40:38 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id h95so1571058pje.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 08:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JhuprND+jQiTm8+uL0T5IxvcnEQrqGWifzKP0d4qVkA=;
        b=gGlTwgs4RnRI980s5nUdvbSJSvupkhz1v2MySy7SoxfZ3MT9KzqwKvFnwMUNFW1ge/
         pk2hLsc/i8QoVgK9pQpc7YDgNX+GeRaigk4Cyn92MCqJxh4mIUzXawnI3DeVxgVDrw3T
         uZJjJ8Tm3gW3jwo3l2/aIEUvHB7oBIL9Un8lQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JhuprND+jQiTm8+uL0T5IxvcnEQrqGWifzKP0d4qVkA=;
        b=FrLrw77qkUd5jrcQgtbL6ZSIzkhVekAEHz39gULY++HC4TT9WC+HLiN8kLqFptbyJE
         ZS+KlM2rsI5i+5yO/Jck4kCiyfUq0zTFxiNqAqiQjlNTM8H21nMZW/cCDwY7wjUabRpP
         UyAlb2LZigZUH/U9dOTuGj4bwraBL/CogPl+46q99lOH614qx6cTBVccZmmHqv9fHJqw
         AjagZSiKtYSMxGIAzPp2CmvryBbm/qKrnSfMsvlZwJm0IbajiyOy/PXmIiRyiK1ZZjuK
         ymSVFzJkWZyrQfJ5EFcnjw6hk/ctIHyIWkSAE0Bhb2Idh0y0bsda13p2HsS5pqdxxtoB
         u3VQ==
X-Gm-Message-State: AOAM533mTS+6pduxyqEJoYVK1LK5LxV8XDAHxh7wf0VmlS1KnTjxA7W9
        +vpL4iTE7VdOrEEAN+JLUsre/w==
X-Google-Smtp-Source: ABdhPJzb2MWRxM/eZx2pZVlc/qlG7unjjMy2Y2UzWX53zzFvdqhMKbG9EEoYy+6QKm7/LNOX+6otRA==
X-Received: by 2002:a17:90a:9d82:: with SMTP id k2mr5496082pjp.224.1591717238322;
        Tue, 09 Jun 2020 08:40:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z23sm8532845pga.86.2020.06.09.08.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 08:40:37 -0700 (PDT)
Date:   Tue, 9 Jun 2020 08:40:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     ebiederm@xmission.com, ak@linux.intel.com,
        alex.huangjianhui@huawei.com, linzichang@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Delete the code of sys_sysctl
Message-ID: <202006090839.6EDB4BA@keescook>
References: <1591683605-8585-1-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591683605-8585-1-git-send-email-nixiaoming@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 02:20:05PM +0800, Xiaoming Ni wrote:
> Since the commit 61a47c1ad3a4dc ("sysctl: Remove the sysctl system call"),
> sys_sysctl has lost its actual role: any input can only return an error.
> 
> Delete the code and return -ENOSYS directly at the function entry
> 
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>

Looks right to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

Should this be taken a step further and just remove the syscall entirely
and update the per-arch tables with the ENOSYS hole?

-Kees

-- 
Kees Cook
