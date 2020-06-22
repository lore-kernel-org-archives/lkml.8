Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DD3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 00:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80DA92531B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 00:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cLSG5wJt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730995AbgFVAdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 20:33:36 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:33241 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgFVAdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 20:33:35 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200622003331epoutp030fd8d3361de71e27177678a0c5b2e3a3~atnBY4oAd1175211752epoutp03k
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 00:33:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200622003331epoutp030fd8d3361de71e27177678a0c5b2e3a3~atnBY4oAd1175211752epoutp03k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592786011;
        bh=4SiNqDCVDcqfE5szDuvhRjKGlENHuU7u1qKt2QTVJ3I=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=cLSG5wJtpA/eA8SgmaaaAXIntR+egBdnQ5QsZst8dEAG24G3IrqjUHe+QcSiLARa7
         THf4a+6iU+jBvSTCUD4DajhatBJPcfHpAnZGPL7oxWoRXnm3n+nzoXd4QL6OOMPZZ5
         sGmsRvHywIvwKgQxw+0wkRI22GuChm7Xu3+jVkdU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200622003331epcas1p4a633442df0ff69d93d9c2b5654196b05~atnBA2CNx2214822148epcas1p4y;
        Mon, 22 Jun 2020 00:33:31 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.161]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 49qr4B3PrnzMqYkh; Mon, 22 Jun
        2020 00:33:30 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        B0.9F.28578.A5CFFEE5; Mon, 22 Jun 2020 09:33:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200622003329epcas1p1ae0bb8f2652a9f350e5db9688ddb906d~atm-kIjME0189001890epcas1p1v;
        Mon, 22 Jun 2020 00:33:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200622003329epsmtrp1aa4654e323de0f100614d64b9e6fd31f~atm-jfIIM0832908329epsmtrp1x;
        Mon, 22 Jun 2020 00:33:29 +0000 (GMT)
X-AuditID: b6c32a39-8dfff70000006fa2-9f-5eeffc5a1298
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.7F.08382.95CFFEE5; Mon, 22 Jun 2020 09:33:29 +0900 (KST)
Received: from [10.253.105.155] (unknown [10.253.105.155]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200622003329epsmtip24f83689fd80193be4905a39b19599e72~atm-VMlFV0734207342epsmtip2h;
        Mon, 22 Jun 2020 00:33:29 +0000 (GMT)
Subject: Re: New mode DM-Verity error handling
To:     Mike Snitzer <snitzer@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>
Cc:     dm-devel@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, agk@redhat.com, corbet@lwn.net
From:   JeongHyeon Lee <jhs2.lee@samsung.com>
Message-ID: <3df0c938-6b7d-4c02-e243-22e0d95e3de0@samsung.com>
Date:   Mon, 22 Jun 2020 09:27:27 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200618170952.GA18057@redhat.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmgW7Un/dxBqcOSVqsP3WM2eLJgXZG
        i73vZrNaLGxbwmJxedccNoulK96yWrRt/MrowO6xYFOpx+K+yawe7/ddZfP4vEkugCUqxyYj
        NTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6AAlhbLEnFKg
        UEBicbGSvp1NUX5pSapCRn5xia1SakFKToGhQYFecWJucWleul5yfq6VoYGBkSlQZUJOxp9j
        61gLeuUqOneeZGpgbJPoYuTkkBAwkZg2ZwpzFyMXh5DADkaJ3deWMEI4nxglnl3sZ4VwvjFK
        7DrXygrTsrexlwXEFhLYyyhxeY4aRNF7Roktm2aBFQkL6El87PwKZosIBEjc//SOEcRmFiiS
        6P38FizOJqAtcbtlEzuIzStgJzFx/VegOzg4WARUJTZsFwIJiwpESNw/toEVokRQ4uTMJ2B7
        OQUMJJZ+b2SCGCkv0bx1NjOELS5x68l8JpB7JARaOSSu/VrOCHG0i8T7d3+gHhCWeHV8CzuE
        LSXxsr8Nyi6XuNJ0Gaq+RmLChW6oemOJ+S0LwW5jFtCUWL9LHyKsKLHz91yot/gk3n3tYQUp
        kRDglehoE4IoUZJY8e8aC4QtIbHhcDcbhO0hsbR1OusERsVZSD6bheSbWUi+mYWweAEjyypG
        sdSC4tz01GLDAlPkuN7ECE6bWpY7GKe//aB3iJGJg/EQowQHs5II7+uAd3FCvCmJlVWpRfnx
        RaU5qcWHGE2BQT2RWUo0OR+YuPNK4g1NjYyNjS1MzMzNTI2VxHmdrC/ECQmkJ5akZqemFqQW
        wfQxcXBKNTCFyzl4JXZsv1si8C4pOGfxhbOcnrWtzNa3Pncc+RQ5S/9aqHGX+7H9shc3vfO6
        rb15iZ5vyubabaLnj18P/lfyrUZMffcd7Sf8mmeLP+wUtDnbH9z/R7Kw09Bm39Wu7i8x3vpn
        DnNN/rrnq+itX6GT72S6V0b8CU089kHxeWdsOtOxmA95/z9zu01Rln1/fFKcUPg8Seu1QQ86
        v98OV8wW8MicGpN17/PZWaohqr6ZHwJZCtTFH++cs9pRqfLQxJdVFv8X1P79PWHuUa6lpnva
        0p/6NvTo7/Gepns19tGC4tqCiL6Xe1I7zZquf11yvORa4bKfkRNzbhwWNGXwqruxVWTGYeEt
        4jz1x+4t28+sxFKckWioxVxUnAgAxvR3gCQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsWy7bCSvG7kn/dxBt/eG1msP3WM2eLJgXZG
        i73vZrNaLGxbwmJxedccNoulK96yWrRt/MrowO6xYFOpx+K+yawe7/ddZfP4vEkugCWKyyYl
        NSezLLVI3y6BK+PPsXWsBb1yFZ07TzI1MLZJdDFyckgImEjsbexlAbGFBHYzSjycZA8Rl5DY
        sGktexcjB5AtLHH4cHEXIxdQyVtGiZ6ex4wgNcICehIfO7+ygtgiAn4Sk48/YwaxmQWKJHbe
        PskE0dDMJHF78WQ2kASbgLbE7ZZN7CA2r4CdxMT1X5lBFrAIqEps2C4EEhYViJA4834FC0SJ
        oMTJmU/AbE4BA4ml3xuZIOabSczb/BBql7xE89bZULa4xK0n85kmMArNQtI+C0nLLCQts5C0
        LGBkWcUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERwnWpo7GLev+qB3iJGJg/EQowQH
        s5II7+uAd3FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeW8ULowTEkhPLEnNTk0tSC2CyTJxcEo1
        MKWVSHK4Ghg8vm206rCqQVnsav/Kqy0Hj7WoTVJ68/Uxy9HFoekex95VtkzRbfi30snu2Iwu
        m1Kvxw7iclI+z36v8iuaXn7gx+wdqj/KbjE53MiqWtnYK/d5xukuiUmW/dsYjyj9tpn5ZKba
        +jWc4du8Hqyvn/pMXGdPj5KG68QX73handKkY49cXVuQpyQc9G+J7ptbh7V/ljD8u/1WY0OP
        JEcxj8WSmX1PbCZuMjk3d6vi1aUCewOEGFVLBHond/zk3FdSf/fY4e/egjKbN5yb8Mv1k62A
        1/7tDR/mi5q1ZXpe408yd9t01eJ2ErPU7Z1f5qlekRd4qnrf2bpoIfOSJxzF/xobXx/L3/Rq
        dokSS3FGoqEWc1FxIgBvTZqGAgMAAA==
X-CMS-MailID: 20200622003329epcas1p1ae0bb8f2652a9f350e5db9688ddb906d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200618070250epcas1p409eb2ddd19ecc5d55c219ac3dc884f25
References: <CGME20200618070250epcas1p409eb2ddd19ecc5d55c219ac3dc884f25@epcas1p4.samsung.com>
        <98eac3fc-c399-625d-5730-29853b3a0771@samsung.com>
        <20200618154444.GB18007@redhat.com> <20200618165006.GA103290@google.com>
        <20200618170952.GA18057@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear DM-Verity maintainers.
Thank you for your reply.

I agreed with you that "the device should be put in a failed state and 
left for admin recovery"
As dear Sami told us, When Android device occurred panic, restarting and 
to save the logs to bootloader also recovery log.
Of course Using the restart mode on systems without firmware support 
won't make sense.
However, on Android devices, restart or panic mode makes sense.

In android, the behavior is different depend on the binary type.
here are 3 type like user / userdebug / eng (engineering).

When kernel panic occurs, it operates as follows
  * kernel panic in user binary(low)-> restart mode
  * kernel panic in eng binary(mid) -> upload mode

It's actually at the debug level.
All users are set to low, but change it build option or others.
but Most users do not know.

You might think, "Why do you need a panic instead of reboot?"

To start with, It's easy to analyze what the device has problem.
If we use restart mode, it's difficult to analyze because device is 
rebooted without logging.(not remain log)
And If use panic mode, samsung takes snapshots(save log etc) when 
occurred panic.(Maybe other company or Android are same).
So We look for a debugging log and the analyze kind of problem in device 
as well as dm-verity.
In the development stage, most of them are use in eng mode.
when panic occurs, it goes to upload mode, so it is convenient to 
analyze whether it is HW problem / SW problem.
In most cases it was a hardware issue. Since we are a manufacturer, the 
HW problem is also important.

Also, users using Android devices can recognize that there is a problem 
with my device through a reboot.
Users don't know the exact reason, but they think that rebooting is wrong.
As mentioned above, in user mode, panic operates in reboot mode.
The user sees that device is rebooting and thinks there is a problem.
They uploads QnA to Samsung members App or visit service center for repair.
Then, developers need to get the log the device used by users to check 
what the problem is. So We are using panic to get the log.

What's more, reboot/panic may seem wrong, but from a security 
perspective, I think it's really important when looking at dm-verity.
Of course, I think the maintainers already know it.
To the important partition or Android devices system, will be protected 
using dm-verity.
We can make the partition(want to protect) into a read-only partition, 
compare the digest, and check whether there are any problems.
If a malicious user or hacker can damage the system or important 
partition may change something.
At this time, we can defend against further hacking by generating a 
panic or restart.
This will make the security feel strong. So reboot mode and panic mode 
will be required.

We have long explained why we need it.
Through this, Samsung needs a panic mode, so please read it carefully 
and give feedback.

Thank you :D
Jeonghyeon Lee


On 19/06/2020 02:09, Mike Snitzer wrote:
> On Thu, Jun 18 2020 at 12:50pm -0400,
> Sami Tolvanen <samitolvanen@google.com> wrote:
>
>> On Thu, Jun 18, 2020 at 11:44:45AM -0400, Mike Snitzer wrote:
>>> I do not accept that panicing the system because of verity failure is
>>> reasonable.
>>>
>>> In fact, even rebooting (via DM_VERITY_MODE_RESTART) looks very wrong.
>>>
>>> The device should be put in a failed state and left for admin recovery.
>> That's exactly how the restart mode works on some Android devices. The
>> bootloader sees the verification error and puts the device in recovery
>> mode. Using the restart mode on systems without firmware support won't
>> make sense, obviously.
> OK, so I need further justification from Samsung why they are asking for
> this panic mode.
>
> Thanks,
> Mike
>
>
>
