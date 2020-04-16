Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C81C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 147972076A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587023730;
	bh=Abz5pSmwk1KTWLiBpkLTEnr6DI7w9tkGqdSG1qVM7Iw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CNpci2MDL6pWJkDE+fZLeUFugdj618Xjd+NE2UeksyBapFdm4sgY0JTC/2UXh9YvU
	 9HaYp6/sX5s4JXjmNGtfX+kqQGb710pis9z5HFrkzZ3y1V3gbpV29YsJaF9u3WqMqm
	 Aq5IuKqQns5bFe3dgIKf1kti8Bsqg4XtVILtYsw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440469AbgDPHz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 03:55:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440183AbgDPHyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 03:54:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41A45206E9;
        Thu, 16 Apr 2020 07:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587023663;
        bh=Abz5pSmwk1KTWLiBpkLTEnr6DI7w9tkGqdSG1qVM7Iw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kodGNv81Ugiz0EHVEVJPyurl5xazIMM1Bfm1yVdNqnHqi3F4oNAB1ZuessyOuCI+l
         96IOKmnVgNevEQ7ap5eLeM+a8oFKSkwrcqlzObL+IhrkJ9DoO0sb05b0llOM1kxy7t
         e5ghtal89lD/uEfz5JKEeV3vhFe+kRpK4z4OClVs=
Date:   Thu, 16 Apr 2020 09:54:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] bdi: simplify bdi_alloc
Message-ID: <20200416075421.GG376871@kroah.com>
References: <20200416071519.807660-1-hch@lst.de>
 <20200416071519.807660-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416071519.807660-8-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 09:15:18AM +0200, Christoph Hellwig wrote:
> Merge the _node vs normal version and drop the superflous gfp_t argument.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
