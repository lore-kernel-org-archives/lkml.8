Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAF4C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 14:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6C824653
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 14:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hNjIz9F/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgAUOmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 09:42:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52906 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgAUOmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 09:42:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LYJn9+5CbWSB4FBZhh3YoGzq2rmbDVPtAhqCEt95EvU=; b=hNjIz9F/QmBXSj74UtIYdAlFN
        7eASKNLLIFcYl5vjZI6vkrBPfDUCVBNgLut2EhZNOKEuBmmDeYCd6bvAKqdmrEVyAA/th/d9igh5b
        zNfK5siY2xQCCwiHoAvkMMy6SU6oknLhlo1/YCj5OW0hH3yOyb89RGrPukkuzWsKARavGysszBbNz
        cpUVR/tGezXeoGd6RtIqypE9rFpCUdgu1vLv9eAdAkxU0UEIrhkRMHaSpn65HXYrKXcK65e2P0+1v
        /lDGqboPDBM28BTjC0y6oweDFTIV8XhFFuaa++jS0qJqEsXUHNaRsX9OsnktpdPBREoVr9XiR1ATu
        zGTqYuwQw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itujf-0003Rf-BK; Tue, 21 Jan 2020 14:42:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 300B5300B8D;
        Tue, 21 Jan 2020 15:40:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5DCF92B6F0C48; Tue, 21 Jan 2020 15:42:29 +0100 (CET)
Date:   Tue, 21 Jan 2020 15:42:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
Subject: Re: [PATCH v8 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20200121144229.GN14914@hirez.programming.kicks-ass.net>
References: <20191230194042.67789-1-alex.kogan@oracle.com>
 <20191230194042.67789-4-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230194042.67789-4-alex.kogan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 02:40:40PM -0500, Alex Kogan wrote:
> +#define pv_wait_head_or_lock		cna_pre_scan

Also inconsitent naming.

> +__always_inline u32 cna_pre_scan(struct qspinlock *lock,
> +				  struct mcs_spinlock *node)
> +{
> +	struct cna_node *cn = (struct cna_node *)node;
> +
> +	cn->pre_scan_result = cna_scan_main_queue(node, node);
> +
> +	return 0;
> +}

The thinking here is that we're trying to make use of the time otherwise
spend spinning on atomic_cond_read_acquire(), to search for a potential
unlock candidate?

Surely that deserves a comment.
