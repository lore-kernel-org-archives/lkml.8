Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC10AC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 05:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92FE12075D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 05:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FRMOQ3jg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgG0Fxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 01:53:50 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:33508 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgG0Fxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 01:53:49 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200727055347epoutp03d7c52d70e793a1e40fdca69a88296c9f~lhjobyse22016820168epoutp03G
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 05:53:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200727055347epoutp03d7c52d70e793a1e40fdca69a88296c9f~lhjobyse22016820168epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1595829227;
        bh=saHxhsM0w2XX7RJSQrbqe2wZRztjJhp30+NjpyHF3Uw=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=FRMOQ3jg5lGnk4gATMtJlJ3Q2aXIOhOulSO1MzCOvLMMXQKnlzeBJEf4oNn5QjxDl
         XhVnigOGRV+f72hyUav0Z6Pw4/YT77/puSvcL7Pb7DGjLGUbfVf3s3M7IndK1QhsRw
         FcNjx0Vocvcw1eCd9232QMnE3tZLfXsT4ZF7+6Is=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200727055346epcas1p2090864eb719c92c0b9fb0fb03621e653~lhjoQieXQ2918529185epcas1p29;
        Mon, 27 Jul 2020 05:53:46 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4BFTWW3ZlCzMqYm0; Mon, 27 Jul
        2020 05:53:43 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.E7.29173.1EB6E1F5; Mon, 27 Jul 2020 14:53:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200727055337epcas1p16683bb2e79f0014871e0512fd35d0869~lhjfgkL5N3027230272epcas1p1t;
        Mon, 27 Jul 2020 05:53:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200727055337epsmtrp26057c71521d276f6171330b69d3c53d2~lhjffnA590809708097epsmtrp2i;
        Mon, 27 Jul 2020 05:53:37 +0000 (GMT)
X-AuditID: b6c32a37-9b7ff700000071f5-e7-5f1e6be19d73
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.97.08382.1EB6E1F5; Mon, 27 Jul 2020 14:53:37 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200727055337epsmtip125908687d47990ef35e99a2658ba7348~lhjfWYG4X3261232612epsmtip1u;
        Mon, 27 Jul 2020 05:53:37 +0000 (GMT)
Subject: Re: linux-next: Fixes tag needs some work in the devfreq tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <cda32633-6fce-6baf-738b-ae2d60f40c34@samsung.com>
Date:   Mon, 27 Jul 2020 15:05:21 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200727141707.3e96c3ee@canb.auug.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEKsWRmVeSWpSXmKPExsWy7bCmge6jbLl4g7aZTBaXd81hs9i69yq7
        A5NH440bbB6fN8kFMEVl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qba
        Krn4BOi6ZeYAjVdSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFFgW6BUn5haX5qXr
        JefnWhkaGBiZAhUmZGfMXv2LseA9S8XGnvssDYz3mLsYOTgkBEwklq1L6WLk4hAS2MEo8Xrj
        c3YI5xOjxNpls5kgnG+MEhPPNLJ2MXKCdRx6d4oZIrGXUeL33M9QzntGiQs75zGDVAkLuEms
        Ob+cBcQWEciR+LBmA1icTUBLYv+LG2wgNr+AosTVH48ZQWxeATuJxx8ngdWzCKhKTFi8AswW
        FQiTOLmtBapGUOLkzCdgcU4Bc4lFn68ygdjMAgYSRxbNYYWwxSVuPZkPFZeX2P52DthxEgKn
        2CVuX7vICPGCi8SVK+fZIGxhiVfHt7BD2FISn9/thYpXS6w8eYQNormDUWLL/gtQ/xtL7F86
        mQnCVpTY+XsuI8Q2Pol3X3tYIaHKK9HRJgRRoixx+cFdqHJJicXtnVDzPSRWbznNPoFRcRaS
        32Yh+WcWkn9mIflnASPLKkax1ILi3PTUYsMCY+T43sQITnxa5jsYp739oHeIkYmD8RCjBAez
        kggvt6hMvBBvSmJlVWpRfnxRaU5q8SFGU2BwT2SWEk3OB6bevJJ4Q1MjY2NjCxNDM1NDQyVx
        3n9n2eOFBNITS1KzU1MLUotg+pg4OKUamMznGR19ssDKaK7qO/PcWLe7F0OaDnzxMbRUS9h1
        89XWvT5e2wPnX1lQuOJ3zsOzmkfkTTq3HT6mkT/7etuTn2cOPnf+d3VmdEicfrL0i7rq9ttd
        KzQruEPjzpyuWp/KdnDRHJYfBn8XB/9xnhv8MVGM5Wa5Wm01p3dmsH0yS0VNgI9DifF0Sy6Z
        /geP+jlW/V/U257aoPPj8lnXthXeZldOfQhe9O6cwKmtm9Ze9vp+odtj6XOO2apM7z/9CQzx
        vqE2TaiRtaL8QORhhguaP2bbBwbcMsj81KgQ2X1QbjZbjcSihOvr96dPei/y1+Xsd5mJ9g+L
        GGdoFwcENzzs2M8d/2SXS9DOhZq/172awKnEUpyRaKjFXFScCADp0r7ABQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsWy7bCSnO7DbLl4g1vTpS0u75rDZrF171V2
        ByaPxhs32Dw+b5ILYIrisklJzcksSy3St0vgypi9+hdjwXuWio0991kaGO8xdzFyckgImEgc
        encKyObiEBLYzSjxbc8iFoiEpMS0i0eBEhxAtrDE4cPFEDVvGSWWHvjCBFIjLOAmseb8crB6
        EYEcifcP5kMN2s4ocb7hA9gGNgEtif0vbrCB2PwCihJXfzxmBLF5BewkHn+cBNbMIqAqMWHx
        CjBbVCBMYueSx0wQNYISJ2c+AYtzCphLLPp8FSzOLKAnseP6L1YIW1zi1pP5UHF5ie1v5zBP
        YBSahaR9FpKWWUhaZiFpWcDIsopRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzjMtTR3
        MG5f9UHvECMTB+MhRgkOZiURXm5RmXgh3pTEyqrUovz4otKc1OJDjNIcLErivDcKF8YJCaQn
        lqRmp6YWpBbBZJk4OKUamELlOR127qtk9u936HNbxbvwA4uq24ynnIcWvWt68vfjZd9VZ350
        SDRsmimtf8X5xdXJRcoPmaS+TD8hmj3hQM8E9TRthWV6u2N49M8qzBbsVjFxWL0qa9miSbIa
        fms3ege6dL/m3m95T7Ret//wjM1b6r9sSkpaobdBuMbLcr+dSF5sh1p5a6Ywj5DKE5Ml02ZG
        8wRFz7/256q7XK5exxGmtSnOU87zVGyvStbqeRU/X5XFuqpP5Udr1+bb14I+ha+eP+VC3d5J
        YZd2ZXU6fl716+c3vznXiw5dDeu42a6pOr3iytycM0cyfNMTvirwnzoTPa9m6aSvxsZXOxuK
        5j5uvljDt17LfqGiRv4LXiWW4oxEQy3mouJEABs5SQDiAgAA
X-CMS-MailID: 20200727055337epcas1p16683bb2e79f0014871e0512fd35d0869
X-Msg-Generator: CA
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200727041725epcas1p26800df7997a32a6b0d16ba2d034da372
References: <20200727132428.2763f57b@canb.auug.org.au>
        <CGME20200727041725epcas1p26800df7997a32a6b0d16ba2d034da372@epcas1p2.samsung.com>
        <20200727141707.3e96c3ee@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/27/20 1:17 PM, Stephen Rothwell wrote:
> Hi,
> 
> On Mon, 27 Jul 2020 13:24:28 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Hi all,
>>
>> In commit
>>
>>   332c5b522b7c ("PM / devfrq: Fix indentaion of devfreq_summary debugfs node")
> 
> This is now commit 470fa173646f
> 
>> Fixes tag
>>
>>   Fixes: commit 66d0e797bf09 ("Revert "PM / devfreq: Modify the device name as devfreq(X) for sysfs"")
>>
>> has these problem(s):
>>
>>   - leading word 'commit' unexpected
> 

Thanks for pointing out. I fixed it. Thanks.


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
