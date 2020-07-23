Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E680FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C06A820714
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595525667;
	bh=Qhrjw7uyDWdXXIAvmKfEK6zrtiSur7oYHENRu1OnN3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G02KIOY/+DfXOllhe1S6Z3KJvd5Qb/7GPRpd7Km1Y3COmmaYY2/ee5tkY74Gt1/Vk
	 3snMnhRcNHLjJEnltl+KryoTGZe9sOsjQJCvdn42h0kb0W8zJlX+4vR3zHwlWg+aiT
	 KmuRkFgaWPLk1X/ECDXuWiP6BWYB+XoU4Crpk/NQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbgGWRe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:34:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbgGWRe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:34:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A64520714;
        Thu, 23 Jul 2020 17:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595525666;
        bh=Qhrjw7uyDWdXXIAvmKfEK6zrtiSur7oYHENRu1OnN3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mPXjgtQfYvIUJ9CMdLnwxLE0QAOiL5hC7Q56P+XKldQdMheN6WLKo3IJtnaWlRm5h
         VrMruFbX9BCXuA9phurly9B34jULxl604wuZB13+rCleqogq1TvWwYw1Yb+dRr8Kr2
         vdIEEDAFwTgqFt3xMxpqtqyEZ9V2tKcGX5beBHsM=
Date:   Thu, 23 Jul 2020 19:34:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Muhammad Usama Anjum <musamaanjum@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: octeon: Add the license identifier
Message-ID: <20200723173429.GA2907237@kroah.com>
References: <20200723163150.GA10505@musamaanjum>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723163150.GA10505@musamaanjum>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 09:31:50PM +0500, Muhammad Usama Anjum wrote:
> This patch fixes the checkpatch.pl warning:
> WARNING: Missing or malformed SPDX-License-Identifier tag
> 
> Add a the SPDX-License-Identifier tag on line 1
> 
> Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
> ---
> Other files in this folder have GPL-2.0 license. So this file should
> have the same license which was missing before and checkpatch.pl was
> giving the warning.

Why is this information not up in the changelog area?

And what changeds from v1?  ALways put that below the --- line.

v3?

thanks,

greg k-h
