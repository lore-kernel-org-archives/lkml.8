Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C763CC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 11:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9301D208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 11:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599220236;
	bh=CX4Fx+ljNJz72Gq5RXYtDsfvmEFGLI60o0LE+qlZJ/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DZPuQnnkZnUfSvlPDEXLd3qevV4CdPgsJ4g8znxuZV2xIpko7JAhQx/AF8cviG28+
	 jtquZDc5IR2IVDP+KZ+yZGk6jSlhyrGa8mu+cJWAoxFaXJBXpDVE5MoHTCDEBqOamE
	 bZPAo5YM/fMCW0gKuJpBTu0N3doEEhPXpuhocU6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbgIDLue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 07:50:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728588AbgIDLu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 07:50:27 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55DB1208CA;
        Fri,  4 Sep 2020 11:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599220226;
        bh=CX4Fx+ljNJz72Gq5RXYtDsfvmEFGLI60o0LE+qlZJ/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sXLr2SJTptnuOGb8LlvqRnMpB8qmE+lct19SyOZy2RMtSnXnBqCPABzg5rwbE7bbw
         xMkthJfAvfwGmV+aZV/9+JYn3mh1yWIyZW5n4KQbVnbLPLwGteoKUA1asmeWX2/TZv
         oZ+Cd6WpDmXHlih/fiWy56ug8W/jFoO1cvMZP04U=
Date:   Fri, 4 Sep 2020 13:50:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vladis Dronov <vdronov@redhat.com>
Cc:     ap420073@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH] debugfs: Fix module state check condition
Message-ID: <20200904115048.GA2964117@kroah.com>
References: <20200811150129.53343-1-vdronov@redhat.com>
 <20200904114207.375220-1-vdronov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904114207.375220-1-vdronov@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 01:42:07PM +0200, Vladis Dronov wrote:
> Hello,
> 
> Dear maintainers, could you please look at the above patch, that
> previously was sent during a merge window?
> 
> A customer which has reported this issue replied with a test result:
> 
> > I ran the same test.
> > Started ib_write_bw traffic and started watch command to read RoCE
> > stats : watch -d -n 1 "cat /sys/kernel/debug/bnxt_re/bnxt_re0/info".
> > While the command is running, unloaded roce driver and I did not
> > observe the call trace that was seen earlier.

It's in my queue, but bugs you can only trigger while root are a bit
lower on the priority list :)

thanks,

greg k-h
