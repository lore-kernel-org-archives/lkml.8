Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F10C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 10:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C4924681
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 10:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgCJKKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 06:10:21 -0400
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:29208 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726199AbgCJKKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 06:10:21 -0400
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Tue, 10 Mar
 2020 18:10:18 +0800
Received: from [10.32.64.44] (10.32.64.44) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Tue, 10 Mar
 2020 18:10:16 +0800
Subject: Re: [PATCH] x86/Kconfig: make X86_UMIP to cover any X86 CPU
To:     Borislav Petkov <bp@alien8.de>
CC:     "H. Peter Anvin" <hpa@zytor.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <DavidWang@zhaoxin.com>,
        <CooperYan@zhaoxin.com>, <QiyuanWang@zhaoxin.com>,
        <HerryYang@zhaoxin.com>, <CobeChen@zhaoxin.com>
References: <1583733990-2587-1-git-send-email-TonyWWang-oc@zhaoxin.com>
 <20200309203632.GB9002@zn.tnic>
 <79c4bc05-0482-3ce7-0f93-544977e466dc@zytor.com>
 <621e255f-f497-a324-b004-4cb9b84784d0@zhaoxin.com>
 <20200310090917.GB29372@zn.tnic>
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Message-ID: <541d167b-c193-538f-fa11-ee2e5681e566@zhaoxin.com>
Date:   Tue, 10 Mar 2020 18:09:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200310090917.GB29372@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.32.64.44]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/03/2020 17:09, Borislav Petkov wrote:
> On Tue, Mar 10, 2020 at 03:24:37PM +0800, Tony W Wang-oc wrote:
>> Moreover, if remove the X86_UMIP config, a kernel-parameter like
>> "noumip" may be needed?
> 
> Not the same thing. Also, why would one need it? If one did, one would
> need it now too.
> 
Yes, you are right, thank you point this. Let us focus on X86_UMIP config.

Sincerely
TonyWWang-oc
