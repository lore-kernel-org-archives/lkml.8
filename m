Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D7FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DABEE24655
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579702372;
	bh=GN5fpjzQ7RCIW8Tfebgcv7+9z7zFZtxiAauAoCBSrqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dgT2xlMuFwyt9IbHnob8KHL8sHjqhdh/S5u1oQc0udc6Jxtv2f2yUNWwfD95ZMilX
	 i75YVGAmVCLptGOxJyNub+PZsqRQB4a16JuEHy0qLf8fcSm3hnv02vC/GtCp5RVUBK
	 +Wx55Wt27CNzzWThvUYSdX2A+7pIPaarIJ8lKArs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgAVOMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 09:12:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:49460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgAVOMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 09:12:51 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C14AA24655;
        Wed, 22 Jan 2020 14:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579702371;
        bh=GN5fpjzQ7RCIW8Tfebgcv7+9z7zFZtxiAauAoCBSrqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2PmxpTvhKKwEmXQnQwBL5EOqA+ZvncBP6H/WVI3acRiWV3pLFdTh3eA1BQA6FC/y8
         fiqpPbOYfYvMADSft40JJMFK6XOueof59PzVQNVlFsmAmmk5L7B4v+jVewenpVIfpG
         s0kHYWJKUW5Y32/mQcotxLZTJY3k8DRHVWNOFmHg=
Date:   Wed, 22 Jan 2020 15:12:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] firmware_loader: load files from the mount namespace
 of init
Message-ID: <20200122141248.GA12472@kroah.com>
References: <0e3f7653-c59d-9341-9db2-c88f5b988c68@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e3f7653-c59d-9341-9db2-c88f5b988c68@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 18, 2020 at 06:03:07PM +0200, Topi Miettinen wrote:

> >From 0b88ff99acccaefbe9b86b6a1ceebf5b075f388f Mon Sep 17 00:00:00 2001
> From: Topi Miettinen <toiwoton@gmail.com>
> Date: Fri, 17 Jan 2020 19:56:45 +0200
> Subject: [PATCH] firmware_loader: load files from the mount namespace of init
> 
> Instead of using the mount namespace of the current process to load
> firmware files, use the mount namespace of init process.
> 
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>

What changed from v1?

Also, you had a great description for your first patch, put all that in
here too.

And finally, no need to include the header of it, use 'git send-email'
to send it directly.

thanks,

greg k-h
