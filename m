Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B435C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 13:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC7EB206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 13:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597410257;
	bh=UEBBj4JW1Cb6Y9ZOu+YhwP/qAxCfGau771iq7qaX3EY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r1/vaTiuPQQj+6ZvKQvubfRJZGpUzFV6R/PUT1flkWy/E3zDHeZC64rI3/riTqawt
	 1EQLbKZwlJ71zDkhRQB7dZWJgjNXk+/DK35ugDqPB8DtXFaV4B/kxviupKiAVchmZO
	 5fSnH5tLSSEg/VJ9AtdkV0esvCTO2Lu2KsoFuSQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgHNNEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 09:04:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgHNNEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 09:04:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99D49206B2;
        Fri, 14 Aug 2020 13:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597410253;
        bh=UEBBj4JW1Cb6Y9ZOu+YhwP/qAxCfGau771iq7qaX3EY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o2BaxLIMZfUPkbatM6CmN3/6TsU/A/WbN5JRgLIRNGTPVwm927bvWBvEvvi04c0Dw
         10aHbLTOMQacnASITrDs0Vwy6DtGmgcbU/eyUKJ2XuT9tb4YKRYZZa7elBx11g5saY
         8zvleOyrUuCcf92Eh8bhIoD1KIJe2SgGTdGSuVnw=
Date:   Fri, 14 Aug 2020 15:04:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, iourit@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 4/4] drivers: hv: dxgkrnl: create a MAINTAINERS entry
Message-ID: <20200814130434.GD56456@kroah.com>
References: <20200814123856.3880009-1-sashal@kernel.org>
 <20200814123856.3880009-5-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814123856.3880009-5-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 08:38:56AM -0400, Sasha Levin wrote:
> Signed-off-by: Sasha Levin <sashal@kernel.org>

I know I don't take patches without changelog text :)

