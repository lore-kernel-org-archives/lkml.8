Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429D9C433F1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17011206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jA23nciz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgGJNuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgGJNuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:50:02 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCD5C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:50:02 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id d17so6529819ljl.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3+t1FJBai3MN8X36lR9GDBEz4WelHJVPns0+ZhtUct0=;
        b=jA23ncizNlqSIf+H6bc/jICF+AF8OgUYhA4tpQ9PVgl5Z96Jy3w5bblIYwTEhY1Zsl
         tCa23GrDnLtVZdstCMJsfsMxYplVybyr9qQ2pvsEr7gEeIRJMpv2I/+lu3ZT4FgAV/Iy
         Tyr248STPS1LuELqZ/yOQZPGUg47TwUmRgQgs2yOv4aJ2p6rD63jvIemUiQ8hGBF3cs+
         f5sjwlJajoPd0GX85mXvkuf3lHdPWCFCQNaevFBC1A7dthU2b6CgF/Rqjc178aIVIC8g
         GMsNCWZCa4DKDP6dpnXH2NFmIwH+hpo5ccRtn/gLWFuCl8WeMT+CMdGJrgHrhS/6TbJY
         ZAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3+t1FJBai3MN8X36lR9GDBEz4WelHJVPns0+ZhtUct0=;
        b=aDomeeGr1x1x+t7+tPDKw0DZQRcW4KUoJgA9HsMQClwjHIlrk3vI3Q7c+ja3jM6p0a
         e1hoUI2/VLtwMegnUQ4YX5v32unRs/aYQJsQbMpPortIu3UqjF3GhVD1piKOd+tgM84g
         yhVgV/xyBnP2ozGATBB/cxv9SUOtANqbokbm6rjKkoYv8biV2Q7fbiWwYOZ3rTolv4tT
         Dx5h6bPslhMLJXOwjw8VJQIXE3jnS0mCi7sJcXUn5BOWgBds9eRHhTqnMUm/EW1nenFU
         ENy2xM/lsnNw5ynU6efx8XSovN+3mEuSajroJZQiqFvyV0uoakqxqVKs6jjapUI6Wez6
         Q33g==
X-Gm-Message-State: AOAM5316MwojK3gH0MfB3RFPMXfq2btddwbWUG1y7aMYouGFOdP0ueev
        XCQAleq+I8dbYGqfDOF7VoE=
X-Google-Smtp-Source: ABdhPJzSWBbYtX7hpYL2c5BfJVOpZx1iPV/QFc7eHwtKBsNjOPBFS1izv/YSHe5lPqVNSUuFiqiUTw==
X-Received: by 2002:a2e:a413:: with SMTP id p19mr29908100ljn.145.1594389000380;
        Fri, 10 Jul 2020 06:50:00 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id g2sm2763463ljj.90.2020.07.10.06.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 06:49:58 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 10 Jul 2020 15:49:56 +0200
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Tian Tao <tiantao6@hisilicon.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v3] vmalloc: Add the right hint when vmalloc failed
Message-ID: <20200710134956.GA14549@pc636>
References: <1594383472-52983-1-git-send-email-tiantao6@hisilicon.com>
 <20200710124323.GJ12769@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710124323.GJ12769@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Jul 10, 2020 at 08:17:52PM +0800, Tian Tao wrote:
> > In fact "vmalloc=<size>" cmdline option is not available on many
> > platforms.When the user encounters this error, add the correct
> > hint to prevent misleading.
> 
> i don't think this is an improvement.
>
Matthew, maybe it should not be considered as improvements?

It is rather an extra information that indicates that your
ARCH may not support "vmalloc" early parameter.

Thanks!

--
Vlad Rezki
