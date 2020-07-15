Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F65C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52A1720663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594797474;
	bh=6OLifhZpY8P2Nf/yLaI8P4QAL9rlGQNYmf4dlB26GIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wFFKqxmWHABh0pwWJk8eCTVAgUeNYY5981qhd/QUWHEdSMLcQ15V7azr32P0K+q6J
	 RyxyxmZDKGny2n4yBQBsGWQtJJt5CEPcHq4NMwI94oXCluBnJr0N0k5S7cMJzR2CLQ
	 YKgP0klKW6NBNte5jFxh5JEk0VDPX0KSAFa2MakQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbgGOHRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 03:17:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728883AbgGOHRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 03:17:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1A522065E;
        Wed, 15 Jul 2020 07:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594797472;
        bh=6OLifhZpY8P2Nf/yLaI8P4QAL9rlGQNYmf4dlB26GIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DjpRJ13Ot+BFAKDkdOP3t2xGMqJ81zplNuPJAPIPd5FPizEOcBRHyWLmkukaSQh1E
         knhyoDuVuY9zvb2Uhc89AuFqqudNu3M0cyEFMoF0AMRXXcJANuBx4oxjw996Zngqpg
         hL259xKF7aewNDzbeb9ysnUOYhq3rMLXysE5b27Y=
Date:   Wed, 15 Jul 2020 09:17:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhixu Zhao <zhixu001@126.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        rcy@google.com, rspringer@google.com, joe@perches.com,
        toddpoynor@google.com, dan.carpenter@oracle.com
Subject: Re: [PATCH v2] staging: gasket: core: Fix a coding style issue in
 gasket_core.c
Message-ID: <20200715071748.GC2305231@kroah.com>
References: <20200617161127.32006-1-zhixu001@126.com>
 <20200714234440.27009-1-zhixu001@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714234440.27009-1-zhixu001@126.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 07:44:40AM +0800, Zhixu Zhao wrote:
> On Thu, Jun 18, 2020 at 12:11:27AM +0800, Zhixu Zhao wrote:
> > A coding alignment issue is found by checkpatch.pl.
> > Fix it by using a temporary for gasket_dev->bar_data[bar_num].
> > 
> > Signed-off-by: Zhixu Zhao <zhixu001@126.com>
> 
> Hi, there~
> 
> Does anybody have any further comments on this?
> Can it be merged?

I never saw the first version of this, are you sure it got sent to the
mailing list?  It's not in any archives anywhere.

Also, 3 days is really fast for a simple coding style cleanup to be
worried about.  Give it usually at least 2 weeks.

thanks,

greg k-h
