Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6B2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07AAB2077D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AYAlBFRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391330AbgFXTj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 15:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391239AbgFXTj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 15:39:29 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67946C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 12:39:27 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id x8so587112plm.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 12:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/a69U9KUnIP/MnmiwpDT352wL+s+ti3tEpAhYbHbhGY=;
        b=AYAlBFRXRnMYtO6R47l2rcLiuVa9KKhciaa9QjRn234ngZHMngLpLvpIIVxxPcK9Fz
         lDiPEIS19OvPsoe07mKHu4PMw/IFQn7FUwE+znyljSnnGCk0jLLyAeK/xdnYBsQ6DDwv
         sLU0mFEqZi25KhCzuV/V57AU21Cu4ZX++JTYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/a69U9KUnIP/MnmiwpDT352wL+s+ti3tEpAhYbHbhGY=;
        b=r+xKj8/tCKyFjbnSMuyCwQ+NAZUb/l5dAh8M2HIdrToe2/mhYUbIcVMW1SAV3Kz3xq
         tujKDztT87YI/G2B95Y8OQWtVeXIngIRppQglyftj0OWGEHTfu+BjUq2xpQ6amoWF+ju
         ruFNnDd1agxHZ/x8dE3g86VE5YoXjA5lB1xQvwxw2H3ocQVRf48zHapdoT8dEgWjKPc7
         lK/X+foxglwrEwvWphgYo0tHY541sdD5m+dVN1xFGtgPDA36FZ/kFJMtHkDt30XBbiLB
         0Rn8EObtWwwORJq2xT87v1oK0yBv31YheCCrAhK+cJN82/cQ0URIVzVS2PqKppvhF6Ga
         u6Pw==
X-Gm-Message-State: AOAM532HA6oPOo+53eux/YCDzUJorwLTQP9iH/DqbPhMhGuJz2Aia8X5
        jO50oEFEuDBQotvrYN8sC9jLYg==
X-Google-Smtp-Source: ABdhPJxsIhSY4LIpPRCeVYP27MH+CcQ1yP3o8etmQfid2B35Utc+FwSfostKkdFyMVSQ/x0hv8EWxg==
X-Received: by 2002:a17:902:ab8e:: with SMTP id f14mr30733842plr.80.1593027566653;
        Wed, 24 Jun 2020 12:39:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n12sm17153037pgr.88.2020.06.24.12.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 12:39:25 -0700 (PDT)
Date:   Wed, 24 Jun 2020 12:39:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Christian Kujau <lists@nerdbynature.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: Re: process '/usr/bin/rsync' started with executable stack
Message-ID: <202006241238.E9CB1CE85B@keescook>
References: <alpine.DEB.2.22.1.446.2006231023390.3892@trent.utfs.org>
 <20200624165148.GD31008@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624165148.GD31008@kadam>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 07:51:48PM +0300, Dan Carpenter wrote:
> In Debian testing the initrd triggers the warning.
> 
> [   34.529809] process '/usr/bin/fstype' started with executable stack

Where does fstype come from there? I am going to guess it is either
busybox or linked against klibc?

klibc has known problems with executable stacks due to its trampoline
implementation:
https://wiki.ubuntu.com/SecurityTeam/Roadmap/ExecutableStacks

> 
> $ checksec --format=json --extended --file=/var/tmp/mkinitramfs_eTyMPQ/bin/fstype | jq
> {
>   "file": {
>     "relro": "no",
>     "canary": "no",
>     "nx": "no",
>     "pie": "no",
>     "clangcfi": "no",
>     "safestack": "no",
>     "rpath": "no",
>     "runpath": "no",
>     "symbols": "no",
>     "fortify_source": "no",
>     "fortified": "0",
>     "fortify-able": "0"
>   }
> }

Wow. _nothing_ implemented. :(

-- 
Kees Cook
