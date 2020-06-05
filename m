Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1419C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC1BC2053B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591360826;
	bh=xpvqA3tUrKpFVjIy0L5X1rBEqvmG8UahUOyHRdxhxVw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DNuPh0og6Bo40wMYFa7QpdwqCFOsY+zWhxzHfFegMJDYgL7egdaDZ10EiUe/7rmyx
	 GqG4fuKDKoXXyDA3MrtxH09ztJBj4G2kI7WoTQgRm/Y+zzvNma9BTlnNK8Zyq7jgpr
	 8K0gTLPet07ClhMuV27x29Wi3w+yzKEmob8P+Znw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgFEMk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 08:40:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbgFEMkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 08:40:25 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D9282053B;
        Fri,  5 Jun 2020 12:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591360825;
        bh=xpvqA3tUrKpFVjIy0L5X1rBEqvmG8UahUOyHRdxhxVw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dZVEBsLtJuQPz0VpaajNcVC0S5hzJ4dZNsAde/SEicOs4miQLK1m8duqV4kSfWYpM
         Fy25Af+zKOKKtJ/xfdkf9pVV6gCM7JlNsfHey1zpV+ep9Lci4lDDZ74/0GACvus4ZR
         av4cV/fSOdC1otRR7No+IYt/YvTC3Yb4nzJ9Q+WY=
Date:   Fri, 5 Jun 2020 14:40:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     mani@kernel.org
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        patong.mxl@gmail.com
Subject: Re: [PATCH v3 0/2] Add support for MaxLinear/Exar USB to serial
 converters
Message-ID: <20200605144020.2c72add5@coco.lan>
In-Reply-To: <20200430184924.31690-1-mani@kernel.org>
References: <20200430184924.31690-1-mani@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri,  1 May 2020 00:19:22 +0530
mani@kernel.org escreveu:

> From: Manivannan Sadhasivam <mani@kernel.org>
> 
> Hello,
> 
> This series adds support for MaxLinear/Exar USB to serial converters.
> This driver only supports XR21V141X series but it can easily be extended
> to other series in future.
> 
> This driver is inspired from the initial one submitted by Patong Yang:
> 
> https://patchwork.kernel.org/patch/10543261/
> 
> While the initial driver was a custom tty USB driver exposing whole
> new serial interface ttyXRUSBn, this version is completely based on USB
> serial core thus exposing the interfaces as ttyUSBn. This will avoid
> the overhead of exposing a new USB serial interface which the userspace
> tools are unaware of.
> 
> This series has been tested with Hikey970 board hosting XR21V141X chip.

I applied this series on the top of Kernel 5.7 (x86_64), and I'm 
using it to access the Hikey970 console.

Seems to be working fine. So, feel free to add:

Tested-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Thanks,
Mauro
