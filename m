Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC8AC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 22:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E5321739
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 22:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bOcmttTE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgCBW7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 17:59:46 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:50412 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbgCBW7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 17:59:45 -0500
Received: by mail-pj1-f65.google.com with SMTP id nm6so37637pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 14:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3y8oGhwwn7h1smMOkH+HeKModpN/iPLNwqgLaZBDC1E=;
        b=bOcmttTEv2j0nh2i8mKInrg32fEJTW3TB8cREMdc4rSJYyrfFHfvzi6z6lw6TzvsHu
         eQyoNfByjgLjSIo5EBhJueSVqTcGZ5Zo8/3CQRcfW1PSrdcYtsvCmRlaA2Z6agovL+3N
         xgoOOZnzugJjbXf4qjU8AIyNZHXpfSqiY6T/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3y8oGhwwn7h1smMOkH+HeKModpN/iPLNwqgLaZBDC1E=;
        b=Etbg71088cPvF+g72s7ZdrISykG8I98PYtpb2FVlx7I8bvuJw0d5rgVM84b/Qbu+Am
         xQqydCj5O0hLAp+e5p4QQ3JXZ3iXVI6363QO5AIAiigesaYVt8m/dtgOlSKuzsZ3IOQe
         5S93oClp03tBeAm7WOkgZGt0SJpJjRHUf33OztoCE2RVFt53hQSGFQSopn1Le+Fofjrv
         miT6EOjlCML3MenSnSA8NCXZz+TTPtG3uME95E+s01o3DrMgwOGuA7xMl/GhvFtD7vxp
         8eFHRWRCkv6SCVJV5Ev0FKMz5/oKNH2DuE27gCyj+umNasMFs16AXW882t9LDLtXh0/W
         vYHg==
X-Gm-Message-State: ANhLgQ0O2RcodKSX8mjR9XT3fOf2aBtWwMgRRUISScKcveSV2INpmmO/
        YHrJL/Hm0c5XVsQ1l0EdhFYtZQ==
X-Google-Smtp-Source: ADFU+vtNhg6nDtNo99bJ4y/4I5aW36azvtouUPnDEfK/uZsT+45FzUc4fJ2YlXeRfiZe7rP20nhIAg==
X-Received: by 2002:a17:90a:348a:: with SMTP id p10mr859061pjb.120.1583189984731;
        Mon, 02 Mar 2020 14:59:44 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u126sm21801657pfu.182.2020.03.02.14.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 14:59:44 -0800 (PST)
Date:   Mon, 2 Mar 2020 14:59:43 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/3] Better organize the core-api manual
Message-ID: <202003021456.F173F9DFC7@keescook>
References: <20200302223957.905473-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302223957.905473-1-corbet@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 03:39:54PM -0700, Jonathan Corbet wrote:
> This is a brief series trying to create some order in the core-api manual.
> The first patch organizes the contents into subsections, hopefully
> straightening things out a bit.  The other two then move a couple of
> documents to more suitable homes.
> 
> Jonathan Corbet (3):
>   docs: Organize core-api/index.rst
>   docs: move gcc-plugins to the kbuild manual
>   docs: move core-api/ioctl.rst to driver-api/

This looks good; thanks! Random thought while looking through it: there's
stuff in the driver-api that seems like maybe it should move into the
core (e.g. Documentation/driver-api/basics.rst) but I'm not sure what
the line between "core" and "driver" is. I would think the "driver API"
docs should be driver-specific, in which case much of basics.rst should
be moved into "core". Regardless, this series seems like a good step in
the right direction.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> 
>  Documentation/core-api/index.rst              | 93 ++++++++++++++-----
>  Documentation/driver-api/index.rst            |  1 +
>  .../{core-api => driver-api}/ioctl.rst        |  0
>  .../{core-api => kbuild}/gcc-plugins.rst      |  0
>  Documentation/kbuild/index.rst                |  1 +
>  MAINTAINERS                                   |  2 +-
>  scripts/gcc-plugins/Kconfig                   |  2 +-
>  7 files changed, 75 insertions(+), 24 deletions(-)
>  rename Documentation/{core-api => driver-api}/ioctl.rst (100%)
>  rename Documentation/{core-api => kbuild}/gcc-plugins.rst (100%)
> 
> -- 
> 2.24.1
> 

-- 
Kees Cook
