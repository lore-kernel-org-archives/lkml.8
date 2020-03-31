Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65375C2D0F0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE1F206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731476AbgCaW5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:57:10 -0400
Received: from ms.lwn.net ([45.79.88.28]:44712 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730589AbgCaW5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:57:09 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 16E572F3;
        Tue, 31 Mar 2020 22:57:09 +0000 (UTC)
Date:   Tue, 31 Mar 2020 16:57:07 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 1/2] Documentation: filesystems: Convert sysfs-pci to
 ReST
Message-ID: <20200331165707.7c708646@lwn.net>
In-Reply-To: <637c0379a76fcf4eb6cdde0de3cc727203fd942f.1585693146.git.vitor@massaru.org>
References: <cover.1585693146.git.vitor@massaru.org>
        <637c0379a76fcf4eb6cdde0de3cc727203fd942f.1585693146.git.vitor@massaru.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Mar 2020 19:28:56 -0300
Vitor Massaru Iha <vitor@massaru.org> wrote:

> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> ---
>  .../{sysfs-pci.txt => sysfs-pci.rst}          | 40 ++++++++++---------
>  1 file changed, 22 insertions(+), 18 deletions(-)
>  rename Documentation/filesystems/{sysfs-pci.txt => sysfs-pci.rst} (82%)

Please supply a changelog with your patches.

The conversion you have done in this file is incomplete; I suspect that
you have not actually built the docs and seen what the results look like.
There are literal blocks that you have not marked as such, as a minimum.
Please actually do a docs build (after adding this file to index.rst) and
make sure that the output is what you intended.

One other thing of note...this file dates back to before the Git era, and
while it has seen numerous tweaks since then, it's clearly outdated.  Look
at what's actually under /sys/devices/pci* compared to what's documented.
I will take the conversion without it, but what I would really like to see
would be an effort to document all of the attributes that appear there
with current kernels.

Thanks,

jon
