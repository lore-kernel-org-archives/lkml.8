Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3ACC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20D6520748
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590072495;
	bh=I2YFyPcPI3f0/PWUh0s9kge175isnr5X0AFtDxs5Ijs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=bn0wmW8D5xn6cESAo8I19iXXWIS6M4cPgNCwmP41jOdee7NoYt56G+QVYp7Hs9I8o
	 q9n4y/WTPZFkXCb0C+zp/236o0N4RZHoHvoIQdG+5KLuNjF3C8LEvCfHBdop2T9wO+
	 1Wt4KzAJN3LGzgF1Mn2kNkiQH/w+4rCDsGk7z3pQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbgEUOsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 10:48:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728229AbgEUOsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:48:14 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1DD320748;
        Thu, 21 May 2020 14:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590072493;
        bh=I2YFyPcPI3f0/PWUh0s9kge175isnr5X0AFtDxs5Ijs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SxvUetC5XaFSj8lCbYHNK1Dvz3JgKT+AT7dUml8T4fv2BO16vDcic+97YOVEn7Rux
         CSfToyq/gG7NCgaWaB/SfKjBlh5xnTWLRdMPvLscjG8HWmfZRouKhl55oLKTizm/M7
         ZKAVzthlyzlzfx/2Tqhdl3XlFjjsN5yYrXabkwE4=
Message-ID: <0bc8334572c0716e8dcad2ec3b623f20cefdfde3.camel@kernel.org>
Subject: Re: INFO: task hung in locks_remove_posix
From:   Jeff Layton <jlayton@kernel.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+f5bc30abd8916982419c@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 21 May 2020 10:48:11 -0400
In-Reply-To: <9a337dfa-175f-e13b-1977-0f63d589f37c@I-love.SAKURA.ne.jp>
References: <000000000000c866c705a61a95d4@google.com>
         <9a337dfa-175f-e13b-1977-0f63d589f37c@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-05-21 at 23:09 +0900, Tetsuo Handa wrote:
> On 2020/05/21 5:53, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    806d8acc USB: dummy-hcd: use configurable endpoint naming ..
> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16c9ece2100000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=d800e9bad158025f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=f5bc30abd8916982419c
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > 
> > Unfortunately, I don't have any reproducer for this crash yet.
> 
> This seems to be a mislabeling due to '?' in all lines in a trace.
> 
> #syz dup: INFO: task hung in wdm_flush


I'm not sure I trust those stack traces. The console output shows '?'
characters in front of every frame. Doesn't that mean that that address
it found on the stack is unreliable?

In principle, unless you're overriding the filp->lock operation (and the
wdm fs doesn't do that, afaict), locks_remove_posix should not block.
I'll also note that there is some of this in the logs before the hung
task warnings:

[  182.020388][   T12] usb 5-1: too many endpoints for config 0 interface 107 altsetting 116: 116, using maximum allowed: 30
[  182.031661][   T12] usb 5-1: config 0 interface 107 altsetting 116 has 0 endpoint descriptors, different from the interface descriptor's value: 116
[  182.045145][   T12] usb 5-1: config 0 interface 107 has no altsetting 0
[  182.052028][   T12] usb 5-1: New USB device found, idVendor=0926, idProduct=3333, bcdDevice= 0.40
[  182.060120][ T3525] usb 6-1: USB disconnect, device number 20
[  182.061148][    C0] xpad 6-1:0.65: xpad_irq_out - usb_submit_urb failed with result -19
[  182.075465][ T3525] xpad 6-1:0.65: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
[  182.075565][   T12] usb 5-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[  182.109020][   T12] usb 5-1: config 0 descriptor??
[  182.136857][  T163] usb usb2-port1: attempt power cycle
[  182.410396][ T4447] udc-core: couldn't find an available UDC or it's busy
[  182.417562][ T4447] misc raw-gadget: fail, usb_gadget_probe_driver returned -16
[  182.856513][  T163] usb 2-1: new high-speed USB device number 18 using dummy_hcd
[  183.026601][  T163] usb 2-1: device descriptor read/8, error -61
[  183.236577][  T163] usb 2-1: device descriptor read/8, error -71
[  184.068991][ T3525] usb 5-1: USB disconnect, device number 21
[  206.185571][   T23] INFO: task syz-executor.2:3145 blocked for more than 143 seconds.
[  206.193630][   T23]       Not tainted 5.7.0-rc5-syzkaller #0
[  206.199512][   T23] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  206.208242][   T23] syz-executor.2  D28552  3145    370 0x80004006

...which leads me to believe that this might have more to do with the
USB subsystem than anything in the posix locking code.

In any case, I doubt there's much we can do here without a more reliable
stack trace to work from. That call stack doesn't seem to make much
sense.

-- 
Jeff Layton <jlayton@kernel.org>

