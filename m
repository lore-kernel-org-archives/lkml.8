Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE53C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1402720772
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585207669;
	bh=Q3K+7pxeUdLdRNAiY1ArOBt8EhEIkSVNiy6pFl3MHMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oFH6n669Xe9006YR2ycJEhDjPyZi4qvxgbaxapR4Fa2zdFlEx5HDrfP/QCHiDoqIG
	 WajMQYXIYl0x8++urEK1lv11611GBcBSODm78W3ZTaqTd8ipHxwItcyfzZZUYEbs+d
	 7QsWZ+QBHsQVcCtsmBpcqlOJICaAKZe8sDNgPZDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgCZH1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 03:27:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbgCZH1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 03:27:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE8E220714;
        Thu, 26 Mar 2020 07:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585207667;
        bh=Q3K+7pxeUdLdRNAiY1ArOBt8EhEIkSVNiy6pFl3MHMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YHNdD+Z9KSFLHDZrpvvIwuevj7UkWHg7PeZZs5JDEvCaw73uZbOhJAob/zOFv7liA
         zvy965JiPRcdjAkgDWxq/kF1MGHPqbV7HHFGklHnwpS4xUIdTa9vBTdABOcOMyG8JL
         koIM4cPdCEa1PdQgQsbleLyJzwZE09QRX4UxOjm4=
Date:   Thu, 26 Mar 2020 08:27:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        John Stultz <john.stultz@linaro.org>, kernel-team@android.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] slimbus: core: Set fwnode for a device when setting
 of_node
Message-ID: <20200326072745.GA935394@kroah.com>
References: <20200326061648.78914-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326061648.78914-1-saravanak@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 11:16:48PM -0700, Saravana Kannan wrote:
> When setting the of_node for a newly created device, also set the
> fwnode. This allows fw_devlink to work for slimbus devices.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Change-Id: I5505213f8ecca908860a1ad6bbc275ec0f78e4a6

-ENOCHANGEID :(

