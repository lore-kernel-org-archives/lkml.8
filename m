Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EE9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 07:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6D3E20671
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 07:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589527571;
	bh=e7XClU6wv3Fo05G0rbMJ6lRGcx0Gg+mA0Yx5uvvdUq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MKVGEyjj8GRyxGvBxPfLlU4BAy3rpmtztM6RCP8k42O3dlfmffY2942CinS9mUvFf
	 wRllNWKyRdcVfczUoCjHg9vfTvufSg3NaS+beG1EgsnjA5tDnPmsRoMh3Z1yWKQljY
	 7IPbaE7Qe0fQrUXPCSKfx2ZmM+SR9LPSLo6ujGa8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgEOH0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 03:26:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbgEOH0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 03:26:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF67D20657;
        Fri, 15 May 2020 07:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589527570;
        bh=e7XClU6wv3Fo05G0rbMJ6lRGcx0Gg+mA0Yx5uvvdUq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TeXzBruww5tf7i2BZLGFTmvZyPI8EXCdVYwkULiPhC6xgikjUKiNXrky/vLWtz7H1
         QjuS6qq2VNI31DwSelTGC0kT2JWyrXkqUSG7wMyXeDaXq2F/eWFsN1bpl/kjFnf4n3
         LAisKNJdXsfLU7q6f6kQj6qpL+HbcIMKCFI/Jy3Y=
Date:   Fri, 15 May 2020 09:26:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Evan Green <evgreen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Colin Cross <ccross@android.com>,
        Kevin Hilman <khilman@ti.com>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/5] kernel/cpu_pm: Fix uninitted local in cpu_pm
Message-ID: <20200515072608.GA1361563@kroah.com>
References: <20200504104917.v6.1.Ic7096b3b9b7828cdd41cd5469a6dee5eb6abf549@changeid>
 <20200504104917.v6.3.I2d44fc0053d019f239527a4e5829416714b7e299@changeid>
 <CAD=FV=WpYm=1gUW2Tu4YMwDvn8r7_4xYQD2_bQFU=Po76xyowA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WpYm=1gUW2Tu4YMwDvn8r7_4xYQD2_bQFU=Po76xyowA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 07:32:53PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Mon, May 4, 2020 at 10:50 AM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > cpu_pm_notify() is basically a wrapper of notifier_call_chain().
> > notifier_call_chain() doesn't initialize *nr_calls to 0 before it
> > starts incrementing it--presumably it's up to the callers to do this.
> >
> > Unfortunately the callers of cpu_pm_notify() don't init *nr_calls.
> > This potentially means you could get too many or two few calls to
> > CPU_PM_ENTER_FAILED or CPU_CLUSTER_PM_ENTER_FAILED depending on the
> > luck of the stack.
> >
> > Let's fix this.
> >
> > Fixes: ab10023e0088 ("cpu_pm: Add cpu power management notifiers")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> > This seems to be an ownerless file.  I'm hoping this patch can just go
> > through the Qualcomm tree.  It would be nice if we could get an Ack
> > from Rafael or Greg KH though.
> 
> Greg / Rafael: any thoughts on this patch?  Care to give it an Ack so
> it could go through the Qualcomm tree?
> 
> Andrew: I think you are the adopter or orphan patches, usually.  If
> nobody else will take this patch, will you consider taking it into
> your tree?  It should be a super straightforward bugfix.  I'm happy to
> re-post it CCing you if need be.

Now reviewed, nice catch.

greg k-h
