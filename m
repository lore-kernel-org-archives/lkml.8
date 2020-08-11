Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EA3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7372F20716
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XuaqnRUA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgHKL3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 07:29:30 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47170 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728579AbgHKL33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 07:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597145367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pROnzIBtZcYQ6h8g+IPqvSZ4Y5L+Qp2DbB3XE4ujM9Q=;
        b=XuaqnRUADi4EgW79X5zmq9vPjMP90r4d62LtbAK9na1r/rM8/gxd1So6b2dg9U/f61Htae
        0RGMXWSruHddsIBnOkGAxMk39rYzMQl4z3YgIQc9Kp4UeT71yagorcgBXtbCqVFRDm+7WC
        xLQDendOsOhYrQ1wJnp8BDBbx/dY49Q=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-yJYRPe3vP8uIEcqr9uWRew-1; Tue, 11 Aug 2020 07:29:25 -0400
X-MC-Unique: yJYRPe3vP8uIEcqr9uWRew-1
Received: by mail-pf1-f198.google.com with SMTP id y13so10247237pfp.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 04:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pROnzIBtZcYQ6h8g+IPqvSZ4Y5L+Qp2DbB3XE4ujM9Q=;
        b=GBXOBxjcZs60DUcWBA1qsht0bIrlHxfLh7feXIF3DI0R6+JH9ZFo12uivC47QlRjo4
         X9L15NKVFcv1hGbqf5vV+PlHdKl566g4GeeLmEESDx1ay/bif+BzKeC5C2rCVKvLDICo
         yck9/xK2VXVQCdkC6mgKeD0IX2+5+b3Zlh22A841MHpfLSnGz4THwGDGYffvdHFonANv
         pJ9nbxEGsMZkTMC5Iq0ycfHy1D9uAFnhP4r6dqY+bLWOsuLrQJC2qKJpCySDCwD0yYeL
         XBXn5Zye9rJImxhah4iaFOsN1+H0cjlFIRJjUCj8nbI9iC4L7afD49xrhXRA9QWyY1Jh
         5knA==
X-Gm-Message-State: AOAM531nBk99T31bBYL9s1VlZTIENcFA0goQomrAVc2J23II72WsMg1P
        csE8WixnMfyTziYwI2xeLMrGdiXHALNF5S6fpCDpm6lkDfbFdITlfC1YGbBAhCC/ZzUKcHJVgA7
        N/hZxDug0bepZZBQNVh+rxayh
X-Received: by 2002:a17:902:40a:: with SMTP id 10mr496964ple.260.1597145364010;
        Tue, 11 Aug 2020 04:29:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznrHYDqp5uPiNka0raBMIBomRr80vmIwpo5q49758OCzMM4JnefhV/fHvK+dtElpJSTFaH9g==
X-Received: by 2002:a17:902:40a:: with SMTP id 10mr496944ple.260.1597145363603;
        Tue, 11 Aug 2020 04:29:23 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w9sm2576496pgg.76.2020.08.11.04.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 04:29:23 -0700 (PDT)
Date:   Tue, 11 Aug 2020 19:29:12 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     Chao Yu <yuchao0@huawei.com>, Daeho Jeong <daehojeong@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: change virtual mapping way for
 compression pages
Message-ID: <20200811112912.GB7870@xiangao.remote.csb>
References: <20200811033753.783276-1-daeho43@gmail.com>
 <20200811071552.GA8365@xiangao.remote.csb>
 <3059d7b0-cf50-4315-e5a9-8d9c00965a7c@huawei.com>
 <CACOAw_yic7GF3E1zEvZ=Gea3XW4fMYdg-cNuu4wfg+uTKMcJqA@mail.gmail.com>
 <CACOAw_wi3C0iyTVYc3075d4K27NT7BGMGzsKFDDozf=98vWMcA@mail.gmail.com>
 <20200811101827.GA7870@xiangao.remote.csb>
 <CACOAw_zRPeGzHyc_siLqBRjURWTE61G5rGCwk7bnbcOnADGRpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8\""
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACOAw_zRPeGzHyc_siLqBRjURWTE61G5rGCwk7bnbcOnADGRpg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 08:21:23PM +0900, Daeho Jeong wrote:
> Sure, I'll update the test condition as you said in the commit message.
> FYI, the test is done with 16kb chunk and Pixel 3 (arm64) device.

Yeah, anyway, it'd better to lock the freq and offline the little
cores in your test as well (it'd make more sense). e.g. if 16k cluster
is applied, even all data is zeroed, the count of vmap/vm_map_ram
isn't hugeous (and as you said, "sometimes, it has a very long delay",
it's much like another scheduling concern as well).

Anyway, I'm not against your commit but the commit message is a bit
of unclear. At least, if you think that is really the case, I'm ok
with that.

Thanks,
Gao Xiang 

> 
> Thanks,
> 
> 2020년 8월 11일 (화) 오후 7:18, Gao Xiang <hsiangkao@redhat.com>님이 작성:
> >
> > On Tue, Aug 11, 2020 at 06:33:26PM +0900, Daeho Jeong wrote:
> > > Plus, when we use vmap(), vmap() normally executes in a short time
> > > like vm_map_ram().
> > > But, sometimes, it has a very long delay.
> > >
> > > 2020ë…„ 8ì›” 11ì�¼ (í™”) ì˜¤í›„ 6:28, Daeho Jeong <daeho43@gmail.com>ë‹˜ì�´ ìž‘ì„±:
> > > >
> > > > Actually, as you can see, I use the whole zero data blocks in the test file.
> > > > It can maximize the effect of changing virtual mapping.
> > > > When I use normal files which can be compressed about 70% from the
> > > > original file,
> > > > The vm_map_ram() version is about 2x faster than vmap() version.
> >
> > What f2fs does is much similar to btrfs compression. Even if these
> > blocks are all zeroed. In principle, the maximum compression ratio
> > is determined (cluster sized blocks into one compressed block, e.g
> > 16k cluster into one compressed block).
> >
> > So it'd be better to describe your configured cluster size (16k or
> > 128k) and your hardware information in the commit message as well.
> >
> > Actually, I also tried with this patch as well on my x86 laptop just
> > now with FIO (I didn't use zeroed block though), and I didn't notice
> > much difference with turbo boost off and maxfreq.
> >
> > I'm not arguing this commit, just a note about this commit message.
> > > > > >> 1048576000 bytes (0.9 G) copied, 9.146217 s, 109 M/s
> > > > > >> 1048576000 bytes (0.9 G) copied, 9.997542 s, 100 M/s
> > > > > >> 1048576000 bytes (0.9 G) copied, 10.109727 s, 99 M/s
> >
> > IMHO, the above number is much like decompressing in the arm64 little cores.
> >
> > Thanks,
> > Gao Xiang
> >
> >
> > > >
> > > > 2020ë…„ 8ì›” 11ì�¼ (í™”) ì˜¤í›„ 4:55, Chao Yu <yuchao0@huawei.com>ë‹˜ì�´ ìž‘ì„±:
> > > > >
> > > > > On 2020/8/11 15:15, Gao Xiang wrote:
> > > > > > On Tue, Aug 11, 2020 at 12:37:53PM +0900, Daeho Jeong wrote:
> > > > > >> From: Daeho Jeong <daehojeong@google.com>
> > > > > >>
> > > > > >> By profiling f2fs compression works, I've found vmap() callings are
> > > > > >> bottlenecks of f2fs decompression path. Changing these with
> > > > > >> vm_map_ram(), we can enhance f2fs decompression speed pretty much.
> > > > > >>
> > > > > >> [Verification]
> > > > > >> dd if=/dev/zero of=dummy bs=1m count=1000
> > > > > >> echo 3 > /proc/sys/vm/drop_caches
> > > > > >> dd if=dummy of=/dev/zero bs=512k
> > > > > >>
> > > > > >> - w/o compression -
> > > > > >> 1048576000 bytes (0.9 G) copied, 1.999384 s, 500 M/s
> > > > > >> 1048576000 bytes (0.9 G) copied, 2.035988 s, 491 M/s
> > > > > >> 1048576000 bytes (0.9 G) copied, 2.039457 s, 490 M/s
> > > > > >>
> > > > > >> - before patch -
> > > > > >> 1048576000 bytes (0.9 G) copied, 9.146217 s, 109 M/s
> > > > > >> 1048576000 bytes (0.9 G) copied, 9.997542 s, 100 M/s
> > > > > >> 1048576000 bytes (0.9 G) copied, 10.109727 s, 99 M/s
> > > > > >>
> > > > > >> - after patch -
> > > > > >> 1048576000 bytes (0.9 G) copied, 2.253441 s, 444 M/s
> > > > > >> 1048576000 bytes (0.9 G) copied, 2.739764 s, 365 M/s
> > > > > >> 1048576000 bytes (0.9 G) copied, 2.185649 s, 458 M/s
> > > > > >
> > > > > > Indeed, vmap() approach has some impact on the whole
> > > > > > workflow. But I don't think the gap is such significant,
> > > > > > maybe it relates to unlocked cpufreq (and big little
> > > > > > core difference if it's on some arm64 board).
> > > > >
> > > > > Agreed,
> > > > >
> > > > > I guess there should be other reason causing the large performance
> > > > > gap, scheduling, frequency, or something else.
> > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > _______________________________________________
> > > > > > Linux-f2fs-devel mailing list
> > > > > > Linux-f2fs-devel@lists.sourceforge.net
> > > > > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > > > > > .
> > > > > >
> > >
> >
> 

