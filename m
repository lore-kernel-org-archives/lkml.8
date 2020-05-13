Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D3BC2D0FA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B92820675
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589366984;
	bh=WI4N0XLn822C5JW3eFGW3auiTCinCLuSa1FZ40QLjLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iLTMq/rNR4e3zQH4UVV6R2P+pqZlqitdIhSDWMwcLaggk78GOR33U5FHHLU3QWohm
	 E4XP/UShBDn2HU35N5DJnQFY87qUHNYymN/cR7e2e898D3/9mpmhRotNnGFzzI4U1l
	 0uSHhdmofTHoPkxwRHBks6uepS9NMd8O4qtKyz6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732741AbgEMKtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 06:49:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54571 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgEMKtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 06:49:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id h4so26052280wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 03:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qGtWvRJM1m2RpMoVIbMi3Ej47pxKSMk0dInoX5vx7QE=;
        b=SVnUYwr2FUKVQ8W9CZjbSCHco7uUa3YGl4coIlLBf5D1XyGRExtcLJRAIt7qYt6mCp
         E4Jb9GI1Qb8tIF3qD6NX+EgskyBJcLwikGyM82FzcXLv6TAbNI15i18Q6GXq2FuU94FS
         RFsvnQvYbtTEYVxOB4Lf5gWbBI4YfGNP0s/TFpsubHekp8TGwoxDGPR2vUd377zbIkXW
         4A/45zd0qqkRvbOqLY8HPocKbOedabp1Th/3gCK1LByFfLgEbHVYb5SmWxOjJUHl6rQ4
         kZ4GMUWtiN5Vum/qqIoe7w0UCeH0sKGV0N+N2azSdWpnFl2IZgAPxO8ILx/J8wBAv/kk
         ObsQ==
X-Gm-Message-State: AOAM5320vDJfdOWXlV9coPRoAq0g+WmmYatKTCtLhOxCmFcct3f/RimV
        01aYSiDBYUVJQ7azVlWaByk=
X-Google-Smtp-Source: ABdhPJyRv8MpJFuutWZlFO+pO+Lfn4/k9QPleIKjdfBRr7snRl3DOAzb9PAKwn9kVVTiPTwh++gEwg==
X-Received: by 2002:a1c:7d43:: with SMTP id y64mr4137833wmc.46.1589366981114;
        Wed, 13 May 2020 03:49:41 -0700 (PDT)
Received: from localhost (ip-37-188-249-36.eurotel.cz. [37.188.249.36])
        by smtp.gmail.com with ESMTPSA id r14sm11330332wmb.2.2020.05.13.03.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 03:49:40 -0700 (PDT)
Date:   Wed, 13 May 2020 12:49:38 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
Message-ID: <20200513104938.GW29153@dhcp22.suse.cz>
References: <4dae86af-1d9a-f5a8-cff6-aa91ec038a79@i-love.sakura.ne.jp>
 <20200428121828.GP28637@dhcp22.suse.cz>
 <b4d74234-8009-9ffd-011f-bd5d1a4b85f6@i-love.sakura.ne.jp>
 <20200428154532.GU28637@dhcp22.suse.cz>
 <b1d507b1-dae7-f526-c74a-d465ddecea6a@i-love.sakura.ne.jp>
 <20200429142106.GG28637@dhcp22.suse.cz>
 <a59271f1-b3fc-26d1-f0a2-5ec351d0095e@i-love.sakura.ne.jp>
 <20200513062652.GM413@jagdpanzerIV.localdomain>
 <a75d6560-ad99-5b02-3648-247c27c3a398@i-love.sakura.ne.jp>
 <20200513100413.GH17734@linux-b0ei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513100413.GH17734@linux-b0ei>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13-05-20 12:04:13, Petr Mladek wrote:
> What is so special about  OOM dump task so that it would deserve such
> complications?

Nothing really. Except for the potential amount of the output. But as
you've said there are two ways around that. Disable this output if you
do not need it or make it a lower loglevel. A completely different
method of tagging messages just to distinguish different backends of the
printk ring buffers sounds like a bad idea to me because it a) adds a
policy to the kernel and b) it makes it incredibly hard to judge when to
use such a feature. I simply cannot tell whether somebody considers
dump_tasks an important information to be printed on consoles.

If there is any need to control which messages should be routed to which
backend then the proper solution would be to filter messages per log
level per backend. But I have no idea how feasible this is for the
existing infrastructure - or maybe it already exists...
-- 
Michal Hocko
SUSE Labs
