Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9A6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 913E7206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbgFHPZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729668AbgFHPZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 11:25:18 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209EFC08C5C2;
        Mon,  8 Jun 2020 08:25:18 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 808F2735;
        Mon,  8 Jun 2020 15:25:17 +0000 (UTC)
Date:   Mon, 8 Jun 2020 09:25:16 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-doc@vger.kernel.org, Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Wang Wenhu <wenhu.wang@vivo.com>,
        Chucheng Luo <luochucheng@vivo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: zh_CN: use doc reference to resolve undefined
 label warning
Message-ID: <20200608092516.0e285bae@lwn.net>
In-Reply-To: <20200531183556.5751-1-lukas.bulwahn@gmail.com>
References: <20200531183556.5751-1-lukas.bulwahn@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 May 2020 20:35:56 +0200
Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Documentation generation warns:
> 
>   Documentation/translations/zh_CN/filesystems/debugfs.rst:5:
>   WARNING: undefined label: debugfs_index
> 
> Use doc reference for files rather than introducing a label to refer to.
> This resolves the warning above.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Jonathan, please pick this quick warning fix.

Applied, thanks.

jon
