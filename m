Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B827C32771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 02:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F5CD24673
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 02:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtbU8QCb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgAWCjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 21:39:41 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38831 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAWCjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 21:39:40 -0500
Received: by mail-pj1-f67.google.com with SMTP id l35so511274pje.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 18:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ObBz/9vwTw3ohjDGTscqyWS1Wi8lhEKFZVbdqUQmqc=;
        b=ZtbU8QCbzG9SfPW0MwWGfsHlxQjUj3j9u8sNB26EDLCUMvOLT/Lc6l2q26ghU8PEjR
         YaEWM90K/88UeXH2FMNsn/FxVein3GORfaTj3Hx6zBabktTsJx5u0vcx1rbpxLdWjtKX
         h3SvnF/edqQgUy0z2xGCoTX4bbGeDVUbG27CHqY0lwDmDmOOvgXqIMAWbnCCPdWO01Vm
         o1m0F4in0lsntPW4H+O9KzpzQEPU72GIEiL1tePh2JElrEx2kVFWGxr7dKQ50MZQjB8o
         k6F76wV/lT7dqYlZoogF7EPLUcz384MIqOmo8Ew9Pce2tJ3LWN+yeFKthzPa9eqguW9h
         aUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ObBz/9vwTw3ohjDGTscqyWS1Wi8lhEKFZVbdqUQmqc=;
        b=InYjNB9cukDQT3Vrh41+sUdHmXAk4goVD8CCoPFVVMfd8/rnOraOtTVfy3E6qdt7TJ
         PW5FE4O6ChDXHgFyztg8k3OJmISZW/gEQEIKu8G2h61g5NJxMa1vS08c6myxKVBeP0Cj
         SgXTeXcgyaCWA2vasrw4tS6YQAvtsMeqJy8q7KqSlHitoFDHNyxzaB9ShSqbDHPFRkTj
         QxgeRc1Yv/8NlvQNGal0ab+OiyYRgwamNixTTkG1k6X87eVFxWO4WYnuduikPWuZ3Dxg
         2/sH20lHrYQ6fRkH+Zh0EY065k0CSXfQhuQghQXLD3qgZ3iOjCbgt0p3Dn8fpWF0r31t
         ib9g==
X-Gm-Message-State: APjAAAW+2Mof8mlRRLrrmFpdTcuxcvAKEUkmXGOx+4AoenweU5G7wR4d
        eqST2DVMRI5+OIbDY74JdlM=
X-Google-Smtp-Source: APXvYqxZCfdu5NMuJiFMUZeqkjIaqsWSjSVbyyBZdQrEGU0li3YjOYM0rshCfGkZNhHG34nxSIwdxA==
X-Received: by 2002:a17:90a:6484:: with SMTP id h4mr1812491pjj.84.1579747180297;
        Wed, 22 Jan 2020 18:39:40 -0800 (PST)
Received: from localhost ([103.29.143.67])
        by smtp.gmail.com with ESMTPSA id j14sm390076pgs.57.2020.01.22.18.39.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Jan 2020 18:39:40 -0800 (PST)
Date:   Thu, 23 Jan 2020 10:39:36 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        linux-kernel@vger.kernel.org, huyue2@yulong.com
Subject: Re: [PATCH] zram: do not set ZRAM_IDLE bit for idlepage writeback
 in writeback_store()
Message-ID: <20200123103936.000044ba.zbestahu@gmail.com>
In-Reply-To: <20200123022305.GF249784@google.com>
References: <20200121113557.11608-1-zbestahu@gmail.com>
        <20200123022305.GF249784@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2020 18:23:05 -0800
Minchan Kim <minchan@kernel.org> wrote:

> On Tue, Jan 21, 2020 at 07:35:57PM +0800, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > Currently, we will call zram_set_flag() to set ZRAM_IDLE bit even for
> > idlepage writeback. That is pointless. Let's set it only for hugepage mode.  
> 
> Could you be more specific? What do you see the problem with that?

If current writeback mode is idle, ZRAM_IDLE bit will be check firstly for this
slot. Then go to call zram_set_flag(, , ZRAM_IDLE) if it's marked as ZRAM_IDLE.
So, it's duplicated setting, am i right? 

Thx.

> 
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > ---
> >  drivers/block/zram/zram_drv.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > index 4285e75..eef5767 100644
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -689,16 +689,18 @@ static ssize_t writeback_store(struct device *dev,
> >  		if (mode == IDLE_WRITEBACK &&
> >  			  !zram_test_flag(zram, index, ZRAM_IDLE))
> >  			goto next;
> > -		if (mode == HUGE_WRITEBACK &&
> > -			  !zram_test_flag(zram, index, ZRAM_HUGE))
> > -			goto next;
> > +		if (mode == HUGE_WRITEBACK) {
> > +			if (!zram_test_flag(zram, index, ZRAM_HUGE))
> > +				goto next;
> > +			/* Need for hugepage writeback racing */
> > +			zram_set_flag(zram, index, ZRAM_IDLE);
> > +		}
> > +
> >  		/*
> >  		 * Clearing ZRAM_UNDER_WB is duty of caller.
> >  		 * IOW, zram_free_page never clear it.
> >  		 */
> >  		zram_set_flag(zram, index, ZRAM_UNDER_WB);
> > -		/* Need for hugepage writeback racing */
> > -		zram_set_flag(zram, index, ZRAM_IDLE);
> >  		zram_slot_unlock(zram, index);
> >  		if (zram_bvec_read(zram, &bvec, index, 0, NULL)) {
> >  			zram_slot_lock(zram, index);
> > -- 
> > 1.9.1
> >   

