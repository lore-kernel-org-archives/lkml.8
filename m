Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EB7C54E7E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15BA7208CA
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ag8rV3XR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgEGLno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 07:43:44 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:20490 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgEGLnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 07:43:41 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200507114335epoutp022e1fc22575470aad9e654b14b913a0dd~MvE7qu1hu2135521355epoutp02M
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 11:43:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200507114335epoutp022e1fc22575470aad9e654b14b913a0dd~MvE7qu1hu2135521355epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588851815;
        bh=5lZpe+aaCuvkrdtFkz5T1CPY41dsC1TFm3yTwD+erGk=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=Ag8rV3XRHzLB+pHwOlmkICWJryzfPFn7Vwo7jMOCLgndJKjJdPEJMMl/cyHM32iNE
         l1sFcUQWvan2ugAu3dAhV0snfKoY+dvLaNWIcRh+nhClc3tADGtAvOWfsVaMf2zIp6
         3ntLkxLXs2pm9CFew4qBlQ/SCaeKGVDnliP2PWrM=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200507114335epcas5p21b9093116416c57e642fa056772b8713~MvE7YOWDq1215912159epcas5p2w;
        Thu,  7 May 2020 11:43:35 +0000 (GMT)
X-AuditID: b6c32a4b-7dbff70000021b78-97-5eb3f46786c0
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3C.26.07032.764F3BE5; Thu,  7 May 2020 20:43:35 +0900 (KST)
Mime-Version: 1.0
Subject: RE:[PATCH 4/4] scripts/checkstack.pl: fix arm sp regex
Reply-To: maninder1.s@samsung.com
From:   Maninder Singh <maninder1.s@samsung.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
CC:     "George G. Davis" <george_davis@mentor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <CAK7LNASf687MLf1oWqrUiOHtw=p9Ug02bi1r-KevsxnFtQni2g@mail.gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20200507105122epcms5p543853209caaec4c3b031d64f916f9ccc@epcms5p5>
Date:   Thu, 07 May 2020 16:21:22 +0530
X-CMS-MailID: 20200507105122epcms5p543853209caaec4c3b031d64f916f9ccc
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42LZdlhTSzf9y+Y4g8c9YhYXd6daPPn/ndXi
        8q45bBYPH9xgtTh0ci6jA6vHplWdbB67vzYxevRtWcXo8XmTXABLFJdNSmpOZllqkb5dAlfG
        4qkH2Aues1Z07v7N3MB4iqWLkZNDQsBE4uTd1WxdjFwcQgK7GSVe/9jC3sXIwcErICjxd4cw
        SI2wgL3E938gNZxANYoSF2asYQQpERYwkPi1VQMkzCagJ7Fq1x6wkSICWhJ3lnawgoxkBhn5
        58UlqF28EjPan0LZ0hLbl29lBLE5BQIlPj2/xAoRF5W4ufotO4z9/th8RghbRKL13llmCFtQ
        4sHP3VBxGYnVm3uhZjYzSnQuSQVZLCEwhVFi96suNoiEucTuDfPAingFfCV+H90FtoxFQFXi
        +fb/UM0uEtve3wGLMwvIS2x/O4cZ5ElmAU2J9bv0IUpkJaaeWscEUcIn0fv7CRPMXzvmwdiq
        Ei03N7DC/Pj540eo8R4S0xd1skPCeRKTxKv7rcwTGBVmIYJ6FpLNsxA2L2BkXsUomVpQnJue
        WmxaYJyXWq5XnJhbXJqXrpecn7uJEZxItLx3MG4653OIUYCDUYmHd8LnzXFCrIllxZW5hxgl
        OJiVRHh5fmyME+JNSaysSi3Kjy8qzUktPsQozcGiJM579h1QtUB6YklqdmpqQWoRTJaJg1Oq
        gXHSjj2cW+6JOfXwJD2YqHNi990Ndi1P5onPvfQxbmGGx/mzB4zPzpt1oVY4QsGBRaeHQ53/
        qLQap/Iksd5fZhPWvKoUf3z3HOeVQ7tYDBVMd3Oktmyfq/5Ja/eU3n3XXPy+budc0ONSkJn3
        1l9Z7OvK67ObvdkPvShrOLV2kaG2f+8KxebztX5KLMUZiYZazEXFiQBlmEu7IAMAAA==
X-CMS-RootMailID: 20200430125001epcas5p2a6f02e9888481cef96f32ba14450bc63
References: <CAK7LNASf687MLf1oWqrUiOHtw=p9Ug02bi1r-KevsxnFtQni2g@mail.gmail.com>
        <1588250972-8507-1-git-send-email-maninder1.s@samsung.com>
        <1588250972-8507-4-git-send-email-maninder1.s@samsung.com>
        <CGME20200430125001epcas5p2a6f02e9888481cef96f32ba14450bc63@epcms5p5>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

Thanks for review.
We will integrate your review comements and send v2.

>>

>> so making regex $re for ARM similar to aarch64
>>
>> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
>> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> 
> 
>This looks good to me, and it is a bug fix.
> 
>Just a question about the SOB.
> 
> 
>Maninder Singh is the author and also the submitter, right?
> 
>What does "Signed-off-by: Vaneet Narang <v.narang@samsung.com>" mean?
> 
>Co-developed-by or something else?
 
Yes All 4 patches are co-developed by Vaneet and me.
we were checking stack usage for arm and AARCH64 and found
some changes in scrips which can help others also.

Thanks,
Maninder Singh
