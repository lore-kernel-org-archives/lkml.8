Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318F6C3403F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 15:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0214207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 15:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="PzuGy0rl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgBRPRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 10:17:50 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38545 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgBRPRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 10:17:50 -0500
Received: by mail-lj1-f196.google.com with SMTP id w1so23392607ljh.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 07:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qWhEX9RKxhypnM5PPqWFOUyYSGe+pegPEe4K7fpUEmA=;
        b=PzuGy0rlY3m0PILFANKBf4jU07YdevfnTGGFHMjs9F/K8E1yFdiUnUyvR7m8no03/h
         3pCXn1X+ehHvBcC3Uc3QRYlT/ZjtUhn7I3SiF6yhssc/WTwymLNmQRg8b73Fcm/TzvJd
         is/qIVvOqL9gFoekZwT0N9mvfC9j0pO39BjX7KBGYqJhCZFbnNX8EIAObEpnQl+Phcx7
         zKYzVNXnUnHTB1ejNs/Rv9cu1w0ldFPqJDk7qgMGuFprB1XspaTqLRWZSbLGSb07BOOi
         05unZ2B2QATKxlasmD2FOCEjp2WZ0CNF820QeigP/i2HUW6XVE+i6Uv6tjUzfJEQ9K6Q
         23Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qWhEX9RKxhypnM5PPqWFOUyYSGe+pegPEe4K7fpUEmA=;
        b=I7ftrIVfoUDYBOHTSlxmtMoPqttsySGKqTsHZoHidphTi1zFR/hUo/dPfcXIsF5fcv
         7TojM+Z602vGs2WFcV41bNHTEI8ehOAX+iFMTWfz9j88Xgho4NL2jiYDtaDlNsNMW2BX
         yTDR9muXLxjDGkBXUqf40Iq//hsJ+wRHlJz4ruskyuHn9ZrLUdR5+RLu2DJzpWEHjyJ7
         I4aXzM8Sp7trioNMrKbrxLhzGbDiYM5I0TZS4o3N9JbatoBGmRB1XehwX3tVqoMG9m8H
         5SHsUxiVcXX9Aks9lqS9wNp93TpJUDiYN9r5THm+dBGPywiB8GGD3gPA9hK6sPE/X9Xw
         uTqg==
X-Gm-Message-State: APjAAAVJJHytn93iXFZsgjJIXvrjxiHTniJlfIWNGI9J4OUIlCQiUTkS
        J4Cgi8vqK+qhdR9TTrm7Kb9itQ==
X-Google-Smtp-Source: APXvYqwmDGsCUfLrJ8biBI5KsgtzZAXb+nMk2XFsea2b0gKSENYf0OwiYFWttt/aHElu78KUASDZmg==
X-Received: by 2002:a05:651c:239:: with SMTP id z25mr12797943ljn.48.1582039067743;
        Tue, 18 Feb 2020 07:17:47 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id g15sm2747705ljk.8.2020.02.18.07.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 07:17:47 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 74291100FA3; Tue, 18 Feb 2020 18:18:13 +0300 (+03)
Date:   Tue, 18 Feb 2020 18:18:13 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Qian Cai <cai@lca.pw>
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot <syzbot+c034966b0b02f94f7f34@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH -next] fork: annotate a data race in vm_area_dup()
Message-ID: <20200218151813.3yzzb2hzlmtbf5xg@box>
References: <20200218103002.6rtjreyqjepo3yxe@box>
 <93E6B243-9A0F-410C-8EE4-9D57E28AF5AF@lca.pw>
 <CANpmjNO320YvGvUfBkWJFnv+QwZy=B0GG=WAMKv7ZOJ2UYFkPg@mail.gmail.com>
 <1582038035.7365.93.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1582038035.7365.93.camel@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 10:00:35AM -0500, Qian Cai wrote:
> On Tue, 2020-02-18 at 15:09 +0100, Marco Elver wrote:
> > On Tue, 18 Feb 2020 at 13:40, Qian Cai <cai@lca.pw> wrote:
> > > 
> > > 
> > > 
> > > > On Feb 18, 2020, at 5:29 AM, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > > > 
> > > > I think I've got this:
> > > > 
> > > > vm_area_dup() blindly copies all fields of orignal VMA to the new one.
> > > > This includes coping vm_area_struct::shared.rb which is normally protected
> > > > by i_mmap_lock. But this is fine because the read value will be
> > > > overwritten on the following __vma_link_file() under proper protectection.
> > > 
> > > Right, multiple processes could share the same file-based address space where those vma have been linked into address_space::i_mmap via vm_area_struct::shared.rb. Thus, the reader could see its shared.rb linkage pointers got updated by other processes.
> > > 
> > > > 
> > > > So the fix is correct, but justificaiton is lacking.
> > > > 
> > > > Also, I would like to more fine-grained annotation: marking with
> > > > data_race() 200 bytes copy may hide other issues.
> > > 
> > > That is the harder part where I don’t think we have anything for that today. Macro, any suggestions? ASSERT_IGNORE_FIELD()?
> > 
> > There is no nice interface I can think of. All options will just cause
> > more problems, inconsistencies, or annoyances.
> > 
> > Ideally, to not introduce more types of macros and keep it consistent,
> > ASSERT_EXCLUSIVE_FIELDS_EXCEPT(var, ...) maybe what you're after:
> > "Check no concurrent writers to struct, except ignore the provided
> > fields".
> > 
> > This option doesn't quite work, unless you just restrict it to 1 field
> > (we can't use ranges, because e.g. vm_area_struct has
> > __randomize_layout). The next time around, you'll want 2 fields, and
> > it won't work. Also, do we know that 'shared.rb' is the only thing we
> > want to ignore?
> > 
> > If you wanted something similar to ASSERT_EXCLUSIVE_BITS, it'd have to
> > be ASSERT_EXCLUSIVE_FIELDS(var, ...), however, this is quite annoying
> > for structs with many fields as you'd have to list all of them. It's
> > similar to what you can already do currently (but I also don't
> > recommend because it's unmaintainable):
> > 
> > ASSERT_EXCLUSIVE_WRITER(orig->vm_start);
> > ASSERT_EXCLUSIVE_WRITER(orig->vm_end);
> > ASSERT_EXCLUSIVE_WRITER(orig->vm_next);
> > ASSERT_EXCLUSIVE_WRITER(orig->vm_prev);
> > ... and so on ...
> > *new = data_race(*orig);
> > 
> > Also note that vm_area_struct has __randomize_layout, which makes
> > using ranges impossible. All in all, I don't see a terribly nice
> > option.
> > 
> > If, however, you knew that there are 1 or 2 fields only that you want
> > to make sure are not modified concurrently, ASSERT_EXCLUSIVE_WRITER +
> > data_race() would probably work well (or even ASSERT_EXCLUSIVE_ACCESS
> > if you want to make sure there are no writers nor _readers_).
> 
> I am testing an idea that just do,
> 
> lockdep_assert_held_write(&orig->vm_mm->mmap_sem);
> *new = data_race(*orig);
> 
> The idea is that as long as we have the exclusive mmap_sem held in all paths
> (auditing indicated so), no writer should be able to mess up our vm_area_struct
> except the "shared.rb" field which has no harm.

Well, some fields protected by page_table_lock and can be written to
without exclusive mmap_sem. Probably even without any mmap_sem: pin
mm_struct + page_table_lock should be enough.

-- 
 Kirill A. Shutemov
