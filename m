Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240D4C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED9052070E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A3RvqCgs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgGPGiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 02:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgGPGiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 02:38:06 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98734C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 23:38:05 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id r19so5795146ljn.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 23:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YaSPUbyvBCVCojGQeoPnqHkyJKZ1ja3Lr18Jje7cOqY=;
        b=A3RvqCgsImn89jAmBAQl0jPkTGXm/qIASiHFdjKuJcvSnzMb7UwKbZPXvRK8ksXBe6
         AHM3R3SiVqGkpawVE4KKXz+kX/RL1W75jq5DZGoysquqtbt3bsvgKrY54HJvqviQXjV5
         95JOjbz1I3BJyEoOE6XyT+UNMnAc2JGrLyIas6TJSznkXgEKBN627ynk8DSDD9SyT5M+
         Awoz1UQbqFptDo7wkZLfH75lSZ/79SNBBDb7ypq/refpjHrGwRZPtIoykmUtTKCDtL8C
         jEG7Lxu8jjhTeoquReZoxynfD7eOy0CkSmENMNHGZFx2/K+VEI/UecbAMaxbzifkYBzm
         i7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YaSPUbyvBCVCojGQeoPnqHkyJKZ1ja3Lr18Jje7cOqY=;
        b=ID1IjhOh3Y49fjD2awcKPU7/1DGi4Aa+hWEvmdT6ArxDxWzYHhL64ZhMjWSIuloFY7
         Hq1kH7NhSe4nzcHIigk8J9fMI/C8okib7lP68hl/v7niY6ViM4ETZzLw4AcaRjTxrFLn
         +X1dO4hv4s/Aj6nX/mc5DeLI3MhVp4avSNr/KSXWAZpCW16/vK5wTormiQUCOSYX350f
         aQ1PWtQIyPZcR9QH2FbncRNOyah4DUxWy8Mp5HHHiJxjdvwj+Jg1ZYJRPINPVwnOoMk3
         G8LyNjI/wsh7hDh53MeCzi8wRRIQPuMw8dtykU1XEyxO6FfoEoRit8y81bUhhwdSnPP1
         8LbQ==
X-Gm-Message-State: AOAM532PMgLg5SKLRIfRo21wsnTJNP4jTHBsNjyjp3dGMLq90g3SIGGP
        r9ZTNUhgGViNk3+5pRbgtf8Ead2rodkW/kCF3x9voJWw+eLR2w==
X-Google-Smtp-Source: ABdhPJzl7MxZcRPZMcYe7FvBIvod+nuK2T3TXFDebC9bRcZP9xfmG1URn2nQMXs8vQhd38i87QcLVdvPUM+if6b5lzw=
X-Received: by 2002:a2e:9857:: with SMTP id e23mr1322227ljj.411.1594881483731;
 Wed, 15 Jul 2020 23:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200715135011.42743-1-kirill.shutemov@linux.intel.com>
 <CAHk-=wh4pB-jRngOjcGxpc8=NPds3jWqJwDMUWC3-OEo4dRiKg@mail.gmail.com>
 <20200715205428.GA201569@google.com> <CAHk-=wg-_Oof43pKUHMk4ySdLwpYi7+shFg+aeV18UP2Akiv8g@mail.gmail.com>
 <CAHk-=wg+iVwK7MDXB+BPbhTmP-1eBa-y4vxRNr_G8ETnzv5pZg@mail.gmail.com>
 <20200715222228.jf2pv5u2wyhtc5o5@box> <CAHk-=wgp-ZJ+J250DMaJFBDU2hnhUUqXcUnVnZZ1iFQEK6O-jg@mail.gmail.com>
 <CAHk-=wh3jD4dwXWWFors9OnYp-YCzYN2bCGs9HDxrtZ=TiFyDQ@mail.gmail.com> <CAHk-=wjw2yuQjP1rqB=ocr9W3=ak+6h4XygoFTAgM5meiM1Q0A@mail.gmail.com>
In-Reply-To: <CAHk-=wjw2yuQjP1rqB=ocr9W3=ak+6h4XygoFTAgM5meiM1Q0A@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 16 Jul 2020 12:07:52 +0530
Message-ID: <CA+G9fYsRcL1mcFhH47ek3YdGcK6sDSa+Gb0UoJzWkMcTsfxWdQ@mail.gmail.com>
Subject: Re: [PATCHv2] mm: Fix warning in move_normal_pmd()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        William Kucharski <william.kucharski@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jul 2020 at 04:49, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Jul 15, 2020 at 4:04 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > It *might* be as simple as this incremental thing on top
>
> No, it needs to be
>
> +       if (*old_addr + *len < old->vm_end)
> +               return;
>
> in try_to_align_end(), of course.
>
> Now I'm going for a lie-down, because this cross-eyed thing isn't working.


Just want to double check.
Here is the diff after those two patches applied. Please correct me if
it is wrong.
This patch applied on top of Linus mainline master branch.
I am starting my test cycles.

---
 mm/mremap.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/mm/mremap.c b/mm/mremap.c
index 6b153dc05fe4..4961c18d2008 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -254,6 +254,77 @@ static bool move_normal_pmd(struct vm_area_struct
*vma, unsigned long old_addr,

  return true;
 }
+
+#define ADDR_BEFORE_PREV(addr, vma) \
+ ((vma)->vm_prev && (addr) < (vma)->vm_prev->vm_end)
+
+static inline void try_to_align_start(unsigned long *len,
+ struct vm_area_struct *old, unsigned long *old_addr,
+ struct vm_area_struct *new, unsigned long *new_addr)
+{
+ if (*old_addr > old->vm_start)
+ return;
+
+ if (ADDR_BEFORE_PREV(*old_addr & PMD_MASK, old))
+ return;
+
+ if (ADDR_BEFORE_PREV(*new_addr & PMD_MASK, new))
+ return;
+
+ /* Bingo! */
+ *len += *new_addr & ~PMD_MASK;
+ *old_addr &= PMD_MASK;
+ *new_addr &= PMD_MASK;
+}
+
+/*
+ * When aligning the end, avoid ALIGN() (which can overflow
+ * if the user space is the full address space, and overshoot
+ * the vm_start of the next vma).
+ *
+ * Align the upper limit down instead, and check that it's not
+ * in the same PMD as the end.
+ */
+#define ADDR_AFTER_NEXT(addr, vma) \
+ ((vma)->vm_next && (addr) > (PMD_MASK & (vma)->vm_next->vm_start))
+
+static inline void try_to_align_end(unsigned long *len,
+ struct vm_area_struct *old, unsigned long *old_addr,
+ struct vm_area_struct *new, unsigned long *new_addr)
+{
+ if (*old_addr < old->vm_end)
+ return;
+
+ if (ADDR_AFTER_NEXT(*old_addr + *len, old))
+ return;
+
+ if (ADDR_AFTER_NEXT(*new_addr + *len, new))
+ return;
+
+ /* Mutual alignment means this is same for new/old addr */
+ *len = ALIGN(*new_addr + *len, PMD_SIZE) - *new_addr;
+}
+
+/*
+ * The PMD move case is much more efficient, so if we have the
+ * mutually aligned case, try to see if we can extend the
+ * beginning and end to be aligned too.
+ *
+ * The pointer dereferences look bad, but with inlining, the
+ * compiler will sort it out.
+ */
+static inline void try_to_align_range(unsigned long *len,
+ struct vm_area_struct *old, unsigned long *old_addr,
+ struct vm_area_struct *new, unsigned long *new_addr)
+{
+ if ((*old_addr ^ *new_addr) & ~PMD_MASK)
+ return;
+
+ try_to_align_start(len, old, old_addr, new, new_addr);
+ try_to_align_end(len, old, old_addr, new, new_addr);
+}
+#else
+#define try_to_align_range(len,old,olda,new,newa) do { } while(0);
 #endif

 unsigned long move_page_tables(struct vm_area_struct *vma,
@@ -272,6 +343,8 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
  old_addr, old_end);
  mmu_notifier_invalidate_range_start(&range);

+ try_to_align_range(&len, vma, &old_addr, new_vma, &new_addr);
+
  for (; old_addr < old_end; old_addr += extent, new_addr += extent) {
  cond_resched();
  next = (old_addr + PMD_SIZE) & PMD_MASK;
-- 
2.27.0

>
>               Linus

- Naresh
