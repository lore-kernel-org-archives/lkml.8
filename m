Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17305C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 05:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E175820899
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 05:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgE1Fm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 01:42:29 -0400
Received: from foss.arm.com ([217.140.110.172]:47374 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgE1Fm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 01:42:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29D8E30E;
        Wed, 27 May 2020 22:42:27 -0700 (PDT)
Received: from A010555 (unknown [10.169.38.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F1FF3F52E;
        Wed, 27 May 2020 22:42:25 -0700 (PDT)
References: <20200427061520.24905-1-nick.gasson@arm.com> <20200427061520.24905-4-nick.gasson@arm.com> <20200527142057.GF14219@kernel.org> <20200527162300.GD16490@kernel.org> <20200527223405.GE16490@kernel.org>
User-agent: mu4e 1.4.5; emacs 26.3
From:   Nick Gasson <nick.gasson@arm.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] perf jvmti: Fix demangling Java symbols
In-reply-to: <20200527223405.GE16490@kernel.org>
Date:   Thu, 28 May 2020 13:42:23 +0800
Message-ID: <xgl9v9kgfwe8.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/28/20 06:34 AM, Arnaldo Carvalho de Melo wrote:
>> 
>> This is in my tmp.perf/core branch pending a round of testing, after
>> that it'll move to perf/core on its way to 5.8, thanks.
>
> All tests passed, moved to perf/core.
>

Great, thank you!

--
Nick

