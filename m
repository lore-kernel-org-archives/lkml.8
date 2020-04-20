Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D61C55181
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 23:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CDB820B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 23:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgDTXKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 19:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726006AbgDTXKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 19:10:44 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20561C061A0E;
        Mon, 20 Apr 2020 16:10:44 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9FC96823;
        Mon, 20 Apr 2020 23:10:43 +0000 (UTC)
Date:   Mon, 20 Apr 2020 17:10:42 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Chucheng Luo <luochucheng@vivo.com>
Cc:     alex.shi@linux.alibaba.com, Harry Wei <harryxiyou@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v6,RESEND] Translate debugfs.txt into Chinese and link
 it to the index.
Message-ID: <20200420171042.66462fe0@lwn.net>
In-Reply-To: <20200408021528.14062-1-luochucheng@vivo.com>
References: <20200408021528.14062-1-luochucheng@vivo.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Apr 2020 10:15:18 +0800
Chucheng Luo <luochucheng@vivo.com> wrote:

> Translate Documentation/filesystems/debugfs.txt into Chinese.
> 
> Signed-off-by: Chucheng Luo <luochucheng@vivo.com>
> ---
> Changelog:
> v6:
>  - keep each line less than 80 chars, but also keep each line full
>  - remove redundant '=' in caption and all other subheadings
>  - send the patch with 'charset=UTF-8'

I went to apply this just now, but no such luck; this patch tries to
create an index.rst file, but it's already there due to another patch that
went in just over a month ago.  I really don't want to try to resolve a
merge conflict in a file I can't read...could I ask you, please, to rebase
this patch on top of current docs-next, then submit one more time?

Thanks,

jon
