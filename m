Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1424EC433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4D162073E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="kAmshiES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgGXLNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 07:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgGXLNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 07:13:13 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3A1C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 04:13:11 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id m15so4320328lfp.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 04:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rodNgtRmSX3QFvgp8/2GzN9KqUWo4U594tRgIyY952U=;
        b=kAmshiESrG9PW9Vj0BLp/nbPKo8PKi/Dt7rIvOOaHRK99EwDSUMRSUvh4KenPcF9qP
         b82m+lMywKAlOupfQ/m9XhZz7leZ7F1FLQiX8xaQCT1DwS8NwMPzHqhWhIT/b7BqLlmQ
         LHkY9cQhgHJMqr6uj7R3lT2wm+N+LUyffL2s/tlUP993D4c+o6PmjiqHZtqumOSoBCMc
         /dAvzXvBMcUc9WmmZmWdwHBpisZI/xnT/iYb8TRQcenWYnYxNlfGavAmHF61VdGbJ13R
         zh2we/Wl8nl0998qF2aHrqUjUNiPXvQ/+i9JaZbVB2bP32zHGBzaZwU7Jq/GqWpML3GQ
         bLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rodNgtRmSX3QFvgp8/2GzN9KqUWo4U594tRgIyY952U=;
        b=HeqBCLIHn8hlh+R5Zd6PC1QE2HM9L/tZmuviPuoUMKCt11ova3XrFVwFDUpdiU2Ckv
         +DEkQPgxzpWrKcJiEdMosezcBKUV0rJ9fFxm4M+UHdd93VfXyIN7nB8forCrY917WfSL
         Wotj/W2CXIUhAeioq8YK7fBby9+pO820seUFFbKDyS0w7mWoSYXyJcYw0Rg+jqXtCUWr
         LxJPgd4jgRDrek5svilxgim8XYnDs9TTpSYpMH99xpCsQDFok4jyRAtX3p1hxDnENwpU
         7Zg/ugDLsUcqf7T7TmncehVtvigUX0usoFTvqDEG1AW0c7ppY1l4SJQjsw9ZbK7GzlOn
         SPJw==
X-Gm-Message-State: AOAM532j/NIUcp9tPkIgsOustCRYL2HWayUoUuWzEkZFe2VKMku8KKqP
        l1N5UlshN+JJTHNmza17x5Nt1w==
X-Google-Smtp-Source: ABdhPJyvoCGm12FzByJM+vcza8LqeNzc3dD7BW/22NHPUnXv4xiiA6O2yJsa9n4xjV0Y8KULv+2fKQ==
X-Received: by 2002:a05:6512:3583:: with SMTP id m3mr4717313lfr.146.1595589190005;
        Fri, 24 Jul 2020 04:13:10 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id o68sm182612lff.57.2020.07.24.04.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 04:13:09 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 4ACDA101670; Fri, 24 Jul 2020 14:13:11 +0300 (+03)
Date:   Fri, 24 Jul 2020 14:13:11 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hillf Danton <hdanton@sina.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+c48f34012b06c4ac67dd@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jens Axboe <axboe@kernel.dk>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: kernel BUG at include/linux/swapops.h:LINE!
Message-ID: <20200724111311.rcjqigtjqpkenxg6@box>
References: <000000000000bc4fd705a6e090e2@google.com>
 <0000000000004c38cd05aad1d13f@google.com>
 <20200720165144.93189f7825bd28e234a42cb8@linux-foundation.org>
 <20200723073744.5268-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723073744.5268-1-hdanton@sina.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 03:37:44PM +0800, Hillf Danton wrote:
> 
> On Tue, 21 Jul 2020 14:11:31 +0300 Kirill A. Shutemov wrote:
> > On Mon, Jul 20, 2020 at 04:51:44PM -0700, Andrew Morton wrote:
> > > On Sun, 19 Jul 2020 14:10:19 -0700 syzbot wrote:
> > > 
> > > > syzbot has found a reproducer for the following issue on:
> > > > 
> > > > HEAD commit:    4c43049f Add linux-next specific files for 20200716
> > > > git tree:       linux-next
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=12c56087100000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=2c76d72659687242
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=c48f34012b06c4ac67dd
> > > > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1344abeb100000
> > > > 
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+c48f34012b06c4ac67dd@syzkaller.appspotmail.com
> > > 
> > > Thanks.
> > > 
> > > __handle_mm_fault
> > >   ->pmd_migration_entry_wait
> > >     ->migration_entry_to_page
> > > 
> > > stumbled onto an unlocked page.
> > > 
> > > I don't immediately see a cause.  Perhaps Matthew's "THP prep patches",
> > > perhaps something else.
> > > 
> > > Is it possible to perform a bisection?
> > 
> > Maybe it's related to the new lock_page_async()?
> 
> Or is there likely the window that after copy_huge_pmd() the src pmd migrate
> entry is removed and the page unlocked but the dst is not?

No.

copy_huge_pmd() runs with exclusive mmap_lock on the source side and
destination side is not running yet.

-- 
 Kirill A. Shutemov
