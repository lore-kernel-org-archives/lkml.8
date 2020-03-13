Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F633C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 00:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8B1206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 00:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JiEN0kcC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgCMAGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 20:06:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37316 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbgCMAGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 20:06:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id a32so3039243pga.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 17:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MT56InialoA5Gvuu17QFzhKM9mlaqKUsiERx8J8mK8A=;
        b=JiEN0kcC+FSY9JxDVE0c/Nf+raSXxIfGzQiQhnnpAW2AxKWxl8VwuQzkSN6DGlyY/D
         eDRiciH0xugCpu0Hh94n501CXjCftR1SK/fbXY07Qli4f+xGd0C7FqiyWqvh4IrwhRRq
         BU1O23uhLzOqB6dxjuJhz6ZTZ5UjPI4f54crU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MT56InialoA5Gvuu17QFzhKM9mlaqKUsiERx8J8mK8A=;
        b=NuJbNxBAJn7l8y+SpRTFLRFmAnLOIBUMJQmQ2bLK5CmtEfVtEidQN/UqFbJ0aoDnYn
         FHsoJJ5LZZGJFIOs6zxp14ByahJfOcj6dZgQpLjV+kf/s9i5/4yNJRaqHvL6WjetE7lN
         Hewpu9eHvoVgHzerI3La/eV5oB3v/AkxVZbUdBSsh1r3uAa2rhmmM032f0YmZI8OxCQe
         WZNCo0Fo/87FE6HIK2erpu6hbcbZ/6T7SBJkR3QhXlgZc5qKr3WDgqi2Y/zvpxuDQsDt
         +UM0hUOoonnldRrdfp2u4EeVGGIvpsoOkDPh33RrQYvShdxwNHyf2FieSnIlhneL8crg
         Hdhw==
X-Gm-Message-State: ANhLgQ3Bik9c9asqa8pPwrLOkUGfZZn7e9dK+h8klqA7fd40s+WMDYel
        HXC83MA+hk94WmqPvcHxCFtr1uVlL34=
X-Google-Smtp-Source: ADFU+vufqVAMrmsyN2FQR+i0rIhNKJocLKys2LdKmIIuznP6bLJC6/QtdecJYAQsRGo5+9W0tYLH9Q==
X-Received: by 2002:aa7:8217:: with SMTP id k23mr10886894pfi.257.1584057963010;
        Thu, 12 Mar 2020 17:06:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g18sm56595595pfi.80.2020.03.12.17.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 17:06:02 -0700 (PDT)
Date:   Thu, 12 Mar 2020 17:06:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, Jann Horn <jannh@google.com>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] x86/elf: Add table to document READ_IMPLIES_EXEC
Message-ID: <202003121705.6ABA79D8F0@keescook>
References: <20200225051307.6401-1-keescook@chromium.org>
 <20200225051307.6401-2-keescook@chromium.org>
 <20200311194446.GL3470@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200311194446.GL3470@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 08:44:46PM +0100, Borislav Petkov wrote:
> Ozenn Mon, Feb 24, 2020 at 09:13:02PM -0800, Kees Cook wrote:
> > Add a table to document the current behavior of READ_IMPLIES_EXEC in
> > preparation for changing the behavior.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
> > ---
> >  arch/x86/include/asm/elf.h | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
> > index 69c0f892e310..733f69c2b053 100644
> > --- a/arch/x86/include/asm/elf.h
> > +++ b/arch/x86/include/asm/elf.h
> > @@ -281,6 +281,25 @@ extern u32 elf_hwcap2;
> >  /*
> >   * An executable for which elf_read_implies_exec() returns TRUE will
> >   * have the READ_IMPLIES_EXEC personality flag set automatically.
> > + *
> > + * The decision process for determining the results are:
> > + *
> > + *              CPU: | lacks NX*  | has NX, ia32     | has NX, x86_64 |
> > + * ELF:              |            |                  |                |
> > + * -------------------------------|------------------|----------------|
> > + * missing GNU_STACK | exec-all   | exec-all         | exec-all       |
> > + * GNU_STACK == RWX  | exec-all   | exec-all         | exec-all       |
> > + * GNU_STACK == RW   | exec-none  | exec-none        | exec-none      |
> 
> In all those tables, you wanna do:
> 
> s/GNU_STACK/PT_GNU_STACK/g
> 
> so that it is clear what this define is.

Fair enough. :) I think I was trying to save 3 characters from earlier
tables that were wider. I'll send a v5.

Thanks!

-Kees

-- 
Kees Cook
