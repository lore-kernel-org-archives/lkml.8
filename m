Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F25DC3B18F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 00:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A64217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 00:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="PacGcFWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgBNAgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 19:36:21 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36538 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgBNAgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 19:36:21 -0500
Received: by mail-lf1-f66.google.com with SMTP id f24so5585304lfh.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 16:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4f0EZeoJlExzljE8pJVUxkTCYd/feIyLQps13jN8CxI=;
        b=PacGcFWD/+hjRVHJiK+ORMA3HMJLTlsaB+Wjr9TLvq+iI0kdJnr0AbgEl5LQCXI/dw
         u9AoIP+FTxfxUXlA9Ps6lORc63DbyQgtlHqzF8v7joJKPBftimDS51TTAwiC6vIznm/0
         oj1OBSd7sy4hEj+laIQEi6a29v5EbGZeacU7LrVOLyKscRyh8yKZarFWURNE/QpdxCNr
         nS6TAzXb5s9c4qXfgbfwka7AcihAZNSnsk4769Lij4sI/EPBL0iLtHUaT9LALPJXTIpS
         YBaGeA5YE3FxbqV/Yh7UmizHXUqeQcRE4l7+8MuaK+AeWHDHey6vx6GeeOE1ZuIPluZ6
         SDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4f0EZeoJlExzljE8pJVUxkTCYd/feIyLQps13jN8CxI=;
        b=YW82tzczcdW61/wq62IUGIXOGPqE6AxO4aglOtcFbfHOJqIkHe6cvUMOpSVh0HD7em
         ieH9pmiDdi+RzW0CJ2PFwa9EIOUvi3cV8XauLlfBzCWsNLtAZyxuCH/G3prntvi3XvkB
         bd/R2s9vQRYZBX9CKE915LRijO4zE7l4DqQSHIzCFFphJDsoR1sBvlW5ZeQTItBgqwhM
         CyiA7l8MTdwzTRY7QdvabxzPJN//mbzGL5FIhGiMQyWSODaZyXR1/f6Gpal9aUIeq8Fg
         +omryNscLL7tqq/BL3d1+O2pK/zbQdI2bmTkKLnHN5R3L2PrUOoVi1mPn0Xqdh6uC7fK
         HBJA==
X-Gm-Message-State: APjAAAVIxTbZpVm1Qw1i/oASydVWoCRaJaKF/PqS4f6Y1UEj9+ztnJ/R
        AUz1GeQCK/bcOsOKtT6bG8+YYw==
X-Google-Smtp-Source: APXvYqyX50RxYmxQWDCQJ4bRjVQ1dfugN3SgCgtgCIto9MmZHtlmWbmJtslnfFe7WjbYmJjlQeJHhQ==
X-Received: by 2002:ac2:4833:: with SMTP id 19mr261332lft.211.1581640578725;
        Thu, 13 Feb 2020 16:36:18 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y2sm2437542ljm.28.2020.02.13.16.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 16:36:17 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 1512C100F2C; Fri, 14 Feb 2020 03:36:40 +0300 (+03)
Date:   Fri, 14 Feb 2020 03:36:40 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH v4] mm: Add MREMAP_DONTUNMAP to mremap().
Message-ID: <20200214003640.yphbnjw7omsx2rje@box>
References: <20200207201856.46070-1-bgeffon@google.com>
 <20200210104520.cfs2oytkrf5ihd3m@box>
 <CADyq12wcwvRLwueucHFV2ErL67etOJdFGYQdqVFM2WAeOkMGQA@mail.gmail.com>
 <20200213120813.myanzyjmpyzixghf@box>
 <CADyq12wWOhGDeUeOB74dxuRKjPhduMWZLBMxOxpm5-yHOpjaRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyq12wWOhGDeUeOB74dxuRKjPhduMWZLBMxOxpm5-yHOpjaRw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 10:20:44AM -0800, Brian Geffon wrote:
> Hi Kirill,
> 
> > But if you do the operation for the VM_LOCKED vma, you'll have two locked
> > VMA's now, right? Where do you account the old locked vma you left behind?
> 
> You bring up a good point. In a previous iteration of my patch I had
> it clearing the locked flags on the old VMA as technically the locked
> pages had migrated. I talked myself out of that but the more I think
> about it we should probably do that. Something along the lines of:
> 
> +    if (vm_flags & VM_LOCKED) {
> +      /* Locked pages would have migrated to the new VMA */
> +      vma->vm_flags &= VM_LOCKED_CLEAR_MASK;
> +      if (new_len > old_len)
> +              mm->locked_vm += (new_len - old_len) >> PAGE_SHIFT;
> +   }
> 
> I feel that this is correct. The only other possible option would be
> to clear only the VM_LOCKED flag on the old vma leaving VM_LOCKONFAULT
> to handle the MCL_ONFAULT mlocked situation, thoughts? Regardless I'll
> have to mail a new patch because that part where I'm incrementing the
> mm->locked_vm lost the check on VM_LOCKED during patch versions.

Note, that we account mlock limit on per-VMA basis, not per page. Even for
VM_LOCKONFAULT.

> Thanks again for taking the time to review.

I believe the right approach is to strip VM_LOCKED[ONFAULT] from the vma
you left behind. Or the new vma. It is a policy decision.

JFYI, we do not inherit VM_LOCKED on fork(), so it's common practice to
strip VM_LOCKED on vma duplication.

Other option is to leave VM_LOCKED on both VMAs and fail the operation if
we are over the limit. But we need to have a good reason to take this
path. It makes the interface less flexible.

-- 
 Kirill A. Shutemov
