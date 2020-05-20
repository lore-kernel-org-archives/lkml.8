Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4138DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F329205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Xj4cuDUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgETNtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 09:49:17 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:12024 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726436AbgETNtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 09:49:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589982556; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=bdYxlleaBZjdmGcxkdFhFiwkox4BqXbXIZrOHd6Ou20=;
 b=Xj4cuDUe6ojzPIKgdLSkniQiWHdzH/19LFRVCBhxFAeGi2MIUmirwyys2XH6MnU9UQkQP7wC
 ZUadADORAFB3YthSLaMyLnSWBo9iFdkVWtSfJuvMk8CJw5x91ucYZOYXKkCzjz8Vma+NJ4XK
 0YLRpT3YvrwyQWUSmsER8U3QXTg=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec53551.7feb22d25848-smtp-out-n02;
 Wed, 20 May 2020 13:49:05 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E54FBC433C6; Wed, 20 May 2020 13:49:04 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rananta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 432AFC433C8;
        Wed, 20 May 2020 13:49:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 20 May 2020 06:49:04 -0700
From:   rananta@codeaurora.org
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Greg KH <gregkh@linuxfoundation.org>, andrew@daynix.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: hvc: Fix data abort due to race in hvc_open
In-Reply-To: <cb5bd2b2-f33a-b541-ed3c-70da14c7252d@suse.cz>
References: <20200428032601.22127-1-rananta@codeaurora.org>
 <20200506094851.GA2787548@kroah.com>
 <98bbe7afabf48d8e8fe839fdc9e836a5@codeaurora.org>
 <20200510064819.GB3400311@kroah.com>
 <77d889be4e0cb0e6e30f96199e2d843d@codeaurora.org>
 <20200511073913.GA1347819@kroah.com>
 <0f7791f5-0a53-59f6-7277-247a789f30c2@suse.cz>
 <20200512082551.GA3526567@kroah.com>
 <417b1d320bda37410788430979dd708d@codeaurora.org>
 <20200513070403.GB764901@kroah.com>
 <0ab0b49f19b824ac1c4db4c4937ed388@codeaurora.org>
 <cb5bd2b2-f33a-b541-ed3c-70da14c7252d@suse.cz>
Message-ID: <bf168752b8808182f07764fb6194775e@codeaurora.org>
X-Sender: rananta@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-20 02:38, Jiri Slaby wrote:
> On 15. 05. 20, 1:22, rananta@codeaurora.org wrote:
>> On 2020-05-13 00:04, Greg KH wrote:
>>> On Tue, May 12, 2020 at 02:39:50PM -0700, rananta@codeaurora.org 
>>> wrote:
>>>> On 2020-05-12 01:25, Greg KH wrote:
>>>> > On Tue, May 12, 2020 at 09:22:15AM +0200, Jiri Slaby wrote:
>>>> > > commit bdb498c20040616e94b05c31a0ceb3e134b7e829
>>>> > > Author: Jiri Slaby <jslaby@suse.cz>
>>>> > > Date:   Tue Aug 7 21:48:04 2012 +0200
>>>> > >
>>>> > >     TTY: hvc_console, add tty install
>>>> > >
>>>> > > added hvc_install but did not move 'tty->driver_data = NULL;' from
>>>> > > hvc_open's fail path to hvc_cleanup.
>>>> > >
>>>> > > IOW hvc_open now NULLs tty->driver_data even for another task which
>>>> > > opened the tty earlier. The same holds for
>>>> > > "tty_port_tty_set(&hp->port,
>>>> > > NULL);" there. And actually "tty_port_put(&hp->port);" is also
>>>> > > incorrect
>>>> > > for the 2nd task opening the tty.
>>>> > >
> 
> ...
> 
>> These are the traces you get when the issue happens:
>> [  154.212291] hvc_install called for pid: 666
>> [  154.216705] hvc_open called for pid: 666
>> [  154.233657] hvc_open: request_irq failed with rc -22.
>> [  154.238934] hvc_open called for pid: 678
>> [  154.243012] Unable to handle kernel NULL pointer dereference at
>> virtual address 00000000000000c4
>> # hvc_install isn't called for pid: 678 as the file wasn't closed yet.
> 
> Nice. Does the attached help?
Yeah, it looks good. I think it also eliminates the port.count reference
issue discussed on the v2 patch. Are you planning to mainline this?
> 
> I wonder how comes the tty_port_put in hvc_open does not cause a UAF? I
> would say hvc_open fails, tty_port_put is called. It decrements the
> reference taken in hvc_install. So far so good.
> 
> Now, this should happen IMO:
> tty_open
>   -> hvc_open (fails)
>     -> tty_port_put
hvc_console driver defines port->ops->destruct(). Upon tty_port_put(), 
the
tty_port_destructor() calls port->ops->destruct(), rather than 
kfree(port).
>   -> tty_release
>     -> tty_release_struct
>       -> tty_kref_put
>         -> queue_release_one_tty
> SCHEDULED WORKQUEUE
> release_one_tty
>   -> hvc_cleanup
>     -> tty_port_put (should die terrible death now)
Since port is not free'd, I think we should be good.
> 
> What am I missing?
> 
> thanks,

Thank you.
Raghavendra
