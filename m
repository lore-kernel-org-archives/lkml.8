Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AE8C35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCDEA2070E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s0H5pn8L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgA2LyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 06:54:19 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48814 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgA2LyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 06:54:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=viw1pgj3UogsAw7+u8jcwAXIxlZhoRVAlbBEaKmYHEU=; b=s0H5pn8LMLr3Yl8gUeu9meC/1
        WRCEk1qrwxaD1fHKE7U6YRLPuCG58IQOfu0ez1ToL5tQkebQOpKBQA4LPoYSrJp0iufVoGx5uUlpr
        xqGADIDLQLJbb/MHTDknT1jABwkt2CwVfz9cvuZZyJoHifT6MwwXOS8+SdhtRsmQnO+hjy+9xjROf
        3vyzeq4a4vfiuL0D+MVvjLal7S05D+xDj0ik1xz/iW61xt4wAafJ+V5M3TFZB7NnkviyHRUwaxsZf
        R+pQwEHXcHMy92Hb4MjgKbsWawX6vy8/9FfRD8fntHvrxC8Q/Xthpya/SySmTRGupBoBuoiVgZO3m
        kKhPCgjNQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwlvD-0001xz-PJ; Wed, 29 Jan 2020 11:54:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DD7FF30607E;
        Wed, 29 Jan 2020 12:52:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AD1562B2E7F22; Wed, 29 Jan 2020 12:54:12 +0100 (CET)
Date:   Wed, 29 Jan 2020 12:54:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [PATCH 0/5] Rewrite Motorola MMU page-table layout
Message-ID: <20200129115412.GN14914@hirez.programming.kicks-ass.net>
References: <20200129103941.304769381@infradead.org>
 <bbdb9596-583e-5d26-ac1c-4775440059b9@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbdb9596-583e-5d26-ac1c-4775440059b9@physik.fu-berlin.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 11:49:13AM +0100, John Paul Adrian Glaubitz wrote:

> > [1] https://wiki.debian.org/M68k/QemuSystemM68k

Now, if only debian would actually ship that :/

AFAICT that emulates a q800 which is another 68040 and should thus not
differ from ARAnyM.

I'm fairly confident in the 040 bits, it's the 020/030 things that need
coverage.
