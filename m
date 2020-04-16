Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16191C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 04:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E303120767
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 04:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587010055;
	bh=5Js663jCMQnnanixbXGlT1h0jEUb3V5uU1s+WTiHyYE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=g5bah7S54m/gCBjX6AAKUNfM2UCnYO3+126ZmT6lUFBhPVkhtzG+Bhm6sDh8FMwmn
	 m2uz6vHvHL5eLH5Lhsr/UpQawxuCdRr6pI6HFhB0oHA1B2L8p1ghQ1jX1OFOG2c+56
	 Txx+DUdESU7PCS7O8WC8lvxB1aNJzdZq2XK57WHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgDPEHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 00:07:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbgDPEH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 00:07:28 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69C3020767;
        Thu, 16 Apr 2020 04:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587010048;
        bh=5Js663jCMQnnanixbXGlT1h0jEUb3V5uU1s+WTiHyYE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FtmA36invyFrgzCq2vyJyaVOVMJLXulhRWuGbEv5CxK6N+hgNugmwsZ1VMlompByA
         yAwdUfOrIn+BgK1fZm2N86xYmiVtyGBc/hgOmqr2OdWBfPqVzTNJ9c+EsB0/u1kxwe
         tY2h4XDhpoDeHiUCHaoJ8kPbncRCBGlM+zmNfv9Y=
Date:   Wed, 15 Apr 2020 21:07:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: rename "catch" function argument
Message-Id: <20200415210727.c0cf80b5a981292bb15d9858@linux-foundation.org>
In-Reply-To: <20200331210905.GA31680@avx2>
References: <20200331210905.GA31680@avx2>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Apr 2020 00:09:05 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> "catch" is reserved keyword in C++, rename it to something
> both gcc and g++ accept.

Why? Is someone compiling the kernel with g++?

> Rename "ign" for symmetry.
> 
> Signed-off-by: _Z6Alexeyv <adobriyan@gmail.com>

Was this intentional?
