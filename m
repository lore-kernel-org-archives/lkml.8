Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A5EC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E9D6206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731148AbgD1Sxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730175AbgD1Se4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:34:56 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4566DC03C1AB;
        Tue, 28 Apr 2020 11:34:56 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E139C44A;
        Tue, 28 Apr 2020 18:34:55 +0000 (UTC)
Date:   Tue, 28 Apr 2020 12:34:54 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-doc@vger.kernel.org, Harry Wei <harryxiyou@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Documentation: zh_CN: convert to use
 i2c_new_client_device()
Message-ID: <20200428123454.4ccbaf6c@lwn.net>
In-Reply-To: <cb2d1373-5bb3-93c2-f5af-40a04b21651b@linux.alibaba.com>
References: <20200425100616.3363-1-wsa+renesas@sang-engineering.com>
        <cb2d1373-5bb3-93c2-f5af-40a04b21651b@linux.alibaba.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Apr 2020 22:26:57 +0800
Alex Shi <alex.shi@linux.alibaba.com> wrote:

> 在 2020/4/25 下午6:06, Wolfram Sang 写道:
> > Move away from the deprecated API and advertise the new one.
> > 
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> > 
> > I can't read Chinese. But given the context, I think just updating to
> > the new function name is enough. Please let me know if not. Thanks!  
> 
> It looks good. Thanks!
> 
> Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>

Applied, thanks.

jon
