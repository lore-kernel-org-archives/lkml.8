Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6406CC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 07:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286AE20658
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 07:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pdZwL4yt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgCaHHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 03:07:36 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55675 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgCaHHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 03:07:35 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200331070734euoutp0186814c20d3dc3a3aa4da08b2b6577989~BUcXca4WJ0528805288euoutp01L
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 07:07:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200331070734euoutp0186814c20d3dc3a3aa4da08b2b6577989~BUcXca4WJ0528805288euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585638454;
        bh=FHPlB9rXvFo9ElX6c8lgznbYAuGDSgmSQuUUt1xIohU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=pdZwL4ytdijADVA7rh3RW45ym9zJrRZCvofHM+umeh/K3h+HIbPpomvQwW3pMXxGG
         nRKRqdjMRsO+EEF0EyW5piztAim/JK1qCqkEVwg+prHlSuUfYsdkgi7Z8GDgIEF2+0
         zhbfoDLenCpIPpcKz0SV/SGJCis4KDcpTPJ4kaIc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200331070733eucas1p2dd8cd2c3c7183e82f3b08ef6bd64dd69~BUcXWk1Y91386513865eucas1p2z;
        Tue, 31 Mar 2020 07:07:33 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 55.47.60679.53CE28E5; Tue, 31
        Mar 2020 08:07:33 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200331070733eucas1p2fd2f9897642024d8c68968506f15cd3e~BUcXBZATF1384913849eucas1p23;
        Tue, 31 Mar 2020 07:07:33 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200331070733eusmtrp1972390906eb3455c88a924ea65973345~BUcXAw1On1264812648eusmtrp1j;
        Tue, 31 Mar 2020 07:07:33 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-ee-5e82ec35e8c4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 92.10.08375.53CE28E5; Tue, 31
        Mar 2020 08:07:33 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200331070733eusmtip1c3ecf767d3e4450845468627465f568b~BUcWlymd50169901699eusmtip1Y;
        Tue, 31 Mar 2020 07:07:33 +0000 (GMT)
Subject: Re: [PATCH v1] driver core: Fix handling of fw_devlink=permissive
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <a34d104a-f8e2-7977-34a5-effb7efcf288@samsung.com>
Date:   Tue, 31 Mar 2020 09:07:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAGETcx8aW-EY+bGEPr+20bZUF-=ghZDPyQ8AdU7eYYd-wOvekA@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7djP87qmb5riDH6sNrdoXryezWLHdhGL
        y7vmsFnM/TKV2aLr0F82B1aPbbu3sXos2FTqsWlVJ5vH/rlr2D0+b5ILYI3isklJzcksSy3S
        t0vgyljT9Iel4LpIxf7XH5kaGGcLdjFyckgImEgsnrmLqYuRi0NIYAWjxOszX5khnC+MEitW
        H4JyPjNKPNzbzA7T8n7FTGYQW0hgOaPEv02sEEXvGSXeXt4ClhAW8JLo3HmHFcQWEdCS2HTt
        MQtIEbPAFkaJtVP2gk1iEzCU6HrbxQZi8wrYSZz7Nw2smUVAVeLI3ydMILaoQIzExcP9rBA1
        ghInZz5hAbE5BQIlzt+bCFbDLCAvsf3tHGYIW1zi1pP5YA9JCMxjl9j87hgjxNkuEgf2X2eB
        sIUlXh3fAvWOjMTpyT0sEA3NQH+eW8sO4fQwSlxumgHVbS1x59wvoFM5gFZoSqzfpQ8RdpR4
        87kBLCwhwCdx460gxBF8EpO2TWeGCPNKdLQJQVSrScw6vg5u7cELl5gnMCrNQvLaLCTvzELy
        ziyEvQsYWVYxiqeWFuempxYb5aWW6xUn5haX5qXrJefnbmIEppvT/45/2cG460/SIUYBDkYl
        Ht4HVxvjhFgTy4orcw8xSnAwK4nwsvk3xAnxpiRWVqUW5ccXleakFh9ilOZgURLnNV70MlZI
        ID2xJDU7NbUgtQgmy8TBKdXAuCtFT2bqsQWB74MMul20E9p5fF63MRhNFtjf6TJxru+b7XHP
        ec4u/+mtYB/iEHpkYvfX12WyXFEfXwd6RTJNvdwx5dZ1xldzDA7evXT9cwfjRSbPTQrSk7a/
        K7M8LS3keXBmqJ6X455g9uDnc8PnrbR/eLwr+4W2yOSjfcb8qy6vtt+iNem+mBJLcUaioRZz
        UXEiAKttXCszAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsVy+t/xu7qmb5riDOZtkrdoXryezWLHdhGL
        y7vmsFnM/TKV2aLr0F82B1aPbbu3sXos2FTqsWlVJ5vH/rlr2D0+b5ILYI3SsynKLy1JVcjI
        Ly6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy1jT9Iel4LpIxf7XH5ka
        GGcLdjFyckgImEi8XzGTGcQWEljKKDHtnDlEXEbi5LQGVghbWOLPtS42iJq3jBI7LySA2MIC
        XhKdO++A1YgIaElsuvaYpYuRi4NZYBujRMPhwywQDV1MEiculIPYbAKGEl1vIQbxCthJnPs3
        DWwxi4CqxJG/T5hAbFGBGImfe7pYIGoEJU7OfAJmcwoESpy/NxGshlnATGLe5ofMELa8xPa3
        c6BscYlbT+YzTWAUmoWkfRaSlllIWmYhaVnAyLKKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMj
        MLa2Hfu5eQfjpY3BhxgFOBiVeHgfXG2ME2JNLCuuzD3EKMHBrCTCy+bfECfEm5JYWZValB9f
        VJqTWnyI0RTouYnMUqLJ+cC4zyuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE
        08fEwSnVwCjidUdtQWCWteMG92/m0xw+zL7cy3cpIGNaSvD6boUfjOLik4O39y72Fn3I+kyX
        Mc4/7hn7feU9E84t173i8pAvSVzInJX7yaaVux4qT77f1BRy+OIto7Phix6oLvw9u/HlUU5N
        udKMlbvLw4u/TIzXu2d858FNgxnbZkY8d3DN6Cm2chcO+abEUpyRaKjFXFScCACzQkNNwwIA
        AA==
X-CMS-MailID: 20200331070733eucas1p2fd2f9897642024d8c68968506f15cd3e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200331022842eucas1p29e52dc93c4bd0b6e470c41aef19c9a86
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200331022842eucas1p29e52dc93c4bd0b6e470c41aef19c9a86
References: <CGME20200331022842eucas1p29e52dc93c4bd0b6e470c41aef19c9a86@eucas1p2.samsung.com>
        <20200331022832.209618-1-saravanak@google.com>
        <781eefdc-c926-7566-5305-bb9633e6fac0@samsung.com>
        <CAGETcx8aW-EY+bGEPr+20bZUF-=ghZDPyQ8AdU7eYYd-wOvekA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2020-03-31 08:18, Saravana Kannan wrote:
> On Mon, Mar 30, 2020 at 10:43 PM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> Hi,
>>
>> On 2020-03-31 04:28, Saravana Kannan wrote:
>>> When commit 8375e74f2bca ("driver core: Add fw_devlink kernel
>>> commandline option") added fw_devlink, it didn't implement "permissive"
>>> mode correctly.
>>>
>>> That commit got the device links flags correct to make sure unprobed
>>> suppliers don't block the probing of a consumer. However, if a consumer
>>> is waiting for mandatory suppliers to register, that could still block a
>>> consumer from probing.
>>>
>>> This commit fixes that by making sure in permissive mode, all suppliers
>>> to a consumer are treated as a optional suppliers. So, even if a
>>> consumer is waiting for suppliers to register and link itself (using the
>>> DL_FLAG_SYNC_STATE_ONLY flag) to the supplier, the consumer is never
>>> blocked from probing.
>>>
>>> Fixes: 8375e74f2bca ("driver core: Add fw_devlink kernel commandline option")
>>> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>>> ---
>>> Hi Marek,
>>>
>>> If you pull in this patch and then add back in my patch that created the
>>> boot problem for you, can you see if that fixes the boot issue for you?
>> Indeed, this fixes booting on my Raspberry Pi3/4 boards with linux
>> next-20200327. Thanks! :)
> Hi Marek,
>
> Thanks for testing, but I'm not able to find the tag next-20200327.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?h=next-20200327

> I
> can only find next-20200326 and next-20200330. I was just trying to
> make sure that next-20200327 doesn't have the revert Greg did. I'm
> guessing you meant next-20200326?

I did my test on next-20200327.

$ git log --oneline next-20200327 -- drivers/base/core.c
d3ef0815f924 Merge remote-tracking branch 'driver-core/driver-core-next'
c442a0d18744 driver core: Set fw_devlink to "permissive" behavior by default
4dbe191c046e driver core: Add device links from fwnode only for the 
primary device
1d3435793123 Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
9a2dd570591e Merge 5.6-rc5 into driver-core-next
9211f0a6a91a driver core: fw_devlink_flags can be static
68464d79015a driver core: Add missing annotation for 
device_links_write_lock()
ab7789c5174c driver core: Add missing annotation for 
device_links_read_lock()
8375e74f2bca driver core: Add fw_devlink kernel commandline option
^C

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

