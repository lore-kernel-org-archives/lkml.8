Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9186C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 02:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE129207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 02:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Hy0FHAYU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgHUCaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 22:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgHUCaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 22:30:01 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D07C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 19:30:01 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id s23so304791qtq.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 19:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kxixIM+JhLr4CA8HoqUsdWcGyULPAwA0w4kNHnnJn1A=;
        b=Hy0FHAYUHwZ20oV/pOQJKKBU/OvKWEerzQKj4850mMN+V8CMFEY07rnnnedLyrYg0q
         m9/0gdjXPSdQsuDetvtAohK+SMRVE5G1bPDUYnV4BHQnCREgi5W3NZG6rT4+NxdyhaXa
         Go0MySOwOkMLpRObZ2cHK8IxFpi7+ppMjR6otFAeFWnKbxMrB6jryIunkhMVPBT9lXLp
         MCwomPdTJmX3lGnRTzt5HGdX3v7erA2+bSqjmouDm+98Lc2EPGw9wecO+qG2FBezKsjT
         aSaCMJfGFmh6jC51FSn2wQGcOYoI9IYtmACMK111rR3mC0WEC2eM1UWssM0VG2rWVZH4
         BaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kxixIM+JhLr4CA8HoqUsdWcGyULPAwA0w4kNHnnJn1A=;
        b=dv9A8Z4CRL6AznhBuab3dIcjlJtZQ0N/wcq8Y9pRfpMqG/uSwL02e3B8w/pcp+cxHF
         zzhcX/36G6Ep7uGIjc64qq/DHPDUWjKZ5GuJR1CGLVufhl7qmVgBdTycVIzZEwWyQhV/
         geNPeh6cXzfBSlCPlyjASmjihsfgCymtAF8m5929GrbzDkzQzzswX7jeQfiQ8Dh/dAV8
         lz3c2Iwx2l2v2bfiCUV3wkjFB9L83D0kUrv3ms4A6O/S6qaUFW2MrzDPEPstlnDOWeDd
         wr1XzTUl2FGpxyjrMVMr9Lbzswq28d5gCUHXo96h68RWnEpNVJbYVpe0AiZxGe1NgUoa
         SMDA==
X-Gm-Message-State: AOAM532prGr6VQdWOqi0CwME5rXqvz2UmozVM/07bkdbWnm0aPJjQ45Q
        2zsjY7khRf7e2J1bRqK6qqU2KWzOx1gvlA==
X-Google-Smtp-Source: ABdhPJwTx3iY7/ab8qofgNfAWK9Ql8cOfkmPqJ/mN8c915NdD76pU1z71GEvNiwPtSt3Yyp+MBSfHQ==
X-Received: by 2002:ac8:6f62:: with SMTP id u2mr700661qtv.155.1597977000492;
        Thu, 20 Aug 2020 19:30:00 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id q34sm637000qtk.32.2020.08.20.19.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 19:29:59 -0700 (PDT)
Date:   Thu, 20 Aug 2020 22:29:57 -0400
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        oleg@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] mm/kmemleak: rely on rcu for task stack scanning
Message-ID: <20200821022955.GD4622@lca.pw>
References: <20200820203902.11308-1-dave@stgolabs.net>
 <20200821002554.GB4622@lca.pw>
 <20200821012750.qxiklfhuaryajvhn@linux-p48b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821012750.qxiklfhuaryajvhn@linux-p48b>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 06:27:50PM -0700, Davidlohr Bueso wrote:
> On Thu, 20 Aug 2020, Qian Cai wrote:
> 
> > On Thu, Aug 20, 2020 at 01:39:02PM -0700, Davidlohr Bueso wrote:
> > > kmemleak_scan() currently relies on the big tasklist_lock
> > > hammer to stabilize iterating through the tasklist. Instead,
> > > this patch proposes simply using rcu along with the rcu-safe
> > > for_each_process_thread flavor (without changing scan semantics),
> > > which doesn't make use of next_thread/p->thread_group and thus
> > > cannot race with exit. Furthermore, any races with fork()
> > > and not seeing the new child should be benign as it's not
> > > running yet and can also be detected by the next scan.
> > 
> > It is not entirely clear to me what problem the patch is trying to solve. If
> > this is about performance, we will probably need some number.
> 
> So in this case avoiding the tasklist_lock could prove beneficial for performance
> considering the scan operation is done periodically. I have seen improvements
> of 30%-ish when doing similar replacements on very pathological microbenchmarks
> (ie stressing get/setpriority(2)).
> 
> However my main motivation is that it's one less user of the global lock,
> something that Linus has long time wanted to see gone eventually (if ever)
> even if the traditional fairness issues has been dealt with now with qrwlocks.
> Of course this is a very long ways ahead. This patch also kills another user
> of the deprecated tsk->thread_group.

This makes thing clearer.

Reviewed-by: Qian Cai <cai@lca.pw>
