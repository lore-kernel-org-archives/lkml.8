Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BC2C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71AA520775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585044555;
	bh=LuLrsI22opq/+1yl39aqKBNIcEn1mW7Q7RRz2dkvH/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dWBvsbL9VIYH7W0Fqe4Iz0NiVLqZqRat1FkXXVSYE347RIDAxdf+2RmxxwYfgBkEQ
	 lnq6t4/do7Vrd54VZTrzT6JgmKDJ4Ikl1u6IuzhOO8cwFAVfIIfneHm3cGKXEBLtqE
	 xs+ojo5Xae3J3mOhBSsIafrDk4K318Mek/KDS0UQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgCXKJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:09:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbgCXKJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:09:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36FB820786;
        Tue, 24 Mar 2020 10:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585044553;
        bh=LuLrsI22opq/+1yl39aqKBNIcEn1mW7Q7RRz2dkvH/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A6QIE1uwQ+IGQpXvGbcnlrCXM+VfHGSM1MNwxqNuUxu2wToB761VmAJQvAnZ2pWgM
         /dsqp372K1KB75cscW/a4FG3qPGYZ6B63eDqAgGTIzT+s1lG6Qx22Piqr1pjW/FVcz
         HnLG9L6m1qRPnzibn5GLODcSoT2mZX/pJ0a5hmJw=
Date:   Tue, 24 Mar 2020 11:08:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs pull request for kernel 5.7
Message-ID: <20200324100817.GB2186290@kroah.com>
References: <20200324093501.GA27782@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324093501.GA27782@ogabbay-VM>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 11:35:01AM +0200, Oded Gabbay wrote:
> Hello Greg,
> 
> This is the pull request for habanalabs driver for kernel 5.7.
> 
> It mainly contains improvements to MMU, hwmon sensors and a new debugfs
> interface to improve debug speed when reading large internal memories.
> 
> Please see the tag message for more details on what this pull request
> contains.
> 
> Thanks,
> Oded
> 
> The following changes since commit bbde5709ee4f60a43b7372545454947044655728:
> 
>   nvmem: mxs-ocotp: Use devm_add_action_or_reset() for cleanup (2020-03-23 20:05:23 +0100)
> 
> are available in the Git repository at:
> 
>   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-next-2020-03-24

Pulled and pushed out, thanks.

greg k-h
