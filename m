Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2654C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 999B32065E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgGWUsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgGWUsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:48:14 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B117C0619D3;
        Thu, 23 Jul 2020 13:48:14 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3AE7C2BA;
        Thu, 23 Jul 2020 20:48:14 +0000 (UTC)
Date:   Thu, 23 Jul 2020 14:48:13 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Harry Wei <harryxiyou@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] doc/zh_CN: add admin-guide index
Message-ID: <20200723144813.4dea8dce@lwn.net>
In-Reply-To: <20200713115807.56362-1-alex.shi@linux.alibaba.com>
References: <20200713115807.56362-1-alex.shi@linux.alibaba.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020 19:58:05 +0800
Alex Shi <alex.shi@linux.alibaba.com> wrote:

> Translate the admin-guide index.rst file into Chinese. and link it into
> Chinese top index file.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Harry Wei <harryxiyou@gmail.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  .../translations/zh_CN/admin-guide/index.rst  | 112 ++++++++++++++++++
>  Documentation/translations/zh_CN/index.rst    |   1 +
>  2 files changed, 113 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/admin-guide/index.rst

I've applied the set, thanks.

jon
