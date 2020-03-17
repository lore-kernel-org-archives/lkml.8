Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92ABFC1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 18:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D6320714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 18:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgCQScN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 14:32:13 -0400
Received: from foss.arm.com ([217.140.110.172]:41394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgCQScM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 14:32:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57C2231B;
        Tue, 17 Mar 2020 11:32:12 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5459E3F67D;
        Tue, 17 Mar 2020 11:32:11 -0700 (PDT)
Date:   Tue, 17 Mar 2020 18:32:09 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, maz@kernel.org, mark.rutland@arm.com,
        shan.gavin@gmail.com
Subject: Re: [PATCH] arm64/kernel: Simplify __cpu_up() by bailing out early
Message-ID: <20200317183209.GG632169@arrakis.emea.arm.com>
References: <20200302020340.119588-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302020340.119588-1-gshan@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 01:03:40PM +1100, Gavin Shan wrote:
> The function __cpu_up() is invoked to bring up the target CPU through
> the backend, PSCI for example. The nested if statements won't be needed
> if we bail out early on the following two conditions where the status
> won't be checked. The code looks simplified in that case.
> 
>    * Error returned from the backend (e.g. PSCI)
>    * The target CPU has been marked as onlined
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>

Queued for 5.7. Thanks.

-- 
Catalin
