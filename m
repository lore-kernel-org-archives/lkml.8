Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4B4C28E83
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAF1A205CB
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="N8ICZD2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbgIDJbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 05:31:41 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:37492 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730079AbgIDJbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:31:23 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200904093120epoutp04d1633d13d25e05a567f32687b8f9fb59~xirtiCXEb0864508645epoutp04b
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 09:31:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200904093120epoutp04d1633d13d25e05a567f32687b8f9fb59~xirtiCXEb0864508645epoutp04b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599211880;
        bh=7eKjrrXMyPcGGy+prk+NmLZfDzVLo+N1HJeKK1CMHe4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=N8ICZD2ofRhxbkY6uMXozC9b8pcHFxQnc2a+t4phOSdGAZdULXKtCDdaiDqt4D2L7
         NJ/FdNPIqrXcdVLg0Al1bomHGsJGy8xG6uach0z/I0TybQPZs8nRMp4ddDRF/Xxf2C
         kiiKrx/aL6urUraPH3tiSWfXmRcgeP01p4jksqr8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20200904093119epcas2p1c407462349b2029df1c237c1471639e2~xirsskAH53257332573epcas2p1o;
        Fri,  4 Sep 2020 09:31:19 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.188]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4BjXVY0YSKzMqYkk; Fri,  4 Sep
        2020 09:31:17 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.65.19322.269025F5; Fri,  4 Sep 2020 18:31:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20200904093114epcas2p36f311d20d3b7729bc965786c76f18ca1~xiroVHUUr2511625116epcas2p3q;
        Fri,  4 Sep 2020 09:31:14 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200904093114epsmtrp1c64de14308dfb25465b57183c1bcac0d~xiroURU9a1961419614epsmtrp1X;
        Fri,  4 Sep 2020 09:31:14 +0000 (GMT)
X-AuditID: b6c32a45-7adff70000004b7a-a9-5f5209626cd4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        47.0A.08303.269025F5; Fri,  4 Sep 2020 18:31:14 +0900 (KST)
Received: from KORDD001994 (unknown [12.36.185.71]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200904093114epsmtip1d36b0b0c3b7c5c7200a14931c2e8fb37~xiroIHwxt0857908579epsmtip1B;
        Fri,  4 Sep 2020 09:31:14 +0000 (GMT)
From:   =?ks_c_5601-1987?B?sejDorHi?= <changki.kim@samsung.com>
To:     "'Greg KH'" <gregkh@linuxfoundation.org>
Cc:     <pmladek@suse.com>, <sergey.senozhatsky@gmail.com>,
        <rostedt@goodmis.org>, <john.ogness@linutronix.de>,
        <masahiroy@kernel.org>, <rd.dunlap@gmail.com>, <krzk@kernel.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <20200904090535.GA2440145@kroah.com>
Subject: RE: printk: Add process name information to printk() output.
Date:   Fri, 4 Sep 2020 18:31:13 +0900
Message-ID: <000001d6829e$2226cc60$66746520$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMW8ccY1/AbwLmEvIpBmAjIk1luugFhZewlAjg6wOumuolUIA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDJsWRmVeSWpSXmKPExsWy7bCmhW4SZ1C8wdaTNhbNi9ezWWy7Mp/R
        4vz5DewWl3fNYbN4+OAGq8X/x19ZLV5s7mS12NfxgMli7efH7A6cHjtn3WX3aNl3i91j06pO
        No93586xe+yfu4bdY/2WqywenzfJBbBH5dhkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoa
        WlqYKynkJeam2iq5+AToumXmAJ2mpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkw
        NCzQK07MLS7NS9dLzs+1MjQwMDIFqkzIydh/aQlzQRNvReeiN0wNjE85uxg5OSQETCR2T57L
        3sXIxSEksINR4t/tzVDOJ0aJl98uskE4nxklzncsYYdpeXl6BitEYhejxNHD7cwQzgug/t+7
        mUGq2ARsJdo7H4B1iAjoSHScOcECUsQscIFRouf7ZCaQBKeAocS7TfsZQWxhAVeJ1yffgTWw
        CKhIXNn9FmwQr4ClxISGeYwQtqDEyZlPWEBsZgEjiSWr5zNB2PIS29/OYYY4T0Hi59NlQOdx
        AC12krjf7AVRIiIxu7MNqmQLh8TvF8oQtovEjEXbWCFsYYlXx7dAfSkl8bK/Dcqul/jWvwDs
        fgmBHkaJv13H2SASxhKznrUzguySEFCWOHIL6jQ+iY7Df9khwrwSHW1CEKaqRPdkfQhTWuLD
        DpsJjEqzkLw1C8lbs5C8NQvJ/QsYWVYxiqUWFOempxYbFRgiR/YmRnCy1XLdwTj57Qe9Q4xM
        HIyHGCU4mJVEeD3OBcYL8aYkVlalFuXHF5XmpBYfYjQFhvREZinR5Hxgus8riTc0NTIzM7A0
        tTA1M7JQEufNVbwQJySQnliSmp2aWpBaBNPHxMEp1cBUsEqL4d4a+8hmf4GElKPV3P/S1q1W
        VmRNY925pulcjnSKRJbq4kzGnp7EFct9xU7Pty6Km/fDRNE5/cVP5Vl8K26FfOSNurrLZaZU
        okfRlDtGU2bwqBbd/xKrsu++WWyJV9Kbj96hp34sfrq1K1h9sf+F7pKJjlzM+pczVe83Td+n
        cWHysewm4TsrLlQZivV/VrRRZyq3ib0RKXh7pxP7V+N5VkrJDWfP/E45f2/P1v9OszxEfq5J
        /Nn67fh83ivzb6y7z3viwF0RprKbPK1LNi12+i1oumEZf+I1/+2xGxI3+NZm9WdXdURYFvns
        ZS34sWeb08a3p5Z1Tw20ZKgx/Coltp2rS6JaTjycc6sSS3FGoqEWc1FxIgDa/2dwPwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSnG4SZ1C8wZKZkhbNi9ezWWy7Mp/R
        4vz5DewWl3fNYbN4+OAGq8X/x19ZLV5s7mS12NfxgMli7efH7A6cHjtn3WX3aNl3i91j06pO
        No93586xe+yfu4bdY/2WqywenzfJBbBHcdmkpOZklqUW6dslcGXsv7SEuaCJt6Jz0RumBsan
        nF2MnBwSAiYSL0/PYO1i5OIQEtjBKLFy/g82iIS0xPFXs9khbGGJ+y1HoIqeMUp8ujqRGSTB
        JmAr0d75AKxIREBHouPMCRaQImaBW4wSKz48Yofo2MwosWbNRLAqTgFDiXeb9jOC2MICrhKv
        T74Di7MIqEhc2f0WbCqvgKXEhIZ5jBC2oMTJmU9YQGxmoFsbD3dD2fIS29/OYYY4T0Hi59Nl
        QOdxAF3hJHG/2QuiRERidmcb8wRG4VlIJs1CMmkWkkmzkLQsYGRZxSiZWlCcm55bbFhglJda
        rlecmFtcmpeul5yfu4kRHHlaWjsY96z6oHeIkYmD8RCjBAezkgivx7nAeCHelMTKqtSi/Pii
        0pzU4kOM0hwsSuK8X2ctjBMSSE8sSc1OTS1ILYLJMnFwSjUwbX1pfjfqtmVZo6ZyVwfnaT6V
        kocp/u8OrT3Lk7OiJO9xQ0fBPNfYKz9LFqzvYWLYzdaYM8F9T5vZhddCZ0z7u0t2bOGYunf5
        JIHZ0//utagx8Iz/yFojaPjITrhxwhsBw8Md118vC2fs/8jhv/uutcTB7QWnZh4Sa03PuH3d
        4rjxxCWOinsSbogc7u1l7eK2EltQfuDuty3HNzhtj1q/ScXdSLGne5LJnrm5GbVxFycrnOjP
        vqvocu+tievV1T9WX/Gdc8hg/SbupzvUjsav+pdSIia8YKL5H5tDhw0nR9/YL8MQOMNyTdbp
        OLHd2nz3OcLTdvycsFKUV9eTKeTGOauN15wZv+9cabT1yg+J+0osxRmJhlrMRcWJAApa+msr
        AwAA
X-CMS-MailID: 20200904093114epcas2p36f311d20d3b7729bc965786c76f18ca1
X-Msg-Generator: CA
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200904082449epcas2p4420d5df2083325b328a182c79f5c0948
References: <CGME20200904082449epcas2p4420d5df2083325b328a182c79f5c0948@epcas2p4.samsung.com>
        <20200904082438.20707-1-changki.kim@samsung.com>
        <20200904090535.GA2440145@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Sep 04, 2020 at 05:24:38PM +0900, Changki Kim wrote:
> > Printk() meesages are the most basic and useful debug method.
> > However, additional information needs in multi-processor.
> > If we add messages with processor id and process name, we can find a
> > problem only with messages when the problem occurs with H/W IP or CPU.
> > This is very useful in narrowing down the scope of the problems.
> >
> > Therefore, instead of trying to help buffering, let's try to help
> > reconstructing messages by saving caller information as of calling
> > log_store() and adding it as "[$processor_id: $process_name:
> $thread_id]"
> > upon printing to consoles.
> >
> > Some examples for console output:
> >
> >   [    0.059580] [0:      swapper/0:    1] CPU: All CPU(s) started at
EL1i
> >   [    2.153157] [5:           init:    1] migov: complete to probe
migov
> >   [    7.441317] [4:           init:    1] NET: Registered protocol
family 39
> >   [   22.793389] [5:  kworker/u16:1:  184] SMP: stopping secondary CPUs
> >
> > Signed-off-by: Changki Kim <changki.kim@samsung.com>
> > ---
> >  kernel/printk/printk.c            | 20 ++++++++++++++++++--
> >  kernel/printk/printk_ringbuffer.h |  7 +++++++
> >  lib/Kconfig.debug                 | 16 ++++++++++++++++
> >  3 files changed, 41 insertions(+), 2 deletions(-)
> 
> Isn't the CPU number already present if you want it today?  Why add it
> again?
> 
> thanks,
> 
> greg k-h

CPU number isn't present now. If I enabled PRINTK_CALLER,
then it is present cpu id or thread id.
The config isn't always present cpu id.
We need cpu id each each message.

Thanks.

