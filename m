Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AA9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 07:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B0DC20671
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 07:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589527543;
	bh=0ddCruwCSBmZGShckOzm/0PobS7Jm3SkMeP1nKtGL3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bmhCT5nLhwmRv4+rzFEqmC7EwitxZ5HY7zvatzt+5/CfUCD5BdS0zXurGjCHkXSYN
	 5IXREG8qGiTvBLOnjH/ssMDLkWaTM//JGi8azlTVjDA9eQVjf/h1jqUbt7MAcW7piF
	 r3PM4+Ug1MpHqIKHBZtflt3z6o8JqU+v/z5ALNe8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgEOHZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 03:25:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbgEOHZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 03:25:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62B8E20657;
        Fri, 15 May 2020 07:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589527541;
        bh=0ddCruwCSBmZGShckOzm/0PobS7Jm3SkMeP1nKtGL3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gyj0iWN5PnBSeaCX45RJV8anO42r4yFOpYGfPNxi87bEguVF/ndXVNZESIEtW8AFk
         3ypXJFklZnesRxZLxD/f7E0sFYS73mZs/l+0LJf0oL5jbocBfCmUo62EjSymA08wwq
         uWux83pOmu7OnMkXkICNuXZ3128IOhr3BdNOop0Y=
Date:   Fri, 15 May 2020 09:25:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     rafael.j.wysocki@intel.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        evgreen@chromium.org, swboyd@chromium.org, mka@chromium.org,
        mkshah@codeaurora.org, Alexios Zavras <alexios.zavras@intel.com>,
        Colin Cross <ccross@android.com>,
        Kevin Hilman <khilman@ti.com>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/5] kernel/cpu_pm: Fix uninitted local in cpu_pm
Message-ID: <20200515072539.GA1334029@kroah.com>
References: <20200504104917.v6.1.Ic7096b3b9b7828cdd41cd5469a6dee5eb6abf549@changeid>
 <20200504104917.v6.3.I2d44fc0053d019f239527a4e5829416714b7e299@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504104917.v6.3.I2d44fc0053d019f239527a4e5829416714b7e299@changeid>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 10:50:17AM -0700, Douglas Anderson wrote:
> cpu_pm_notify() is basically a wrapper of notifier_call_chain().
> notifier_call_chain() doesn't initialize *nr_calls to 0 before it
> starts incrementing it--presumably it's up to the callers to do this.
> 
> Unfortunately the callers of cpu_pm_notify() don't init *nr_calls.
> This potentially means you could get too many or two few calls to
> CPU_PM_ENTER_FAILED or CPU_CLUSTER_PM_ENTER_FAILED depending on the
> luck of the stack.
> 
> Let's fix this.
> 
> Fixes: ab10023e0088 ("cpu_pm: Add cpu power management notifiers")
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---


Should also have a cc: stable@vger.kernel.org tag on it.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
