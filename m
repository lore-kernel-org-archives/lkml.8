Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4D4C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF3272065F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594943366;
	bh=uaPx3NHnlak2s8/Bw+uGgnUTIdfrCFx1I8qftHQtHq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=glp9J3jfZxKbKzfRrPPSSXrgM7+uj3tQ0xOLUK43KZr8M5t9PgaNrvc5AE372icIB
	 48GA+b1adQQRhxXOL1W4mgVkSLB2VKYxdXUiSTS9ydLatwIC/L1OrIweQoz5ZLa2SC
	 rBh1sm+ND0dGWkvSqyG9e8jfG9w2vza8ae+6kakc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgGPXtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:49:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgGPXtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:49:25 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71DFC204EC;
        Thu, 16 Jul 2020 23:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594943364;
        bh=uaPx3NHnlak2s8/Bw+uGgnUTIdfrCFx1I8qftHQtHq4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fgauLvK2grUIhQBTb8Kt72Cvi9foLQMtrzTNppPRjRLgEqf5/zk4D8Hd4ov/rUrea
         SJKe2ZtuyRZuq0sAAz10PvHkNRjbm0BeGGA2GXk1/Gl0G9JkOK5n3PHZ4Je2jlrvHs
         sft8edVKvC9SHbZQbOORP7He9vfhSNpTqREj5yfM=
Date:   Thu, 16 Jul 2020 16:49:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: clean up address limit helpers v2
Message-Id: <20200716164924.15e373f4dbb3071e9d4ee37c@linux-foundation.org>
In-Reply-To: <20200714105505.935079-1-hch@lst.de>
References: <20200714105505.935079-1-hch@lst.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020 12:54:59 +0200 Christoph Hellwig <hch@lst.de> wrote:

> Hi all,
> 
> in preparation for eventually phasing out direct use of set_fs(), this
> series removes the segment_eq() arch helper that is only used to
> implement or duplicate the uaccess_kernel() API, and then adds
> descriptive helpers to force the kernel address limit.
> 
> 
> Changes since v1:
>  - drop to incorrect hunks
>  - fix a commit log typo

I think this *is* v1.  I can't find any differences in the patches and I
was unable to eyeball any changelog alterations?

