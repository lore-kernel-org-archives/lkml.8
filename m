Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C04C2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 05:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B51932076C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 05:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587706984;
	bh=34rav/hD7Vz6kYtXurWnJEzStxDjFihGA7K7yZ7x7FY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kApLrp8jqi6aYHSA/WlZktiTA47fCV3Dok8Lb0k9VMj60fQVtxUU0M7xgdK3WqUBI
	 Y8HHCAPlsj0VXModvqQH7nHcK0uitI2mN8q/pIQlUXsFy/AgLBEq/971oHzxDe4cy7
	 eq1usMPPtvVpqUP7KH355unvNfaJRuFzYVMa8MpU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgDXFnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 01:43:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgDXFnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 01:43:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C23832075A;
        Fri, 24 Apr 2020 05:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587706983;
        bh=34rav/hD7Vz6kYtXurWnJEzStxDjFihGA7K7yZ7x7FY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z1l5+mXUfMv1ehSPi5Y9TRLaJnIbsPor4HAR+vcatyzcj983uQnLZLRDuRUf3qmDI
         aJujXkhtZ/fuKpULTTUtTrS7xqIzHmgdIqOsRNBE5qRS44u3RGl/nNQptPpdI0/qDW
         +HlxLiRwai+vWObB0/Drh9jj1nmZIWExTwgrYxEg=
Date:   Fri, 24 Apr 2020 07:43:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH USB 2/2] usb: raw-gadget: fix typo in uapi headers
Message-ID: <20200424054300.GC103562@kroah.com>
References: <ca6b79b47313aa7ee9d8c24c5a7f595772764171.1587690539.git.andreyknvl@google.com>
 <059e7e0ff26cc7d6e85275f764e31d85db867c4b.1587690539.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <059e7e0ff26cc7d6e85275f764e31d85db867c4b.1587690539.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 03:09:59AM +0200, Andrey Konovalov wrote:
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---

I can't take patches without any changelog text, sorry.

greg k-h
