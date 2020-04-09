Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91923C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E652082D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586460743;
	bh=2eHWQ/4goNgPuFGvtFabW7ncIzGtyqDsPe64tABuLfQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=k3MS0LLSHCPd81Gvw6ySTrJuHzTdaN4suGydpZVp4qWVEbGsS7nUwtp+GUccpC1j9
	 PwPRf5/zDV7Tek5m5NLKgczuNti/pHZlLo/Hfm7o+Gp/tX6HrmqP9yF4FevNV/n6Hm
	 S0iSQMRq2RBaKv4yMX/tZJ80aWgXR5JZ+/ZYRJ1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgDITcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:32:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgDITcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:32:21 -0400
Received: from kicinski-fedora-PC1C0HJN (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69F4820757;
        Thu,  9 Apr 2020 19:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586460741;
        bh=2eHWQ/4goNgPuFGvtFabW7ncIzGtyqDsPe64tABuLfQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cNtxuLtIYGSMwtXWmzjBWIk0WUJ8Z7/MRAVbsF2tkTfYtlTOcqlsKK9/O64V3XkhC
         3yDXpHXx3WCBI/p59yn3wR2qqQk27rI74cfj2raq9RIH9t6LBSX3Aco7jV1BM7ZYjF
         o1VfDHy6ZpWrQeDDXYjn4bt0OMRWgYzvcUCm9P40=
Date:   Thu, 9 Apr 2020 12:32:19 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Cc:     takafumi.kubota1012@sslab.ics.keio.ac.jp, davem@davemloft.net,
        oss-drivers@netronome.com (open list:NETRONOME ETHERNET DRIVERS),
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] nfp: Fix memory leak in nfp_resource_acquire()
Message-ID: <20200409123203.1b5f6534@kicinski-fedora-PC1C0HJN>
In-Reply-To: <20200409174113.28635-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
References: <20200409150210.15488-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
        <20200409174113.28635-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Apr 2020 17:41:11 +0000 Keita Suzuki wrote:
> This patch fixes a memory leak in nfp_resource_acquire(). res->mutex is
> alllocated in nfp_resource_try_acquire(). However, when
> msleep_interruptible() or time_is_before_eq_jiffies() fails, it falls
> into err_fails path where res is freed, but res->mutex is not.
> 
> Fix this by changing call to free to nfp_resource_release().

I don't see a leak here. Maybe you could rephrase the description to
make things clearer?

AFAICS nfp_resource_try_acquire() calls nfp_cpp_mutex_free(res->mutex)
if it's about to return an error. We can only hit msleep or time check
if it returned an error.
