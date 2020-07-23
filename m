Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557E4C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37F4A206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgGWUGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgGWUGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:06:50 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E388C0619DC;
        Thu, 23 Jul 2020 13:06:50 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 074922BA;
        Thu, 23 Jul 2020 20:06:49 +0000 (UTC)
Date:   Thu, 23 Jul 2020 14:06:48 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Wang Long <w@laoqinren.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: driver-api: update kernel connector
Message-ID: <20200723140648.6edb788f@lwn.net>
In-Reply-To: <1595229852-114071-1-git-send-email-w@laoqinren.net>
References: <1595229852-114071-1-git-send-email-w@laoqinren.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 15:24:12 +0800
Wang Long <w@laoqinren.net> wrote:

> This patch changes:
> 1) Fix typo in kernel connector documentation.
> 	s/cn_netlink_send_multi/cn_netlink_send_mult/
> 2) update definition of struct cn_msg
> 
> Signed-off-by: Wang Long <w@laoqinren.net>
> ---
>  Documentation/driver-api/connector.rst | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied, thanks.

This sort of documentation would be better handled with kerneldoc
comments, though...

jon
