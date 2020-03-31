Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C445C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C44206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="adQNgq7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730664AbgCaQxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:53:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44074 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbgCaQxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M1mhR07HOZla69RsrkO44Gxk+Z9xDcXnvMT8lsqIgFA=; b=adQNgq7gEiRGU9IPa56cqgpMB6
        htVSrYehe9zCxoqLcibx9qSYcQeyX7LGk7oneigtNMVkZRdAEB4JgYFDAHnqysNFblGTPrQQYCf9y
        UYF8C02ttlNL4GRSXpIr5VPThvuvxNXVD350fdIXI/64Vn1igeiyrenN/MRMQrcOPX/88Lrxi8jaG
        QfkVig+Kpriw5UlmZnmaJC39Xos73ELVcNiF3AhmC12UNUUDUcl1kVTLx/jnGuvvhCrWLyRkoLhK9
        KO2w/QwkXXTUzM4E9/O+KO/LHs3SSrnZuCK20PSydgACQ5F9kcN6SRLP+dO0Nav8ZyVQn907k4P4P
        sk1IthpA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJK8a-0006NO-4E; Tue, 31 Mar 2020 16:53:16 +0000
Date:   Tue, 31 Mar 2020 09:53:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     mporter@kernel.crashing.org, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, alistair@popple.id.au,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/44x: Make AKEBONO depends on NET
Message-ID: <20200331165316.GA6380@infradead.org>
References: <20200330143153.32800-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330143153.32800-1-yuehaibing@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Why would a board select a network driver?  That is what defconfig
files are for!  I thin kthe select should just go away.
