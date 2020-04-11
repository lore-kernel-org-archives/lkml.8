Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761CAC2BB85
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 00:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC922145D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 00:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586564610;
	bh=f0p2kHyven9B7/rEs4yASxu/X7zNikw2/7hIkDrfLf0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=l+S193/5wepmrw8eLI7VTQxaeKJO4IZD3nc/erMKm6tG7qXyFzefjeHKRfb4LHLld
	 vWrrMr3LY6Jz7M7fNWeUJA5bz5IfYbbIShigwHWPJxJk6+9xAtQHld0npwoCn2Um9+
	 tYibdLr8N5H11RYjTPp86BkLixrj/6kpwpRfGnuA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgDKAX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 20:23:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbgDKAX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 20:23:28 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E11220936;
        Sat, 11 Apr 2020 00:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586564608;
        bh=f0p2kHyven9B7/rEs4yASxu/X7zNikw2/7hIkDrfLf0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DVzTN+cq8OybNLSiIhfj7Lf3JzHWc0u3Wt9XOWKZyqKW6SGG3GgxPjrjBXWfF9NQ+
         EJ7cVy+xzas4uNIYrk2bXDELt9sm+DJihr9xT4D2493iyNAGi6ab4FHrj+B24cejwf
         B1LHyl+7ke6Fli78TDcqUEQEwmNSZ5wqSbg7UN3E=
Date:   Fri, 10 Apr 2020 17:23:26 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     keescook@chromium.org, shuah@kernel.org
Cc:     netdev@vger.kernel.org, luto@amacapital.net, wad@chromium.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Tim.Bird@sony.com
Subject: Re: [PATCH v5 0/5] kselftest: add fixture parameters
Message-ID: <20200410172326.3ad05290@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200318010153.40797-1-kuba@kernel.org>
References: <20200318010153.40797-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Mar 2020 18:01:48 -0700 Jakub Kicinski wrote:
> Hi!
> 
> Shuah please consider applying to the kselftest tree.
> 
> This set is an attempt to make running tests for different
> sets of data easier. The direct motivation is the tls
> test which we'd like to run for TLS 1.2 and TLS 1.3,
> but currently there is no easy way to invoke the same
> tests with different parameters.
> 
> Tested all users of kselftest_harness.h.

Hi Shuah!

Were these applied anywhere? I'm happy to take them via 
the networking tree if that's easier.
