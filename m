Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0939FC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 05:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAC90206D7
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 05:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgHAFDx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 01:03:53 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:53827 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725601AbgHAFDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 01:03:52 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=cambda@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0U4MsdmN_1596258228;
Received: from 10.150.185.158(mailfrom:cambda@linux.alibaba.com fp:SMTPD_---0U4MsdmN_1596258228)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 01 Aug 2020 13:03:50 +0800
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
From:   Cambda Zhu <cambda@linux.alibaba.com>
Mime-Version: 1.0 (1.0)
Subject: Re:  [PATCH] checkpatch: skip macros when finding missing switch/case break
Message-Id: <46F62293-BC9E-4428-94BD-186B0E3D3A5E@linux.alibaba.com>
Date:   Sat, 1 Aug 2020 13:03:48 +0800
Cc:     linux-kernel@vger.kernel.org
To:     Joe Perches <joe@perches.com>
X-Mailer: iPhone Mail (17G68)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

﻿I agree with you. Actually there are some false warnings not mentioned in my patch, such as:

case xxx: {
   if () {
       return;
   } else {
           if () {
               return;
           } else {
               return;
           }
   }
}
case xxx:
   ...

Since compiler can do this now, I think this test should be removed.

Regards,
Cambda

> 在 2020年8月1日，02:05，Joe Perches <joe@perches.com> 写道：
> 
> ﻿On Wed, 2020-07-29 at 20:59 +0800, Cambda Zhu wrote:
>> The checkpatch.pl only searches 3 previous lines when finding missing
>> switch/case break, and macros are treated as normal statements. If the
>> cases are surrounded with CONFIG, checkpatch.pl may report false
>> warnings. For example:
> 
> Likely this test should be removed altogether as
> it's never really worked well and now compilers
> find this and emit warnings.

