Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A490C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB17D20679
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JqfphNW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbgFOQDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730426AbgFOQDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:03:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCFCC061A0E;
        Mon, 15 Jun 2020 09:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=ImvJGlO0FP5FUU6GtE+Nf8W+2JHUvHYZF8+rh8hHYCs=; b=JqfphNW3m5JEbtWD7auHtyYFgA
        wPlfQu2st2C/QdQtRSI9nUPGeeLL5D1lcQ+0iUrOH0CjO6c8xE2dpaREGtmZPVaFqeF5etyrU4KYq
        OPlxVd6SepR9OhMKq/kxoiLXRLN5w8zXEjg+fDlMXIYsoMZcNoU1Hr0QNpTGEmeek76PivPj9VLao
        IsjqIPvkL1pQZ1lGaMzS84JWpQ7rkU9K/rQ1zW8u9mZ+IKpoye1vZKTv6Kl7PtUqHXGnIZ5P2WgZP
        XUVB0qGlpi96O3cHN+7R33SlAQtRFoeQz7Z/CMqbXHPNjixP2n2aFyn/k7O4G8didRptDpVEIlROg
        3tY3P7cg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkraQ-0007Sy-6N; Mon, 15 Jun 2020 16:03:50 +0000
Subject: Re: decruft the early init / initrd / initramfs code
To:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200615125323.930983-1-hch@lst.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <aa12bf27-9013-439e-f946-3d8ad654d4fd@infradead.org>
Date:   Mon, 15 Jun 2020 09:03:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615125323.930983-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/20 5:53 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this series starts to move the early init code away from requiring
> KERNEL_DS to be implicitly set during early startup.  It does so by
> first removing legacy unused cruft, and the switches away the code
> from struct file based APIs to our more usual in-kernel APIs.

Hi,

Would it be possible to get a series diffstat in your patch
cover letters as a regular thing, please?

thanks.
-- 
~Randy

