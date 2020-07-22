Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DE4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E1C3207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595414988;
	bh=UFWHvGoRpD0FNixhvW+CszXqh9w0CID6irHRprUemH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D812x+Ug+B8CqAaAqbEvJMEq3C28zbIqLembbiYFV33GmHt4rutbLtKZvelPJ5v/R
	 ojKifj4IPblDXkTuMipLf3Enwd7fiqb9cpKA/wiljmf9FuzrU1pSJJUauMV8B1RLRm
	 K+kUZmNo3s1tMzXWPJ5XK87W8704jArvIQ7AuCaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgGVKtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:49:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbgGVKtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:49:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0495206F5;
        Wed, 22 Jul 2020 10:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595414986;
        bh=UFWHvGoRpD0FNixhvW+CszXqh9w0CID6irHRprUemH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mtYYHdzElRk+jm4uGZT1eQm0wNWHl1/pX2xtTXzEdxUEiKAJil7WkechSbrbFcJpt
         D34VODvPM8VBMAUBa+5u03G5/6cPkKmhfsbxrfvo9pqwofIMkWkPHtdPDVLG5eRVRJ
         I6V6tYf8Ydx8G3d6n9nvXNkB6Z3I8SZPLKz43A0I=
Date:   Wed, 22 Jul 2020 12:49:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     jslaby@suse.com, linux-kernel@vger.kernel.org, huyue2@yulong.com,
        zbestahu@163.com
Subject: Re: [PATCH] sysrq: use only one slot for loglevels in key table
Message-ID: <20200722104952.GB2827860@kroah.com>
References: <20200722092610.11504-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722092610.11504-1-zbestahu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 05:26:09PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Currently, sysrq_key_table[] has 10 slots for same interface to change
> console loglevel. No specific purpose to do that. Let's use only one slot
> to save memory space. Also, update the key2index calculation. And remove
> needless code in help message print path to make the logic simpler.

That sounds like a lot of different things being all done at once.  Can
you break this up into individual patches, each only doing one type of
thing at a time.

And if you are saving memory, please show how much you really are
saving.

thanks,

greg k-h
