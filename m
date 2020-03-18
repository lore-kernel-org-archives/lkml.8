Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36441C5ACD9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E8820774
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584532497;
	bh=vog5jmqIjkgcCbl6H/fzs7vG/KRa87L6309/v2uXLmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eSOQMATUQzOig586uuUOBVY5dNTBaMVYhx4PnK8MoiHVvPZPXemuQJygM+3YqNlaj
	 nODlEUxP8CfxatXhrAKkhjMMZvKt9jbKYgAEi77kqUCjnfy74VNh7kj63EDU3px9Y3
	 Wum12k459Q/fkXCqG5PJJqxEOLwqQzmRt1kkIRv4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgCRLy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:54:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgCRLyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:54:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 622CD20772;
        Wed, 18 Mar 2020 11:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584532494;
        bh=vog5jmqIjkgcCbl6H/fzs7vG/KRa87L6309/v2uXLmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Na1jsHhb8csDiM3dBjnzZmuz+N+26R0vSZ86fWmREdnGAB4HGA2NBCC6S53DM0nw4
         FcwmizkX3yiGSLZQXZ4UWTLZwP/3vWBr2hMl4B55hBy6mbP7fFp1eM1Q9nKGCMBp/v
         4PRO9wr9DnDjZHx69Nrz5eds7DM4CuCL2XTKR0Y0=
Date:   Wed, 18 Mar 2020 12:54:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jolly Shah <jolly.shah@xilinx.com>
Cc:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        matt@codeblueprint.co.uk, sudeep.holla@arm.com,
        hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com,
        rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/24] firmware: xilinx: Add xilinx specific sysfs
 interface
Message-ID: <20200318115452.GA2491827@kroah.com>
References: <1583538452-1992-1-git-send-email-jolly.shah@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583538452-1992-1-git-send-email-jolly.shah@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 03:47:08PM -0800, Jolly Shah wrote:
> This patch series adds xilinx specific sysfs interface for below
> purposes:
> - Register access
> - Set shutdown scope
> - Set boot health status bit
> 
> Also this patch series removes eemi ops and adds API
> corresponding to each eemi ops.

I've applied the first 19 patches here, they looked good, thanks for
doing that work, makes things a lot more "obvious" as to what is going
on here.

The rest, please see my review comments and redo.

thanks,

greg k-h
