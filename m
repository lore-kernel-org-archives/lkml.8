Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A044C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 422EC2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598257291;
	bh=QzEX0Q0X7UQ0E+od+HjoUCNPygMXV4J3DojKFe3+NZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wRjToNR4cxrQe7OGuuTBR2uEeUAC1i0hCQYReqWLtKAabjoKxbnQtWQ4z1wchtrLV
	 vqfFzrg8NI1ja7WG8MYtNfoh7rHaCLDR8yUXheNSD6bTe/I19oPbnKLvO0ZbQuB1cU
	 76u8vfSNq0kzNNn9rQfCfdlvQ6h+cGQyCWkv1NQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgHXIVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:21:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbgHXIV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:21:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F9C72074D;
        Mon, 24 Aug 2020 08:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598257289;
        bh=QzEX0Q0X7UQ0E+od+HjoUCNPygMXV4J3DojKFe3+NZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QaG3LqfKOISmBY156FLtaptY51AFWM7Jij4KCYaZTciGnWrpUKCeO2eOQu+8p/4X1
         6ELe3WbbbBvJO4ZZ+SlLYMwPQOCA5EAkfwLz8kmG+Z69XB8rIL1ZtWdaMq2bVjkcT0
         S8srWmV5J3Vc/CriWvDQbMf8KddAESW1z8M3lkh0=
Date:   Mon, 24 Aug 2020 10:21:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Prateek Sood <prsood@codeaurora.org>, mcgrof@kernel.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] firmware_loader: fix memory leak for paged buffer
Message-ID: <20200824082147.GB336539@kroah.com>
References: <s5h364lpj3d.wl-tiwai@suse.de>
 <1597957070-27185-1-git-send-email-prsood@codeaurora.org>
 <s5hy2m48nh5.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hy2m48nh5.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 10:19:50AM +0200, Takashi Iwai wrote:
> On Thu, 20 Aug 2020 22:57:50 +0200,
> Prateek Sood wrote:
> > 
> > vfree() is being called on paged buffer allocated
> > using alloc_page() and mapped using vmap().
> > 
> > Freeing of pages in vfree() relies on nr_pages of
> > struct vm_struct. vmap() does not update nr_pages.
> > It can lead to memory leaks.
> > 
> > Fixes: ddaf29fd9bb6 ("firmware: Free temporary page table after vmapping")
> > Signed-off-by: Prateek Sood <prsood@codeaurora.org>
> > Reviewed-by: Takashi Iwai <tiwai@suse.de>
> > Cc: stable@vger.kernel.org
> 
> Greg, could you review and merge this one please?

It's in my to-review queue, thanks.

greg k-h
