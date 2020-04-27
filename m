Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526EAC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 310C2206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587997058;
	bh=50KIcAj0jAShkqsphU2nLz+JkRuymzuf47BD5KjkLl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fOXEB6vL1McQKqXyRREE96cAsar+b/2r6Zu39LRW0UuVbENTBhHgdpmsbMX20cdko
	 sMP0xPC64RFoU8IQDdxdcgszXmvm8mBcSKc5wNga7GBXtYh1njHAEVSNK8huEdDFDz
	 qNQPKvW59U96PeFU4OI1sBEnkMBP6yGvVbVvPXFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgD0ORh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:17:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgD0ORf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 10:17:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83872206B6;
        Mon, 27 Apr 2020 14:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587997055;
        bh=50KIcAj0jAShkqsphU2nLz+JkRuymzuf47BD5KjkLl8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2PGctTybfxdtFOQxOJg/ryKh7QpTcYPlf+JjsUE95FMniO9OiIQZ9BiP+krQArJhA
         4lG+C+moPbTIjHbSGqzzQFk112jJM6g14JKuzvJhaHxW3wt2n88fxZwEQA7p1Amsvn
         zYF9db/Enh3we6BE1c6SUH6axC1zqIAp7ircChN4=
Date:   Mon, 27 Apr 2020 16:17:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Oldman <john.oldman@polehill.co.uk>
Cc:     devel@driverdev.osuosl.org, hslester96@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drivers: staging: rts5208: rtsx.c fix Unbalanced
 braces around else statement issue
Message-ID: <20200427141732.GA3158628@kroah.com>
References: <20200427135212.26285-1-john.oldman@polehill.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427135212.26285-1-john.oldman@polehill.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 02:52:11PM +0100, John Oldman wrote:
> Fix coding stype issue

"stype"???

