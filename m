Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66D0C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 14:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822EB207E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 14:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="II9TKAQ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgBCOU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 09:20:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38996 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgBCOU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 09:20:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k23CcfH9ASrLYKn7WfbNnaNUbdijVtlcHOMPFjBFcQ4=; b=II9TKAQ1U9DLf2RWWtwO8gJGuT
        zn11g5GaKb1sKNqd1LqgGThtOlNkVVZg1Q9U5F0aontkXCiHZPKlhk4p4IVzj2PAsdeqSq0PD6rYy
        bezOG/w1VsBsWwsWJIU8dBmA2L/gX5wMvB/32KULU7Vx0AkgiZ9F4DyoPUAEqZtGWESAMZ5fozSXO
        Vjleryznv8IBF+wDtJmGG4AxLJ/k7GpAe6hDWHQsfYEEiLTwkxDhx278dfi2EcvoHwZ0M/9gPFqmX
        84KRNmfupC281paiQe/RBdubpEuAqUoGhCwmSLM2hulU6rFTsD3DM8ocZ4Y7JVCS4gM4LWHz+dAVw
        9YLfP+vg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iycao-0000KH-Lm; Mon, 03 Feb 2020 14:20:50 +0000
Date:   Mon, 3 Feb 2020 06:20:50 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, will@kernel.org, oleg@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, juri.lelli@redhat.com, williams@redhat.com,
        bristot@redhat.com, longman@redhat.com, dave@stgolabs.net,
        jack@suse.com
Subject: Re: [PATCH -v2 5/7] locking/percpu-rwsem: Remove the embedded rwsem
Message-ID: <20200203142050.GA28595@infradead.org>
References: <20200131150703.194229898@infradead.org>
 <20200131151540.155211856@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131151540.155211856@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 04:07:08PM +0100, Peter Zijlstra wrote:
> @@ -53,12 +53,6 @@ struct rw_semaphore {
>  #endif
>  };
>  
> -/*
> - * Setting all bits of the owner field except bit 0 will indicate
> - * that the rwsem is writer-owned with an unknown owner.
> - */
> -#define RWSEM_OWNER_UNKNOWN	(-2L)

Can you split the removal of the non-owned resem support into a separate
patch?  I still think keeping this one and moving aio to that scheme is
a better idea than the current ad-hoc locking scheme that has all kinds
of issues.
