Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F4FC2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9D220730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgDGTlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 15:41:49 -0400
Received: from ms.lwn.net ([45.79.88.28]:40634 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbgDGTlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 15:41:49 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DA85E728;
        Tue,  7 Apr 2020 19:41:48 +0000 (UTC)
Date:   Tue, 7 Apr 2020 13:41:47 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: driver-api: address duplicate label warning
Message-ID: <20200407134147.067ba4d8@lwn.net>
In-Reply-To: <20200330060132.7773-1-lukas.bulwahn@gmail.com>
References: <20200330060132.7773-1-lukas.bulwahn@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Mar 2020 08:01:32 +0200
Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Delete identically named subsection to fix Documentation warning:
> 
>   Documentation/driver-api/w1.rst:11: \
>   WARNING: duplicate label driver-api/w1:w1 api internal to the kernel, \
>   other instance in Documentation/driver-api/w1.rst
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> One of many doc warnings...
> Jonathan, this patch is for you.

Applied, thanks.

jon
