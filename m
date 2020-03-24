Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736C6C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB0C2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585072715;
	bh=3bq9xwRbw4as5OhWunjB4/vALijb9AU81xWgdEwbwrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Pw/aKQ2xlMPzhsOMyv3A6tzaUr+Y2JoO9g3avn66cc8E7xYod1tsljGdccPf2s6J7
	 PqBT7MBSbe0xrkBkHcWwdJRbG76px0ZNlphRbw0zQCrWIN7bVNaANFrVC88S4Yi8pG
	 T1IrJMQBkwDeHJ9xAL1mbn2m3y2JQpdfg20xzI+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbgCXR6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 13:58:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727333AbgCXR6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:58:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13D99206F6;
        Tue, 24 Mar 2020 17:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585072713;
        bh=3bq9xwRbw4as5OhWunjB4/vALijb9AU81xWgdEwbwrU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lVtTgwLS79keQu8s6Q3+aJdoGAA3d+B0OBRbvXk1FPpqh7yM33jqrb/eSL3UPE5Xq
         bBYfQOVVYhTcrM730DCLZotpxj/jv3ql/M7l1J4mhx0RmyeWle0n3Yww6KwtccNZDv
         eTpHjvmCUlYb7ahOlPCoSx4rYuCpyC1dBK8saZnk=
Date:   Tue, 24 Mar 2020 18:58:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        nicholas.johnson-opensource@outlook.com.au
Subject: Re: [PATCH 0/3] nvmem: use is_bin_visible callback
Message-ID: <20200324175831.GA2536632@kroah.com>
References: <20200324171600.15606-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324171600.15606-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 05:15:57PM +0000, Srinivas Kandagatla wrote:
> Hi Greg,
> 
> As suggested I managed to use is_bin_visible for the existing code and
> one cleanup for using device_register/unregister directly instead of splitting.
> 
> Note: this does not add any new functionality, its just a cleanup

I took patch 1 of this series already, as it was "obvious" :)

thanks,

greg k-h
