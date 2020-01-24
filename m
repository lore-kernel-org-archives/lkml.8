Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA11C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423C1206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579877240;
	bh=2K3H22Cu7erJApBK93Dt0/rmgQyNpf1MKs/i95/mmFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qIOjo4oNsufEwYqNqgs7b27QgDMYo/wcKyVecmcHpyoqq0MFjEKl18omHt1S/WqgL
	 sMqg45JngtuxK8eLqFGps000FMbLrOTDaOh0+1rcAd1qkUj45OT4P3EwV1Y1lSBnPb
	 m3myot8FPBSa9IvzN04KYnKOS0eAAB4lCO05d5v0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389897AbgAXOrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:47:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42053 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389447AbgAXOqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:46:46 -0500
Received: by mail-wr1-f65.google.com with SMTP id q6so2269658wro.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 06:46:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d7nho88btA7XdPKueW+DP7zXBwkgUh/Agx/c+r7pFKg=;
        b=DTZylmCwg5vELLX/se29ZL5QefwWb5Pxqp3i8o0pxcrnW6Rmr2QhZqBoxDKMEiH/IE
         IKZLYSJu28s/9NTqow02DckxtvnaagJUEXB6PuKkW282rAlFdRRFvq9/Qx0neQJKLOV7
         qDsHerItTkCbURWEkgYKLaH5ArIj2G6cvEiXEB/IC1YZDjFZoIKwub/ugp0coYZ3rGuL
         +pNdvEP7Uu7veTffsrxb+YFoEW3ggTMhIQ/8o2AIDoR1NL3KM5N+iqDcIex2OE2FVkdr
         ZwL4lEIzeNTfnDQwlk8j80abWODr5VhmgQ9psmG/oNXgBH5lM/WxFPsfVKDPu+5rNIPN
         /QVQ==
X-Gm-Message-State: APjAAAUJxIZk+cIcEaqBkDXt97480Jr74iNVox6/7QgWbQXBgrsOjOId
        fGMEDXsGvWWuN32TmAboHBIL4guz
X-Google-Smtp-Source: APXvYqwy13C+hrb5rggN5Fl0X/KO2iHGJRZqQvDZIaU7Uvx2HYIxOl4AtUirvS8iwnXAGM3sw4j40A==
X-Received: by 2002:a5d:44ca:: with SMTP id z10mr4758194wrr.266.1579877204963;
        Fri, 24 Jan 2020 06:46:44 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id b128sm7032226wmb.25.2020.01.24.06.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:46:44 -0800 (PST)
Date:   Fri, 24 Jan 2020 15:46:43 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, yang.shi@linux.alibaba.com,
        jhubbard@nvidia.com, vbabka@suse.cz, cl@linux.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] mm/migrate.c: also overwrite error when it is bigger
 than zero
Message-ID: <20200124144643.GV29276@dhcp22.suse.cz>
References: <20200119065753.21694-1-richardw.yang@linux.intel.com>
 <20200124072127.GO29276@dhcp22.suse.cz>
 <20200124141538.GA12509@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124141538.GA12509@richard>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 24-01-20 22:15:38, Wei Yang wrote:
> On Fri, Jan 24, 2020 at 08:21:27AM +0100, Michal Hocko wrote:
> >[Sorry I have missed this patch previously]
> >
> 
> No problem, thanks for your comment.
> 
> >On Sun 19-01-20 14:57:53, Wei Yang wrote:
> >> If we get here after successfully adding page to list, err would be
> >> 1 to indicate the page is queued in the list.
> >> 
> >> Current code has two problems:
> >> 
> >>   * on success, 0 is not returned
> >>   * on error, if add_page_for_migratioin() return 1, and the following err1
> >>     from do_move_pages_to_node() is set, the err1 is not returned since err
> >>     is 1
> >
> >This made my really scratch my head to grasp. So essentially err > 0
> >will happen when we reach the end of the loop and rely on the
> >out_flush flushing to migrate the batch. Then err contains the
> >add_page_for_migratioin return value. And that would leak to the
> >userspace.
> >
> >What would you say about the following wording instead?
> >"
> >out_flush part of do_pages_move is responsible for migrating the last
> >batch that accumulated while processing the input in the loop.
> >do_move_pages_to_node return value is supposed to override any
> >preexisting error (e.g. when the user input is garbage) but the current
> 
> I am afraid I have a different understanding here.
> 
> If we jump to out_flush on the test of node_isset(), err is -EACCESS. Current
> logic would return this instead of the error from do_move_pages_to_node().
> Seems we don't override -EACCESS.

And this is the expected logic. The unexpected behavior is the one you
have fixed by this patch because err = 1 wouldn't get overriden and that
should have been.
-- 
Michal Hocko
SUSE Labs
