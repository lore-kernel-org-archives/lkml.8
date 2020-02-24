Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05C4C38BF9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 923E1218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582581224;
	bh=OQfgRDNqPUwUySOhg5bb3Y/nenIgHuWlmnmhgJ6GTHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u3SjJFXyZxxHHmA+tURkE4/vKm506AxRNGETRiC7IU7tyxYyJZgmwwcj4cWuu86/M
	 0uuEdARQ2t5Wf39JtoNFAyXGOscWOvGqxP6lijf9TdEva3ayqjyGpjTVozz2XaAo5T
	 UgElx8hKMNimZaSSrK6tBZyHu4HNLltkC/+EqBio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgBXVxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:53:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:36012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727421AbgBXVxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:53:42 -0500
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5861C20CC7;
        Mon, 24 Feb 2020 21:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582581222;
        bh=OQfgRDNqPUwUySOhg5bb3Y/nenIgHuWlmnmhgJ6GTHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fe/ofi/UwUcKmEvcM/dTb8cHpCur6gEGE4qnCv3RefIsGWfGr/LkaJ4JUsRH0KEWF
         T7gLHhiaLepMt5oh+U4eFcuV4AC30Xtncx0R12uJ67RZAHACo90NvHnF0FmEO0h/vs
         46JTTgWYTjm0seaEiJlFNKEzYpDF4StWl61ZCvmk=
Date:   Mon, 24 Feb 2020 13:53:41 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: skip migration only when BG_GC is
 called
Message-ID: <20200224215341.GB77839@google.com>
References: <20200214185855.217360-1-jaegeuk@kernel.org>
 <20200214185855.217360-3-jaegeuk@kernel.org>
 <9c497f3e-3399-e4a6-f81c-6c4a1f35e5bb@huawei.com>
 <20200218232714.GB10213@google.com>
 <117a927f-7128-b5a1-a961-22934bb62ec5@huawei.com>
 <20200219030425.GA102063@google.com>
 <266f233b-e084-cccd-d07e-96d8438d5b74@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <266f233b-e084-cccd-d07e-96d8438d5b74@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/19, Chao Yu wrote:
> On 2020/2/19 11:04, Jaegeuk Kim wrote:
> > On 02/19, Chao Yu wrote:
> >> On 2020/2/19 7:27, Jaegeuk Kim wrote:
> >>> On 02/17, Chao Yu wrote:
> >>>> On 2020/2/15 2:58, Jaegeuk Kim wrote:
> >>>>> FG_GC needs to move entire section more quickly.
> >>>>>
> >>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >>>>> ---
> >>>>>  fs/f2fs/gc.c | 2 +-
> >>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> >>>>> index bbf4db3f6bb4..1676eebc8c8b 100644
> >>>>> --- a/fs/f2fs/gc.c
> >>>>> +++ b/fs/f2fs/gc.c
> >>>>> @@ -1203,7 +1203,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
> >>>>>  
> >>>>>  		if (get_valid_blocks(sbi, segno, false) == 0)
> >>>>>  			goto freed;
> >>>>> -		if (__is_large_section(sbi) &&
> >>>>> +		if (gc_type == BG_GC && __is_large_section(sbi) &&
> >>>>>  				migrated >= sbi->migration_granularity)
> >>>>
> >>>> I knew migrating one large section is a more efficient way, but this can
> >>>> increase long-tail latency of f2fs_balance_fs() occasionally, especially in
> >>>> extreme fragmented space.
> >>>
> >>> FG_GC requires to wait for whole section migration which shows the entire
> >>> latency.
> >>
> >> That will cause long-tail latency for single f2fs_balance_fs() procedure,
> >> which it looks a very long hang when userspace call f2fs syscall, so why
> >> not splitting total elapsed time into several f2fs_balance_fs() to avoid that.
> > 
> > Then, other ops can easily make more dirty segments. The intention of FG_GC is
> 
> Yup, that's a problem, if there are more dirty datas being made, reserved segments
> may be ran out during FG_GC.
> 
> > to block everything and make min. free segments as a best shot.
> 
> I just try to simulate write GC's logic in FTL to mitigate single op's max latency,
> otherwise benchmark looks hang during FG_GC (in a 500mb+ section).

Hmm, I think we may need to think another way like doing BG_GC more aggressively.

> 
> Thanks,
> 
> > 
> >>
> >> Thanks,
> >>
> >>>
> >>>>
> >>>> Thanks,
> >>>>
> >>>>>  			goto skip;
> >>>>>  		if (!PageUptodate(sum_page) || unlikely(f2fs_cp_error(sbi)))
> >>>>>
> >>> .
> >>>
> > .
> > 
