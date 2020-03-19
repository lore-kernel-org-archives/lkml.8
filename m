Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71FDC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8E720663
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgCSQMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 12:12:52 -0400
Received: from foss.arm.com ([217.140.110.172]:38336 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbgCSQMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 12:12:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6677330E;
        Thu, 19 Mar 2020 09:12:51 -0700 (PDT)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A75F3F52E;
        Thu, 19 Mar 2020 09:12:47 -0700 (PDT)
Subject: Re: [PATCH 1/2] perf: dsu: Allow multiple devices share same IRQ.
To:     Mark Rutland <mark.rutland@arm.com>,
        Tuan Phan <tuanphan@os.amperecomputing.com>
Cc:     patches@amperecomputing.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1584491176-31358-1-git-send-email-tuanphan@os.amperecomputing.com>
 <20200319143250.GA4876@lakrids.cambridge.arm.com>
 <20200319143510.GB4876@lakrids.cambridge.arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <5c1e81ff-467c-f2dc-4d92-f60117f67b40@arm.com>
Date:   Thu, 19 Mar 2020 16:12:43 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200319143510.GB4876@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-19 2:35 pm, Mark Rutland wrote:
> On Thu, Mar 19, 2020 at 02:32:51PM +0000, Mark Rutland wrote:
>> On Tue, Mar 17, 2020 at 05:26:15PM -0700, Tuan Phan wrote:
>>> Add IRQF_SHARED flag when register IRQ such that multiple dsu
>>> devices can share same IRQ.
>>>
>>> Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
>>
>> I don't think that this makes sense; further I think that this
>> highlights that the current driver doesn't support such a configuration
>> for other reasons.
>>
>> A DSU instance can only be accessed from a CPU associated with it, since
>> it's accessed via sysregs. The IRQ handler must run on one of those
>> CPUs.
>>
>> To handle that, the DSU PMU driver will need to gain an understanding of
>> which CPUs are associated with the instance. As it stands the driver
>> seems to assume that there's a single DSU instance, and that all CPUs
>> are affine to that same instance.
> 
> Sorry, I misread dsu_pmu_get_online_cpu_any_but(), multiple instances
> are handled already.

Oh, so either way it's effectively a rerun of the U8500 problem of 
having no guarantee that the interrupt will be taken on an appropriate 
CPU, and losing genuine events as apparently spurious if it isn't. Yeah, 
that's really really bad... :(

>> So NAK to this patch, given the above.
> 
> Regardless, this NAK stands.

Agreed, pretending that this might work without significantly more 
invasive workarounds does more harm than good.

Robin.
