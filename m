Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615F0C35670
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 10:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A3E208C4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 10:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582452029;
	bh=xwKm9mG+11CRzycDripWRYB5FalIoOmjBWJgOiYvD5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dGg7EpK84j4GY747U1FDNUoLCTMz4/89Ydoss2NbS8338mEtD6TNVjqSu3h1LeOVG
	 UmQ1eavPnzjSuntmQmR9bRfmR5vwfYrapwfYf3IkwP54p/DXw0EiSjHHvxb8G32IjN
	 txcaizipUsdYjy6q4pp7r92MCcqpBLSnYjpvNGqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgBWKA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 05:00:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:44162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgBWKA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 05:00:26 -0500
Received: from localhost (95-141-97-180.as16211.net [95.141.97.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CC16206ED;
        Sun, 23 Feb 2020 10:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582452025;
        bh=xwKm9mG+11CRzycDripWRYB5FalIoOmjBWJgOiYvD5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NwryWQ5Goji2SiP6xJzMmh7wCi300mTSXPWWqyPuSGdZGL3+TXg/MKgteSFqqoFLa
         vqqDacaNByLoHmQQIHWfBnP8xK+rBbROt7YWk6Tf2cCbWOEgm+iLjcG0PSEFnradCr
         p1xCdrnh264QsepdCKdaenBu4e5yDT334vyn1CD0=
Date:   Sun, 23 Feb 2020 11:00:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Desmond Yan <desmond.yan@broadcom.com>,
        James Hu <james.hu@broadcom.com>
Subject: Re: [PATCH v2 6/7] misc: bcm-vk: add Broadcom VK driver
Message-ID: <20200223100022.GB120495@kroah.com>
References: <20200220004825.23372-1-scott.branden@broadcom.com>
 <20200220004825.23372-7-scott.branden@broadcom.com>
 <20200220074711.GA3261162@kroah.com>
 <ee53fe6f-53de-87c0-db16-989cc15abbce@broadcom.com>
 <CAK8P3a0y8RfjEng4AsMr4MAPGMTXduiFOyfUzazgw9c+KVWmYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0y8RfjEng4AsMr4MAPGMTXduiFOyfUzazgw9c+KVWmYA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 09:02:44AM +0100, Arnd Bergmann wrote:
> On Fri, Feb 21, 2020 at 7:19 PM Scott Branden
> <scott.branden@broadcom.com> wrote:
> > On 2020-02-19 11:47 p.m., Greg Kroah-Hartman wrote:
> 
> > > Have you worked with the V4L developers to tie this into the proper
> > > in-kernel apis for this type of functionality?
> > We looked at the V4L model doesn't have any support for anything we are
> > doing in this driver.
> > We also want a driver that doesn't care about video.  It could be
> > offloading crypto or other operations.
> > We talked with Olof about all of this previously and he said leave it as
> > a misc driver for now.
> > He was going to discuss at linux plumbers conference that we need some
> > sort of offload engine model that such devices could fit into.
> 
> I see. Have you looked at the "uacce" driver submission? It seems
> theirs is similar enough that there might be some way to share interfaces.
> 
> > > Using a tty driver seems like the totally incorrect way to do this, what
> > > am I missing?
> > tty driver is used to provide console access to the processors running
> > on vk.
> > Data is sent using the bcm_vk_msg interface by read/write operations
> > from user space.
> > VK then gets the messages and DMA's the data to/from host memory when
> > needed to process.
> 
> In turn here, it sounds like you'd want to look at what drivers/misc/mic/
> and the mellanox bluefield drivers are doing. As I understand, they have the
> same requirements for console, but have a nicer approach of providing
> abstract 'virtio' channels between the PCIe endpoint and the host, and
> then run regular virtio based drivers (console, tty, block, filesystem,
> network, ...) along with application specific ones to provide the custom
> high-level protocols. This is also similar to what the drivers/pci/endpoint
> (from the other end) as the drivers/ntb (pci host on both ends) frameworks
> and of course the rpmsg/remoteproc framework do.
> 
> In the long run, I would want much more consolidation between the
> low-level parts of all these frameworks, but moving your high-level
> protocols to the same virtio method would sound like a step in the
> direction towards a generialized framework and easier sharing of
> the abstractions.

I agree, please do not override the generic tty api with something so
hardware-specific like this as it really is not a serial device here.

thanks,

greg k-h
