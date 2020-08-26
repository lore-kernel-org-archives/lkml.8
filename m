Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC6CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 124B7206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="r8MSmZIE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgHZQRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:17:45 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45609 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbgHZQR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:17:29 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200826161727euoutp02061cd5bebbf6000932cf381272545fad~u3aukV2Nl1312413124euoutp02Z
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 16:17:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200826161727euoutp02061cd5bebbf6000932cf381272545fad~u3aukV2Nl1312413124euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598458647;
        bh=GpJGAq70vOGSpz7J1rewomRYAlKup8ySSp2DpUocRJg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=r8MSmZIExlrJ2+qY9z63FBkSuUUVKdbwVmyB6kxfe7aohdHLWc8/7+Crmdr9TRYa9
         QQTG1MuPo8ubvp6PA6e466bnHQ3WSaAFBcYVyAXC3wz6gG5lhjKIEUDJqkBhmm0fJK
         nqTGWFzxI0dPVdlQ/5KT5lZ3u2WivjCQALT/Gn9Y=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200826161726eucas1p1805c273ce35a3cdfb8266afc2b4a0543~u3at0_Jdm0093800938eucas1p1_;
        Wed, 26 Aug 2020 16:17:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 5C.CD.05997.61B864F5; Wed, 26
        Aug 2020 17:17:26 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200826161725eucas1p2116574868253c5d9f8d61be9ff4cd79f~u3atNoBpx1073210732eucas1p2C;
        Wed, 26 Aug 2020 16:17:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200826161725eusmtrp27cac6b5d820740d8a2add7526903a9d7~u3atM3OWl0613006130eusmtrp2H;
        Wed, 26 Aug 2020 16:17:25 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-0f-5f468b16511a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 30.D8.06314.51B864F5; Wed, 26
        Aug 2020 17:17:25 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200826161724eusmtip12f009372a0ac291f14a451c70a0e9293~u3asoHXHB0451704517eusmtip1V;
        Wed, 26 Aug 2020 16:17:24 +0000 (GMT)
Subject: Re: [GIT PULL] USB fixes for 5.9-rc3
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Brooke Basile <brookebasile@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Ilja Van Sprundel <ivansprundel@ioactive.com>,
        Kees Cook <keescook@chromium.org>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <de6aea2f-5f31-4391-0c36-8fd5fd63ab05@samsung.com>
Date:   Wed, 26 Aug 2020 18:17:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VepkugjZ4pvdNgxzT4T83ewL1AFtSZZtVq6aL+7=sqskA@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7djPc7pi3W7xBkdOc1jMWb+GzeLlhMOM
        FhtnrGe1ONb2hN1iaesFZovmxevZLO7c/spkcaY71+LyrjlsFouWtTJbPOp7y+7A7TG74SKL
        x85Zd9k9rh+4xuqxaVUnm8eJGb9ZPPbPXcPu0bdlFaPH501yARxRXDYpqTmZZalF+nYJXBnz
        O96wFDRxVnw6+52pgXEGexcjJ4eEgInE80fdLF2MXBxCAisYJVY09TFBOF8YJa52TmGEcD4z
        Sjxccg+u5fTttSwgtpDAckaJTzerIYreM0pc6z/FBpIQFtCV6D3cwQpiiwiES1zvWgu2g1lg
        MrPElaerwSaxCRhKdL3tAmvgFbCTuHAPooFFQFXiSOtxsA2iAnESW49fZYKoEZQ4OfMJWJxT
        IFDiYXc/WJxZQF5i+9s5zBC2uMStJ/PBfpAQeMQuMXHqC2aIs10kbr7rZYKwhSVeHd8C9Y6M
        xP+dMA3NQH+eW8sO4fQwSlxumsEIUWUtcefcL6BTOYBWaEqs36UPEXaU6Dh3hQUkLCHAJ3Hj
        rSDEEXwSk7ZNZ4YI80p0tAlBVKtJzDq+Dm7twQuXmCcwKs1C8tosJO/MQvLOLIS9CxhZVjGK
        p5YW56anFhvlpZbrFSfmFpfmpesl5+duYgSmstP/jn/ZwbjrT9IhRgEORiUeXo14t3gh1sSy
        4srcQ4wSHMxKIrxOZ0/HCfGmJFZWpRblxxeV5qQWH2KU5mBREuc1XvQyVkggPbEkNTs1tSC1
        CCbLxMEp1cAYeTNJXzLr3Op9/bPn7+JdrVo1ez2DlfWVossXPx260pH/Zudt0wIOdfPiGeaW
        2rvSPE+vXizEeGDzujU8cWKqu7hPzi6xSQm3DPa+WxQndSnkqdIN1wDHdxcei7V/j/kuH6kb
        USj/Nlhx3cfLV/O6VlU61L6TSLHJ4Nl/5vn94w+YrlsY12cosRRnJBpqMRcVJwIAUNlBCmED
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsVy+t/xu7qi3W7xBg+XKFjMWb+GzeLlhMOM
        FhtnrGe1ONb2hN1iaesFZovmxevZLO7c/spkcaY71+LyrjlsFouWtTJbPOp7y+7A7TG74SKL
        x85Zd9k9rh+4xuqxaVUnm8eJGb9ZPPbPXcPu0bdlFaPH501yARxRejZF+aUlqQoZ+cUltkrR
        hhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehnzO96wFDRxVnw6+52pgXEGexcj
        J4eEgInE6dtrWboYuTiEBJYySjw5tYMNIiEjcXJaAyuELSzx51oXG0TRW0aJo/3NjCAJYQFd
        id7DHWBFIgLhEv9XHQebxCwwnVni+/mVjBAdy5kkpsz+xgRSxSZgKNH1tgtsBa+AncSFexDd
        LAKqEkdaQbo5OUQF4iQe9/5nhqgRlDg58wlYnFMgUOJhdz/YHGYBM4l5mx8yQ9jyEtvfzoGy
        xSVuPZnPNIFRaBaS9llIWmYhaZmFpGUBI8sqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwOjd
        duzn5h2MlzYGH2IU4GBU4uHViHeLF2JNLCuuzD3EKMHBrCTC63T2dJwQb0piZVVqUX58UWlO
        avEhRlOg5yYyS4km5wMTS15JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4m
        Dk6pBkbfGpf2v9cPB/32frST2WVxkXvxmQlLG14ErphWb/ZB8kxzyKQHvVGBp6Z9OreGQ6vx
        1ATN5QeOq2RtTVm48O7V3WnMxqaH2PuC/dkqeSflvOh/MXtf0rSPXo5LDpTu+71NzmZpRqQu
        38FZ348FbdBmvXSE8ySj8139neVyE6pXyJYduWejKMCtxFKckWioxVxUnAgARO/XePQCAAA=
X-CMS-MailID: 20200826161725eucas1p2116574868253c5d9f8d61be9ff4cd79f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200826150239eucas1p24c59716cc31edfeb2eece84d97936b93
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200826150239eucas1p24c59716cc31edfeb2eece84d97936b93
References: <20200826134315.GA3882506@kroah.com>
        <CGME20200826150239eucas1p24c59716cc31edfeb2eece84d97936b93@eucas1p2.samsung.com>
        <1425ab4f-ef7e-97d9-238f-0328ab51eb35@samsung.com>
        <20200826153347.GB4187816@kroah.com>
        <CAHp75VepkugjZ4pvdNgxzT4T83ewL1AFtSZZtVq6aL+7=sqskA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 26.08.2020 17:53, Andy Shevchenko wrote:
> On Wed, Aug 26, 2020 at 6:36 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>> On Wed, Aug 26, 2020 at 05:02:38PM +0200, Marek Szyprowski wrote:
>>> On 26.08.2020 15:43, Greg KH wrote:
>>>
>>>> Brooke Basile (2):
>>>>         USB: gadget: u_f: add overflow checks to VLA macros
>>> Sorry, but the above patch breaks USB Ethernet Gadget operation. It also
>>> didn't get the proper testing in linux-next (next-20200826 is the first
>>> one with this patch).
>>>
>>> This is how it explodes on Samsung Exynos (ARM 32bit) based board with
>>> g_ether module loaded:
>> Odd, for a "normal" descriptor, the logic should have remained the same
>> as without this patch.
>> Brooke, any ideas?
> I have an idea.
>
> Does below fix this?

Yep, that's it. I've also moved offset assignment in the first part 
after size_t size = array_size(n, sizeof(type));

Feel free to add:

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks!

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

