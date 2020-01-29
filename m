Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60988C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 14:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B14206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 14:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blg8gwsa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgA2Ok4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 09:40:56 -0500
Received: from mail-pl1-f169.google.com ([209.85.214.169]:39168 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgA2Ok4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 09:40:56 -0500
Received: by mail-pl1-f169.google.com with SMTP id g6so17683plp.6;
        Wed, 29 Jan 2020 06:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JvoTSG0VTvs6pJMcpuNeyCO599C87Lk3Oo9v+qxULZI=;
        b=blg8gwsapzbY2PNjCATaR8gACZe4IAbMvIOPlaVwZBVD+KK+/DRYL5ZRX7kF54mC3a
         0fudadBagP03wxrtq0bOFzOmazsOj80LePzcicX65cKWQewU1WqfC8hPl4JQgHYn3ZFD
         lilBxSeLwnsbY/Kn8KQCZEBRzd6zG7K72A9B8nknpGeAwGG3BMr5pr6n0yDJnxJ8K8yd
         H560zsGnT5Hlh2YKsErc2ue0CV6BbGg5XmqwQ/ZH8wmJ3D4mXX/q0gyEm9bt+ytH++rV
         zji6ig7TkU6ron1fTOW4QSekxzr9iRzpuV0JGz9IdJ08IJQk8gKk0SzDJi4GCNz4Z11l
         4v0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JvoTSG0VTvs6pJMcpuNeyCO599C87Lk3Oo9v+qxULZI=;
        b=sFptDzZh3clS4WnfB8AwVtAHt3WSy7A2Aa7gue2b2qkM04T9RCwb+/abqLaehOWUCL
         c/GJcrlIYN9ipBLI+9dApPCwYQGzk4WmBLemWb1G2rM7IzgwMb43t/BLNoyzmMsSDq+Y
         mNdq6rPBVS4WkFK2MbMpFMcB1lmM7eo88CvJsB/ZIVwlXvj/87Djd0DswazRG0CaUWIx
         mviHtSc3bQILOoyAIOGUBAOKlvi0e+nbBmAzvbK3+WMKyj8xf22eVjviqqavBsHkwFqW
         oaEuMS0Cl+8po4i2WDlGmJTwHYYOrrPsxkThzLzc1L0hEGyFD9OEr5IysWIGSteGug/e
         jqFw==
X-Gm-Message-State: APjAAAUM3V2wcAaXRJaNX840MTlPdmT34LocllZEj5HtxUahOyQdboHL
        gyX7HO+iJdFGE3lvGFsDcmQ=
X-Google-Smtp-Source: APXvYqxYEyfC9oqU0Z47wPGTFSxtroHT+AOWj1ahbryAH1H5ZIJWeQqJn6nq9evPrLs8x+gGJZ38mA==
X-Received: by 2002:a17:90a:a416:: with SMTP id y22mr11586404pjp.114.1580308855223;
        Wed, 29 Jan 2020 06:40:55 -0800 (PST)
Received: from localhost (167.117.30.125.dy.iij4u.or.jp. [125.30.117.167])
        by smtp.gmail.com with ESMTPSA id x10sm3134798pfi.180.2020.01.29.06.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 06:40:54 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Wed, 29 Jan 2020 23:40:52 +0900
To:     anon anon <742991625abc@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Petr Mladek <pmladek@suse.com>, wangkefeng.wang@huawei.com,
        syzkaller@googlegroups.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Write in vgacon_scroll
Message-ID: <20200129143754.GA15445@jagdpanzerIV.localdomain>
References: <CAA=061EoW8AmjUrBLsJy5nTDz-1jeArLeB+z6HJuyZud0zZXug@mail.gmail.com>
 <CGME20200128124918eucas1p1f0ce2b2b7b33a5d63d33f876ef30f454@eucas1p1.samsung.com>
 <20200128124912.chttagasucdpydhk@pathway.suse.cz>
 <4ab69855-6112-52f4-bee2-3358664d0c20@samsung.com>
 <20200129141517.GA13721@jagdpanzerIV.localdomain>
 <20200129141759.GB13721@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129141759.GB13721@jagdpanzerIV.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc-ing Dmitry and Tetsuo

Original Message-id: CAA=061EoW8AmjUrBLsJy5nTDz-1jeArLeB+z6HJuyZud0zZXug@mail.gmail.com

On (20/01/29 23:17), Sergey Senozhatsky wrote:
> > Hmm. There is something strange about it. I use vga console quite
> > often, and scrolling happens all the time, yet I can't get the same
> > out-of-bounds report (nor have I ever seen it in the past), even with
> > the reproducer. Is it supposed to be executed as it is, or are there
> > any preconditions? Any chance that something that runs prior to that
> > reproducer somehow impacts the system? Just asking.
> 
> These questions were addressed to anon anon (742991625abc@gmail.com),
> not to Bartlomiej.

Could this be GCC_PLUGIN related?

	-ss
