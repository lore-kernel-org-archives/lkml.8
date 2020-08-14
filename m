Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949C9C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 15:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FC9420866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 15:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgHNPUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 11:20:36 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:51498 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgHNPUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 11:20:35 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k6bVR-00H01D-G4; Fri, 14 Aug 2020 09:20:33 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k6bVQ-0001vZ-PO; Fri, 14 Aug 2020 09:20:33 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Sang Yan <sangyan@huawei.com>
Cc:     <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <xiexiuqi@huawei.com>, <guohanjun@huawei.com>,
        <zhuling8@huawei.com>, <luanjianhai@huawei.com>,
        <luchunhua@huawei.com>
References: <20200814055239.47348-1-sangyan@huawei.com>
Date:   Fri, 14 Aug 2020 10:17:06 -0500
In-Reply-To: <20200814055239.47348-1-sangyan@huawei.com> (Sang Yan's message
        of "Fri, 14 Aug 2020 01:52:38 -0400")
Message-ID: <87tux5i7f1.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k6bVQ-0001vZ-PO;;;mid=<87tux5i7f1.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/U8iQDvUHSg0k7Zv0nFYBoIQGMmYLEEDU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 1/2] kexec: Add quick kexec support for kernel
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sang Yan <sangyan@huawei.com> writes:

> In normal kexec, relocating kernel may cost 5 ~ 10 seconds, to
> copy all segments from vmalloced memory to kernel boot memory,
> because of disabled mmu.

I haven't seen kexec that slow since I tested on my 16Mhz 386.

That machine has an excuse it really is slow.  Anything else
that takes seconds is almost certainly slow because someone
has misconfigured things to not cache the data copied by kexec.

I humbly suggest that you fix the arm64 code so that the data gets
cached.

Eric
