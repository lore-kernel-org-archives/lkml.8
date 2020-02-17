Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F996C3B1BF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 01:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6152A2072C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 01:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dw2SFnan"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgBQBxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 20:53:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54722 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgBQBxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 20:53:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=ZvKy8cN1oeW6FFUvXPgwsqS+7nTP4G4tR9YL0f/QYMY=; b=dw2SFnanczrBwiVB1Iho3fr7ie
        HJtHtssC1AxzBlaTxdx6p0cU+JIxiLcQenc/AT0lwTPptBkjf1h5sFExh1wwdM4M2dDpOofwpl7L+
        /N3oC/SyJbFk/t/5jvNnww7RojkgyXvdB655RLFQmyNClJM15seyOXW+XVAjTBodxbJHs22PkxEqE
        e6PHnS4XfRIjpickmU4XlbNrDcs4G+Z02d/kcITAVkwrzhoq1q4hjkv8OHq9yA8sCLsr2U0UndynO
        kiUYg8I6C2ncfJ6VT8a6QQbIAII6ndk24MKm2FcmXUAGEgcb9U35JFXiLZOnQan6c46kJnf7Uu1UC
        VQvjZ2aA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3Vax-0006fX-8X; Mon, 17 Feb 2020 01:53:11 +0000
Subject: Re: [PATCH] Documentation: bring process docs up to date
To:     Tony Fischetti <tony.fischetti@gmail.com>, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200217000826.55767-1-tony.fischetti@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5e8c6ff0-951f-e447-9606-0c1177a596cd@infradead.org>
Date:   Sun, 16 Feb 2020 17:53:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217000826.55767-1-tony.fischetti@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/20 4:08 PM, Tony Fischetti wrote:
> The guide to the kernel dev process documentation, for example, contains
> references to older kernels and their timelines. In addition, one of the
> "long term support kernels" listed have since reached EOL, and a new one
> has been named. This patch brings information/tables up to date.
> 
> Additionally, some very trivial grammatical errors, unclear sentences,
> and potentially unsavory diction have been edited.
> 
> Signed-off-by: Tony Fischetti <tony.fischetti@gmail.com>
> ---
>  Documentation/process/2.Process.rst    | 108 +++++++++++++------------
>  Documentation/process/coding-style.rst |  18 ++---
>  Documentation/process/howto.rst        |  17 ++--
>  3 files changed, 73 insertions(+), 70 deletions(-)


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.
-- 
~Randy

