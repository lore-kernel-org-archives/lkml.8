Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D072C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DEAF20771
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M1f7WYXv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgHMLmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 07:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgHMLk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 07:40:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B250BC061757;
        Thu, 13 Aug 2020 04:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2DtpeNiIF6S/B3g+Kt5wUDgMBKVuFkosm757FNhgE1A=; b=M1f7WYXvppktqa9ZEJqZQXmJpI
        nWu1Csk9GhX1CtV5cvYEJLOo8ChGp77nDsOHCcJKT0Jh5QV34M25cdhhxaAKdnDr7mAr480EC43XI
        9u+QgduTuSIMLKuOyYrOoCoVdhDH0KTAaHewOHXoutZ6kvy56QTN4C6jAOSOt2LTckyPQLq+CDnJY
        rrHz6/AKg7/tmBA9F/t1npfuFaFSPiMHfz4cJUo+mGvFvZ0SSw1A0cx2dmuCcPeXU45rdCpYnY4Qp
        3jHOwqPVNaFlnM2/UWdAQa/Y6/SCW7lY7U4/WBfNG/HCNY6vrJ+jCgk85/e0Er05EkZWyuWVuFZCx
        Kn0V7eew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6BbH-0002Qu-QI; Thu, 13 Aug 2020 11:40:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A20343003E5;
        Thu, 13 Aug 2020 13:40:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E30F2C217FE7; Thu, 13 Aug 2020 13:40:50 +0200 (CEST)
Date:   Thu, 13 Aug 2020 13:40:50 +0200
From:   peterz@infradead.org
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jacob Wen <jian.w.wen@oracle.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: insert a general SMP memory barrier before
 wake_up_bit()
Message-ID: <20200813114050.GW2674@hirez.programming.kicks-ass.net>
References: <20200813024438.13170-1-jian.w.wen@oracle.com>
 <20200813073115.GA15436@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813073115.GA15436@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 08:31:15AM +0100, Christoph Hellwig wrote:
> On Thu, Aug 13, 2020 at 10:44:38AM +0800, Jacob Wen wrote:
> > wake_up_bit() uses waitqueue_active() that needs the explicit smp_mb().
> 
> Sounds like the barrier should go into wake_up_bit then..

Oh, thanks for reminding me..

https://lkml.kernel.org/r/20190624165012.GH3436@hirez.programming.kicks-ass.net

I'll try and get back to that.


