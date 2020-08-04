Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09F7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49E2620792
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="E6oxyEIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgHEAXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 20:23:05 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:50030 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgHEAXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 20:23:04 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200805002301epoutp03d2f7acfb5dbff1fd3cb7e8d6ffb48415~oN2aqWhSw1578215782epoutp03H
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 00:23:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200805002301epoutp03d2f7acfb5dbff1fd3cb7e8d6ffb48415~oN2aqWhSw1578215782epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596586982;
        bh=qlNdJKxS6vjRNEiMmu428ar6fswYmiSCm+c/7glGFUc=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=E6oxyEImGOCEmwvFkNP+WDq6o4Wg2m9tfMl8jKsUYo8Ce2RfhFM9Yr/5Q740qa+yT
         PX+Pq7ANbScCy3ERYJ//Z/ffnc7pXst307ZILFouAt1P67vOeoGh9PbeHq7SjXNcVy
         AnHtjk+MhNZRsdJ2nfZOm4VbQJ9J8HcTZ8Mh3PAI=
Received: from epcpadp2 (unknown [182.195.40.12]) by epcas1p4.samsung.com
        (KnoxPortal) with ESMTP id
        20200805002301epcas1p4bd83ad50725ee1ba24824c5ff429a42c~oN2aOGZ3c1926719267epcas1p4a;
        Wed,  5 Aug 2020 00:23:01 +0000 (GMT)
Mime-Version: 1.0
Subject: RE: Re: [PATCH v6 2/5] scsi: ufs: Add UFS-feature layer
Reply-To: daejun7.park@samsung.com
From:   Daejun Park <daejun7.park@samsung.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Daejun Park <daejun7.park@samsung.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>
CC:     "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sang-yoon Oh <sangyoon.oh@samsung.com>,
        Sung-Jun Park <sungjun07.park@samsung.com>,
        yongmyung lee <ymhungry.lee@samsung.com>,
        Jinyoung CHOI <j-young.choi@samsung.com>,
        Adel Choi <adel.choi@samsung.com>,
        BoRam Shin <boram.shin@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <8d0fe031-e941-1b4e-7596-301ebd36f06d@acm.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <231786897.01596586981491.JavaMail.epsvc@epcpadp2>
Date:   Wed, 05 Aug 2020 08:33:04 +0900
X-CMS-MailID: 20200804233304epcms2p1a36cc6f2726b091573bb592e261a7961
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20200713103423epcms2p8442ee7cc22395e4a4cedf224f95c45e8
References: <8d0fe031-e941-1b4e-7596-301ebd36f06d@acm.org>
        <7bcf45da-233b-0c38-b93a-99d205603e63@acm.org>
        <231786897.01594636801601.JavaMail.epsvc@epcpadp1>
        <963815509.21594636682161.JavaMail.epsvc@epcpadp2>
        <231786897.01594637401708.JavaMail.epsvc@epcpadp1>
        <20200722064112.GB21117@infradead.org>
        <yq1h7tzg1lb.fsf@ca-mkp.ca.oracle.com>
        <963815509.21595830981720.JavaMail.epsvc@epcpadp2>
        <CGME20200713103423epcms2p8442ee7cc22395e4a4cedf224f95c45e8@epcms2p1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

> Any idea how much time this work will take and when a new version will be
> posted?

I have plan to patch new version in this week.

Thanks,

Daejun

