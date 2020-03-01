Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F32C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 00:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D1B24649
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 00:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u+6DgU7O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgCAAL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 19:11:27 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:33963 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgCAAL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 19:11:26 -0500
Received: by mail-qv1-f68.google.com with SMTP id o18so3197034qvf.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 16:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3tYKB2ToaIQnbC0ndiITx7BdT8yRg6GYHGZIM+yZOF4=;
        b=u+6DgU7OlIQLBQ3P8XYjTUI6xh9cKsGzL8N4Zljr++uSy4c/i6KZ+HoT5qHXZOJpiS
         uWvmH2TmNZys7qVxxye6WO0c666s/+5LwCinkCvn/gwWU+tOgHvb4bDFougbqNmSVElQ
         ckqsExJwfHcmWIpGFJZh8n4SeF/UrJ+r6q6lWXcMeA51jUNdzsRmFKOa+Atirmy5KHI6
         eLfnIV6Eegsj5UWiT2p/97M4LhDVje59uKLAnacnZTS473o1YrgZpulzRyc3WkfC4ZfC
         mR0hiWhj3eKtZQpXBIvv982zKW/rWkli4iZO8s68EHZE08d5oqLY6/DZYYns4e6ECp0U
         Kidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3tYKB2ToaIQnbC0ndiITx7BdT8yRg6GYHGZIM+yZOF4=;
        b=ucLFZiwDEvKe8/CPM+o9D+Cs2mpRuIHNJrRTJQvzTFZ5hMiMIkaIQAkHcWDq7RIz+H
         SDgidSJ3o3mRKbKvp/ZraUWp6aVbc29yJGiNUjXaLxEScO8IfQWql7ApXFvGkiBjA2ns
         d/p3SEBBmaRxhOoFHdFV2Rl/I3qn5x6pfWXTJIpwz1NN31wVflqAgVikP+OOYU0zrNVI
         tOpOjE86UTh1qHtIJUyxRYl7MizsWvJdtKTjz5rOUd81ihGrpdHmDWp6FqBDlNcoZUAy
         AWR8++B4yrdk+nEvxcqg0kFXQjACfL3RXNYfgn9gi3qlgBt/LHu3FANiUJVEikLiZkWk
         IaEw==
X-Gm-Message-State: APjAAAWTgHehQGM8ZWsIKXmbw1pMsK/x/7S9LiRFGzM+hCVJo0rLh2Mr
        LajVFnahzLTpbEVJcvcviv8=
X-Google-Smtp-Source: APXvYqwT6diWdvuhxX543aTn35qI2BUo2FL7gUorP9jX0s3qLtx4AN7mcQ/mmPtoxnEX48v3pq7tMw==
X-Received: by 2002:a0c:b203:: with SMTP id x3mr9403820qvd.197.1583021485669;
        Sat, 29 Feb 2020 16:11:25 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d74sm7636037qke.91.2020.02.29.16.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Feb 2020 16:11:25 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 29 Feb 2020 19:11:23 -0500
To:     Kees Cook <keescook@chromium.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, dave.hansen@linux.intel.com,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, me@tobin.cc, peterz@infradead.org, tycho@tycho.ws,
        x86@kernel.org
Subject: Re: [PATCH] x86/mm/init_32: Don't print out kernel memory layout if
 KASLR
Message-ID: <20200301001123.GA1278373@rani.riverdale.lan>
References: <20200226215039.2842351-1-nivedita@alum.mit.edu>
 <202002291534.ED372CC@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202002291534.ED372CC@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 29, 2020 at 03:51:45PM -0800, Kees Cook wrote:
> Arvind Sankar said:
> > For security, only show the virtual kernel memory layout if KASLR is
> > disabled.
> 
> These have been entirely removed on other architectures, so let's
> just do the same for ia32 and remove it unconditionally.
> 
> 071929dbdd86 ("arm64: Stop printing the virtual memory layout")
> 1c31d4e96b8c ("ARM: 8820/1: mm: Stop printing the virtual memory layout")
> 31833332f798 ("m68k/mm: Stop printing the virtual memory layout")
> fd8d0ca25631 ("parisc: Hide virtual kernel memory layout")
> adb1fe9ae2ee ("mm/page_alloc: Remove kernel address exposure in free_reserved_area()")
> 
> -Kees
> 
> -- 
> Kees Cook

microblaze (arch/microblaze/mm/init.c) and PPC32 (arch/powerpc/mm/mem.c)
appear to still print it out. I can't test those, but will resubmit
x86-32 with it removed.
