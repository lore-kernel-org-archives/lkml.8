Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F543C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F543208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="KDxK8K+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgCEUu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 15:50:27 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:33522 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgCEUu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 15:50:26 -0500
Received: by mail-yw1-f65.google.com with SMTP id j186so113986ywe.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 12:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w+OmpmqF00gA9FGrIOBgOQ4xJK5bBYcQsPPrukOSwVQ=;
        b=KDxK8K+kqZFSM1Ls+1Z0akgc9T4awAnlofZt4GX5sz88Iuz0zEEUi1WzniegxDnLj+
         IS1GPjWA/SAvmrYB8Nzmg3XSYo/yEzalY6+n+VCP8HTtmEQIevxUDAi851sC5TQqgJfI
         S7DFe4x2GzhL3UBSpzu4EFnnaxIxFW8gDyUjp3ZYRHDX2RaLBEyoXyN+PPYV7M22mfb6
         BJ9UUM0kLxwlvuBiIIqKEgfVeYKfGwXuplT0NZbjKSdvh4/zyRawcJHG5LzVeNsKSu4E
         vcWE/Y3R23XFhVkIgze/8lxDatDTgcbiNAhzYdO4NVDiqhHzwDD7EgX/rU+kcZzmn0UB
         UtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w+OmpmqF00gA9FGrIOBgOQ4xJK5bBYcQsPPrukOSwVQ=;
        b=tXZL/wPK7IHpa8AYrQhmAk8lhy7XZbxSykEJjsZta2y8NunbRiU5i8BSPOWUGMPj7t
         GL+FzOw+jKRKYcmw4ftcCj2LHnQle5gG8oJ583lys4lM0HVyxRGzb+teIIcD90w49eNe
         QfmGg0Y//zx+/PO9KpT201VfnDhkYlv7X47T/6rJlSi/il28ucy5kn3Xo24lre4be1Do
         PuYzOULu8uvr4UZJr9m8L3rl5j0E6D/U0yc1aKaJSz5xYoiJoeybQc9h6dE5Cf1L26SX
         ioyVNt9YBICa5ezxf1ErNQ6REHtxfZPdTffpTSOSQVgA0HA3ozzgz3i0GC/A9AHa2H+R
         pppQ==
X-Gm-Message-State: ANhLgQ3ozjrDp88LNWwFwm6hnWrlc/YqxXtJa9Iq7oaFGYKgVHWQAW3q
        Qk6E+LOulvVEKstfCrqNXkM2VEs8/Fg=
X-Google-Smtp-Source: ADFU+vvTM/Al7Umv0rKSgmlF123yGh/rmK8r19ETS904XycHgtDzdV5FSkZzB8KqPw0qqLne1Lpu4A==
X-Received: by 2002:a25:664a:: with SMTP id z10mr89446ybm.461.1583441425906;
        Thu, 05 Mar 2020 12:50:25 -0800 (PST)
Received: from cisco ([2607:fb90:17d4:133:1002:9a44:e2a2:4464])
        by smtp.gmail.com with ESMTPSA id g70sm5261657ywh.53.2020.03.05.12.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 12:50:25 -0800 (PST)
Date:   Thu, 5 Mar 2020 13:50:19 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>,
        kernel-hardening@lists.openwall.com,
        Michal Simek <monstr@monstr.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] microblaze: Stop printing the virtual memory layout
Message-ID: <20200305205019.GB6506@cisco>
References: <202003021038.8F0369D907@keescook>
 <20200305150503.833172-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305150503.833172-1-nivedita@alum.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 10:05:03AM -0500, Arvind Sankar wrote:
> For security, don't display the kernel's virtual memory layout.
> 
> Kees Cook points out:
> "These have been entirely removed on other architectures, so let's
> just do the same for ia32 and remove it unconditionally."
> 
> 071929dbdd86 ("arm64: Stop printing the virtual memory layout")
> 1c31d4e96b8c ("ARM: 8820/1: mm: Stop printing the virtual memory layout")
> 31833332f798 ("m68k/mm: Stop printing the virtual memory layout")
> fd8d0ca25631 ("parisc: Hide virtual kernel memory layout")
> adb1fe9ae2ee ("mm/page_alloc: Remove kernel address exposure in free_reserved_area()")
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Acked-by: Tycho Andersen <tycho@tycho.ws>
