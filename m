Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1297AC10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 19:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90BB20656
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 19:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="qk06El3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgCFTxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 14:53:25 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:39034 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFTxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 14:53:25 -0500
Received: by mail-qv1-f66.google.com with SMTP id fc12so1515308qvb.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 11:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QaNxcQb7Gg+vxIHDRqfm2dfWV4oEZhj/ZtvsBzj/+Bk=;
        b=qk06El3JD3uD38dR/+KpHsLyQqx2wruXRJgkstX2ahhw9X3IFGj5nLe2Z+o4giq/pM
         ldJs5F7oyuhAevtUXI557hIOqP78gga6BNTgb4Smwr0CdmuPgHBd9R/mpRAuAVFgT6Si
         FO4sdeP9aVDm3bSjSYygt3LXsi7uG2og5cDNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QaNxcQb7Gg+vxIHDRqfm2dfWV4oEZhj/ZtvsBzj/+Bk=;
        b=KCmPmstc+KK8Tnct5yIPRZgaLs4FmqSA7kUvRHoD90FS9/ghViW9ao4OJcriHwEbTV
         QtOJm2e9+2Zo22XDFuRj+MF5oNNakhiwEBGhKK10u2ikB0EG7FzoXDEYixUd8mhm8iAZ
         ADBj+2rH9uqNhafd5ooq9rw2YUKygbNLWdjBFpCh8Q1z8YJFDtAtGhiZUAVZbA/qSrmK
         b1uVZjl1m1shH5/aoi6iq0wDVMxmVeZXTcj7l6iZk7BjGcLsdh6IZHHPIL2v1xIGCB9s
         cWOcnvlG3JB6lxWGtr1qPN7j9NtCqnzUFQboST78ejKExjqQV4d9y8p5om3aSBzZX07k
         a0GA==
X-Gm-Message-State: ANhLgQ1A1Eo6aVJp7FrZ1jYsAD06n741BBOoU8covk/i2KMlF22qh+gF
        /AW8+INQnAX4GiyrH9FfFCsoqQ==
X-Google-Smtp-Source: ADFU+vtbUmkkv8Fc33D5K6vbh/9sVOZA5kQ0oSPjOpP/B5uhae1bm0YKFhE+l4pQ9zfnhd2Fpzr5Rw==
X-Received: by 2002:a05:6214:1051:: with SMTP id l17mr4508705qvr.175.1583524404428;
        Fri, 06 Mar 2020 11:53:24 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id x188sm8961139qka.53.2020.03.06.11.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 11:53:23 -0800 (PST)
Date:   Fri, 6 Mar 2020 14:53:23 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     dsterba@suse.cz,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org, paulmck@kernel.org,
        frextrite@gmail.com, linux@roeck-us.net
Subject: Re: [PATCH] fs: btrfs: block-group.c: Fix suspicious RCU usage
 warning
Message-ID: <20200306195323.GE60713@google.com>
References: <20200306065243.11699-1-madhuparnabhowmik10@gmail.com>
 <dfd2c14c-acda-3862-9f48-a512e16a895c@gmx.com>
 <20200306140023.GA14186@madhuparna-HP-Notebook>
 <20200306152527.GH2902@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200306152527.GH2902@twin.jikos.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 04:25:27PM +0100, David Sterba wrote:
> On Fri, Mar 06, 2020 at 07:30:24PM +0530, Madhuparna Bhowmik wrote:
> > On Fri, Mar 06, 2020 at 03:16:53PM +0800, Qu Wenruo wrote:
> > > 
> > > 
> > > On 2020/3/6 下午2:52, madhuparnabhowmik10@gmail.com wrote:
> > > > From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > > > 
> > > > The space_info list is rcu protected.
> > > > Hence, it should be traversed with rcu_read_lock held.
> > > > 
> > > > Warning:
> > > > [   29.104591] =============================
> > > > [   29.104756] WARNING: suspicious RCU usage
> > > > [   29.105046] 5.6.0-rc4-next-20200305 #1 Not tainted
> > > > [   29.105231] -----------------------------
> > > > [   29.105401] fs/btrfs/block-group.c:2011 RCU-list traversed in non-reader section!!
> > > > 
> > > > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > > > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > > > ---
> > > >  fs/btrfs/block-group.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > > > index 404e050ce8ee..9cabeef66f5b 100644
> > > > --- a/fs/btrfs/block-group.c
> > > > +++ b/fs/btrfs/block-group.c
> > > > @@ -1987,6 +1987,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
> > > 
> > > This function is only triggered at mount time, where no other rcu
> > > operation can happen.
> > >
> > Thanks Qu.
> > 
> > Joel and Paul, what should we do in this case?
> > Should we just pass cond = true or use list_for_each_entry instead?
> 
> I think we can afford to add rcu lock/unlock, even if it's not strictly
> necessary due to the single threaded context where the function is run.
> There are some lightweight operations inside and inc_block_group starts
> with two spin locks so there's nothing we'd be losing with disabled
> preemption from the caller.

I think use list_for_each_entry().

thanks,

 - Joel

