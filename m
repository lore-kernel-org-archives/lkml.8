Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5E5C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E3D20870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="ulRcbiJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgCEUum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 15:50:42 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38505 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgCEUum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 15:50:42 -0500
Received: by mail-yw1-f65.google.com with SMTP id 10so82473ywv.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 12:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZN2bKPbKeIRtrM9iIgiOAYxD5vcZHWo0jv5xrjPRAk0=;
        b=ulRcbiJE8IyxHOYf0toI7GVOJUnzYm1nE08URECAHtMkc7tW2VwDS/KoP8Cp18LA9g
         WIWEmqqihik7TT2J6KG/KWusnIMnKOwBj7PvzuDBl7C8BiCAKyO9TgA259u1JZg7Q9BI
         KPSWVsP98pe/fehSp3HH5r543p7r+AYzcuS3G3tzMa8BAk8/QWvg3rLv8iX4x/9cGBVh
         zkr7/LrGLKEW1wwDndGzRCIY/Vn/vgUXLlYxa/Mru2MoKEOILj417aBEf7GiAVhkvzcQ
         ZmjnKsBLN0hKCAkF4RzJyh4Du0apmJ4JHK4wWErt8fB2R+Yh4I0s8LmkaXjc7UYn0/Zy
         Yzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZN2bKPbKeIRtrM9iIgiOAYxD5vcZHWo0jv5xrjPRAk0=;
        b=cbyDjhPiR5jSoE1rOVYFaAYtql2svoob1R0mB4k+mIonlCtWtdm3fZ/BS7gTvxPIe8
         y59xnPShgNU9IR5sPMi1VQayaGM9WvgdYGJfJMiu0N4vojmpnuHaFsURJAh1gIVrzJ6v
         Q7CeiC8dgOVkOLh7Hx/8m4qBs495fPIioHtYSEYmYhursBAzuv2hXVfgUt/vJH292DKD
         cSWEEKisJQ2hqmQrWOYc0mhnuJIJj17gbQkODXq1tW2pHlZK/fIrsOWrOOonxvGBBBCC
         BMkOAwszDpaeEAy2kX/108W35BYknoP3nlWcYzT60n4EkrMx1aQrFYpMq4QEFKYuv6Ii
         1ubg==
X-Gm-Message-State: ANhLgQ07tDYB6k1VWuXgI6FsB6LcWMdCGajohRUaxYfO9fOEttu8ZWdc
        +9JYLhVPIVmg4Z/WlHc80evvXQ==
X-Google-Smtp-Source: ADFU+vuf8b03n0ektuyVOOaTbgELLufIJbGO8TesTTpByeRD4Pmk6NbMDojOYTn39X9+RHrcH3RU+g==
X-Received: by 2002:a0d:e7c6:: with SMTP id q189mr296834ywe.329.1583441441200;
        Thu, 05 Mar 2020 12:50:41 -0800 (PST)
Received: from cisco ([2607:fb90:17d4:133:1002:9a44:e2a2:4464])
        by smtp.gmail.com with ESMTPSA id h139sm12575001ywa.35.2020.03.05.12.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 12:50:40 -0800 (PST)
Date:   Thu, 5 Mar 2020 13:50:34 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>,
        kernel-hardening@lists.openwall.com,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nds32/mm: Stop printing the virtual memory layout
Message-ID: <20200305205034.GC6506@cisco>
References: <202003021038.8F0369D907@keescook>
 <20200305150639.834129-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305150639.834129-1-nivedita@alum.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 10:06:39AM -0500, Arvind Sankar wrote:
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
