Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035EFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDDAC2078E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbgG1P4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:56:11 -0400
Received: from smtprelay0250.hostedemail.com ([216.40.44.250]:37202 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730963AbgG1P4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:56:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id EED4018029122;
        Tue, 28 Jul 2020 15:56:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: milk44_171497c26f6b
X-Filterd-Recvd-Size: 1381
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 28 Jul 2020 15:56:08 +0000 (UTC)
Message-ID: <e5d2cb28493050f2df7cedef209288abf103b4f3.camel@perches.com>
Subject: Re: [PATCH net-next] liquidio: Remove unneeded cast from memory
 allocation
From:   Joe Perches <joe@perches.com>
To:     Derek Chickles <dchickles@marvell.com>,
        "wanghai (M)" <wanghai38@huawei.com>,
        Satananda Burla <sburla@marvell.com>,
        Felix Manlunas <fmanlunas@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 28 Jul 2020 08:56:07 -0700
In-Reply-To: <BYAPR18MB24230A8301FD9849F9943B9DAC730@BYAPR18MB2423.namprd18.prod.outlook.com>
References: <BYAPR18MB24230A8301FD9849F9943B9DAC730@BYAPR18MB2423.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-28 at 15:39 +0000, Derek Chickles wrote:
> I think that is fine as well. We just used vmalloc since there is no need
> for a physically contiguous piece of memory.

Do any of the allocs in the driver actually need vmalloc?


