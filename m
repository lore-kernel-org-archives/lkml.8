Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77F7C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 21:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC88F2076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 21:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371413AbgDOVNt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 17:13:49 -0400
Received: from ms.lwn.net ([45.79.88.28]:52810 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S371372AbgDOVNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 17:13:44 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B36D1739;
        Wed, 15 Apr 2020 21:13:43 +0000 (UTC)
Date:   Wed, 15 Apr 2020 15:13:42 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH] scripts: documentation-file-ref-check: Add line break
 before exit
Message-ID: <20200415151342.00db4a08@lwn.net>
In-Reply-To: <1586857308-2040-1-git-send-email-yangtiezhu@loongson.cn>
References: <1586857308-2040-1-git-send-email-yangtiezhu@loongson.cn>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020 17:41:48 +0800
Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> If execute ./scripts/documentation-file-ref-check in a directory which is
> not a git tree, it will exit without a line break, fix it.
> 
> Without this patch:
> 
> [loongson@localhost linux-5.7-rc1]$ ./scripts/documentation-file-ref-check
> Warning: can't check if file exists, as this is not a git tree[loongson@localhost linux-5.7-rc1]$
> 
> With this patch:
> 
> [loongson@localhost linux-5.7-rc1]$ ./scripts/documentation-file-ref-check
> Warning: can't check if file exists, as this is not a git tree
> [loongson@localhost linux-5.7-rc1]$
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Applied, thanks.

jon
