Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B84EC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD836206F4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="VNE7eGd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgIIHzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:55:20 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:38018 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726399AbgIIHzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:55:18 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08975UI5016693;
        Wed, 9 Sep 2020 00:55:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pfpt0220;
 bh=WMlUyTptfef2ZZMiT/FpV0KuG7I2KWn4l+YZAIuGk18=;
 b=VNE7eGd+k5mKJgUl9OrIpJ1634+sBrv9wTu50HSEy2c0LVnPhidUGo/eccy8VGFQ3jgO
 2uMIlNpWtai1ImbmLlOz6zJjPRhXvYzcE1iwJqVb1iEPIGK+ckc8G97jTHn+dg044kJk
 V/uwlS5+9WnISe7fgJCardfgvJfZUEN2vjWDOeHhIsxhwCCs3/NEYlI7TlOB6Kk4PXWD
 nrRNItwMuj+Cd8eNWT4pJPL+jqjeMlTD4e3VmfZ8GUWvw87IRtWds1uktTGAtfBEmOk+
 N9tGjXZsJ+j6Scio/DdR3MEadjdbEgC/FHHSyhfXbh9y746jYFlaRstJL9gGn1Do1QYf xg== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 33c81pxvs5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 00:55:15 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Sep
 2020 00:55:14 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Sep 2020 00:55:14 -0700
Received: from [10.6.200.75] (NN-LT0019.marvell.com [10.6.200.75])
        by maili.marvell.com (Postfix) with ESMTP id 34A4F3F7044;
        Wed,  9 Sep 2020 00:55:11 -0700 (PDT)
Subject: Re: [EXT] [PATCH 0/5 REBASED to v5.9-rc4] Qlogic drivers: Convert to
 SPDX license identifiers
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-spdx@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Nilesh Javali <njavali@marvell.com>
References: <20200908123451.7215-1-lukas.bulwahn@gmail.com>
From:   Igor Russkikh <irusskikh@marvell.com>
Message-ID: <e5688d4c-f512-6705-6bb1-db832828fb35@marvell.com>
Date:   Wed, 9 Sep 2020 10:55:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101
 Thunderbird/81.0
MIME-Version: 1.0
In-Reply-To: <20200908123451.7215-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_03:2020-09-08,2020-09-09 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Igor, can you please ack these patches?
> 
> Igor, please also let us know:
>   A. if you will pick them up and let them travel through your tree, or
>   B. if the spdx maintainers shall pick them up and they shall route them
>      directly to Linus.

Thanks Lukas,

Acked on ethernet driver patches. For storage drivers I believe you'll have
ACK from Nilesh.

We don't manage our own tree, we normally do directly on netdev list.
Thus I think its safe to go with (B) and do this through spdx tree.

Regards,
  Igor
