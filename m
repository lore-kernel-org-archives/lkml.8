Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1ACEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACB0020727
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="k+JgZuET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731342AbgFVX7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 19:59:48 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:41949 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731175AbgFVX7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 19:59:48 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200622235945epoutp0457e51f9835ed392d2b132afc2c3195fa~bAy0SpBWa2094420944epoutp04Q
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 23:59:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200622235945epoutp0457e51f9835ed392d2b132afc2c3195fa~bAy0SpBWa2094420944epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592870385;
        bh=YExroDqc6XzESFm8WunT73Vwegt7O2NMI3eTkUs4C38=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=k+JgZuETmQ9o+0EMIw4bTkiG5QYFyXbfSMNJn21ke5BDVOf6AzWIPpL9n71mzHEo4
         Qov3tNO4QxhxI6dbqRlWHrW4RrajJ3i9Fv7JkSxVeYnkvXe7UDBlVFD02H/291Fhdx
         ni5p0bw4NEpyyUwNB++hfu5lrv1R9ShSuBwfU2S8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200622235944epcas1p1d7b823d4a1887b71eccd67af654f27fe~bAyzmnqUJ1886118861epcas1p11;
        Mon, 22 Jun 2020 23:59:44 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.166]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 49rRGl41M6zMqYkk; Mon, 22 Jun
        2020 23:59:43 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.54.28581.FE541FE5; Tue, 23 Jun 2020 08:59:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200622235942epcas1p3cda4faa2bf5ad932189cbe1a87b0b0fd~bAyyBP-sU2815928159epcas1p38;
        Mon, 22 Jun 2020 23:59:42 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200622235942epsmtrp13d82fa0db9948bc0dac8fdbe90844315~bAyyAg5232670726707epsmtrp1d;
        Mon, 22 Jun 2020 23:59:42 +0000 (GMT)
X-AuditID: b6c32a38-2e3ff70000006fa5-fa-5ef145efa0c5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        10.F1.08303.EE541FE5; Tue, 23 Jun 2020 08:59:42 +0900 (KST)
Received: from [10.253.105.155] (unknown [10.253.105.155]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200622235942epsmtip16d13b33e18f9c69da82d677090e641a9~bAyxdYJnb0379503795epsmtip1G;
        Mon, 22 Jun 2020 23:59:42 +0000 (GMT)
Subject: Re: New mode DM-Verity error handling
To:     Milan Broz <gmazyland@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>
Cc:     dm-devel@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, agk@redhat.com, corbet@lwn.net
From:   JeongHyeon Lee <jhs2.lee@samsung.com>
Message-ID: <250156a6-a2d6-dbfd-daa3-be9c36f0cf36@samsung.com>
Date:   Tue, 23 Jun 2020 08:53:32 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b7eaf4a7-6692-ffdf-2bbc-b622f93ef601@gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmnu57149xBr1P5SzWnzrGbPHkQDuj
        xd53s1ktju2fxW6xsG0Ji8XlXXPYLJaueMtq0bbxK6MDh8fOWXfZPRZsKvVY3DeZ1eP9vqts
        Hp83yQWwRuXYZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl
        5gCdoqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMDQo0CtOzC0uzUvXS87PtTI0
        MDAyBapMyMmYdnEha8EW/op1K3gbGKfwdDFyckgImEhce/+TsYuRi0NIYAejxL/bd5ghnE+M
        El+ezYbKfGaUuH96KhtMy4dXz5kgErsYJQ6uOwPlvGeU+Ll6EwtIlbCAnsTHzq+sILaIQJHE
        tAVNYHFmILv381uwOJuAtsTtlk3sIDavgJ3E338XmUBsFgFVid27l4LViwpESNw/toEVokZQ
        4uTMJ2BxTgFbiY3rjjJBzJSX2P52DjOELS5x68l8sIMkBHo5JDZNmMUCcbaLxIT+U6wQtrDE
        q+Nb2CFsKYmX/W1QdrnElabLjBB2jcSEC91Q9cYS81sWAi3gAFqgKbF+lz5EWFFi5++5jBB7
        +STefe1hBSmREOCV6GgTgihRkljx7xrUBRISGw53QwPRQ2Jp63TWCYyKs5B8NgvJN7OQfDML
        YfECRpZVjGKpBcW56anFhgUmyJG9iRGcTLUsdjDOfftB7xAjEwfjIUYJDmYlEd7XAe/ihHhT
        EiurUovy44tKc1KLDzGaAsN6IrOUaHI+MJ3nlcQbmhoZGxtbmJiZm5kaK4nznrS6ECckkJ5Y
        kpqdmlqQWgTTx8TBKdXAxCouFXBE41fyuvWJXNlmamvSz7/05lghwtP/J/mP/pE1hdP2lCw+
        bbZ1Xr9XiMyUuVbBgg1+/6dKqc6+6TKhoqbf9ZdqoPCGkt95s930jm+Y0jOrOcr4v4ToX801
        bKbufvYfHd8Yfz99+INWVvDz3X2LDv/Ln2tc8s/Vp0lUNee8Ea/axCMMHU2Lurnla7wcrQWE
        JkyMvfqTs7zhx4mFhzRmG9Zk1y+UenvAluH/R/7okF5dyd/amy8fv7lWnXNLKSev7rcW5ZvS
        3S/Kfn2/uuLlarVtZlslHzf/3aS55WTVwlrBkPn3o+vOya2Sijfc9NmcYwZfeM3p+NtmzHtk
        kv0ueKzVSAn7MtPQ08xSiaU4I9FQi7moOBEAtqQW3C8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsWy7bCSnO47149xBktmGFqsP3WM2eLJgXZG
        i73vZrNaHNs/i91iYdsSFovLu+awWSxd8ZbVom3jV0YHDo+ds+6yeyzYVOqxuG8yq8f7fVfZ
        PD5vkgtgjeKySUnNySxLLdK3S+DKmHZxIWvBFv6KdSt4Gxin8HQxcnJICJhIfHj1nKmLkYtD
        SGAHo8TL9p1MEAkJiQ2b1rJ3MXIA2cIShw8XQ9S8ZZS4unovO0iNsICexMfOr6wgtohAkcS7
        BQ/AbGYge+ftk1BDtzFJTGyYzwKSYBPQlrjdsgmsmVfATuLvv4tgy1gEVCV2714KViMqECFx
        5v0KFogaQYmTM5+A2ZwCthIb1x1lglhgJjFv80NmCFteYvvbOVC2uMStJ/OZJjAKzULSPgtJ
        yywkLbOQtCxgZFnFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcPVpaOxj3rPqgd4iR
        iYPxEKMEB7OSCO/rgHdxQrwpiZVVqUX58UWlOanFhxilOViUxHm/zloYJySQnliSmp2aWpBa
        BJNl4uCUamCSZ/lyeI3ItBfuVxRWSWzKj3ZplDt7NIht6UaVnSkNjV+jH3u91N9lYt9u+O3W
        3hdrVynffuzzfIv8ta0X9j16+y28Kz79/bo1TRxbVuQ8tFqvf+yir6Hp94KWstPZkcWxO2y/
        MTNefRdy8WdUWYXsesa2vPMms1MvcbIrtfrKXlj4ek3oldvcqjOTtq0W9+dRELZJD1ZMPvO7
        1+x1rudJP20u/uKP575qLzTxNb+gI3vj0I+Vn65WqB68q1xjFWk7W3pa288HM2L4c7ovZU2y
        /LIy4qzhjLSs3dq7FwVIG30x921pnqRzjONiZFHJJl62w6yOHYsjqjY0b54b2Zd42TWdb33z
        /eQf0rb3612UWIozEg21mIuKEwGDjIQCDQMAAA==
X-CMS-MailID: 20200622235942epcas1p3cda4faa2bf5ad932189cbe1a87b0b0fd
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Milan Broz.

Thank for your reply.


I didn't understand well, could you explain it in more detail?

For what reason isn't panic better?

Is it because there is a place to use other device-mapper?

Or other things? I just wonder. I would like to hear various 
explanations and information.


I just wanted user to use what they wanted through the options(flags).

Yes, If adding a new feature, modify user-space to support.


Oh, I'm sorry :(

If when i suggested new patch, i will send you a patch that increased 
minor version.

Thank you for all your detailed information.


Thanks.

JeongHyeon Lee



On 22/06/2020 16:58, Milan Broz wrote:
> On 18/06/2020 19:09, Mike Snitzer wrote:
>> On Thu, Jun 18 2020 at 12:50pm -0400,
>> Sami Tolvanen <samitolvanen@google.com> wrote:
>>
>>> On Thu, Jun 18, 2020 at 11:44:45AM -0400, Mike Snitzer wrote:
>>>> I do not accept that panicing the system because of verity failure is
>>>> reasonable.
>>>>
>>>> In fact, even rebooting (via DM_VERITY_MODE_RESTART) looks very wrong.
>>>>
>>>> The device should be put in a failed state and left for admin recovery.
>>> That's exactly how the restart mode works on some Android devices. The
>>> bootloader sees the verification error and puts the device in recovery
>>> mode. Using the restart mode on systems without firmware support won't
>>> make sense, obviously.
>> OK, so I need further justification from Samsung why they are asking for
>> this panic mode.
> I think when we have reboot already, panic is not much better :-)
>
> Just please note that dm-verity is used not only in Android world (with own tooling)
> but in normal Linux distributions, and I need to modify userspace (veritysetup) to support
> and recognize this flag.
>
> Please *always* increase minor dm-verity target version when adding a new feature
> - we can then provide some better hint if it is not supported.
>
> Thanks,
> Milan
>
>
