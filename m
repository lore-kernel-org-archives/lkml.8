Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C294C43465
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 448A82064C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="lfiFnDf5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbgGQXKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 19:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbgGQXK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 19:10:27 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2CBC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 16:10:27 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e4so14509345ljn.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 16:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FmUurtNr8DsvIpsatQ0QZyiVO7vjkVTvgORSNA0VraU=;
        b=lfiFnDf5/hcNt4iNktxDTmBsFCUZHL+MYzpIy6YNbC7QlUQM6TakFJr+XrIzoNORkW
         8bmsLA3Oq27caiG0e1TMNOoCcIVS4Tb72dSY7RCl1FF7MIGsm/fFV605IUaObL4EcZt3
         elb6TRQJKRqg2Fd8aruQ1TrqlQsCQXoU0U9rAQPp93E9u0boxAPvyUzHnVwSN17g/zTJ
         oOgAiaPAN2sfkTG6KMPsu262V+0oxoemiJMnmKXOnaRuvVOdx4wkl9qWw97Y8YLmD4Ns
         cDtvEaVHQiO5i4j70j5qwCqwgnFUf7Eb/04zpIMGgGROC6T30AuKqOKg2OpAY4gmSVff
         7qpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FmUurtNr8DsvIpsatQ0QZyiVO7vjkVTvgORSNA0VraU=;
        b=my89C0lfR3Q8gl7IYOwMA3FgmXYxCtoN8pwIiD8POlu0/1Q7JfI+epiPKF7ClUU2Mb
         A2uzengcgOLdWUSPweYdrQbHlpyJaJiHSoBN6pTthsmgs4HGzj1WLduvPQ/H4sYjUIGq
         0c6sGxQ5J/JqVINP9mGVcgi6dKRC1J3Ln4uLGuq89Nrplaagf8P1StNlR6e+5AZDT3vA
         WZ3JK0oNedpIHHeLQaJGfv4ZsA4ErOton8PoRIoRSD7yhdtkrCTNKXSuXvhQxGKLkZQe
         yZG15D41C3XhvlmwkW0tVzS+yQofBZ8Y9weC5kcMpYzSNP0AvSrnVwGeOQWkW0q0UdOw
         +RNw==
X-Gm-Message-State: AOAM532+wc7zxwmEH7Ie1fIc8AAYJ/+ILi/wURn6ySgOuBMZ4/kRVgv1
        ylquwX0GF9OSC1yG94GaCyC9lQ==
X-Google-Smtp-Source: ABdhPJxFWdc1CHNgacIHbLK/JJTWJWTShV9FV/auq+6FQoYOgSaMz+P+4z+UfxI/oCDgLUPopItmAA==
X-Received: by 2002:a2e:3316:: with SMTP id d22mr5578396ljc.18.1595027425548;
        Fri, 17 Jul 2020 16:10:25 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i8sm1880972ljg.57.2020.07.17.16.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 16:10:24 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id EA54F10216B; Sat, 18 Jul 2020 02:10:23 +0300 (+03)
Date:   Sat, 18 Jul 2020 02:10:23 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     syzbot <syzbot+ed318e8b790ca72c5ad0@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org, william.kucharski@oracle.com,
        yang.shi@linux.alibaba.com, ziy@nvidia.com
Subject: Re: general protection fault in khugepaged
Message-ID: <20200717231023.tawtcmpwwqi2qsni@box>
References: <000000000000358aec05a9fc8aa8@google.com>
 <0000000000008ad07505aaaad631@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000008ad07505aaaad631@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 03:40:04PM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit ffe945e633b527d5a4577b42cbadec3c7cbcf096
> Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Date:   Wed Jun 3 23:00:09 2020 +0000
> 
>     khugepaged: do not stop collapse if less than half PTEs are referenced
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17356c2f100000
> start commit:   e44f65fd xen-netfront: remove redundant assignment to vari..
> git tree:       net-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=14b56c2f100000
> console output: https://syzkaller.appspot.com/x/log.txt?x=10b56c2f100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=829871134ca5e230
> dashboard link: https://syzkaller.appspot.com/bug?extid=ed318e8b790ca72c5ad0
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113406a7100000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=175597d3100000
> 
> Reported-by: syzbot+ed318e8b790ca72c5ad0@syzkaller.appspotmail.com
> Fixes: ffe945e633b5 ("khugepaged: do not stop collapse if less than half PTEs are referenced")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 

My guess is that anonymous VMA got replaced by file VMA under us.

Could you reproduce the issue with the patch below? I have hard time
triggering it myself.

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b043c40a21d4..f8ec58a1e72b 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1107,6 +1107,8 @@ static void collapse_huge_page(struct mm_struct *mm,
 	if (mm_find_pmd(mm, address) != pmd)
 		goto out;
 
+	if (!vma->anon_vma)
+		dump_vma(vma);
 	anon_vma_lock_write(vma->anon_vma);
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, NULL, mm,
-- 
 Kirill A. Shutemov
