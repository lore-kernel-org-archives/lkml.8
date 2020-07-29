Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46E1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8CB520829
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Y9LYoKMx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgG2WVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 18:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2WVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 18:21:37 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AFBC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 15:21:37 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 140so13896931lfi.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 15:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pXu8OuCl8XPKqUjZK4V7JWQi6YMrByUyT2Rl4z35rjc=;
        b=Y9LYoKMxXRNo9xRu1W1RcAkN/ZZtus8wohN98GH+lzAizy5vx1oOzOnrdwPZl1AfGJ
         CX57JUSohfYObl+vy2xZYvHNvUONb2kWTTd3sh+8MwPH0EdZzE+eCanhm7AvKTzFFixB
         jfrZj34JHqsc8LQx18rkoKptFPodeiPU3odWI2BEAciVxek04O2+tYPRoEmdd3Dw94TI
         Ipr+Xpw2jPZjTgtZNxvfooceNG5b2MtTSWeVBddA1xBitbhArT0BqfJOKFARNjXvcHzz
         EXIVSN7QTFCUCXuqK2wLU4I2jLTLkb4FLY1flz7VHGnRmYVVxr4ip5kzm2ABcBE0cTfC
         EpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pXu8OuCl8XPKqUjZK4V7JWQi6YMrByUyT2Rl4z35rjc=;
        b=t1hhKZyNxARsSYwwsOLftQdNBlqD//cIVRQfhws3SzPqG0EmINF5ecEIyKsOIkaVqX
         ulmdYYrP0KdhbwA/TWqT4oO8+KXSv5+LvVd31M5YNxRKRj1FoR9Ez44JaFQmER7czySH
         KPTZ9pU6Kk18keheY/dR1BqDbjc9AK34/ogkcFGIyYJTrx8yHnqHKsC4yhgernk3TLlc
         cdMM8Dk76k5kZ/rBFw39bv3DRmyW3vjGnWnp4CGyxfd0BmLHZe8F2w7Ebs9ADdX6zbbm
         FfI5rOYrEGmc2vmZ4fJgqccsb9U2KO/t0ThVA46tAmU8qX8UeRmRzGFgRNUPT5Pj3sSP
         oDWQ==
X-Gm-Message-State: AOAM5323X9tuMckdb2AfWq2WVpROg19ttDTmYWDc5b2/1fybkEFM1EK6
        Q2zFLo56NupDJXyQUzXmotZtpw==
X-Google-Smtp-Source: ABdhPJyz4egeo7b/obsOl2OCYxxRlBJryZHGBbVCSpuZ6IBZYcUgnwYDKzpRYsTWz4eF/vmVr3VfAg==
X-Received: by 2002:a19:c752:: with SMTP id x79mr154133lff.197.1596061295935;
        Wed, 29 Jul 2020 15:21:35 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id 193sm882389lfa.90.2020.07.29.15.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 15:21:35 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id EE1CC102152; Thu, 30 Jul 2020 01:21:39 +0300 (+03)
Date:   Thu, 30 Jul 2020 01:21:39 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     syzbot <syzbot+f62749569eab36774dc5@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: kernel BUG at mm/internal.h:LINE! (2)
Message-ID: <20200729222139.nhok7opbvh6vr7t3@box>
References: <000000000000c276c005ab9a0fb1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000c276c005ab9a0fb1@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 01:04:21PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    68845a55 Merge branch 'akpm' into master (patches from And..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17c86c54900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f87a5e4232fdb267
> dashboard link: https://syzkaller.appspot.com/bug?extid=f62749569eab36774dc5
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f62749569eab36774dc5@syzkaller.appspotmail.com
> 
> vma ffff888000153210 start 0007700000077000 end 0000000000077000
> next 0007700000000000 prev 0000000007070707 mm 0007700000000000
> prot 77700000077000 anon_vma 0000000000000000 vm_ops ffffffff885cecc0

All these 0 and 7 look very broken. Is it some magic or just garbage?

-- 
 Kirill A. Shutemov
