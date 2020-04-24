Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA0BC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 19:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EFCE20857
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 19:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nV1EfN6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgDXTSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 15:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726793AbgDXTSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 15:18:40 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D34C09B048
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 12:18:40 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x15so5260918pfa.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 12:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jTXhU16A9f20mBuu55i1N5tKQ/YnXN5h5AIwPuslRMg=;
        b=nV1EfN6ZmE2x8RvvWY6vrJ3lW2X3dXiVzH8qROTf2wPgUd/QtmamqGhGr0UDOcbmjI
         +6rLop62QemOx9h8egpv950FpzBITun6MisOH3EnHptSlUTXV8l59wxW9EDaLA3IQBHe
         Lfge11AvQhw2vky8hRnIBXJ/9pswd8FTq3AKd+d2bPDmn1cyteXS/VwAvnSTKrthJPu4
         CRJW44nNuiemqwDbtBeTTkafXsGi/LtlLz4WGOwpeJmZeh8DBV2ZhaB2mVmTVMN3wL8S
         j2gAKGdjA89XX0JmDY+xzSjUgQKr4wEYZOIPtZ29eQaQLhToiU433biI3ilAFczq9lel
         jptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jTXhU16A9f20mBuu55i1N5tKQ/YnXN5h5AIwPuslRMg=;
        b=pTCYv4YZ3vcJZ5PmzebWp5ml4IZ7SMVDXEMSNt0eRE4DPhMbaqA/fHp6Tk5ycZG9Y/
         ocP75r9xpcyKGJyVeXVMub9VKfgGmWCJcMjazBX0QdYw2nmFyVce0LC87YxuBDx8/YWu
         JA+XNoBqWpCG6/XdV+ZKAShAXFG/qqOf7LDJHTRcLTodYFaB9u6CveWKCxNOHfrwtaBb
         oeKv7BTzyFOiqFiMKjyQMGQeHeePs4+dNivB/NyRsGLxb1vylsRXZJh4oS7QPxR6q5Fl
         25VTzjBRXg9Qo0axqxgKVErwhWGXNYXY9lRj2VTVk+a1ICFirLBYtWsV4LKqgQjAFuTi
         EsTw==
X-Gm-Message-State: AGi0PuaFdWQW2iOmBQyZjBUiYcfgOqN6IglDs5D2C0zRqIT0FPVIyRge
        bJClxsvuQB60UlPAbbrxtzdMLA==
X-Google-Smtp-Source: APiQypL3GF0IA3FPXvIB4BaH+YXLYmcQEL8UKsod6EOYXpS5VubITIDtjbXPSf2q4ZxlOxgWjuFXeQ==
X-Received: by 2002:a63:5724:: with SMTP id l36mr818367pgb.317.1587755919194;
        Fri, 24 Apr 2020 12:18:39 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:ce90:ab18:83b0:619])
        by smtp.gmail.com with ESMTPSA id h6sm5306704pje.37.2020.04.24.12.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 12:18:38 -0700 (PDT)
Date:   Fri, 24 Apr 2020 12:18:32 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Matt Helsley <mhelsley@vmware.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] recordmcount: support >64k sections
Message-ID: <20200424191832.GA231432@google.com>
References: <20200422232417.72162-1-samitolvanen@google.com>
 <20200423214734.GB9040@rlwimi.vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423214734.GB9040@rlwimi.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

On Thu, Apr 23, 2020 at 02:47:34PM -0700, Matt Helsley wrote:
> > +static unsigned int get_shnum(Elf_Ehdr const *ehdr, Elf_Shdr const *shdr0)
> 
> I noticed this returns an unsigned int ...
> 
> > +	Elf_Shdr *const shdr0 = (Elf_Shdr *)(old_shoff + (void *)ehdr);
> > +	unsigned const old_shnum = get_shnum(ehdr, shdr0);
> 
> While this is not explicitly called out as an unsigned int. Perhaps we
> could just make this and new_shnum explicit unsigned ints and then...

> > +	if (!ehdr->e_shnum || new_shnum >= SHN_LORESERVE) {
> > +		ehdr->e_shnum = 0;
> > +		shdr0->sh_size = w(new_shnum);
> > +	} else
> > +		ehdr->e_shnum = w2(2 + w2(ehdr->e_shnum));
> 
> If we make the unsigned int change proposed above can we reuse new_shnum
> here like so:
> 		ehdr->e_shnum = w2(new_shnum);
> 
> So this if/else is doing the inverse of get_shnum(). I think the code
> could be cleaned up a little and prepare for moving to objtool by
> putting it in a helper function.

Sure, sounds good to me.

> > +	for (relhdr = shdr0, k = nhdr; k; --k, ++relhdr) {
> > +		if (relhdr->sh_type == SHT_SYMTAB)
> > +			symtab = (void *)ehdr + relhdr->sh_offset;
> > +		else if (relhdr->sh_type == SHT_SYMTAB_SHNDX)
> > +			symtab_shndx = (void *)ehdr + relhdr->sh_offset;
> > +
> > +		if (symtab && symtab_shndx)
> > +			break;
> > +	}
> 
> Could you break this out into a helper function? find_symtab() maybe? Again, I think
> that helper would go away with conversion to objtool.

Agreed, this wouldn't be needed with libelf. I'll send v2 shortly.
Thanks for the review!

Sami
