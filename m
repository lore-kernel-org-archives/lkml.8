Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61B5C33CAF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 01:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12CB20728
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 01:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388092AbgAQBcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 20:32:04 -0500
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:22532 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730070AbgAQBcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 20:32:03 -0500
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Fri, 17 Jan
 2020 09:32:01 +0800
Received: from [10.32.64.11] (10.32.64.11) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Fri, 17 Jan
 2020 09:31:44 +0800
Subject: Re: [PATCH] x86/speculation/spectre_v2: Exclude Zhaoxin CPUs from
 SPECTRE_V2
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>, <mingo@redhat.com>,
        <hpa@zytor.com>, <x86@kernel.org>, <luto@kernel.org>,
        <pawan.kumar.gupta@linux.intel.com>, <peterz@infradead.org>,
        <fenghua.yu@intel.com>, <vineela.tummalapalli@intel.com>,
        <linux-kernel@vger.kernel.org>, <DavidWang@zhaoxin.com>,
        <CooperYan@zhaoxin.com>, <QiyuanWang@zhaoxin.com>,
        <HerryYang@zhaoxin.com>
References: <1579146434-2668-1-git-send-email-TonyWWang-oc@zhaoxin.com>
 <87r1zzuy48.fsf@nanos.tec.linutronix.de> <20200116180748.GG27148@zn.tnic>
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Message-ID: <e578b820-9016-0f49-eb2c-18da631e2879@zhaoxin.com>
Date:   Fri, 17 Jan 2020 09:32:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200116180748.GG27148@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.32.64.11]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/01/2020 02:07, Borislav Petkov wrote:
> On Thu, Jan 16, 2020 at 06:09:27PM +0100, Thomas Gleixner wrote:
>> So the right thing here is to resend both patches as a patch series
>> with the conflict properly resolved.
> 
> And it is about time you started using --thread and --no-chain-reply-to
> with git send-email so that your patchsets are properly threaded. See
> the git-send-email(1) if something's still unclear.
> 

Ok, will do like this.

Sincerely
TonyWWang-oc
