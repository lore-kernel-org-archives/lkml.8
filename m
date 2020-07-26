Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC24C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 15:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9820720714
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 15:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ODPvI/C2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGZPna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 11:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgGZPna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 11:43:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7E9C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 08:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YxEFDJd2LiHUJZHU0U0wj25O0MJBQkRdlwAlA8XnHA8=; b=ODPvI/C2W1BrGgNBObtCWG1xwC
        osulfr3ys4P/AQbs/gAuIRiCMrBMLJzXo9CwVEsOF5iaxywL6at1T3FrK9Yq6JJVBIasO/iZ1SI1m
        LaZi+mnearcwN1o5ze+zMT8kPeW2EdVNAMVPP2kAEeec0dgH9PTPODDGytEU58hC4AlKQJVDOSkR+
        9gYDJG3RbYJ4HDmwp29Xc6t+n3txNkGqjDqp9oB4aYzUuXa1vfCh08D4YQnHhbkQE9oRBwOGowuKO
        YRO/5mmCI3E/2SxsvXM8EovgdsYq0y7zrDzDHfkr3cXkoWIoKOW6BeYIdr4ICJyLrREeDn/VvBQyp
        ksolx8rw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzioB-000836-OQ; Sun, 26 Jul 2020 15:43:27 +0000
Date:   Sun, 26 Jul 2020 16:43:27 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        James Smart <james.smart@broadcom.com>,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-fc: nvme-fc-driver.h: drop a duplicated word
Message-ID: <20200726154327.GB30848@infradead.org>
References: <20200719003015.20745-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719003015.20745-1-rdunlap@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to nvme-5.9, thanks.
