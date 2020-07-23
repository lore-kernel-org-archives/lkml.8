Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13FBC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 869FE206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SW9/QPma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387477AbgGWDBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 23:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728902AbgGWDBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 23:01:33 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD61C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 20:01:33 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id o22so2362942pjw.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 20:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2y+I6PwwxSElCmcFQvxr1HYP5aFtMrEZ6V7jnXGLsO0=;
        b=SW9/QPmazUCR7LyWcHbbpG03Z3ogWE4FsXtmL4pW6n0Mvj6SzTFZTf10zY1lGn1oKl
         6p2yFixjjpZa90mM8m6dd02rEYgr2wz9tyydVW5O5vs4q+u3j/rwH+HoWn3HaAP5lPJZ
         45Xwh6yvxU8GfZRBlILyHIX2BFbOGGOvEfHEA7Z4oMEWYu04Ha0DgC99aEGo176pyctP
         /Rn4NmOPxaAnVu3pvY+/l2q6F6meSft/CpX3o66udTo2DYpYN4/ZcP3CJinJJH8n/7jK
         OFZoBTODT1+oXnVJn5X+80+GKPoQ1KMsPQqHld/xjlvDb3USvK+XDZQzpku3OUu0UC9i
         kfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2y+I6PwwxSElCmcFQvxr1HYP5aFtMrEZ6V7jnXGLsO0=;
        b=GKlxYebZgirkZFyX38cu97EbVvAOwiZ2K49EIClLNx03ca9j3+es2d7WVeKLIoztB3
         4KEV0L/UAiY6M3EWGoT+OwuJmkfl6QzvzdX5d8UWVRM/gWMdpjwHHQeNutfK0zhXi6Ic
         zRDO5tVHQgPGv7MY6smlS3aWZngZ15nmZqMtyxzWSVh/14gjovLkSaZv32GB6N95fO2B
         9qgiYJiZaRgwcrgEhbETiCyFnTKWHb9rmny5RneTNg5V3ENXoGtnghOTa8rc9ElspIk1
         UVC+Sg0q3t4MaOg5KbQxoLMgJfc2KTCvFHBwA2TrRa+5ZZUkELrOlJgJZX9vP5ZiSTH1
         vvGA==
X-Gm-Message-State: AOAM5331qKboAXLOMZaPT07yMm0/X4msG+l00G9DxHxldPI17GSnqtdR
        7k2XS0IyRK2V4VDA2gdAgvU=
X-Google-Smtp-Source: ABdhPJxG1oVrZ6RSheJ2/LLYoXDKajjvT7utaHFeGlxYAKCFHgiZq/iAlRziL1FEBJGsV85rFE6lJQ==
X-Received: by 2002:a17:902:a708:: with SMTP id w8mr2187711plq.128.1595473292727;
        Wed, 22 Jul 2020 20:01:32 -0700 (PDT)
Received: from localhost ([103.29.143.67])
        by smtp.gmail.com with ESMTPSA id 198sm1004255pfb.27.2020.07.22.20.01.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Jul 2020 20:01:32 -0700 (PDT)
Date:   Thu, 23 Jul 2020 11:01:23 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jslaby@suse.com, linux-kernel@vger.kernel.org, huyue2@yulong.com,
        zbestahu@163.com
Subject: Re: [PATCH] sysrq: use only one slot for loglevels in key table
Message-ID: <20200723110123.000017e1.zbestahu@gmail.com>
In-Reply-To: <20200722104952.GB2827860@kroah.com>
References: <20200722092610.11504-1-zbestahu@gmail.com>
        <20200722104952.GB2827860@kroah.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jul 2020 12:49:52 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Wed, Jul 22, 2020 at 05:26:09PM +0800, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > Currently, sysrq_key_table[] has 10 slots for same interface to change
> > console loglevel. No specific purpose to do that. Let's use only one slot
> > to save memory space. Also, update the key2index calculation. And remove
> > needless code in help message print path to make the logic simpler.  
> 
> That sounds like a lot of different things being all done at once.  Can
> you break this up into individual patches, each only doing one type of
> thing at a time.

Should be not. The different command key(0 - 9) share same operation which is just
setting loglevel. And the code will find the operation via key2index calculation.
So one index/slot is enough to represent it. rt?

> 
> And if you are saving memory, please show how much you really are
> saving.

The key table is consuming global memory, decrease the array size should be more
better. It will save 9 slots space. The memory saving is 72 bytes via
sizeof(sysrq_key_table) tested under arm64.

> 
> thanks,
> 
> greg k-h

