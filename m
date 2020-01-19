Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FADAC33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 14:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CB2206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 14:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgASO6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 09:58:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60149 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgASO6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 09:58:01 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1itC1H-0003ON-Nl; Sun, 19 Jan 2020 15:57:43 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id AE7E4105BE3; Sun, 19 Jan 2020 15:57:42 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Liu\, Jing2" <jing2.liu@linux.intel.com>,
        Zha Bin <zhabin@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Cc:     mst@redhat.com, jasowang@redhat.com, slp@redhat.com,
        virtio-dev@lists.oasis-open.org, gerry@linux.alibaba.com,
        jing2.liu@intel.com, chao.p.peng@intel.com
Subject: Re: [PATCH v1 1/2] x86/msi: Enhance x86 to support platform_msi
In-Reply-To: <d3282993-714e-69cb-6113-72f6a8854839@linux.intel.com>
References: <874kwu2nih.fsf@nanos.tec.linutronix.de> <d3282993-714e-69cb-6113-72f6a8854839@linux.intel.com>
Date:   Sun, 19 Jan 2020 15:57:42 +0100
Message-ID: <87iml74hp5.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Liu, Jing2" <jing2.liu@linux.intel.com> writes:
> On 1/17/2020 9:58 PM, Thomas Gleixner wrote:
>>> Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
>>> Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
>>> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
>>> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
>> This Signed-off-by chain is invalid.
>>
>
> Could I ask how can we handle such co-author situation?

Search for Co-developed-by in Documentaiton,

Thanks,

        tglx
