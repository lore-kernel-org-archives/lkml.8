Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFA1C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 12:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E54D20716
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 12:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="chj7OOUV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730167AbgC3MuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 08:50:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37910 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729995AbgC3MuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 08:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tbFlFP+N6juld/DZ+YupWfUv8ZdRpquH02jWIBxGg94=; b=chj7OOUVG8wxZIg1nEZOI30ci3
        QzlvUHWyqpnvp8ACkeVWs2QRlWfJa/Rg+Mfm6FzOtjuH0raKgGu2c/1MVbtoPMy2576bvkWm7SKUS
        pXIveaSvL1WzZj7O9KlrMwFBi1N4uAoUXxdStSzxLzc5uf241rrn9Bf0/8BtloVSMynCvJns1nKu6
        X4bHKt7z/pf7hQhaE21d87/v2U4oyvjCR67R6OciGmJ+Hesq2VHigCrvnNreIJKTAwDNg7hg8EtHM
        93/+0joHwGGLjrcLDLMvEpBWjhHj8KSnXARwYG3x2oLbKXIjYdrMxTg25HNnX4CHUwiyhxRve3kx4
        9BRYNbtQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jItri-000390-QV; Mon, 30 Mar 2020 12:50:06 +0000
Date:   Mon, 30 Mar 2020 05:50:06 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] XArray: internal node is a xa_node when it is bigger
 than XA_ZERO_ENTRY
Message-ID: <20200330125006.GZ22483@bombadil.infradead.org>
References: <20200330123643.17120-1-richard.weiyang@gmail.com>
 <20200330123643.17120-7-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330123643.17120-7-richard.weiyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 12:36:40PM +0000, Wei Yang wrote:
> As the comment mentioned, we reserved several ranges of internal node
> for tree maintenance, 0-62, 256, 257. This means a node bigger than
> XA_ZERO_ENTRY is a normal node.
> 
> The checked on XA_ZERO_ENTRY seems to be more meaningful.

257-1023 are also reserved, they just aren't used yet.  XA_ZERO_ENTRY
is not guaranteed to be the largest reserved entry.
