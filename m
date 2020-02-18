Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DF3C3403D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 15:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6962176D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 15:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="eSZVmwVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgBRPAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 10:00:40 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34220 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgBRPAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 10:00:39 -0500
Received: by mail-qt1-f195.google.com with SMTP id l16so10019460qtq.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 07:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o9sBoUPUqO81jEFCnxVttX8yCrxeL2usN9PLh+pjJ3o=;
        b=eSZVmwVa2gbbGMwMBbKARsAd7cwBPFl00qDx0B2YhBIRPvtxboPzJsFssHP2a80lsc
         4vF/4Mk9CH7lpPDGv7jvgX3kUE0C8cx9L+m0vGGhyHp+V1Xwnq762gh5SAbSdWw4PDn4
         ITxMO+y/SNAHSwbRai4jALTtbnLMhgttn4nqOnDpka8DEASRlBUsgGJB/FShle4gOMbB
         R+qW+74WmicKGgvlCp0d/VFjDZz3wMgruiBadc3GeHICdlRdxb/N1wRi8jnVNTr5gtpm
         MT3elb7KwBbU3dhcvRcDc18mrTvfGLn0X2IIEwyG3RbsWjb5BLybomWjfg01nPLuZovV
         ciGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o9sBoUPUqO81jEFCnxVttX8yCrxeL2usN9PLh+pjJ3o=;
        b=NDoeSB+twbyMxkbtIdBkCzmYJxDRMEYFaVubVs55dHpJV+GmloXh0B5LZ3cZoN+5Qr
         8xDZOtpthEz5zlfKU0pHQ7uV3GncBhJhU/cc3vFM86uauxfCgXq2Py6d4ED7R5Nn6a/R
         7KSLH1TOyjUYiAbeyxHJUmBc+hb30ZrGDXH/hGufC9cK5kjB6R9ssw+c8VItzVypr1FM
         nLeZSE/2arAnc9zqm12OhPZbXsUYb5dncOXGQM8uXefKDHtz3Jn4ssWX7uQRAepD0Cae
         U8YjTOUQV/YlRAsMiW/wJCoABnHoSZeRmNayTmRPsAF9Oa5t00Z0RgdEY81XrsEI4pmD
         FPrQ==
X-Gm-Message-State: APjAAAWjLLBhtxVB//KpH9Px5JHpoHHO59wlxozXS5M5DMEs4qJWtO42
        1EuQ2zKZFrxeonQCebtPDbwp9w==
X-Google-Smtp-Source: APXvYqylsE1qbtN1Q//rOh0WFFDimHe+/9iLy/BtPX+LViPUw+eMK+jjmTxcqviyH1QdlQADIyb8sQ==
X-Received: by 2002:ac8:6bc1:: with SMTP id b1mr17126390qtt.313.1582038037225;
        Tue, 18 Feb 2020 07:00:37 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q6sm1950780qkm.46.2020.02.18.07.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2020 07:00:36 -0800 (PST)
Message-ID: <1582038035.7365.93.camel@lca.pw>
Subject: Re: [PATCH -next] fork: annotate a data race in vm_area_dup()
From:   Qian Cai <cai@lca.pw>
To:     Marco Elver <elver@google.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot <syzbot+c034966b0b02f94f7f34@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Date:   Tue, 18 Feb 2020 10:00:35 -0500
In-Reply-To: <CANpmjNO320YvGvUfBkWJFnv+QwZy=B0GG=WAMKv7ZOJ2UYFkPg@mail.gmail.com>
References: <20200218103002.6rtjreyqjepo3yxe@box>
         <93E6B243-9A0F-410C-8EE4-9D57E28AF5AF@lca.pw>
         <CANpmjNO320YvGvUfBkWJFnv+QwZy=B0GG=WAMKv7ZOJ2UYFkPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-02-18 at 15:09 +0100, Marco Elver wrote:
> On Tue, 18 Feb 2020 at 13:40, Qian Cai <cai@lca.pw> wrote:
> > 
> > 
> > 
> > > On Feb 18, 2020, at 5:29 AM, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > > 
> > > I think I've got this:
> > > 
> > > vm_area_dup() blindly copies all fields of orignal VMA to the new one.
> > > This includes coping vm_area_struct::shared.rb which is normally protected
> > > by i_mmap_lock. But this is fine because the read value will be
> > > overwritten on the following __vma_link_file() under proper protectection.
> > 
> > Right, multiple processes could share the same file-based address space where those vma have been linked into address_space::i_mmap via vm_area_struct::shared.rb. Thus, the reader could see its shared.rb linkage pointers got updated by other processes.
> > 
> > > 
> > > So the fix is correct, but justificaiton is lacking.
> > > 
> > > Also, I would like to more fine-grained annotation: marking with
> > > data_race() 200 bytes copy may hide other issues.
> > 
> > That is the harder part where I don’t think we have anything for that today. Macro, any suggestions? ASSERT_IGNORE_FIELD()?
> 
> There is no nice interface I can think of. All options will just cause
> more problems, inconsistencies, or annoyances.
> 
> Ideally, to not introduce more types of macros and keep it consistent,
> ASSERT_EXCLUSIVE_FIELDS_EXCEPT(var, ...) maybe what you're after:
> "Check no concurrent writers to struct, except ignore the provided
> fields".
> 
> This option doesn't quite work, unless you just restrict it to 1 field
> (we can't use ranges, because e.g. vm_area_struct has
> __randomize_layout). The next time around, you'll want 2 fields, and
> it won't work. Also, do we know that 'shared.rb' is the only thing we
> want to ignore?
> 
> If you wanted something similar to ASSERT_EXCLUSIVE_BITS, it'd have to
> be ASSERT_EXCLUSIVE_FIELDS(var, ...), however, this is quite annoying
> for structs with many fields as you'd have to list all of them. It's
> similar to what you can already do currently (but I also don't
> recommend because it's unmaintainable):
> 
> ASSERT_EXCLUSIVE_WRITER(orig->vm_start);
> ASSERT_EXCLUSIVE_WRITER(orig->vm_end);
> ASSERT_EXCLUSIVE_WRITER(orig->vm_next);
> ASSERT_EXCLUSIVE_WRITER(orig->vm_prev);
> ... and so on ...
> *new = data_race(*orig);
> 
> Also note that vm_area_struct has __randomize_layout, which makes
> using ranges impossible. All in all, I don't see a terribly nice
> option.
> 
> If, however, you knew that there are 1 or 2 fields only that you want
> to make sure are not modified concurrently, ASSERT_EXCLUSIVE_WRITER +
> data_race() would probably work well (or even ASSERT_EXCLUSIVE_ACCESS
> if you want to make sure there are no writers nor _readers_).

I am testing an idea that just do,

lockdep_assert_held_write(&orig->vm_mm->mmap_sem);
*new = data_race(*orig);

The idea is that as long as we have the exclusive mmap_sem held in all paths
(auditing indicated so), no writer should be able to mess up our vm_area_struct
except the "shared.rb" field which has no harm.
