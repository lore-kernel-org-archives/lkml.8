Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E40C2D0EB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 06:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202BE2078B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 06:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ec+UG6k3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgC3GU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 02:20:29 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46373 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbgC3GU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 02:20:28 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200330062026euoutp01cdbb8c79f56ee209d3b23cd433c0064a~BAJ7ag-Jd1010110101euoutp014
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 06:20:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200330062026euoutp01cdbb8c79f56ee209d3b23cd433c0064a~BAJ7ag-Jd1010110101euoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585549226;
        bh=nsIfS6BnmjJA8Lt919nWtF036B/rzvBikihgl7w5WIk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Ec+UG6k3+xA2J4v4AcJNd84aJDUOQBl2AO+FBu8KvUtlqKnV1KJ8sEi2YlVcpWcM9
         rIvAqTjIhURan9uODCxO1iXofnAyWTLDw9h//I3VapKv8qhT452UrYengzQd3Rm186
         yG2qd1/ckgx9Sju4V2JLePIfffAvYv91gJVGz3Ho=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200330062025eucas1p1aa51b3df54c37aae5f1cbec85b941d2d~BAJ7FBuGL3253432534eucas1p17;
        Mon, 30 Mar 2020 06:20:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B9.3A.61286.9AF818E5; Mon, 30
        Mar 2020 07:20:25 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200330062025eucas1p143ff4a865cb9ed37a28507033a601276~BAJ6oLSz23252332523eucas1p19;
        Mon, 30 Mar 2020 06:20:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200330062025eusmtrp2e73997cc62fee5718b621d5a64b1c933~BAJ6nEgvx2090220902eusmtrp2r;
        Mon, 30 Mar 2020 06:20:25 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-74-5e818fa92ed8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 03.30.08375.9AF818E5; Mon, 30
        Mar 2020 07:20:25 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200330062024eusmtip13be868ceaa19317d913e9c15ffde358f~BAJ6FZsRQ0535305353eusmtip1G;
        Mon, 30 Mar 2020 06:20:24 +0000 (GMT)
Subject: Re: [RFC PATCH v1] driver core: Set fw_devlink to "permissive"
 behavior by default
To:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <4f3326c2-186d-2853-fcb6-1210d67a836f@samsung.com>
Date:   Mon, 30 Mar 2020 08:20:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAGETcx-J+TP+0NsOe75Uu3Q8K6=qYja6eDbjNH2764QV53=nMA@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djPc7or+xvjDHomaVrMP3KO1WLmm/9s
        Fs2L17NZ7NguYnF51xw2i7lfpjJbtO49wm7RdegvmwOHx7bd21g9ds66y+6xYFOpx6ZVnWwe
        ++euYff4vEkugC2KyyYlNSezLLVI3y6BK2Nu7yH2ggbRiieL+BsYDwh2MXJySAiYSDy5fJyx
        i5GLQ0hgBaNE59rtzBDOF0aJY5M62CGcz4wS044/Z4Np+XdzLRNEYjmjxMIn7UAtHEDOe0aJ
        ry4gNcICsRKb9h1lBwmLANmf34HNYRZYzSRxrfMEO0gNm4ChRNfbLrCZvAJ2Em/eTgSzWQRU
        JeZO2sEKYosKxEhcPNzPClEjKHFy5hMWEJtTIFDi/9TnYHFmAXmJ5q2zmSFscYlbT+YzQdy5
        i11i90xXCNtFYt/PlawQtrDEq+Nb2CFsGYn/O+eD/SIh0Mwo8fDcWnYIp4dR4nLTDEaIKmuJ
        O+d+sYF8wyygKbF+lz6IKSHgKPF1vzaEySdx460gxAl8EpO2TWeGCPNKdLQJQcxQk5h1fB3c
        1oMXLjFPYFSaheSxWUiemYXkmVkIaxcwsqxiFE8tLc5NTy02zEst1ytOzC0uzUvXS87P3cQI
        TEan/x3/tIPx66WkQ4wCHIxKPLwztjbECbEmlhVX5h5ilOBgVhLhZfMHCvGmJFZWpRblxxeV
        5qQWH2KU5mBREuc1XvQyVkggPbEkNTs1tSC1CCbLxMEp1cDoLRw6wWdWyKYrTdltV/svsSQq
        3SuKkfk/Rcf+Tok5H+fZKDv29gjDee0uc//FWuzcOzH7w4cE/b2L7mu+uKhcWDfr6Idf+nMT
        Nl4NurPp8a0a/5e+oYmvf3ycJMvLlV3LPNFksqOSwZGe7BcM8U2tbl/brjr8r7/cLMWwpFB4
        7iuN80+bpbiVWIozEg21mIuKEwFZMScSQgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xu7or+xvjDBofcVnMP3KO1WLmm/9s
        Fs2L17NZ7NguYnF51xw2i7lfpjJbtO49wm7RdegvmwOHx7bd21g9ds66y+6xYFOpx6ZVnWwe
        ++euYff4vEkugC1Kz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSez
        LLVI3y5BL2Nu7yH2ggbRiieL+BsYDwh2MXJySAiYSPy7uZapi5GLQ0hgKaPEiXNz2CESMhIn
        pzWwQtjCEn+udbFBFL1llLjZcJEFJCEsECuxad9RsAYRILtn1RR2kCJmgdVMElM2vmCB6NjA
        JPHodgszSBWbgKFE11uQUZwcvAJ2Em/eTgSzWQRUJeZO2gG2TlQgRuLnni4WiBpBiZMzn4DZ
        nAKBEv+nPgerYRYwk5i3+SEzhC0v0bx1NpQtLnHryXymCYxCs5C0z0LSMgtJyywkLQsYWVYx
        iqSWFuem5xYb6hUn5haX5qXrJefnbmIExuG2Yz8372C8tDH4EKMAB6MSD++MrQ1xQqyJZcWV
        uYcYJTiYlUR42fyBQrwpiZVVqUX58UWlOanFhxhNgZ6byCwlmpwPTBF5JfGGpobmFpaG5sbm
        xmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoYy1uUNh/ZVzZD9M0Etd0K3n8XCXytZpWZ
        st4vzzRbQuEw6605fjKMVZZ1/D9zbvPZXJ6kuDJisfukd98OCRVe1VWze1Hfm7r19+bfX4pF
        Ba6//9x2aMYLGcOrzqGiyY33Tk3UF2bw2x/o80bqQWL7waSgFfOfrt10f0G8wu7/DM92H/0V
        tz3IWImlOCPRUIu5qDgRAO8ScBrZAgAA
X-CMS-MailID: 20200330062025eucas1p143ff4a865cb9ed37a28507033a601276
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200327102554eucas1p1f848633a39f8e158472506b84877f98c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200327102554eucas1p1f848633a39f8e158472506b84877f98c
References: <20200321210305.28937-1-saravanak@google.com>
        <CGME20200327102554eucas1p1f848633a39f8e158472506b84877f98c@eucas1p1.samsung.com>
        <bd8b42d3-a35a-cc8e-0d06-2899416c2996@samsung.com>
        <20200327152144.GA2996253@kroah.com>
        <CAGETcx-J+TP+0NsOe75Uu3Q8K6=qYja6eDbjNH2764QV53=nMA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 2020-03-27 19:30, Saravana Kannan wrote:
> On Fri, Mar 27, 2020 at 8:21 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> On Fri, Mar 27, 2020 at 11:25:48AM +0100, Marek Szyprowski wrote:
>>> On 2020-03-21 22:03, Saravana Kannan wrote:
>>>> Set fw_devlink to "permissive" behavior by default so that device links
>>>> are automatically created (with DL_FLAG_SYNC_STATE_ONLY) by scanning the
>>>> firmware.
>>>>
>>>> This ensures suppliers get their sync_state() calls only after all their
>>>> consumers have probed successfully. Without this, suppliers will get
>>>> their sync_state() calls at late_initcall_sync() even if their consuer
>>>>
>>>> Ideally, we'd want to set fw_devlink to "on" or "rpm" by default. But
>>>> that needs more testing as it's known to break some corner case
>>>> drivers/platforms.
>>>>
>>>> Cc: Rob Herring <robh+dt@kernel.org>
>>>> Cc: Frank Rowand <frowand.list@gmail.com>
>>>> Cc: devicetree@vger.kernel.org
>>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>>> This patch has just landed in linux-next 20200326. Sadly it breaks
>>> booting of the Raspberry Pi3b and Pi4 boards, either in 32bit or 64bit
>>> mode. There is no warning nor panic message, just a silent freeze. The
>>> last message shown on the earlycon is:
>>>
>>> [    0.893217] Serial: 8250/16550 driver, 1 ports, IRQ sharing enabled
> Marek,
>
> Any chance you could get me a stack trace for when it's stuck? That'd
> be super helpful and I'd really appreciate it. Is it working fine on
> other variants of Raspberry?

I have no access to other variants of Raspberry board.

The issue seems to be related to bcm2835aux_serial_driver. I've added 
"initcall_debug" and "ignore_loglevel" to kernel cmdline and I got the 
following log:

[    4.595353] calling  exar_pci_driver_init+0x0/0x30 @ 1
[    4.600597] initcall exar_pci_driver_init+0x0/0x30 returned 0 after 
44 usecs
[    4.607747] calling  bcm2835aux_serial_driver_init+0x0/0x28 @ 1

The with some debug printk calls I've found that the clock lookup fails 
with -517 (-EPROBE_DEFER) in bcm2835aux_serial_driver: 
https://elixir.bootlin.com/linux/v5.6/source/drivers/tty/serial/8250/8250_bcm2835aux.c#L52

Without this patch, the lookup works fine.

Please let me know if you need more information. The kernel cmdline I've 
use is: "8250.nr_uarts=1 console=ttyS0,115200n8 
earlycon=uart8250,mmio32,0x3f215040 root=/dev/mmcblk0p2 rootwait rw", 
kernel is compiled with bcm2835_defconfig, booted on Raspberry Pi3b+ 
with arch/arm/boot/dts/bcm2837-rpi-3-b.dtb

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

