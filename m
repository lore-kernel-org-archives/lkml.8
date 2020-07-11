Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861CFC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 03:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56B0F2075D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 03:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrGcGC/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgGKDal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 23:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgGKDal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 23:30:41 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18739C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 20:30:41 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id a11so6833717ilk.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 20:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1xGtSn3GzgnnxnxHEMkxu4A5bFvBvCATbzs0GEZtET8=;
        b=mrGcGC/l0RixNmVPT1JtgeSd/s2/az05bb9aOnqtWrfEKdYkAGtyRInDvcykJshFMg
         B8df7EQ5c5ATVRYIWo6py9ViEZ/c3C/fECBpvukN90WABTHKicbWeG2hLJw2RK1me/Sj
         FvClA1ssJz+sv3qxycUsjDQjckpzV3OqEN7wEcYyTl9T42VW0sMpxuVVx0k9Qu/qIY1G
         PFB7RJ01gKqR81ohebqhB+TZ+RmGG2O804JKPcDkNAn3Lypem3oWc2Zn2Fs/dF1nmvh9
         cGAJk3Y+FZB+9gGSa6RYiDbLCObod+JBFOW3zzwJWcoHRlzaLpee7MyhkesDJQCuMOL9
         vFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1xGtSn3GzgnnxnxHEMkxu4A5bFvBvCATbzs0GEZtET8=;
        b=Aa6DcjjkBtC5fiiAcrEI3YWdz06B5XK1vJNSblRU6rXG6zaJaz7K+YWPDU2X0FI8xd
         /vusVtgAR+5WDsxQrJCglxNUhA0/XKxB4BIA7Y1SxlF8HFh53EE5NkqsxbZtukZxKXTH
         chGsm1uHJIwJV9MkrqEcSOa7/LjTZ/lL8s7HEyC+b1uz+9LOsv8XIBB5J02rvwDYXNpJ
         ei3tu6KErLTPBjwZ7jAvnO9xAwT6/qmj2lxWIDUal9adNWGB1F4M8bcwOCD6BFn9K+WC
         2NiaDibTePPJU2jWYNAzSWUPVIYtEQODlegrjVEsIfLDEkdwN5q7xZ/F3RBeP2QNiWvG
         gyCA==
X-Gm-Message-State: AOAM533/bnee5Nuv3dELBowiB9XZ6e9I2BFDQ/S73UJzMdH+wzKXKlzT
        h7QAe2+S9qiM5QdXyDMWtvI=
X-Google-Smtp-Source: ABdhPJx2W29CCiPvn5uJf9cHVpmqBwFUZF7Zl/9tjYANUYzAmy7EHSWaFYfLC7lWWSDqSfSLr7Gb7g==
X-Received: by 2002:a92:cf42:: with SMTP id c2mr9952649ilr.13.1594438240262;
        Fri, 10 Jul 2020 20:30:40 -0700 (PDT)
Received: from Ryzen-9-3900X.localdomain ([107.152.99.41])
        by smtp.gmail.com with ESMTPSA id v62sm4506808ila.37.2020.07.10.20.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 20:30:39 -0700 (PDT)
Date:   Fri, 10 Jul 2020 20:30:36 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: sound/soc/codecs/zl38060.c:614:34: warning: unused variable
 'zl38_dt_ids'
Message-ID: <20200711033036.GA4486@Ryzen-9-3900X.localdomain>
References: <20200710024100.GA2055744@ubuntu-n2-xlarge-x86>
 <20200710122459.GE5653@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710122459.GE5653@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 01:24:59PM +0100, Mark Brown wrote:
> On Thu, Jul 09, 2020 at 07:41:00PM -0700, Nathan Chancellor wrote:
> 
> > When CONFIG_SND_SOC_ZL38060 is y, MODULE_DEVICE_TABLE expands to nothing
> > so zl38_dt_ids will be unused. This is a pretty common construct in the
> > kernel and the only way I can think of to resolve this through the code
> > is by adding __used annotations to all of these variables, which I think
> > is overkill for this.
> 
> > Personally, I think this warning should be downgraded to W=2, thoughts?
> 
> We've had that warning available for ever, we shouldn't need to disable
> it now.  I had thought there was supposed to be magic which caused
> of_match_ptr() to make things look referenced when !OF but don't seem to
> actually see any sign of it.  The other thing is to just have ifdefs
> around the table.

While it has been available, it's been hidden behind W=1, which is now
default on for 0day.

Sure, you could hide it behind an ifdef for either CONFIG_OF or MODULE
(since you could build this as a module with CONFIG_OF disabled).

I just figured this would be something frowned upon but if that is how
you would prefer it to be fixed, then I have no objections to it.

Cheers,
Nathan
