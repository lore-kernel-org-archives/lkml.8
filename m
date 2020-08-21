Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45D6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7FAD20702
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgHURxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:53:34 -0400
Received: from foss.arm.com ([217.140.110.172]:35310 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgHURxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 13:53:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74E2B1063;
        Fri, 21 Aug 2020 10:53:30 -0700 (PDT)
Received: from [192.168.1.8] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E7C53F66B;
        Fri, 21 Aug 2020 10:53:28 -0700 (PDT)
Subject: Re: CFS flat runqueue proposal fixes/update
To:     Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Paul Turner <pjt@google.com>,
        "vincent.guittot" <vincent.guittot@linaro.org>, kernel-team@fb.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dietmar.eggeman" <dietmar.eggeman@arm.com>
References: <1609106d05a6a4a5938233e993548510f599d7d9.camel@surriel.com>
 <0e7a9174-6ed9-752d-dacb-4dce182852cf@arm.com>
 <ad2a59c680d361847f257cdae576dd479e6ab9ac.camel@surriel.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <7b6349fc-c4c1-9c32-6b8f-0a9b3d7fa93c@arm.com>
Date:   Fri, 21 Aug 2020 19:53:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ad2a59c680d361847f257cdae576dd479e6ab9ac.camel@surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.08.20 22:39, Rik van Riel wrote:
> On Thu, 2020-08-20 at 16:56 +0200, Dietmar Eggemann wrote:

[...]

> The issue happens with a flat runqueue, when t1 goes
> to sleep, but t2 and t3 continue running.
> 
> We need to make sure the vruntime for t2 has not been
> advanced so far into the future that cgroup A is unable
> to get its fair share of CPU wihle t1 is sleeping.

Ah, these problems are related to the 'CFS flat runqueue' patch-set!
Misunderstanding om my side.

I somehow assumed that you wanted to say that these problems exist in
current mainline and could be solved with the patch-set plus some extra
functionality on top.
