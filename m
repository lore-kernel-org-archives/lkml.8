Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3220C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB32120724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmhp9CA8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390281AbgFWVWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390406AbgFWVWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:22:19 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B94C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 14:22:18 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id g18so89583wrm.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 14:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TjVmkqwM1SP/ST4rNtt0OphGd72YPH7okl/8MCZZIlY=;
        b=cmhp9CA81IvdtrwmSDnaPGCT6Ba6wyCGRyFc/HUfxsjL0bEzyQjdT2wCAMISUzJIZc
         J7jV4odkp+XpvSHMEThBOEmasGaEw8uT+s8Vu934pvdjSwiSa0+mCdXgzEOVTmcUtnQv
         ucOReWUFL48mgWyUSuphhrU/qULRnrISovH0xnPe5b9s5oHlTS3BhI0mSjMja1dxi1hX
         5FPomdWu6XBhcCezQNwXmDo+E4ePZeNRdJ2lD240nXhwFx+lRvHGQeBkOSr3RoqvruhA
         kUJpYbiEJzJLh1lA0DulR1BL2XG5suqOETqEGCV009/aUM0WuPxkmdkmjc3vSLt0N2qb
         vQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TjVmkqwM1SP/ST4rNtt0OphGd72YPH7okl/8MCZZIlY=;
        b=ScoSNNh4W1TDyo0BEvZflQ5Yxeyoh2EBLtt2J0XrqS1B/gkz9rWswDggZQ4prCDYCw
         BeEGZVOkDt4Kw7YNlTyttiP598vOONu9skoMfSEl8AIipba8WiwaRA3xBzdQvZNyXvxS
         jaRaD4A+vV0epGHsxJ6Vo1GqZL7yG+P4u4DebEPMuPXmZJEeGVa9hYYmzm9O7aX1kbcl
         6QP3j2AUKMyrun7DI/XWcTOTzBB+rmPSDgSZgJ4PVTZOuxjl6A956/oHakidJQkZhza3
         XWycR155oBXNjPxh8jHJ/OEpdSFK+m9BPAGBECvDVtFhphvveKQquMVTxnSPyquBbwHc
         A9lA==
X-Gm-Message-State: AOAM530vf+G8LoRdkOvKkpkTAsoGFegmTtuU64FtpHdj9D1m1EBmmj8q
        +ISN6IWkvceJdQGpNJGPajQU+aE=
X-Google-Smtp-Source: ABdhPJwXf9UnFg6LTPqtZe0Nw0fZBtvKciNSqh4YLg+vHr1SjOfTG+4co+eFOPlc5Y+xcswjq3KNdw==
X-Received: by 2002:adf:ef46:: with SMTP id c6mr8696827wrp.34.1592947337317;
        Tue, 23 Jun 2020 14:22:17 -0700 (PDT)
Received: from localhost.localdomain ([46.53.253.162])
        by smtp.gmail.com with ESMTPSA id p4sm13847035wrx.63.2020.06.23.14.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 14:22:16 -0700 (PDT)
Date:   Wed, 24 Jun 2020 00:22:14 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Christian Kujau <lists@nerdbynature.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Kook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: process '/usr/bin/rsync' started with executable stack
Message-ID: <20200623212214.GA41702@localhost.localdomain>
References: <alpine.DEB.2.22.1.446.2006231023390.3892@trent.utfs.org>
 <20200623211218.GA40110@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200623211218.GA40110@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 12:12:18AM +0300, Alexey Dobriyan wrote:
> On Tue, Jun 23, 2020 at 10:39:26AM -0700, Christian Kujau wrote:
> > Hi,
> > 
> > exactly this[0] happened today, on a 5.6.5 kernel:
> > 
> >   process '/usr/bin/rsync' started with executable stack
> > 
> > But I can't reproduce this message,

This message is once-per-reboot.

If you run something with exec stack after the message
you shouldn't get it second time.

If you rebooted and rsync starts clean, then it is separate story.

> > and rsync (v3.2.0, not exactly 
> > abandonware) runs several times a day, so to repeat Andrew's questions[0] 
> > from last year:
> > 
> >   > What are poor users supposed to do if this message comes out? 
> >   > Hopefully google the message and end up at this thread.  What do you
> >   > want to tell them?
> > 
> > Also, the PID is missing from that message.
> 
> That's intentional. I for one hate pids.
> 
> > I had some long running rsync 
> > processes running earlier, maybe the RWE status would have been visible in 
> > /proc/$PID/map, or somewhere else maybe?
> 
> If you think process is still running, /proc/*/maps should have 'rwxp'
> indeed. You can do quick
> 
> 	$ grep -e '\[stack\]' /proc/*/maps'
> 
> to find it.

Run as root obviously, or you won't get full picture.
