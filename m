Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25C8C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 17:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A94252192A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 17:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589044294;
	bh=Knc6lihQiyioaGFRTOVqQ9keAhGSuwjLXItKg6yamdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q7fxPcX7pz4S7dnCXyMnOzTYJ3fGpwThC95DyLvceq2suaXq9AcXslUZ/DuUNv+sf
	 PdBxjcGyGBeIcUgvh5wU1MOpeMsxusuN/1zM2g9qWWIUaluZ9oOcsFyBNmIIyV3K8j
	 noGFBhXgLEC1y9sZ7KPYwq95gw29i0kh4yIbOuJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgEIRLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 13:11:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgEIRLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 13:11:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB84D2184D;
        Sat,  9 May 2020 17:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589044293;
        bh=Knc6lihQiyioaGFRTOVqQ9keAhGSuwjLXItKg6yamdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Awx6svb+sXY9Nb1+JkPtcyV+gT732HQk2LBchxvGubEgp3mbS7q9AwBqMxh55g0/t
         Li864Ct2Zx/qanTNcvtRN350fif6Rr+879RB03rX33tTlRlh7X+9aHfnSKofph22sn
         Js8zspBbqLHuW6ZBLywIrEdE3ccr8zKi+rkUJYdU=
Date:   Sat, 9 May 2020 19:11:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Oldman <john.oldman@polehill.co.uk>
Cc:     nsaenzjulienne@suse.de, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] staging: vc04_services: interface: vchiq_arm:
 vchiq_connected.c: Block comments should align the * on each line
Message-ID: <20200509171131.GA2495033@kroah.com>
References: <20200509130714.10586-1-john.oldman@polehill.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509130714.10586-1-john.oldman@polehill.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 09, 2020 at 02:07:14PM +0100, John Oldman wrote:
> Coding style issue

Your subject line needs to be much shorter, don't you think?

Please fix up and resend.

greg k-h
