Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD09C433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 04:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF09820709
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 04:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c88WkDd9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgIBEWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 00:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgIBEWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 00:22:33 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CF4C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 21:22:33 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id d27so2692787qtg.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 21:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=l6CoZr0F56z7vGGkZxHqFEtyYx6mlMWzZpAv9vqAiw4=;
        b=c88WkDd917M/cYNeWf6xj5kM/aoxt59h5QaRarY1afOxjFbA0eX22XVA1VEXfl+YrU
         thRAmHc27PJHXMbo8K+BLvv1punKWheQh8saPbtzDwSc+KBpmJOnFh7RaD8gp8AvVRbe
         0aTjWL9rQHFK6+dHFunm1JSGcAR3UofL7UOg7wZYQC0LzYnvKAzuPwFRsCSVGhmwhGMQ
         HDWW4O4ertLL+H1dJ7mJ1+e96L4RGYn+WbNsGTvX08jPsFkgpVYO0r0S1aizowMwYrq3
         98RkENlEz7pz4ZIHuceXZzejLdMk2YW8xuzIDXiV9XWUrB7wa6coMsv/OvT5iTGCVs9a
         etcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=l6CoZr0F56z7vGGkZxHqFEtyYx6mlMWzZpAv9vqAiw4=;
        b=AeaIXjZ8xAB7fDMe7xBNSzUaq65DqhsNe2wVQagVnFwJBxt57AEBPcJQEu8t7TRfAv
         l7Pz+Fz/R6V7v6JAjbs0azzsKVklWutSPgIruknZmCE3hiZOF7LvhrL8hFNpEWS2pmjR
         JZtBZXQxtLYHGqdjNerXNdqYaPPSJckQfvXcXowekIPfbS2Sw1r6z/z6JAeyBi/FldWA
         nvOXVw1N49f9P1dXRC8AR/BtG/wkuepETDeG2OY2R7YPVp36reD+21uF1BbkHip4thZ9
         rM+Ov5DrQrHBfGfJo71zrcc9LJqukV6bAZ5OGTiS7NMcTGncEXTPZVUaYYVbmFLaOA6t
         mBBQ==
X-Gm-Message-State: AOAM531KOqiigU44VQP4Z5XrtWsEio+pCALJig8DVDRp31aeye2/BuJz
        00WnJJ54pfIFTZ0DirtOGAXwow==
X-Google-Smtp-Source: ABdhPJzO5rHQSMIPY+MB7qZqgOe07fSWudlq7dmfuf95lwRcrcmvio431Y34HI57agV+U+pSvrMCgA==
X-Received: by 2002:ac8:6f0d:: with SMTP id g13mr5321304qtv.236.1599020551923;
        Tue, 01 Sep 2020 21:22:31 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k185sm3916005qkd.94.2020.09.01.21.22.29
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 01 Sep 2020 21:22:30 -0700 (PDT)
Date:   Tue, 1 Sep 2020 21:22:09 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Byron Stanoszek <gandalf@winds.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Chris Down <chris@chrisdown.name>
Subject: Re: [PATCH] tmpfs: Restore functionality of nr_inodes=0
In-Reply-To: <20200902035715.16414-1-gandalf@winds.org>
Message-ID: <alpine.LSU.2.11.2009012109030.5519@eggly.anvils>
References: <20200902035715.16414-1-gandalf@winds.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Sep 2020, Byron Stanoszek wrote:

> Commit e809d5f0b5c9 ("tmpfs: per-superblock i_ino support") made changes to
> shmem_reserve_inode() in mm/shmem.c, however the original test for
> (sbinfo->max_inodes) got dropped. This causes mounting tmpfs with option
> nr_inodes=0 to fail:
> 
>   # mount -ttmpfs -onr_inodes=0 none /ext0
>   mount: /ext0: mount(2) system call failed: Cannot allocate memory.
> 
> This patch restores the nr_inodes=0 functionality.
> 
> Fixes: e809d5f0b5c9 ("tmpfs: per-superblock i_ino support")
> Cc: Chris Down <chris@chrisdown.name>
> Signed-off-by: Byron Stanoszek <gandalf@winds.org>

Yikes, thank you Byron, very bad of me not to have spotted that:

Acked-by: Hugh Dickins <hughd@google.com>

I've taken a quick look to see how I missed it: yes, I'd compared
against my own tree, knew I had to come back here sometime to replace
the SB_KERNMOUNT test by a max_inodes test like I had, to restore the
performance of nr_inodes=0; but thought the SB_KERNMOUNT test was good
enough for now - without realizing the effect on the code below it. The
error does seem to be localized just to this block, yes.  Many thanks.

> ---
>  mm/shmem.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 271548ca20f3..8e2b35ba93ad 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -279,11 +279,13 @@ static int shmem_reserve_inode(struct super_block *sb, ino_t *inop)
>  
>  	if (!(sb->s_flags & SB_KERNMOUNT)) {
>  		spin_lock(&sbinfo->stat_lock);
> -		if (!sbinfo->free_inodes) {
> -			spin_unlock(&sbinfo->stat_lock);
> -			return -ENOSPC;
> +		if (sbinfo->max_inodes) {
> +			if (!sbinfo->free_inodes) {
> +				spin_unlock(&sbinfo->stat_lock);
> +				return -ENOSPC;
> +			}
> +			sbinfo->free_inodes--;
>  		}
> -		sbinfo->free_inodes--;
>  		if (inop) {
>  			ino = sbinfo->next_ino++;
>  			if (unlikely(is_zero_ino(ino)))
> -- 
> 2.28.0
