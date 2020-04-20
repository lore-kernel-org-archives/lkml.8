Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADA2C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECB66206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="goQ2DYjO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgDTQdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725287AbgDTQdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 12:33:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CF0C025491;
        Mon, 20 Apr 2020 09:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=CvAAuoxWyufDWEFP6WEdB7uoSrO8WvrXLQoymRvBxWA=; b=goQ2DYjOqDYIjUoE1hbxb7KL5m
        kAAns3hsxydLwGCF628DLRfJUmcdZuDHht1BPGxhQgMr9Pd1pA8qQ+P5imIC6mULqPqu7u3eYP66c
        djemYJzRQONbt9Acpf16FDPboAZtKVz5HI1s/aMr09SnTLOjwNGFv52Djy91MpRlJcnrTyXQsKabl
        JeCcB7I5ysxZDfghDRWsWW/pF9Zt7U/eHdDSj0Rt3kjk8cX+jagkUUckmL+S1SbfvgoACMKIfwf0B
        2K84eS5Y8zveh/If0gJoMKbCD/QR6boyifR3RWO+oMLT3ZfWLGOkYDrAzVhgQ3uwbGVQvt1aPVsI4
        8Rs03b9w==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQZMT-00057w-QB; Mon, 20 Apr 2020 16:33:33 +0000
Subject: Re: linux-next: Tree for Apr 20 (media: usbvision)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20200420142610.390e5922@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <02165f8b-f19f-2293-065a-cf9ad4de9689@infradead.org>
Date:   Mon, 20 Apr 2020 09:33:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200420142610.390e5922@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/20 9:26 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20200417:
> 

on i386:
CONFIG_USB=m
CONFIG_VIDEO_USBVISION=y

ld: drivers/staging/media/usbvision/usbvision-core.o: in function `usbvision_write_reg_irq':
usbvision-core.c:(.text+0x8a4): undefined reference to `usb_submit_urb'
ld: drivers/staging/media/usbvision/usbvision-core.o: in function `usbvision_isoc_irq':
usbvision-core.c:(.text+0x2ee8): undefined reference to `usb_submit_urb'
ld: drivers/staging/media/usbvision/usbvision-core.o: in function `usbvision_read_reg':
usbvision-core.c:(.text+0x30ad): undefined reference to `usb_control_msg'
ld: drivers/staging/media/usbvision/usbvision-core.o: in function `usbvision_write_reg':
usbvision-core.c:(.text+0x3178): undefined reference to `usb_control_msg'
ld: drivers/staging/media/usbvision/usbvision-core.o: in function `usbvision_set_output':
usbvision-core.c:(.text+0x344e): undefined reference to `usb_control_msg'
ld: drivers/staging/media/usbvision/usbvision-core.o: in function `usbvision_set_input':
usbvision-core.c:(.text+0x3b9b): undefined reference to `usb_control_msg'
ld: drivers/staging/media/usbvision/usbvision-core.o: in function `usbvision_setup':
usbvision-core.c:(.text+0x4009): undefined reference to `usb_control_msg'
ld: drivers/staging/media/usbvision/usbvision-core.o:usbvision-core.c:(.text+0x417f): more undefined references to `usb_control_msg' follow
ld: drivers/staging/media/usbvision/usbvision-core.o: in function `usbvision_set_alternate':
usbvision-core.c:(.text+0x4518): undefined reference to `usb_set_interface'
ld: drivers/staging/media/usbvision/usbvision-core.o: in function `usbvision_init_isoc':
usbvision-core.c:(.text+0x4673): undefined reference to `usb_alloc_urb'
ld: usbvision-core.c:(.text+0x46a5): undefined reference to `usb_alloc_coherent'
ld: usbvision-core.c:(.text+0x4765): undefined reference to `usb_submit_urb'
ld: drivers/staging/media/usbvision/usbvision-core.o: in function `usbvision_stop_isoc':
usbvision-core.c:(.text+0x4837): undefined reference to `usb_kill_urb'
ld: usbvision-core.c:(.text+0x485f): undefined reference to `usb_free_coherent'
ld: usbvision-core.c:(.text+0x4874): undefined reference to `usb_free_urb'
ld: usbvision-core.c:(.text+0x48f1): undefined reference to `usb_set_interface'
ld: drivers/staging/media/usbvision/usbvision-video.o: in function `usbvision_release':
usbvision-video.c:(.text+0x1a8a): undefined reference to `usb_free_urb'
ld: drivers/staging/media/usbvision/usbvision-video.o: in function `usbvision_disconnect':
usbvision-video.c:(.text+0x1b74): undefined reference to `usb_put_dev'
ld: drivers/staging/media/usbvision/usbvision-video.o: in function `usbvision_radio_close':
usbvision-video.c:(.text+0x1c89): undefined reference to `usb_set_interface'
ld: drivers/staging/media/usbvision/usbvision-video.o: in function `usbvision_probe':
usbvision-video.c:(.text+0x1e4b): undefined reference to `usb_get_dev'
ld: usbvision-video.c:(.text+0x20e1): undefined reference to `usb_alloc_urb'
ld: usbvision-video.c:(.text+0x2797): undefined reference to `usb_put_dev'
ld: drivers/staging/media/usbvision/usbvision-video.o: in function `usbvision_exit':
usbvision-video.c:(.exit.text+0x37): undefined reference to `usb_deregister'
ld: drivers/staging/media/usbvision/usbvision-video.o: in function `usbvision_init':
usbvision-video.c:(.init.text+0xf9): undefined reference to `usb_register_driver'
ld: drivers/staging/media/usbvision/usbvision-i2c.o: in function `usbvision_i2c_write':
usbvision-i2c.c:(.text+0x2f4): undefined reference to `usb_control_msg'

-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
