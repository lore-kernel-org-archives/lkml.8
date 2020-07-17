Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21E0C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79E872076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DwB7iiOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgGQLWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 07:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgGQLWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 07:22:33 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9E9C061755;
        Fri, 17 Jul 2020 04:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ScRcak3+YLnK0/Ajj7pWGryQXqgK+eh4WORPeOEWNM8=; b=DwB7iiOpiSXr/UmffzIY8qzpD/
        FXFx40H9475zT+5+zCrE27fdFyphk7NXVgAt8lhVagq6FYHucJaVeCM4AB+2q/+yJALuLQ3ToQuLk
        dS3HTxHoHBuJpHXWJWYA55A8MypGV2FG9XCH7O16BI5w0gFFJM4ngG7vydr5kuJNxEfcxTo1SWuQd
        Wjf7gcaGNTRe+8IRXjVayp+MDT4u3/Z5ewHe6Stt+5l8OuPP/diriB7VuqnJZ6dPi7iyw8NG1cxmn
        1UlwEds/dza2F7FCpqjMmUI3RSYYusNqstH2yXhc39CLXf7tIoRVFlh/JSdAeNGuwDFe/9hjBplGn
        EsZoVHDw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwORW-0003Ms-0y; Fri, 17 Jul 2020 11:22:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7D888307488;
        Fri, 17 Jul 2020 13:22:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1C662203D4090; Fri, 17 Jul 2020 13:22:16 +0200 (CEST)
Date:   Fri, 17 Jul 2020 13:22:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>
Cc:     linux-arch@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Burton <paulburton@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Richard Henderson <rth@twiddle.net>,
        Nick Hu <nickhu@andestech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 00/11] Fixup page directory freeing
Message-ID: <20200717112216.GI10769@hirez.programming.kicks-ass.net>
References: <20200717111005.024867618@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717111005.024867618@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 01:10:05PM +0200, Peter Zijlstra wrote:
> Hi All,
> 
> While fixing a silly bug on SH (patch #1), I realized that even with the
> trivial patch to restore prior behaviour, page directory freeing was still
> broken.

*sigh*, I got patches 1 and 2 in the 'wrong' order.
