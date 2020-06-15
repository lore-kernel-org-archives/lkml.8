Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DA1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3673E20714
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GQO48Y7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgFOHZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:25:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51544 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728521AbgFOHZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592205937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XHwguCxo4c2cVMancqpzmFcNo1EaIuQKAA2ekR4KvOU=;
        b=GQO48Y7H7OSovPkuta2dq3dwywWCrC8ONAWgnO27bRXRI4RgPL1xMIP/NFpUrfJ5KdgOJl
        aB8txB4F/GnxkeibxyfTulA7sCmyq7mX1/NoRmKXFJyGcLFbwz64xiLiAYSYcXsX5q25ER
        r5EBjun6FYdnezmz0P3VnQIIk2Wr1wk=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-PB54_YscNOuJ6zh8S2pVrw-1; Mon, 15 Jun 2020 03:25:34 -0400
X-MC-Unique: PB54_YscNOuJ6zh8S2pVrw-1
Received: by mail-pf1-f198.google.com with SMTP id m11so12513420pfh.22
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 00:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XHwguCxo4c2cVMancqpzmFcNo1EaIuQKAA2ekR4KvOU=;
        b=oBtD8mFLtCKQ1+DdK3hLs+u9oo7KjXeHbEocN+zEyYsUzuRASKYHIK3KOhJ9C6uIcZ
         8qnRQ/zxyqQqtYY1cehaabTVqlHoU5SNh0RmYQeWMqpY90NYE0EAHLb/o7sJzWIWXtNc
         GI3GDCiMKDJmzKkcCrln16b5gxu8phd6SN8/Aw4XV6haLgXFEnGuWava/FQBzetT5QV6
         GFzErjG7Qa5xXWzue0/kl67pJuGsopVJXGRsPmCHNystM0oQnChcukgtnToAcVJ63HhP
         8cnm2nYkewb6Fu+J9UzT/XPkm4qF/zDB/UVw0i/3o0nd8udoDZitRFFMK14wq+vkDeOI
         4tkA==
X-Gm-Message-State: AOAM533tWjv7oV/4VXW0bco5wxoh9dy6qpodJ1sIm63ELiw07fX/zv1+
        TKbtvx7tl4o7aZiescyCe4t91pCDMVt/8E5woNf1Up4XAVS3Ejl9XLMvYd6cMziVMFJgKv2IB4D
        3eDSdItHeCmSzQtqi8bqwzkEh
X-Received: by 2002:a62:7ccb:: with SMTP id x194mr23171903pfc.318.1592205933331;
        Mon, 15 Jun 2020 00:25:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYaTupNZjWJqlIUP4l94FShAOlauozvMBU4WlPvbNTKjhwYoirQ+2pYQeFVKE9wK3gIS1IOw==
X-Received: by 2002:a62:7ccb:: with SMTP id x194mr23171888pfc.318.1592205933006;
        Mon, 15 Jun 2020 00:25:33 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id mw5sm13015199pjb.27.2020.06.15.00.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 00:25:32 -0700 (PDT)
Date:   Mon, 15 Jun 2020 15:25:21 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     xiang@kernel.org, chao@kernel.org, gregkh@linuxfoundation.org,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH] erofs: Eliminate usage of uninitialized_var() macro
Message-ID: <20200615072521.GA25317@xiangao.remote.csb>
References: <20200615040141.3627746-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615040141.3627746-1-yanaijie@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Mon, Jun 15, 2020 at 12:01:41PM +0800, Jason Yan wrote:
> This is an effort to eliminate the uninitialized_var() macro[1].
> 
> The use of this macro is the wrong solution because it forces off ANY
> analysis by the compiler for a given variable. It even masks "unused
> variable" warnings.
> 
> Quoted from Linus[2]:
> 
> "It's a horrible thing to use, in that it adds extra cruft to the
> source code, and then shuts up a compiler warning (even the _reliable_
> warnings from gcc)."
> 
> The gcc option "-Wmaybe-uninitialized" has been disabled and this change
> will not produce any warnnings even with "make W=1".
> 
> [1] https://github.com/KSPP/linux/issues/81
> [2] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---

I'm fine with the patch since "-Wmaybe-uninitialized" has been disabled and
I've also asked Kees for it in private previously.

I still remembered that Kees sent out a treewide patch. Sorry about that
I don't catch up it... But what is wrong with the original patchset?

Thanks,
Gao Xiang

