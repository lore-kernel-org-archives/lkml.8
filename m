Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC90C34048
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3AD24649
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="rIWSKd/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgBRQqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 11:46:40 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43859 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgBRQqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 11:46:39 -0500
Received: by mail-qt1-f196.google.com with SMTP id d18so14965980qtj.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 08:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T8bF+pORiY8PeSjCtC7UrykFxDxF7KoVLB+X2H57+r8=;
        b=rIWSKd/B0aB55Dekd8pjLuev1MFl1RfX1mliLmvbPkCvo+JLAZEL2J2dLtEf783Z/Z
         26EVH0WjKIHmq1nL02rV9crhpo67vDdn3gztNN+jGQ14DQIE8Q/XOpg6B75SYoeCHjBl
         a3U9qFj8M6ZqIF2lsDXu0Jgs68cptuAqM26s4Go3hy/2pS5rwgkooU86VOaU5bh7ZSfX
         CS8b7zm6IYngDIimj58tDJpjwpWQoes56Bf1knLqLRzvgtEJeA9zvkEr4SHRH30sM9wz
         qMjksu2NFsvtGUtCRN0K9JFGKN9dB7S7WEepbkdCZN/Fpunz5G6/qooYvXJrKrJ8xMm/
         dhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T8bF+pORiY8PeSjCtC7UrykFxDxF7KoVLB+X2H57+r8=;
        b=DtKocdfqWNXMTbijQvsUr5A06B7NLPhlGmBR5aOOxUGGe7zm3UhlPYqgK5djzL4tDw
         gkNnEcs0ISos/apKEuhfIF0khWUlzhGF/7biEK6YWpoLPC9W6aEDzv6t3gbhy3pCP9zs
         /lSZnPpidL2Yy6rhSc9tsstZEBUSC2MydVjb36tHKAxc70VcfOuOVDCP6ux0ELu683Yb
         iEUQyDhIrP67txa7SoSSsfiiWBk2fgrl8uslzkSGLvgDM57ptbmzTye6iL5kcd5Wr7Z6
         j56bzBWKqQDmlnBxjpAl68bPolBIMYhPNsPimtGlZjRUbe311r/8ITq5ZtbptGUOTV4d
         mO+g==
X-Gm-Message-State: APjAAAWXOvJgZnFglSmfU3u7+3+lPMYgVCGs158HhNkuT5cvHGCTkDoH
        K3ZCukWWous2zObS41/Q1o2wTA==
X-Google-Smtp-Source: APXvYqy0PMHgd6DS8SURJABmhNCWT9jAkeYA+IlfYABnhpIgMJOcH/r3wU+tuj7gEABHol3f593SBQ==
X-Received: by 2002:ac8:6bce:: with SMTP id b14mr17799998qtt.200.1582044398605;
        Tue, 18 Feb 2020 08:46:38 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id m54sm2098569qtf.67.2020.02.18.08.46.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2020 08:46:38 -0800 (PST)
Message-ID: <1582044396.7365.94.camel@lca.pw>
Subject: Re: [PATCH -next] fork: annotate a data race in vm_area_dup()
From:   Qian Cai <cai@lca.pw>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot <syzbot+c034966b0b02f94f7f34@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Date:   Tue, 18 Feb 2020 11:46:36 -0500
In-Reply-To: <20200218151813.3yzzb2hzlmtbf5xg@box>
References: <20200218103002.6rtjreyqjepo3yxe@box>
         <93E6B243-9A0F-410C-8EE4-9D57E28AF5AF@lca.pw>
         <CANpmjNO320YvGvUfBkWJFnv+QwZy=B0GG=WAMKv7ZOJ2UYFkPg@mail.gmail.com>
         <1582038035.7365.93.camel@lca.pw> <20200218151813.3yzzb2hzlmtbf5xg@box>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-02-18 at 18:18 +0300, Kirill A. Shutemov wrote:
> On Tue, Feb 18, 2020 at 10:00:35AM -0500, Qian Cai wrote:
> > On Tue, 2020-02-18 at 15:09 +0100, Marco Elver wrote:
> > > On Tue, 18 Feb 2020 at 13:40, Qian Cai <cai@lca.pw> wrote:
> > > > 
> > > > 
> > > > 
> > > > > On Feb 18, 2020, at 5:29 AM, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > > > > 
> > > > > I think I've got this:
> > > > > 
> > > > > vm_area_dup() blindly copies all fields of orignal VMA to the new one.
> > > > > This includes coping vm_area_struct::shared.rb which is normally protected
> > > > > by i_mmap_lock. But this is fine because the read value will be
> > > > > overwritten on the following __vma_link_file() under proper protectection.
> > > > 
> > > > Right, multiple processes could share the same file-based address space where those vma have been linked into address_space::i_mmap via vm_area_struct::shared.rb. Thus, the reader could see its shared.rb linkage pointers got updated by other processes.
> > > > 
> > > > > 
> > > > > So the fix is correct, but justificaiton is lacking.
> > > > > 
> > > > > Also, I would like to more fine-grained annotation: marking with
> > > > > data_race() 200 bytes copy may hide other issues.
> > > > 
> > > > That is the harder part where I don’t think we have anything for that today. Macro, any suggestions? ASSERT_IGNORE_FIELD()?
> > > 
> > > There is no nice interface I can think of. All options will just cause
> > > more problems, inconsistencies, or annoyances.
> > > 
> > > Ideally, to not introduce more types of macros and keep it consistent,
> > > ASSERT_EXCLUSIVE_FIELDS_EXCEPT(var, ...) maybe what you're after:
> > > "Check no concurrent writers to struct, except ignore the provided
> > > fields".
> > > 
> > > This option doesn't quite work, unless you just restrict it to 1 field
> > > (we can't use ranges, because e.g. vm_area_struct has
> > > __randomize_layout). The next time around, you'll want 2 fields, and
> > > it won't work. Also, do we know that 'shared.rb' is the only thing we
> > > want to ignore?
> > > 
> > > If you wanted something similar to ASSERT_EXCLUSIVE_BITS, it'd have to
> > > be ASSERT_EXCLUSIVE_FIELDS(var, ...), however, this is quite annoying
> > > for structs with many fields as you'd have to list all of them. It's
> > > similar to what you can already do currently (but I also don't
> > > recommend because it's unmaintainable):
> > > 
> > > ASSERT_EXCLUSIVE_WRITER(orig->vm_start);
> > > ASSERT_EXCLUSIVE_WRITER(orig->vm_end);
> > > ASSERT_EXCLUSIVE_WRITER(orig->vm_next);
> > > ASSERT_EXCLUSIVE_WRITER(orig->vm_prev);
> > > ... and so on ...
> > > *new = data_race(*orig);
> > > 
> > > Also note that vm_area_struct has __randomize_layout, which makes
> > > using ranges impossible. All in all, I don't see a terribly nice
> > > option.
> > > 
> > > If, however, you knew that there are 1 or 2 fields only that you want
> > > to make sure are not modified concurrently, ASSERT_EXCLUSIVE_WRITER +
> > > data_race() would probably work well (or even ASSERT_EXCLUSIVE_ACCESS
> > > if you want to make sure there are no writers nor _readers_).
> > 
> > I am testing an idea that just do,
> > 
> > lockdep_assert_held_write(&orig->vm_mm->mmap_sem);
> > *new = data_race(*orig);
> > 
> > The idea is that as long as we have the exclusive mmap_sem held in all paths
> > (auditing indicated so), no writer should be able to mess up our vm_area_struct
> > except the "shared.rb" field which has no harm.
> 
> Well, some fields protected by page_table_lock and can be written to
> without exclusive mmap_sem. Probably even without any mmap_sem: pin
> mm_struct + page_table_lock should be enough.
> 

How about this?

diff --git a/kernel/fork.c b/kernel/fork.c
index cb2ae49e497e..68f273e0ebf4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -359,7 +359,10 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct
*orig)
        struct vm_area_struct *new = kmem_cache_alloc(vm_area_cachep,
GFP_KERNEL);
 
        if (new) {
-               *new = *orig;
+               ASSERT_EXCLUSIVE_WRITER(orig->vm_flags);
+               ASSERT_EXCLUSIVE_WRITER(orig->vm_file);
+
+               *new = data_race(*orig);
                INIT_LIST_HEAD(&new->anon_vma_chain);
                new->vm_next = new->vm_prev = NULL;
        }
