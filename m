Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDDDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6188B206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dU+8SVFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbgGMOG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbgGMOG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:06:28 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40937C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:06:28 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g75so13426842wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AYBT93/x6rrYq9RPd2K35aqbqlGYbFacLRXNWsdWgbc=;
        b=dU+8SVFwmJ267v2437oNfANVH0w+KtdmF9nlS2MFnrlicHxPWJba+nGK3mBC1/TMue
         lfjmeyk2ndOV4n+34k+r2FM1693H8W0za4PmgmOmiWm+EdpE+ewUND7/X4bUSYs0ourB
         sqAPho5W/cEVWxjkjy1ueK9vvnSrtfhsSw9XN8adimyJbzDhXoeREA+KQUXb4NAeSnCn
         Nuhn4lgVc9NCG2mO9w/SJu8mWyOHAM+C6WZce27gosSNTyOf16LEN+e/ST1rlpK3C69D
         F4x+M67cw1w8E3e+JyVfa3WjN8acPOkjrWhuqpJ2O0XXkiVWNhPBjWmN0RztZYtp34Vc
         WnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AYBT93/x6rrYq9RPd2K35aqbqlGYbFacLRXNWsdWgbc=;
        b=iKolf61+WU1g8lfhxaTfbvuIKGpoGvHO4lMgnuTu1yA6WLZnCVho1OAANB9HcY9eFJ
         kMBorLD70qZrsrZpMb0Ij5AtRrTMKlWC0PzmYEuUETEMBzmGRtSNvcwgYjHcN4zjtWN2
         tRDyKKKU3R29v+Mvh6ZFbMGZVudYtvvkXwYfkSnqhgVT8+NllFZmW5Jj2F+Jfg/pUyg3
         yGYn/roC1KXaY7NSfogt2fSo+WRUKVaT8LcL6lRsNAaTarVaLaLEdKTT+BARbMWEtVaU
         ffgDEVF/eHBFcyzCKzGntvQjMPCQm2CCqQHVV8njG6wZxHZk+VZBCTnwADrNueDB1TCr
         9jYg==
X-Gm-Message-State: AOAM531K7OLs04VnBZ2KHdHUII5CqqDUT9HcZqwWwOY6g+sLSfpSBmyN
        dKxZsm1O/XF+plUmIfZ8/A==
X-Google-Smtp-Source: ABdhPJz3OFpkcawfZxoAkzyzpvPTTaS800Rls2LKkpXfbGS8hiN+ULKhhCWMIwYbyBMRLsJTLf4Qdg==
X-Received: by 2002:a1c:80d3:: with SMTP id b202mr120710wmd.111.1594649186814;
        Mon, 13 Jul 2020 07:06:26 -0700 (PDT)
Received: from localhost.localdomain ([46.53.252.34])
        by smtp.gmail.com with ESMTPSA id 51sm25807572wrc.44.2020.07.13.07.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 07:06:25 -0700 (PDT)
Date:   Mon, 13 Jul 2020 17:06:24 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, will@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rwsem: fix commas in initialisation
Message-ID: <20200713140624.GA17904@localhost.localdomain>
References: <20200711145954.GA1178171@localhost.localdomain>
 <20200713115141.GH10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200713115141.GH10769@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 01:51:41PM +0200, Peter Zijlstra wrote:
> On Sat, Jul 11, 2020 at 05:59:54PM +0300, Alexey Dobriyan wrote:
> > Leading comma prevents arbitrary reordering of initialisation clauses.
> > The whole point of C99 initialisation is to allow any such reordering.
> 
> I'm conflicted on this argument, the only reason I'd be inclined to take
> this patch is that it allows fixing the initialization order to not be
> random.

Yes, this is how the issue was noticed.

> That is, I'd fold in the below.
> 
> --- a/include/linux/rwsem.h
> +++ b/include/linux/rwsem.h
> @@ -89,9 +89,9 @@ static inline int rwsem_is_locked(struct
>  #define __RWSEM_INITIALIZER(name)				\
>  	{ __RWSEM_INIT_COUNT(name),				\
>  	  .owner = ATOMIC_LONG_INIT(0),				\
> -	  .wait_list = LIST_HEAD_INIT((name).wait_list),	\
> -	  .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(name.wait_lock),\
>  	  __RWSEM_OPT_INIT(name)				\
> +	  .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(name.wait_lock),\
> +	  .wait_list = LIST_HEAD_INIT((name).wait_list),	\

One less chunk to compile with g++, a billion to go :^)
