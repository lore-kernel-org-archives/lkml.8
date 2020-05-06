Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966BDC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D66420746
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="X9OVv2YE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgEFMqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 08:46:53 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:38576 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbgEFMqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 08:46:52 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200506124649epoutp040841cbdeaea657b338ceeadf1081f479~McS3GcvmC3144031440epoutp04X
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 12:46:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200506124649epoutp040841cbdeaea657b338ceeadf1081f479~McS3GcvmC3144031440epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588769210;
        bh=xVrjiSj5rcUhJLioOUHhCxYgtIhKDaT+fJC4NTefkOY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=X9OVv2YEMa5hSQOqEgO1C8E6WzO+4Lx+xwnb7zUBxUXxZREvZ9YoDh3sJQ1fEzncl
         4yMuOSayiexWATPrl3szgkU6PPOn5IB+ShTWO/l+uzXf+6zc1C852OYZiV4Hew9kH+
         Ab/ZQSblMsEXl6k8M8BAR+4Ys2bFN1pGizfN/1lI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20200506124649epcas2p31079cf7fe833bd73619a4cb8d52c3620~McS2y0aXY1725117251epcas2p3T;
        Wed,  6 May 2020 12:46:49 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.40.184]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 49HGYy6tVSzMqYkX; Wed,  6 May
        2020 12:46:46 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        6F.66.04393.6B1B2BE5; Wed,  6 May 2020 21:46:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20200506124645epcas2p25a8efbe59fa20194e19d642227dd47ae~McSzW7WBh0988709887epcas2p2Z;
        Wed,  6 May 2020 12:46:45 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200506124645epsmtrp2c0d025800c13c46d0ab69b29fb16d4d9~McSzWNUJq0702807028epsmtrp2w;
        Wed,  6 May 2020 12:46:45 +0000 (GMT)
X-AuditID: b6c32a47-67fff70000001129-63-5eb2b1b6f586
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        70.40.18461.5B1B2BE5; Wed,  6 May 2020 21:46:45 +0900 (KST)
Received: from KORCO008850 (unknown [12.36.185.49]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200506124645epsmtip2f8a8c49ca6bc2cb002988bed2586bac6~McSzIvCoX2016420164epsmtip2y;
        Wed,  6 May 2020 12:46:45 +0000 (GMT)
From:   =?ks_c_5601-1987?B?w9a1v8f1L0RPTkdIWUVPSyBDSE9F?= 
        <d7271.choe@samsung.com>
To:     <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Cc:     <hosung0.kim@samsung.com>, <changki.kim@samsung.com>,
        <hajun.sung@samsung.com>, <gregkh@google.com>,
        <youngmin.nam@samsung.com>
Subject: Reqeust export symbol for API in arch/arm64/*
Date:   Wed, 6 May 2020 21:46:45 +0900
Message-ID: <00bc01d623a4$669d1e70$33d75b50$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdYjn6ASFzdtaHLVT9iANgi25bpynQ==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH++1ud1drcZtWJ6FatyIy1G25dWdZQlKL/EOKKCWcN72otBe7
        W2UU2UtdhFlqj6Ul9MCMUKeoGJKZpVm4qNDsYdJUtLBQyybaY/Mq7L/vOedzfuec3zkEJi3D
        Q4gMo5W1GBk9hQcKa5+spcNqq5xJ8rHzGtre81JED4xPYPSpR68x+lfXFzHtdHeK6DcNxTh9
        5qOKvtU0Ko4htKVOm9ZZbse11bdPaPNqypF2zLksXpSo35TOMqmsRcYaU0ypGca0aGrnbt1W
        nUotV4QpNPQGSmZkDGw0FRsXH7YtQ+9thJIdYvQ2ryue4TgqYvMmi8lmZWXpJs4aTbHmVL1Z
        oTCHc4yBsxnTwlNMhiiFXK5UeclkffpgoQszFxJHPjwoFmShT/g5RBBARsLv7L3nUCAhJesR
        tFb2i3ljFEHTvQkBb4wjcF91eY2A6QzXrUnEBxoR1E/lzVCDCIYcLsxH4eQueJVfJPLpYFIH
        j3vbMR+EkWcRTDUWCH3Fg0g1dHm0PkZIroJ/k13TvITUQEN+lZjXC+D5tT6hT2OkEm7fvyng
        9XKoGy7G+I5kMNF/d6ZWOBRdGUI8EwzX7dnTdYE8SUCfvVHEJ8RCft8PnNdB8LW1RszrEBj7
        3jjjPwyjE62IT85F0PPiPOID68ExkIP431sJLe9nmpsPuU/+iHm3BHKzpTy9Clx5vWj2+cqS
        YQGPaMHzdl0+WuHwm9LhN6XDb0qH3zSlSFiOFrFmzpDGckrzev9tO9H0lYZur0e1HXHNiCQQ
        NU/SdNeZJBUxh7hMQzMCAqOCJfM8VUlSSSqTeZS1mHQWm57lmpHKu4WLWMjCFJP35o1WnUKl
        VKvlGhWtUitparHEObd7v5RMY6zsQZY1s5bZPAEREJKF9HWZDR3fniYnl5oqTmc8LKm4bBMP
        tq0+tRsvaune/tdTg8zP4hKPTe7olCQMf0hY0tPbxB5oizI9qizY85NOKGu/lFyBx9QVvOtd
        E7rmc1nJnS1/3daNc4bVO5ZGDH6tu3/BHudyVbtvhDkSNOJEYvL4dcvASmKf1JMzoiwYiXRT
        Qi6dUYRiFo75D0lPHgu7AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsWy7bCSvO7WjZviDF4sMbbovHeG1eLZt5/M
        Fk37LzFbfL3+iN1i0+NrrBaXd81hs2i5Y2qx+MAndgcOjwWbSj02repk89i8pN6jb8sqRo/P
        m+QCWKO4bFJSczLLUov07RK4Ml5MOc9cMIWj4vbaOUwNjHfZuhg5OSQETCTOL/7N2MXIxSEk
        sJtR4vfBP4wQCSmJ9i0zmSBsYYn7LUdYQWwhgWeMEk0HckFsNoEAiUON89lBbBGBRIlvpx+A
        DWIW6GaU+D5rLpDDwSEsYCZx/YcHSA2LgIrE/9/XwebwClhK7JqwkR3CFpQ4OfMJC4jNDHRQ
        4+FuKFteYvvbOcwQNyhI/Hy6jBVil57E1OkvGSFqRCRmd7YxT2AUnIVk1Cwko2YhGTULScsC
        RpZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5mxjBEaKluYNx+6oPeocYmTgYDzFKcDAr
        ifDy/NgYJ8SbklhZlVqUH19UmpNafIhRmoNFSZz3RuHCOCGB9MSS1OzU1ILUIpgsEwenVAMT
        89NnZsfP66rNCVxhzp26I2nnuZnZDtdlDObFHtK91mVUKmxhnCm1Zb/Z64orM1cmaXpEFU8X
        26aRU9rEwLxldv0bh/oaxm2Kx0PvBa+1WFbZ2uK0TXnyAseqKw+WxE0s2ncgJNtAQ2Nnrcem
        KkvPi7H13mFHHk4Wqq2tT7y1NuQe+0Y2PdXZvHovZggeNl3cPkfNLHxn4ybtJ6uuPd126qbJ
        smdWfzbl+3jrf6jpEs+ymjHnx5fXt7zb9u6zCj0YYFf058qWUxtMy51jghJ1ROXi25bNOdOh
        8DOiz7fGtSyqdAcPu/6U3tDYj27GEq9P8/LlaRToS17b2CejfeP3S8NXzrXxt1f71T5YdFeJ
        pTgj0VCLuag4EQCzdtmG/wIAAA==
X-CMS-MailID: 20200506124645epcas2p25a8efbe59fa20194e19d642227dd47ae
X-Msg-Generator: CA
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200506124645epcas2p25a8efbe59fa20194e19d642227dd47ae
References: <CGME20200506124645epcas2p25a8efbe59fa20194e19d642227dd47ae@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am software engineer in charge of BSP (Samsung SOC vendor).

Recently, Google introduced GKI from Android R version.
We cannot use mainline API without 'export symbol' by the GKI policy.
But we want to make an arm64 specific vendor driver in {kernel source
root}/drivers/soc/samsung/*.

Could you support us to use the below APIs?

1. [register_kernel_break_hook]
To make runtime debug feature. We need architecture support.(break hook)
It's an architecture specific function. After cpu execute specific
instruction, A function with a parameter which is the context at that
time(the executing specific instruction) is performed. I am trying to
restore the locked context by using this fuction with  the el3 trap for
debugging hardlockup core(s).

2. [dump_backtrace]
Although 'dump_stack' is already supported, we need 'dump_backtrace' also.
Because we need lighten api to debug system. In some situation like bus
hang(HW bug), dump_stack highly likely make a problem again while printing
debug information.

