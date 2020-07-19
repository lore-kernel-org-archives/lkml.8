Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70220C433E4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 11:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BFE820809
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 11:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595156749;
	bh=3RYTI3kIR0sm4yP0B0+AU+jVL4lPaOvkU/H2NQe3xxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yiuRGaPmo4LAyDp6KoLU4UBvnORhI6VBZNPiD0Gt5OHUK1UOx5FUd4UJMA5UYHl+t
	 rzPt+3G7fNli4uyTwMS2TY7OCnYK1HbndBUg+UEAGER4jfuhNOKBpgJlVM3Rop3Da9
	 gdWBHidred17+yKgp1u+qKoTqFpTph08mlNqt7Fs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgGSLFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 07:05:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgGSLFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 07:05:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92D3C2065E;
        Sun, 19 Jul 2020 11:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595156746;
        bh=3RYTI3kIR0sm4yP0B0+AU+jVL4lPaOvkU/H2NQe3xxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wHp3kH9/ZqL7UhMEWQeT1ocg5zsEdnfeeHHmHNz7XvxlXar0s99dFgJN5xDT2rT5Z
         KVvdZ3JBnYk+xXZH+4PLP3Ov82QHXuPitOn1k4Dz1ImghYlkcI/kUjKSSz4U7nxe+q
         bhXq8f5rROB3iW0yRCvnuLZbo/T3dTCcSMDTBE0U=
Date:   Sun, 19 Jul 2020 13:05:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Darshan D V <darshandv10@gmail.com>
Cc:     yuehaibing@huawei.com, ardb@kernel.org, contact@christina-quast.de,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: rtl8192e: Fixed a coding style warning
Message-ID: <20200719110558.GC266150@kroah.com>
References: <20200719092236.GB171181@kroah.com>
 <20200719105557.12605-1-darshandv10@gmail.com>
 <20200719105557.12605-2-darshandv10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719105557.12605-2-darshandv10@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 04:25:57PM +0530, Darshan D V wrote:
>     rtllib_crypt_ccmp.c: Fixed the warning - suspect code indent for
>     conditional statements on line #338

You can't send two patches that do two different things, yet have the
same exact subject: line :(

