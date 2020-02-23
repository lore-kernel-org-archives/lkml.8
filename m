Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70450C35670
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 23:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39AF720880
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 23:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggVP7Lgw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgBWXaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 18:30:17 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41552 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbgBWXaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 18:30:16 -0500
Received: by mail-pf1-f195.google.com with SMTP id j9so4368460pfa.8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 15:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BHvuL1JKTAOYifV/CjMNtfxfmXNZrw8/BIhfR9Y1A9A=;
        b=ggVP7LgwmoN8STUuj3mWba1bX30zmHY8CmaaZqN2n8hkUiwVxT2D236tdCePXHrakm
         NWqrvN0EDjd0EWtssVj7Q4gBFU/Kw+hsM8BYTpC4HPrfm7jo0koB5Hn9ba9AIBWpbVsa
         TMGDevIFAV7aMSY7npz2JijEoOxrC0EB30XKK37QyJMdRKLenkQcfvQFnh9dJvMgPN+m
         tVhDBNkq80xeU8slJPd6VOtdBnWMXHQAThm+FTb3uAFXn/49OIjnM8molXwhHBuM4rtx
         BB0GJgitUHg7+D9005tqrB6LQq6oKEwaQQQkQXhqJ+/f6y6Gzefkjw9n9Z4D454X9bDv
         +XOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BHvuL1JKTAOYifV/CjMNtfxfmXNZrw8/BIhfR9Y1A9A=;
        b=iCOmSLsb3k6FKLzcQxCkOXcVaktreHXlCuMbD6hSsQu0ChDx8Wf4hjvynA5F6RWUVZ
         ehkOnTHv3BWnjSlrFM+ZKO/txfwAD5IfBHoyc0sYAPn5UllhwlHJkHTeMrffwCWhWwLG
         6UJDdPoaC/hz879pMAZYDtdeRt0H7qM9FaaiEKArdoNIbjsYA7FyoF3mCVyguoKJh0Qn
         ug4QNTWVv/j9ZM8tkql9Ik0shIVUmADf8hEp7HLGrEm6mT3RpqjNct0O2Mx8VPapED9m
         GC7GuRZwLmLvdSt1T4iuNQvGuEkJtggTh03Kc7sLDhDzKoISD6BGyqLEyHZ7DiBief3k
         A/7A==
X-Gm-Message-State: APjAAAX298xHrwyTPtfOu0M6vzcVgYpQHbDZ93BsiHzo9HilJR9rrcKp
        PIkdIj2yDwhSrow4TpWEak4=
X-Google-Smtp-Source: APXvYqwkvpjyGn5lU3qH+jbJ8b//vzZVj3gZxwDU6iE+AEDPoIzSjbWJzvdR3JYo8IjRWKxmWZPH6Q==
X-Received: by 2002:a63:cb52:: with SMTP id m18mr12736278pgi.291.1582500615701;
        Sun, 23 Feb 2020 15:30:15 -0800 (PST)
Received: from gmail.com ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id c19sm10303501pfc.144.2020.02.23.15.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 15:30:14 -0800 (PST)
Date:   Sun, 23 Feb 2020 15:30:13 -0800
From:   Andrei Vagin <avagin@gmail.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH 5/5] arm64/vdso: Restrict splitting VVAR VMA
Message-ID: <20200223233013.GB349924@gmail.com>
References: <20200204175913.74901-1-avagin@gmail.com>
 <20200204175913.74901-6-avagin@gmail.com>
 <df8fa53c-5c21-b620-0254-ffefdd3a8834@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <df8fa53c-5c21-b620-0254-ffefdd3a8834@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 12:22:52PM +0000, Vincenzo Frascino wrote:
> Hi Andrei,
> 
> On 04/02/2020 17:59, Andrei Vagin wrote:
> > Forbid splitting VVAR VMA resulting in a stricter ABI and reducing the
> > amount of corner-cases to consider while working further on VDSO time
> > namespace support.
> > 
> > As the offset from timens to VVAR page is computed compile-time, the pages
> > in VVAR should stay together and not being partically mremap()'ed.
> > 
> 
> I agree on the concept, but why do we need to redefine mremap?
> special_mapping_mremap() (mm/mmap.c +3317) seems doing already the same thing if
> we leave mremap == NULL as is.
> 

Hmmm. I have read the code of special_mapping_mremap() and I don't see where
it restricts splitting the vvar mapping.

Here is the code what I see in the source:

static int special_mapping_mremap(struct vm_area_struct *new_vma)
{
        struct vm_special_mapping *sm = new_vma->vm_private_data;

        if (WARN_ON_ONCE(current->mm != new_vma->vm_mm))
                return -EFAULT;

        if (sm->mremap)
                return sm->mremap(sm, new_vma);

        return 0;
}

And I have checked that without this patch, I can remap only one page of
the vvar mapping.

Thanks,
Andrei

