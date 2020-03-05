Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8D5C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C382072D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="oCjzxHqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgCEUt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 15:49:27 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45992 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgCEUt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 15:49:27 -0500
Received: by mail-yw1-f67.google.com with SMTP id d206so34698ywa.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 12:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5zmgxN7VRZXC7kbix0t7HZalzUvTentTfjnGm/3hMTE=;
        b=oCjzxHqsExisvhlxj2vLbWI+LleP320DIA63HiMC3CvCVE+taSKApySOErK4ZOUpEt
         J9NEAZwHZEmWGlvwUQRcTkTuMMzGpWOQXnz4PiGwEe5CWdNMxavPFDWW2EAGixCQhviZ
         +I4OFEjaLBOeE10vj1L+uU8FohllLaMLab6RAz0XnnMv15zFailN4BfRGHiOaoAiaIYw
         8y7qzIaNpPZH88IK1Cp3LTrqck3d8e8y5MxZg3BI38HsHzkuz/kBeEblxNYQ8e5miY8W
         LR739rAjjIcqXS5O5Y8bv+USeISElSCSY4fbxmQTRCK7NaVpZZ18/K2gcxXqCO097Yi6
         pKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5zmgxN7VRZXC7kbix0t7HZalzUvTentTfjnGm/3hMTE=;
        b=dRwHRcN3IRrpoZP9QvaxtA7LyXF04ml8+HocI3NDNoRB2a+jE3s7tAzMiFDRDlUW5l
         u22wIjs89UolcRxtxIfYZ4qvlVpQ5XpC8gZYm+TsifDEYDAXFEFBJNC528b/Sff8hD0R
         tXmRJBCgx0hJM/9tUiu7wNmSxhcp7PDjvErP+QbPN2tPOc7YT0l1IYLGHhsAp8Ff6kRX
         7BY2KrELVl5IdCg3irwtOUpW1LHQY3HQcXH2KkPdutCnHekm9BxbFrQWt4RUHXVRmxVh
         tGdvhcD4t18BDCEfAAohaeRPXWryRp5RTXJgL5F8ExZpnEGS0OnlOK8XjGBkFAxywZBq
         YuIA==
X-Gm-Message-State: ANhLgQ3EwiW4Uzo1Y/9+ulIn9pX074Q/401gV1N68VUi2rKScY9ysys8
        SWxEEgEtlMSVoj/SNH6aw4qZUg==
X-Google-Smtp-Source: ADFU+vut5SaFR53pXBOtJjgao2EQ5xqKFPyU2dbqIJP6N0WO2apubN/ljUNmlK9XJyrF+68bzRL6FA==
X-Received: by 2002:a25:860d:: with SMTP id y13mr137357ybk.310.1583441366443;
        Thu, 05 Mar 2020 12:49:26 -0800 (PST)
Received: from cisco ([2607:fb90:17d4:133:1002:9a44:e2a2:4464])
        by smtp.gmail.com with ESMTPSA id s63sm12469943ywd.82.2020.03.05.12.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 12:49:25 -0800 (PST)
Date:   Thu, 5 Mar 2020 13:49:08 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>,
        kernel-hardening@lists.openwall.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86/mm/init_32: Stop printing the virtual memory
 layout
Message-ID: <20200305204908.GA6506@cisco>
References: <202003021039.257258E1B@keescook>
 <20200305150152.831697-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305150152.831697-1-nivedita@alum.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 10:01:52AM -0500, Arvind Sankar wrote:
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
