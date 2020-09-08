Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7925C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 03:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA2E321532
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 03:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgIHD7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 23:59:41 -0400
Received: from mx2.cyber.ee ([193.40.6.72]:34933 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbgIHD7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 23:59:41 -0400
Subject: Re: gcc crashes with general protection faults in
 5.9.0-rc3-00091-ge28f0104343d
From:   Meelis Roos <mroos@linux.ee>
To:     LKML <linux-kernel@vger.kernel.org>
References: <9883f24e-7ea4-ffe1-e284-8583a3407c94@linux.ee>
Message-ID: <b87406f8-a4a3-2aa6-34f7-268d109ba6af@linux.ee>
Date:   Tue, 8 Sep 2020 06:58:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <9883f24e-7ea4-ffe1-e284-8583a3407c94@linux.ee>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following up my yesterdays mail:

> This is 5.9.0-rc3-00091-ge28f0104343d on Lenovo t460s that has ran fine up to 5.8.0.
> 
> Today I tried reproducing my linking problem with git kernel on my laptop and got segmentation faults in gcc. This is probably the corresponding dmesg part:
> 
> 0xdead000000000400 loks like some kind of poisoning.
> 
> [307299.392045] general protection fault, probably for non-canonical address 0xdead000000000400: 0000 [#1] SMP PTI

Was not reproducible in 5.9-rc4 while recompiling the kernel in a loop for 8 hours.

-- 
Meelis Roos <mroos@linux.ee>
