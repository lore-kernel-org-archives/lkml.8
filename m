Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71B6C5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9CC520770
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgCRPMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 11:12:49 -0400
Received: from ms.lwn.net ([45.79.88.28]:41118 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbgCRPMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:12:48 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3A798144F;
        Wed, 18 Mar 2020 15:12:48 +0000 (UTC)
Date:   Wed, 18 Mar 2020 09:12:47 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Chucheng Luo <luochucheng@vivo.com>
Cc:     Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@vivo.com
Subject: Re: [PATCH] Translate Documentation/filesystems/debugfs.txt into
 Chinese
Message-ID: <20200318091247.6dfa27f5@lwn.net>
In-Reply-To: <20200318150743.13480-1-luochucheng@vivo.com>
References: <20200318150743.13480-1-luochucheng@vivo.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Mar 2020 23:07:30 +0800
Chucheng Luo <luochucheng@vivo.com> wrote:

Thanks for working to improve the docs.  A couple of quick notes...

> Signed-off-by: Chucheng Luo <luochucheng@vivo.com>
> ---
>  .../zh_CN/filesystems/debugfs.rst             | 257 ++++++++++++++++++
>  1 file changed, 257 insertions(+)
>  create mode 100755 Documentation/translations/zh_CN/filesystems/debugfs.rst

You need to add this file to index.rst as well so it becomes a part of the
docs build.

> diff --git a/Documentation/translations/zh_CN/filesystems/debugfs.rst b/Documentation/translations/zh_CN/filesystems/debugfs.rst
> new file mode 100755
> index 000000000000..69cd1fb8d3c6
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/filesystems/debugfs.rst
> @@ -0,0 +1,257 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. raw:: latex
> +
> +	\renewcommand\thesection*
> +	\renewcommand\thesubsection*
> +
> +.. include:: ../disclaimer-zh_CN.rst

Why are you putting raw LaTeX in here?  Please avoid that if you possibly
can, or explain why it's there otherwise.

Thanks,

jon
