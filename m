Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71299C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 04:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F9B420663
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 04:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l2Gni8Vk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgGJEbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 00:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgGJEbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 00:31:40 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB51C08C5DC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 21:31:40 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ls15so2075810pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 21:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NT4ks9hhnbWaFMSgDjtyc7VOZxcDYOUZO3SrDJL1oNA=;
        b=l2Gni8VkGX4ycXwuoNMtI8lJuVbDljbiMhzSv5/h7SZY0y4lolp3y9Ff4MS2p8D9zH
         SufvsUXukygmincyfyqGytqJ8byubGSu2ttU1UDOCLQ/gxHGSjVl4SuNXDinHaszIjDW
         9afeTbzQtHCoemu5kIqZ82N7Uh2gXe4KMrANo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NT4ks9hhnbWaFMSgDjtyc7VOZxcDYOUZO3SrDJL1oNA=;
        b=dBMDhPa5b4RYOrZ6RMTGTaYUUBnMRMD3NDC+ne5Gap2eGItU+C09QxAxXNxjxrYhqa
         xZBB+8uynzCqFK5PRGXCVeaMj5A4jmPHGJJ0c+F1jRKVWsEDOadQg5Y4j454Kt2BG2jO
         r3sF4TuKHhFvtT31if3L3ucWw+6QEZFfdC4kfRqNvpScfroCMZLnMlNWxrxbTnZy1ULw
         mO6ZMdKj5AVdARMDoGfDmv/MWZNkhoUG8dhbFrB5LqP3u/XlhCu8oS134CJscY5ax+gk
         qiZSmD0WS+29uWuSsdJ4ObXGv6+8rDVrbCCVgp776uVs2JrfSawYMfrGeBEQrYMBnegM
         KhUg==
X-Gm-Message-State: AOAM531ROAl/O9cPjRluoS3xcjXtrQKvbQn5TcDPUeE8FEMpQWad0eWn
        EGQegyE7p8JIrCrib7/LjbmD9Q==
X-Google-Smtp-Source: ABdhPJwIspzog1VUiBfY70nRImgloUCtHTT/BN1paaclHnpBfUxBpsJr4jZpnSNdlG+u2KnB5S4+Ug==
X-Received: by 2002:a17:902:aa0c:: with SMTP id be12mr58619318plb.45.1594355499772;
        Thu, 09 Jul 2020 21:31:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g30sm4540856pfq.189.2020.07.09.21.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 21:31:38 -0700 (PDT)
Date:   Thu, 9 Jul 2020 21:31:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Julius Hemanth Pitti <jpitti@cisco.com>, mingo@elte.hu,
        akpm@linux-foundation.org
Cc:     yzaikin@google.com, mcgrof@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, xe-linux-external@cisco.com,
        jannh@google.com
Subject: Re: [PATCH] proc/sysctl: make protected_* world readable
Message-ID: <202007092122.782EE053@keescook>
References: <20200709235115.56954-1-jpitti@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709235115.56954-1-jpitti@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 04:51:15PM -0700, Julius Hemanth Pitti wrote:
> protected_* files have 600 permissions which prevents
> non-superuser from reading them.
> 
> Container like "AWS greengrass" refuse to launch unless
> protected_hardlinks and protected_symlinks are set. When
> containers like these run with "userns-remap" or "--user"
> mapping container's root to non-superuser on host, they
> fail to run due to denied read access to these files.
> 
> As these protections are hardly a secret, and do not
> possess any security risk, making them world readable.
> 
> Though above greengrass usecase needs read access to
> only protected_hardlinks and protected_symlinks files,
> setting all other protected_* files to 644 to keep
> consistency.
> 
> Fixes: 800179c9b8a1 ("fs: add link restrictions")
> Signed-off-by: Julius Hemanth Pitti <jpitti@cisco.com>

Acked-by: Kees Cook <keescook@chromium.org>

I had originally proposed it as 0644, but Ingo asked that it have
a more conservative default value[1]. I figured that given the settings
can be discovered easily, it's not worth much. And if there are legit
cases where things are improved, I don't have a problem switching this
back.

Ingo, any thoughts on this now, 8 years later in the age of containers?
:)

(One devil's advocate question: as a workaround, you are able to just
change those files to 0644 after mounting /proc, yes? But regardless,
why get in people's way for no justifiable reason.)

-Kees

[1] https://lore.kernel.org/lkml/20120105091704.GB3249@elte.hu/

-- 
Kees Cook
