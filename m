Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01C6C4BA01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 22:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA37E20732
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 22:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DyLkCv60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgBYWhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 17:37:41 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45618 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbgBYWhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 17:37:41 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22so408308pls.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 14:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ujUSpbSlCH5ZCbsE0Im09CK5jyllUEPbsT32AKCmZZ8=;
        b=DyLkCv60xAdLCmRKcDclI0CdjpCht6vI0Kff3FlLtJ7IJj+r1jKD0DZHiRDVNX9oU2
         4ILDtH0EHnHCBkWm9pY11x/hcehrKdRPZLnZ0B+wuKFb3zlDp6C5dn106hviyEbF5k2w
         /2q2TLjsB4pOYE7UmuaRr59Z8/Ete9pGvTXVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ujUSpbSlCH5ZCbsE0Im09CK5jyllUEPbsT32AKCmZZ8=;
        b=c2qGJQB/J9+xiAheHijCVXl9WV19DBliJp/hZ2CsGNtKNEH0OJ9PSIvdkNO14ecqd8
         Sf4lj4rWTUatPz++HWnc3oRQT0W7y8/1ZneZnbZmYPVlL//G0oGHgrqiBQHenudBAOhm
         7tIDbOWNnQvXVejmCj7jKTjIYNhHvp+Zvr0urnbFlSoQ9LYspKNvJaVJL0k4KtcT62Pf
         5IhMkiJVS7CicUiv/C9YDyCV6Jf5Hys1/JjBK68tAzGODmuxQTKXdjUnwRRFAEXBifyU
         xIZDA02HjSl+OXej6nppy3awmOsV+UAtQ/DguCu52Zd4Vud64OHrSxdqwdIqTY9bDG5A
         kcGQ==
X-Gm-Message-State: APjAAAXsZkGwb+ryHaMBiN47GxSzkjZorCaoZAHcMbQ6iUrm7v1C53vE
        eRs7Fv1q1BC5o2yYq/98re29Xg==
X-Google-Smtp-Source: APXvYqyClLjlKFFh151KqjRXFbjTgwsEjNcVLzqq++3PiVnTCzW7kl9YidPkNzPtFOSSHwlCCAAalw==
X-Received: by 2002:a17:902:bf41:: with SMTP id u1mr738034pls.207.1582670259870;
        Tue, 25 Feb 2020 14:37:39 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id x12sm111778pfr.47.2020.02.25.14.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 14:37:39 -0800 (PST)
Subject: Re: [PATCH v2 6/7] misc: bcm-vk: add Broadcom VK driver
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Desmond Yan <desmond.yan@broadcom.com>,
        James Hu <james.hu@broadcom.com>
References: <20200220004825.23372-1-scott.branden@broadcom.com>
 <20200220004825.23372-7-scott.branden@broadcom.com>
 <20200220074711.GA3261162@kroah.com>
 <ee53fe6f-53de-87c0-db16-989cc15abbce@broadcom.com>
 <CAK8P3a0y8RfjEng4AsMr4MAPGMTXduiFOyfUzazgw9c+KVWmYA@mail.gmail.com>
 <CAOesGMj423YXNhk_vFE0ueNjzbYoD0wQ68jJApewZS8qtVX3=g@mail.gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <d35204c1-054e-ec5b-069b-42a053a3863f@broadcom.com>
Date:   Tue, 25 Feb 2020 14:37:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAOesGMj423YXNhk_vFE0ueNjzbYoD0wQ68jJApewZS8qtVX3=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof/All,

I'm trying to digest all the feedback of what needs to be done.
I will be fixing up all the valuable comments about general issues but 
would like to know
what needs to be done about the tty interface.

The VK devices are configured to write serial data to circular buffers 
in memory or out a UART.
When we configure a system using the UART we connect a cable to the host 
and open a tty device.
When we don't connect a UART cable to the host we open the tty device in 
our driver instead.
In this case the memory is exposed to the host via PCI BAR memory space.
The bcm-vk host driver then accesses PCI space and presents a tty 
interface to the host.
We implemented a tty device to present the tty interface.
Host doesn't change anything other than opening a different devnode in 
UART vs. PCI case.

Based on all the comments: what interface should we be providing in 
driver instead?

On 2020-02-23 3:55 p.m., Olof Johansson wrote:
> On Sat, Feb 22, 2020 at 12:03 AM Arnd Bergmann <arnd@arndb.de> wrote:
>> On Fri, Feb 21, 2020 at 7:19 PM Scott Branden
>> <scott.branden@broadcom.com> wrote:
>>> On 2020-02-19 11:47 p.m., Greg Kroah-Hartman wrote:
>>>> Have you worked with the V4L developers to tie this into the proper
>>>> in-kernel apis for this type of functionality?
>>> We looked at the V4L model doesn't have any support for anything we are
>>> doing in this driver.
>>> We also want a driver that doesn't care about video.  It could be
>>> offloading crypto or other operations.
>>> We talked with Olof about all of this previously and he said leave it as
>>> a misc driver for now.
>>> He was going to discuss at linux plumbers conference that we need some
>>> sort of offload engine model that such devices could fit into.
>> I see. Have you looked at the "uacce" driver submission? It seems
>> theirs is similar enough that there might be some way to share interfaces.
> Uacce isn't a driver (or wasn't last time I looked at it, when it had
> a different name). It's more of a framework for standardized direct HW
> access from userspace, and relies on I/O virtualization to keep DMA
> secure/partitioned, etc. VK is more of a classic PCIe device, it'll
> handle DMA to/from the host, etc.
>
>>>> Using a tty driver seems like the totally incorrect way to do this, what
>>>> am I missing?
>>> tty driver is used to provide console access to the processors running
>>> on vk.
>>> Data is sent using the bcm_vk_msg interface by read/write operations
>>> from user space.
>>> VK then gets the messages and DMA's the data to/from host memory when
>>> needed to process.
>> In turn here, it sounds like you'd want to look at what drivers/misc/mic/
>> and the mellanox bluefield drivers are doing. As I understand, they have the
>> same requirements for console, but have a nicer approach of providing
>> abstract 'virtio' channels between the PCIe endpoint and the host, and
>> then run regular virtio based drivers (console, tty, block, filesystem,
>> network, ...) along with application specific ones to provide the custom
>> high-level protocols.
> This has more value on the device than on the host, as far as I've
> seen it used (if you want to boot Linux on it and have things
> exposed).
>
> virtio isn't necessarily a match if all you really want is a character
> stream for a console and don't need (or have performance requirements
> beyond what virtio offers) other types of communication.
>
>> This is also similar to what the drivers/pci/endpoint
>> (from the other end) as the drivers/ntb (pci host on both ends) frameworks
>> and of course the rpmsg/remoteproc framework do.
> remoteproc is more about booting a tightly integrated device on an
> embedded system. Also not a match here IMHO.
>
>> In the long run, I would want much more consolidation between the
>> low-level parts of all these frameworks, but moving your high-level
>> protocols to the same virtio method would sound like a step in the
>> direction towards a generialized framework and easier sharing of
>> the abstractions.
> For a simple naive console/character stream, doing something on top of
> hvc might be easier -- it already does polling for you, etc.
>
> Of course, the intent is not to ever use it as a console for the host
> here, so that aspect of hvc isn't useful. But it gives you a bunch of
> other stuff for free with just getchar/putchar interfaces to
> implement.
>
>
> -Olof

