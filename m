Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B70C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF2E020716
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FZt+cNrf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731691AbgFWIOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:14:11 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:48377 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731158AbgFWIOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:14:10 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200623081407epoutp04f592dec0611e24731a1046607c05d95b~bHidOGRoN1130611306epoutp04R
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 08:14:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200623081407epoutp04f592dec0611e24731a1046607c05d95b~bHidOGRoN1130611306epoutp04R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592900047;
        bh=z71SzKcNIdbIGTQsQhBF7NcJhtuDhSvPtc4WWpaIk7Q=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=FZt+cNrfCidpu56ynCrB0x8u2pcgx4izB/7qCCj7RHcV9W8E6D2JBDTwNNhxyC0aV
         nDwSNMnefh/+rmjlHg7h2OGdt6359xcoF9NdPOyc1NRkkBz7Qt+6GstucL4TmE5DCy
         TQghQ0dkE2BXNGYWT8S7uNyfqXAIO0l1afy+RDHs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200623081406epcas1p19fa98cbd01dc8c555ceddc3267a93be1~bHictCMQi0908009080epcas1p1y;
        Tue, 23 Jun 2020 08:14:06 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.165]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 49rfF96Gc7zMqYkZ; Tue, 23 Jun
        2020 08:14:05 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        97.8F.29173.DC9B1FE5; Tue, 23 Jun 2020 17:14:05 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200623081405epcas1p3c449f8d4d3386601e6d811d8828cf817~bHibfaCKM1406714067epcas1p38;
        Tue, 23 Jun 2020 08:14:05 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200623081405epsmtrp2a8de4abb466562268c4d5794cb9732e0~bHibemnXS1427414274epsmtrp2b;
        Tue, 23 Jun 2020 08:14:05 +0000 (GMT)
X-AuditID: b6c32a37-9cdff700000071f5-68-5ef1b9cd08ab
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        74.40.08382.DC9B1FE5; Tue, 23 Jun 2020 17:14:05 +0900 (KST)
Received: from [10.253.105.155] (unknown [10.253.105.155]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200623081405epsmtip1a1b09901a8b8151e87968da1647ce60b~bHibQgaO01684716847epsmtip1w;
        Tue, 23 Jun 2020 08:14:05 +0000 (GMT)
Subject: Re: New mode DM-Verity error handling
To:     Milan Broz <gmazyland@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>
Cc:     dm-devel@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, agk@redhat.com, corbet@lwn.net
From:   JeongHyeon Lee <jhs2.lee@samsung.com>
Message-ID: <579f4147-1825-1825-84be-2088ea670a64@samsung.com>
Date:   Tue, 23 Jun 2020 17:08:02 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2c3bf8c1-c742-b1e9-6ff6-91b2253638e1@gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmge7ZnR/jDBatM7RYf+oYs8WTA+2M
        FnvfzWa1OLZ/FrvFwrYlLBaXd81hs1i64i2rRdvGr4wOHB47Z91l91iwqdRjcd9kVo/3+66y
        eXzeJBfAGpVjk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuW
        mQN0ipJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwNCgQK84Mbe4NC9dLzk/18rQ
        wMDIFKgyISdj6qeigrMiFYvWn2VtYDws0MXIwSEhYCJxYpd4FyMXh5DADkaJm19PMUM4nxgl
        zs7axtbFyAnkfGOUaLmvC2KDNNw/PZcJomgvo8Ti3VOhOt4zSnRc+sEMUiUsoCfxsfMrK4gt
        IlAkMW1BEwuIzQxk935+CxZnE9CWuN2yiR3kDF4BO4nP/7lATBYBVYmuBeYgFaICERL3j20A
        q+YVEJQ4OfMJ2BROAVuJxfsOMkJMlJfY/nYOM4QtLnHryXyw2yQEJnJI7Jj8lBniaBeJC+83
        skDYwhKvjm9hh7ClJD6/28sGYZdLXGm6zAhh10hMuNDNCmEbS8xvWcgMchuzgKbE+l36EGFF
        iZ2/50LdwCfx7msPKyRAeSU62oQgSpQkVvy7BrVVQmLD4W6oTR4SS1uns05gVJyF5LNZSL6Z
        heSbWQiLFzCyrGIUSy0ozk1PLTYsMEaO6E2M4CSqZb6DcdrbD3qHGJk4GA8xSnAwK4nwvg54
        FyfEm5JYWZValB9fVJqTWnyI0RQY1BOZpUST84FpPK8k3tDUyNjY2MLEzNzM1FhJnNfX6kKc
        kEB6YklqdmpqQWoRTB8TB6dUA9N8Dy8poboDiT+0hPaF3Ozb1/gliUuCYYtRwnfPnqd7/c4p
        LzvrKMWZK7zx+GHNxrrfrV86a5eJf8zgO6ySYu30f2moX3KJlWBs/7tTx28IHHt2S1rN4WfW
        5dj5EmsZV/VYOT7d+qWM90Cyxa/voScDN3VcKZx86a5jXOSVU1NV/s5UV7J3/XOiu/b0L3WN
        O99XrqmP/7e7zpxdWGDpT8bpbeLeakKXdXkOrPDMyLYuXfUyMb/s7532Az+dq88Lspcn+Aln
        G96/8Wy1GJvFtlltCs+Ef19zzzZ4Zr9LKm5j20smPWfR6BKzswwiH3UEDBa+nqpaIhd9a8Of
        re3Vja8nvb7VwZh/v/FNmffJKUosxRmJhlrMRcWJACGDzkgrBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsWy7bCSnO7ZnR/jDK6fkrJYf+oYs8WTA+2M
        FnvfzWa1OLZ/FrvFwrYlLBaXd81hs1i64i2rRdvGr4wOHB47Z91l91iwqdRjcd9kVo/3+66y
        eXzeJBfAGsVlk5Kak1mWWqRvl8CVMfVTUcFZkYpF68+yNjAeFuhi5OSQEDCRuH96LhOILSSw
        m1Hi4mo5iLiExIZNa9m7GDmAbGGJw4eLuxi5gEreMkqsWXGaDaRGWEBP4mPnV1YQW0SgSOLd
        ggdgNjOQvfP2SSaIhnnMEl/2zmEGSbAJaEvcbtkENpRXwE7i838uEJNFQFWia4E5SIWoQITE
        mfcrWEBsXgFBiZMzn4DZnAK2Eov3HWSEGG8mMW/zQ2YIW15i+9s5ULa4xK0n85kmMArNQtI+
        C0nLLCQts5C0LGBkWcUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERw3Wpo7GLev+qB3
        iJGJg/EQowQHs5II7+uAd3FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeW8ULowTEkhPLEnNTk0t
        SC2CyTJxcEo1MO1N+uvxMvjTnoaSSv6sa4fkHS7yTrsidLBzOo/4BZ8nMznfbTI398qse1UY
        8vhQYs/Tz99c1xy39lVbvvSEX9d2xappx/aVRCSFHnJL+d299cXFjGMa6k/r5867uGBu/Y45
        ITGuXh/31PlNdlf00Zme92j2g003H+xQSnl4N3gVs56rFY/2R57JJ+78sVgxcS1/WUjMVPey
        KoXqz9Z2Qs+2Cv+S2Me5ZtnH80a31m9KvXfe8a7bFddAOYO/5lzF14tEq5JWGUSKp14M2xgx
        ZXf0YaeD7RypO/4fqOCaJRx+Ol848tennsRjUyPaFsz1mBjQ8aVJ6N5u24jmrfejJnF6CKxe
        KHfB7KzYMufScylKLMUZiYZazEXFiQDOSkZICgMAAA==
X-CMS-MailID: 20200623081405epcas1p3c449f8d4d3386601e6d811d8828cf817
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
        <b7eaf4a7-6692-ffdf-2bbc-b622f93ef601@gmail.com>
        <250156a6-a2d6-dbfd-daa3-be9c36f0cf36@samsung.com>
        <2c3bf8c1-c742-b1e9-6ff6-91b2253638e1@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Milan Broz.


Thank you for answer my query.

I asked you again because i was confused.


Yes, I also looked at the document and get a lot of information or 
studies related to dm-verity.

https://gitlab.com/cryptsetup/cryptsetup/-/wikis/DMVerity


Thank you : D

JeongHyeon Lee


On 23/06/2020 16:28, Milan Broz wrote:
> On 23/06/2020 01:53, JeongHyeon Lee wrote:
>> For what reason isn't panic better?
> I did not say panic is better, I said that while we have restart already in mainline dm-verity code,
> panic() is almost the same, so I see no problem in merging this patch.
>
> Stopping system this way could create more damage if it is not configured properly,
> but I think it is quite common to stop the system as fast as possible if data system integrity
> is violated...
>
>> If when i suggested new patch, i will send you a patch that increased
>> minor version.
> I think Mike can fold-in version increase, if the patch is accepted.
>
> But please include these version changes with every new feature.
>
> Actually I am tracking it here for dm-verity as part of veritysetup userspace documentation:
>    https://gitlab.com/cryptsetup/cryptsetup/-/wikis/DMVerity
>
> Thanks,
> Milan
>
>> On 22/06/2020 16:58, Milan Broz wrote:
>>> On 18/06/2020 19:09, Mike Snitzer wrote:
>>>> On Thu, Jun 18 2020 at 12:50pm -0400,
>>>> Sami Tolvanen <samitolvanen@google.com> wrote:
>>>>
>>>>> On Thu, Jun 18, 2020 at 11:44:45AM -0400, Mike Snitzer wrote:
>>>>>> I do not accept that panicing the system because of verity failure is
>>>>>> reasonable.
>>>>>>
>>>>>> In fact, even rebooting (via DM_VERITY_MODE_RESTART) looks very wrong.
>>>>>>
>>>>>> The device should be put in a failed state and left for admin recovery.
>>>>> That's exactly how the restart mode works on some Android devices. The
>>>>> bootloader sees the verification error and puts the device in recovery
>>>>> mode. Using the restart mode on systems without firmware support won't
>>>>> make sense, obviously.
>>>> OK, so I need further justification from Samsung why they are asking for
>>>> this panic mode.
>>> I think when we have reboot already, panic is not much better :-)
>>>
>>> Just please note that dm-verity is used not only in Android world (with own tooling)
>>> but in normal Linux distributions, and I need to modify userspace (veritysetup) to support
>>> and recognize this flag.
>>>
>>> Please *always* increase minor dm-verity target version when adding a new feature
>>> - we can then provide some better hint if it is not supported.
>>>
>>> Thanks,
>>> Milan
>>>
>>>
>
