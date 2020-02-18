Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369D0C34036
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 10:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C77A22527
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 10:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="FzFE0W+U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgBRK3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 05:29:39 -0500
Received: from mail-lj1-f169.google.com ([209.85.208.169]:32835 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgBRK3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 05:29:39 -0500
Received: by mail-lj1-f169.google.com with SMTP id y6so22325172lji.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 02:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=s+I8pj7DDW7+MEIcYQaGsLXCKLqSSyhyC6U6vjGcY3Y=;
        b=FzFE0W+UiHz1mbo6S9YKAeko2ypDGCUCA9ezE4SgAQI+9W3ZOhB7sCDgtSRGsbtiwi
         WHZsz3Ox+UF79hDY/VMkWmHo8Ylh6afm7d6jEMM4QkPq8OxyIbGj8kaVffWRHnB9Z+gd
         bDwvsnrR7OxysvPw6GY+SYBGvFfHxfqSAfiYwoKx/bHuUYCBpPHjG/TBRUB4sKfDohAb
         ajJ6baDqYQgGGcVaKMuzuzxKAHyhP11EuHwX2aObJUIy7DDpX+zlSF72Sby7L3f7qQyo
         ypJmiBrIUWebmMoik0zRHK+cC4QiX6NBnxcTPdyBUAIpfG219xIdk/K0+0N/PnViW+8i
         hTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=s+I8pj7DDW7+MEIcYQaGsLXCKLqSSyhyC6U6vjGcY3Y=;
        b=dW6/8lLh0thY9l8Y7VGHWjdPbBTX2aEeT31B7sVhkPb6P0jpFfxJCLxt2Bs5tVFUAv
         ABBiprnNlinW1nVLieFRLvTYk61qvfojaCrIYt6lrbCOacwwutvuxtClM/bAO3mIfEuy
         bmlhQlQjoFQ6bMnCaG+tdqyi2aAHbSGTclbIv6miz0JImbvuTnVgwwV3afS1iu1UEfc/
         kY456SqXSClie3jkmaDKUx9Kaw62s5OXnM/tNfxL+zRk/A7AjNBx39su3bddyqIsVjJn
         MvlSovwKUoyM6ewl4fc3RCCbrboUW3Eq/IPvxqC7x03DwR1stVyWTXIbW2jDf/WtK7Gd
         BaCg==
X-Gm-Message-State: APjAAAWyqYFXUYFL0AkSbDKIWQll7ywfLUkim7EKzLN/wKV+oeXQROlk
        vlEMtlJGyXqLY2VFCDo1Rh+WQw==
X-Google-Smtp-Source: APXvYqx7w7kDrGAiOADdb7ykxRBSJpPOsXY00e27KzXbWnE6fz0tXD7YeabOs3OfrMDVtrtRpo9D/Q==
X-Received: by 2002:a2e:a551:: with SMTP id e17mr12742787ljn.86.1582021777270;
        Tue, 18 Feb 2020 02:29:37 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a10sm1922743lfr.94.2020.02.18.02.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 02:29:36 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 1C99A100F9D; Tue, 18 Feb 2020 13:30:02 +0300 (+03)
Date:   Tue, 18 Feb 2020 13:30:02 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>, elver@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org,
        syzbot+c034966b0b02f94f7f34@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH -next] fork: annotate a data race in vm_area_dup()
Message-ID: <20200218103002.6rtjreyqjepo3yxe@box>
References: <20200217223138.doaph66iwprbwhw5@box>
 <EAD6E54D-8A57-4494-94F2-2EEEC3265560@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EAD6E54D-8A57-4494-94F2-2EEEC3265560@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 10:59:47PM -0500, Qian Cai wrote:
> 
> 
> > On Feb 17, 2020, at 5:31 PM, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > 
> > I'm confused. AFAICS both sides hold mmap_sem on write:
> > 
> > - vm_mmap_pgoff() takes mmap_sem for the write on the write side
> > 
> > - do_mprotect_pkey() takes mmap_sem for the write on the read side
> > 
> > 
> > What do I miss?
> 
> Ah, good catch. I missed the locking for the read there. This is interesting because Marco
> did confirmed that the concurrency could happen,
> 
> https://lore.kernel.org/lkml/20191025173511.181416-1-elver@google.com/
> 
> If that means KCSAN is not at fault, then I could think of two things,
> 
> 1) someone downgrades the lock.
> 
> I don’t think that a case here. Only __do_munmap() will do that but I did not see how
> it will affect us here.
> 
> 2) the reader and writer are two different processes.
> 
> So, they held a different mmap_sem, but I can’t see how could two processes shared
> the same vm_area_struct. Also, file->f_mapping->i_mmap was also stored in the
> writer, but I can’t see how it was also loaded in the reader.
> 
> Any ideas?

I think I've got this:

vm_area_dup() blindly copies all fields of orignal VMA to the new one.
This includes coping vm_area_struct::shared.rb which is normally protected
by i_mmap_lock. But this is fine because the read value will be
overwritten on the following __vma_link_file() under proper protectection.

So the fix is correct, but justificaiton is lacking.

Also, I would like to more fine-grained annotation: marking with
data_race() 200 bytes copy may hide other issues.

-- 
 Kirill A. Shutemov
