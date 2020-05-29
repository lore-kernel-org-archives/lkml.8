Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6D1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 09:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4001F2074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 09:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590745157;
	bh=aWwiy2JJZmwgenpCaaRBwVJixnzlvtaj38u8l+RiriA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bz1crmeTGEkha6YQHP4ZRWnFE6OzauZtii9owVSTcqnG2+kWIhkOZiUO6se6G5lgu
	 MWEfGjU7rZmFHV7mPuD67hZikC+Ft/92U484Tv2kwrRhCJ9o4M6jDKS0n6X8gpcWtB
	 Q0oB/tCq51VRgbckAv/CI6Lx27KqL0P1HGk+Spo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgE2JjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 05:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2JjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 05:39:15 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EE7C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 02:39:15 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u26so6389569wmn.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 02:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jiwhIhCdI7UczGB+LUJllwDqt0eNxoEDzDHZsprEwd4=;
        b=EEMvAMJM2toHk0sX45V+7mybc50QB/jS0h7AFvHttyAXfNBwVlLwZEDjWBWG+Zrrhn
         6X/UvPLpzi9NMLZTyjan6wC9EW/mt/hfJ+iJWD/8CU2Nksw7w7Dq8dRPDF4M8AwNvJbC
         e0WnNXehytv3VtX29Q6qBJ3Sr1s3HGVJt7cbGMc9tKdU2xEfMPN2ZXQa0JPKG5+qulm9
         7Z7lRcLIJtH2GMBoI9tutjBepIqAkSdGfOM/wJ0wfZJ+LbhniozU9xCtmbvzXeIWuRgo
         vskRPJNmKH0EECGLrzMlB5sKwZRla4DDp0sGaUzcPpMOYQF5QEi7CPOrDh66n9mRinme
         xF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=jiwhIhCdI7UczGB+LUJllwDqt0eNxoEDzDHZsprEwd4=;
        b=KB3fEBSg0Rkrw/F0ZTNt3qHckBfFXng2HXaLU3FDMZJitGhazx8n/oxqCm3ZKoYsLq
         FEzyhNTY7I6lxbSv+yhNvK7XSYolohnGCxqgRnomZXgT3FutgQX19TaPlKnrwiGk6yON
         54QmBzfUZjctAzG1zMGmcoolEpPC3S4ywF95Ci+G4LLjeoH/Gqnd9w/yzFThPqCa6WPI
         5Nz19VEf8Yg57XpU1w0/FEtkoVrYUhvYK7YGlEBjTyZR3erSi0GMn5qz5n1JyERoK5Y6
         skYSp8IzhE/irOcHcL+nDKlPsisrY4p0bTE8/D7unOnh/YcKy8VYN39DlVTz0yK6AJP1
         g3fw==
X-Gm-Message-State: AOAM531qZRK1g85A1Cx5WuSCeZLBc5XlFCt+jiJueLBkK+PkRRE8pfBF
        Pfzd2QHeKP4HiaGPa8hnbkI=
X-Google-Smtp-Source: ABdhPJwkUJ233CzgKxkyuLQ8HP4dVd7D6fKAU5718M/DltXlnxfYfNwssTYFmfJfF21N7ZyjkOZFrA==
X-Received: by 2002:a1c:2183:: with SMTP id h125mr7307199wmh.112.1590745153992;
        Fri, 29 May 2020 02:39:13 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id g187sm8651055wma.17.2020.05.29.02.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 02:39:13 -0700 (PDT)
Date:   Fri, 29 May 2020 11:39:11 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [git pull] coredump infoleak fix
Message-ID: <20200529093911.GF790247@gmail.com>
References: <20200527213447.GH23230@ZenIV.linux.org.uk>
 <20200528070255.GA790247@gmail.com>
 <CAHk-=wgXqVTGA-HrzJZ_yboLrtQ4rK-qoz8AfwLV=PT7ke4fbA@mail.gmail.com>
 <20200528190555.GO23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528190555.GO23230@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Thu, May 28, 2020 at 11:34:38AM -0700, Linus Torvalds wrote:
> > On Thu, May 28, 2020 at 12:03 AM Ingo Molnar <mingo@kernel.org> wrote:
> > >
> > > I'm wondering, shouldn't we also zero-initialize the dump data to
> > > begin with? See the patch below (untested).
> > 
> > I actually got this patch from Andrew today independently due to a
> > KMSAN report. Which I'm applying.
> 
> It doesn't fix all problems, though - you don't get an infoleak, but
> you do get incorrect data...

BTW., I pulled this into x86/urgent with a potential v5.7 merge, 
although it's getting tight.

I think the ptrace impact qualifies it for v5.7?

Thanks,

	Ingo
