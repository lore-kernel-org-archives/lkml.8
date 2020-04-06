Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E2DC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181FB20781
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgDFJLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 05:11:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:36862 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbgDFJLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 05:11:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 16907AC7B;
        Mon,  6 Apr 2020 09:11:04 +0000 (UTC)
Date:   Mon, 6 Apr 2020 11:11:03 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Julien Thierry <jthierry@redhat.com>
cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org
Subject: Re: [PATCH] objtool: Fix off-by-one in symbol_by_offset()
In-Reply-To: <20200403131730.32618-1-jthierry@redhat.com>
Message-ID: <alpine.LSU.2.21.2004061110450.26870@pobox.suse.cz>
References: <20200403131730.32618-1-jthierry@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Apr 2020, Julien Thierry wrote:

> Sometimes, WARN_FUNC() and other users of symbol_by_offset() will
> associate the first instruction of a symbol with the symbol preceding
> it.
> This is because symbol->offset + symbol->len is already outside of the
> symbol's range.
> 
> Signed-off-by: Julien Thierry <jthierry@redhat.com>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

