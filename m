Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E9DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 10:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B072070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 10:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595844787;
	bh=t4D1FuJzCWxTOpgMJa4HQg6WIwmibM3xExErnAiX4MI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mnHPRDKhm4CpmWQeYNs2XJUdjzS4hqrbC/qJ+LrYVEGOBdYorAD3vuf0vbounve6F
	 ZIK8HWHzLX8//fD6A+VVhJV6zbYAK8MlJBw32r7t+cchfNJgUCUa2k32JdJIWnYCqh
	 q9bVncKYe77GsN4w7RChYl/1+BQO3rrOEXeWUATQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgG0KNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 06:13:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgG0KNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 06:13:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 590042070B;
        Mon, 27 Jul 2020 10:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595844783;
        bh=t4D1FuJzCWxTOpgMJa4HQg6WIwmibM3xExErnAiX4MI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dj/HLeYeVtEppj3YU0JNqU8s+eqN16yDQYhj7XUfNc+X18cXtccn7QnThuR6Nfm+o
         3vX9lL58a6TrLeFDe2qSynwfKapt27eqkPaY7kaQPiDlfb6eFtNCVB4pCwdVd34XLb
         ZUTYbbPTQdsYVCCdu/xAesOifcVmZEMgfnVNewik=
Date:   Mon, 27 Jul 2020 12:12:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Forest Crossman <cyrozap@gmail.com>
Cc:     linux-usb@vger.kernel.org, mathias.nyman@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: xhci: define IDs for various ASMedia host
 controllers
Message-ID: <20200727101259.GA1925099@kroah.com>
References: <20200727090629.169701-1-cyrozap@gmail.com>
 <20200727090629.169701-2-cyrozap@gmail.com>
 <20200727092654.GD1764157@kroah.com>
 <CAO3ALPwJq4=GairV8ksHenRtXwg2mYNDKtnYcf99eN6Eo6es5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO3ALPwJq4=GairV8ksHenRtXwg2mYNDKtnYcf99eN6Eo6es5A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 05:03:43AM -0500, Forest Crossman wrote:
> On Mon, Jul 27, 2020 at 4:26 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jul 27, 2020 at 04:06:28AM -0500, Forest Crossman wrote:
> > > Signed-off-by: Forest Crossman <cyrozap@gmail.com>
> >
> > I can not take patches without any changelog text, sorry.
> 
> Ah, whoops, I'm very sorry about that! Should I send a v2 of just this
> patch? Or would it be better to send the whole series again?

Whole series is always easier to handle.

thanks,

greg k-h
