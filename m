Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C2BC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22521222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dcS6pegO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgBMSVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:21:13 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34706 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgBMSVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 13:21:13 -0500
Received: by mail-ed1-f66.google.com with SMTP id r18so8021792edl.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 10:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ckYAtFkLGTpqFasss2Yh3sgNnvC6X5fXw2I1Fp2BCnI=;
        b=dcS6pegO12bP6j8/IxZRcJacM50FbD1iRPyqN51QsgWQuddjlR5/CEHWNuIeE9aA3J
         m7T0l7tq2/Gcod87ssIr+J94iXOhbqETJnhWbz8UtLia+BEPXix4UP2NHFcQrNy0NNoO
         I9LF6zTMEL2mdpfCuweuZ08YKBckzPkf4JAFtJlnnAIDYYqB6touDFQccxfDXWXmVo8q
         RYejfAEVD1DrZcyUxTqTcmucp6CwA+iVZuOpyRGNDZL9MWbPi47AtWH2/Il6ez6JQNv3
         u3cMYgodLRvwzyGKKU17fkEX23SDPg/uYhyBUuk3wITZPNplSPlzZU3cf8y8PHJGgCvn
         0iDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ckYAtFkLGTpqFasss2Yh3sgNnvC6X5fXw2I1Fp2BCnI=;
        b=XLN7Zvg/brLcXIfN1vIqNatow1JwDPt7yFdXLwfdyN8tZu4bEGPZbQGmyxSVZxP3pz
         u/3gBb2w4bEpf6CkYqzg9Z4iMmRx7GvJheY5IrEFIzy4KshhWf/hLkczHU8d72PSL1s0
         PmZSvedmwNT2BuQzmO0mIYE5Khnm+VwW97DsNOZvpD3L8jsEjXsZ7yNZGhMgk1VEtb8E
         CnL8NPWOwugb0i4oUjZDa5xsM39aT25h9VCPPm/fPF6F5v0GBs94pLXRmtOEv75WvKnA
         OVORsHejHgqV3FpQmoc7OThMMWpqlK0MT/whqFQFfBtlfYJQFupkBtFH1D5IpljKjAwC
         I7Rg==
X-Gm-Message-State: APjAAAUgMj5/Ru0ij2ZC499MAIg7JkDe6501tSIeTIYtew4dxOUndqlJ
        Q8WRxymwFPTDYTcVOwSwpNBvwf7beyxG7/EgN1rfoA==
X-Google-Smtp-Source: APXvYqwiJPQ8Fg+Dw3qWjh34zdXDeJrcERoGTVCIyZvCpVoBcfFB4U15IkYT3Sgub2qcfUBd9eIRuKLQ1/iNvIecqKg=
X-Received: by 2002:a17:906:4e01:: with SMTP id z1mr17455077eju.46.1581618070828;
 Thu, 13 Feb 2020 10:21:10 -0800 (PST)
MIME-Version: 1.0
References: <20200207201856.46070-1-bgeffon@google.com> <20200210104520.cfs2oytkrf5ihd3m@box>
 <CADyq12wcwvRLwueucHFV2ErL67etOJdFGYQdqVFM2WAeOkMGQA@mail.gmail.com> <20200213120813.myanzyjmpyzixghf@box>
In-Reply-To: <20200213120813.myanzyjmpyzixghf@box>
From:   Brian Geffon <bgeffon@google.com>
Date:   Thu, 13 Feb 2020 10:20:44 -0800
Message-ID: <CADyq12wWOhGDeUeOB74dxuRKjPhduMWZLBMxOxpm5-yHOpjaRw@mail.gmail.com>
Subject: Re: [PATCH v4] mm: Add MREMAP_DONTUNMAP to mremap().
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,

> But if you do the operation for the VM_LOCKED vma, you'll have two locked
> VMA's now, right? Where do you account the old locked vma you left behind?

You bring up a good point. In a previous iteration of my patch I had
it clearing the locked flags on the old VMA as technically the locked
pages had migrated. I talked myself out of that but the more I think
about it we should probably do that. Something along the lines of:

+    if (vm_flags & VM_LOCKED) {
+      /* Locked pages would have migrated to the new VMA */
+      vma->vm_flags &= VM_LOCKED_CLEAR_MASK;
+      if (new_len > old_len)
+              mm->locked_vm += (new_len - old_len) >> PAGE_SHIFT;
+   }

I feel that this is correct. The only other possible option would be
to clear only the VM_LOCKED flag on the old vma leaving VM_LOCKONFAULT
to handle the MCL_ONFAULT mlocked situation, thoughts? Regardless I'll
have to mail a new patch because that part where I'm incrementing the
mm->locked_vm lost the check on VM_LOCKED during patch versions.

Thanks again for taking the time to review.

Brian
