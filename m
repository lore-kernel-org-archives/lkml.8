Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2A1C3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC562467B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgCBTxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 14:53:06 -0500
Received: from ms.lwn.net ([45.79.88.28]:58382 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgCBTxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 14:53:06 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id F1BDC99C;
        Mon,  2 Mar 2020 19:53:05 +0000 (UTC)
Date:   Mon, 2 Mar 2020 12:53:04 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: kernel-docs: Remove "Here is its" at the end of
 lines
Message-ID: <20200302125304.0c430142@lwn.net>
In-Reply-To: <20200228204147.8622-1-j.neuschaefer@gmx.net>
References: <20200228204147.8622-1-j.neuschaefer@gmx.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2020 21:41:45 +0100
Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:

> Before commit 9e03ea7f683e ("Documentation/kernel-docs.txt: convert it
> to ReST markup"), it read:
> 
>        Description: Linux Journal Kernel Korner article. Here is its
>        abstract: "..."
> 
> In Sphinx' HTML formatting, however, the "Here is its" doesn't make
> sense anymore, because the "Abstract:" is clearly separated.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

I wonder about the value of this file, but while it exists it might as
well make sense.  So applied, thanks.

jon
