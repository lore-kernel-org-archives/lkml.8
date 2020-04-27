Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7164AC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 06:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E11F206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 06:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMwu1Zhl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgD0GVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 02:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726231AbgD0GVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 02:21:25 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2B9C061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 23:21:21 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t11so8236648pgg.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 23:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=StnDT2Y1mZLv8dGLTvE62VW7GyrfpO3b0lv+vjj4Tbk=;
        b=kMwu1Zhlnd8jP5wNHs2RcGVW651Z63OT/P7piUwCswfRWKnW+dkIcYgSPrRidSuIcu
         pZLjuZFuRJJONr8RcXM/t/NfXjSfgMRIANPnewk2VBcwqHdSoECgcgpsVwZhg8TYbkCm
         HJGsjlaHpGeVlHIOc9dqRh5VSmgTi5htYB2EYRaz3+xHmHpqpW6xZv4AQbjVmQ+SgqPB
         9hXa7hdRPZmwxLQUCtcoHDDC+km5ClBvqxKodJkyaA9pNpqrDnUjpsVlOJd1Lf6oMUJu
         I06upCOeIUubx75Lsh3V+aYwDTfTnu+b1F8JWbz+py25wgcRGXHW2TP7809iNCV0SLiZ
         qcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=StnDT2Y1mZLv8dGLTvE62VW7GyrfpO3b0lv+vjj4Tbk=;
        b=pb4uapdNvpXHkfpx/YHh+fIxfDlucSD6Lzm7tHQNkejV/YlSuUmnJ61yGvpes2+YkA
         pxenzkuqewgkeon6RLowRA4F9f/+W1r8o+CS7LikELIKNP3ltSG8hndGC+/szw5MVAKT
         aggwPTtQ2+NCDVfdMYyW36pKFIoVd6MUfNnT+uBl0Pex70+LEsK2VGr/NDTxiEtBTmB3
         rcVrfFP0i+txw2YQ8Q+oVqpupre17ZJzcJCmDJ1edKkgUIbiH5Rh+QW0pc5C+CR1GZOx
         gJMmfkR8d4bT92vL8KujhYGXJP7xrLdld/yYPYuI8HcHLpHEmQq7GwKR98S1sqphc8zC
         mupw==
X-Gm-Message-State: AGi0PuY2tQmapyWPZbWNdxf8MTiUtXAV3mbW1RHJGnsfRnW4vc4kPYHw
        ichD/NCjRa8UeH8Tx1OEnss=
X-Google-Smtp-Source: APiQypKFCN30Dp1GVXuBWcylRARJAGhGoA8eTPtocawf3Jh8hAJ+T1zFWq7ReUlPg1AwLcLSKdBkMg==
X-Received: by 2002:a62:3644:: with SMTP id d65mr4155037pfa.186.1587968480851;
        Sun, 26 Apr 2020 23:21:20 -0700 (PDT)
Received: from localhost (146.85.30.125.dy.iij4u.or.jp. [125.30.85.146])
        by smtp.gmail.com with ESMTPSA id p10sm11633165pff.210.2020.04.26.23.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 23:21:20 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Mon, 27 Apr 2020 15:21:17 +0900
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Michal Hocko <mhocko@suse.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
Message-ID: <20200427062117.GC486@jagdpanzerIV.localdomain>
References: <20200424024239.63607-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200425004609.GE8982@jagdpanzerIV.localdomain>
 <842ff40b-a232-6098-4333-996a3033b30a@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <842ff40b-a232-6098-4333-996a3033b30a@i-love.sakura.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/04/25 10:07), Tetsuo Handa wrote:
> On 2020/04/25 9:46, Sergey Senozhatsky wrote:
> > On (20/04/24 11:42), Tetsuo Handa wrote:
> > [..]
> >> @@ -19,6 +19,7 @@ static inline int printk_get_level(const char *buffer)
> >>  		switch (buffer[1]) {
> >>  		case '0' ... '7':
> >>  		case 'c':	/* KERN_CONT */
> >> +		case 'S':       /* KERN_NO_CONSOLES */
> >>  			return buffer[1];
> >>  		}
> >>  	}
> > 
> > So this means NO_CONSOLES_AT_ALL, slow + fast ones.
> 
> Right.
> 
> >                                                     I wonder if this
> > wants to be NO_SLOW_CONSOLES instead. Which then brings us to the
> > next question - can this be done with per-console loglevel setting?
> 
> It is difficult to define what is slow consoles. While netconsole will be
> a fast console, we can forward kernel messages via syslog daemon if desired.

Yes, there is no universal definition for "fast" and "slow" console and
I'm not suggesting to come with such a definition.

> KERN_NO_CONSOLES is for type of messages where "saved for later analysis" is
> important but "printed for immediate notification" is not important.
> In other words, KERN_NO_CONSOLES is NOT for dying messages where "printed for
> immediate notification" is important.

per-console loglevel is a user configurable parameter.
KERN_NO_CONSOLES is a hard-coded policy.

	-ss
