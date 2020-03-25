Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C04C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC6A20714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ey+7y/nx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbgCYIjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:39:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50222 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgCYIjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Ey+7y/nxZ2WWmjmT57f3uPrig9
        jYI2eM3OAsgmkgsBsDdeDxsxstJ7/gy/jIB9foe/qmishct+0T8v5dHwVu98grQ5PZw+/+p9mgiY5
        DUxPUt6Nf16F742bqkjp6LUL6jqimrSu20ZMCAV8pTyFu7axV1meA/IqLgTfb/3+TRJR2U1D60Jkv
        cLzFyeh6kxUagxus96O7yepOFrQ63JmuSH6MYxx3vAM/oSiaIvMuX29v2y9ra65z4UzuDfYZQwom5
        yXop2f6h27wzOTNpQQKaGhuhg9cXcuDFsUwZDYmGzxurvZs0ksJnc5CjgHMW5Al0fyW7nplfkQH79
        9YWBgM9g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH1Yv-0005sI-3a; Wed, 25 Mar 2020 08:38:57 +0000
Date:   Wed, 25 Mar 2020 01:38:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Salman Qazi <sqazi@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] bdev: Reduce time holding bd_mutex in sync in
 blkdev_close()
Message-ID: <20200325083857.GA11943@infradead.org>
References: <20200324144754.v2.1.I9df0264e151a740be292ad3ee3825f31b5997776@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324144754.v2.1.I9df0264e151a740be292ad3ee3825f31b5997776@changeid>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
