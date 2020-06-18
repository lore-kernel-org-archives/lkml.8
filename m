Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0E3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83F1021548
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PvkwbgCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgFRHbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 03:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbgFRHbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 03:31:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9573CC06174E;
        Thu, 18 Jun 2020 00:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v4L6lZAkHTyhV+SZ3KGpRIcwEK4RMYkpNqGr2+ga4y4=; b=PvkwbgCIgfcMjIcJ4dCi5DLmFY
        CRgaNHRHtbyiqTs7WZMKE5MxNNvBa50xa9jqmeAcL2/6ny5HOoNW5ZaLLHwR3gOhAleFwsvdiiibI
        jaHmM9hx73qfkx9kueMZUxJxEIHWkjngFvcf8Jkw+npS/ulMCJ4XMHdgZczy9QxUOLsfmPlMcX7GX
        lBsK5lymCAwsoWDqO9RPyZBc+Xcj9K2QkWFqANQi2C5KeT1YqCifoBU7oNWTH6JiK6WGcB04ViL86
        3wFWmMVo2cYOwAJZ9HgWCXmiRYyqQTYcAWMuboDsNXtjG8EEqZm0z8ysMQ0yPHRyPdIKzvH7nZWeT
        QqX2K5jw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlp0j-0000lN-97; Thu, 18 Jun 2020 07:30:57 +0000
Date:   Thu, 18 Jun 2020 00:30:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Tetsuhiro Kohada <kohada.t2@gmail.com>
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2 v3] exfat: write multiple sectors at once
Message-ID: <20200618073057.GA24032@infradead.org>
References: <20200618011205.1406-1-kohada.t2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618011205.1406-1-kohada.t2@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	for (i = 0; i < es->num_bh; i++)
> +		err ? bforget(es->bh[i]):brelse(es->bh[i]);

Please use a good old if / else instead of obsfucating the code.
Also even without that this seems to be missing a few whitespaces.
