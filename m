Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B169EC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 05:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C0722075E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 05:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgEEF6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 01:58:21 -0400
Received: from verein.lst.de ([213.95.11.211]:33405 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgEEF6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 01:58:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B397168BEB; Tue,  5 May 2020 07:58:19 +0200 (CEST)
Date:   Tue, 5 May 2020 07:58:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Make sure proc handlers can't expose heap
 memory
Message-ID: <20200505055819.GB3552@lst.de>
References: <202005041205.C7AF4AF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005041205.C7AF4AF@keescook>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 12:08:55PM -0700, Kees Cook wrote:
> Just as a precaution, make sure that proc handlers don't accidentally
> grow "count" beyond the allocated kbuf size.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> This applies to hch's sysctl cleanup tree...

This looks ok o me.  You should probably add Al to the Cc list as
he has picked up my series into a branch of vfs.git.

Acked-by: Christoph Hellwig <hch@lst.de>
