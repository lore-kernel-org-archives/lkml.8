Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC05C2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 22:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB4420679
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 22:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584399562;
	bh=fDzZ9sd6ydw01iKuGsTPZvhI4ca9FxZByXLxHe4+dg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Q/rVgYSF68HpBV96mpY2ygF6CYGzFvtJtE/iqvEUGzcwoQvAM9K1V/0s5q+skaPOV
	 DCU4qokUtQpIEq65Zdmp4qUM85muFUTOMo+niaw4Y6nSWt5JuMB/yZE6T9WOT1/+P4
	 /7rLG9FdrGpQ2guXjlOYIV06J/eoKAhvScJJD4/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732891AbgCPW7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 18:59:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732846AbgCPW7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 18:59:21 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7237820674;
        Mon, 16 Mar 2020 22:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584399560;
        bh=fDzZ9sd6ydw01iKuGsTPZvhI4ca9FxZByXLxHe4+dg0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nSpTIy3e2KcyQdsDKHo45qOwSCjeLNnFXY7+uaytRmIQv3iJxOAefEebPANBkVTGS
         MW/QCvsvU5L92AJJP9WvgwoZkT6MFQ4M2Szfa02VbM+zKfDdQCPkQB6DmJMK6uSug0
         wAh8+VJv4y4uYw+MSNn2ZLVnn+2UltcRnrKOQ1xw=
Date:   Mon, 16 Mar 2020 15:59:17 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     shuah@kernel.org, keescook@chromium.org
Cc:     luto@amacapital.net, wad@chromium.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, Tim.Bird@sony.com
Subject: Re: [PATCH v3 0/6] kselftest: add fixture parameters
Message-ID: <20200316155917.5ba8db1c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200316225647.3129354-1-kuba@kernel.org>
References: <20200316225647.3129354-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Mar 2020 15:56:40 -0700 Jakub Kicinski wrote:
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
> 
> v2:
>  - don't run tests by fixture
>  - don't pass params as an explicit argument
> 
> v3:
>  - go back to the orginal implementation with an extra
>    parameter, and running by fixture (Kees);
>  - add LIST_APPEND helper (Kees);
>  - add a dot between fixture and param name (Kees);
>  - rename the params to variants (Tim);
> 
> v1: https://lore.kernel.org/netdev/20200313031752.2332565-1-kuba@kernel.org/
> v2: https://lore.kernel.org/netdev/20200314005501.2446494-1-kuba@kernel.org/

Ugh, sorry I forgot to realign things after the rename :S

I'll send a whitespace-only v4 in a hour, allowing a little bit 
of time in case there are some comments already.
