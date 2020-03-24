Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86288C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593C120788
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585067304;
	bh=OwaKuYa+9PST2bZOdVKnZ0hlu4DJ0Q8E1oQGPjlNHno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YqUWbJWELUCbxwIxh3AB3FnNacgWub5xegZLd5tY09lotdXivdi9KTU/K4IG6QC6F
	 SpuyppBMxvjGX5h0lOgYOmZkjKaN/jg5vqMpsAZVibNX0APrqFd3AWF8hARyjD3GNH
	 j99/Jp308U4/n8sW7hzXJkkpHwzMfsPtxcHJW+EA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbgCXQ2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:28:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727708AbgCXQ2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:28:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D71AF20774;
        Tue, 24 Mar 2020 16:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585067302;
        bh=OwaKuYa+9PST2bZOdVKnZ0hlu4DJ0Q8E1oQGPjlNHno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xaHWyl5k+iunZr/F/yLvuO1VnQ/BlNmfc5+iTDmwR79r08X32r7KVpME6hDbQXy6w
         +ixeuUCtn0m6o70wDBGrLlIFnrtOO3MigjTiRmyQ3icXm+6sucMV8FrWqFyJyUk098
         b311m4SPLQrNVwQbKCiNfN8ptJNhxWU4wU/bTwSE=
Date:   Tue, 24 Mar 2020 17:28:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Maddie Stone <maddiestone@google.com>,
        Marco Elver <elver@google.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 17/21] linux/bit_spinlock.h: Include linux/processor.h
Message-ID: <20200324162820.GD2518046@kroah.com>
References: <20200324153643.15527-1-will@kernel.org>
 <20200324153643.15527-18-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324153643.15527-18-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 03:36:39PM +0000, Will Deacon wrote:
> Needed for cpu_relax().

Is this needed now, or for the next patch?  And if for next patch, why
not just add it then?

thanks,

greg k-h
