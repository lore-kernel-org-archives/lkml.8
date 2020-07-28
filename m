Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA6AC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 07:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18B7020786
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 07:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595921844;
	bh=nHg0yBmAWqsOsobn8G2iptEUXidooZ09VVmDRHvOIpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=liQ629WGX8C8srXC4KwshlZTALIK2gUjW5+SU8NvvvUS4Q9MknVDJV1ocZe1rKgi9
	 JgsgJhld7lZlKuPuNr0cHoDWzETK0lrbz6YzG0UjmAAJvK5yHV6slgLcK+F5WMuQQQ
	 Pa9agNqDELji2OJf7R6Sn+C4pWElNPAjyCdcdELw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgG1HhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 03:37:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbgG1HhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 03:37:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FF1C20786;
        Tue, 28 Jul 2020 07:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595921842;
        bh=nHg0yBmAWqsOsobn8G2iptEUXidooZ09VVmDRHvOIpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZeqX0DBs30ldEyJ0nnuMTe2YpqY/Sly2qjXTN+TsU4jUvf6J2FMKCbZGwr/mU79Lf
         Ib84m4TchlLqbONBVCdTmKEVNam8Or+/RC7ijCuByx3BPkkh/L+tZ+2Upt/xpuz/Gr
         W9mkxaebKHZQj54v1G6JXxz9KZrWoi78ZVaibKmQ=
Date:   Tue, 28 Jul 2020 09:37:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ankit <b18007@students.iitmandi.ac.in>
Cc:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        andriy.shevchenko@linux.intel.com, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging : media : atomisp : fixed a brace coding sytle
 issue
Message-ID: <20200728073715.GA351768@kroah.com>
References: <20200727121635.GT3703480@smile.fi.intel.com>
 <20200727213010.15156-1-b18007@students.iitmandi.ac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727213010.15156-1-b18007@students.iitmandi.ac.in>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 03:00:10AM +0530, Ankit wrote:
> From: Ankit Baluni<b18007@students.iitmandi.ac.in>

You need a ' ' before the '<' character.

> 
> Fixed a coding style issue.

Be more descriptive of what you are doing, this is vague.

> 
> Signed-off-by: Ankit Baluni<b18007@students.iitmandi.ac.in>

Same here with the ' '.

thanks,

greg k-h
