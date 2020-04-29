Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E91C83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E36B52083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgD2RAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:00:50 -0400
Received: from foss.arm.com ([217.140.110.172]:42294 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbgD2RAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 13:00:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39FA41045;
        Wed, 29 Apr 2020 10:00:49 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 479573F73D;
        Wed, 29 Apr 2020 10:00:46 -0700 (PDT)
Subject: Re: [PATCH v9 01/18] arm64: kexec: make dtb_mem always enabled
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-2-pasha.tatashin@soleen.com>
From:   James Morse <james.morse@arm.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        vladimir.murzin@arm.com, matthias.bgg@gmail.com,
        bhsharma@redhat.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com
Message-ID: <f29c53ec-a152-a4a9-6d50-7aeedd60173f@arm.com>
Date:   Wed, 29 Apr 2020 18:00:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200326032420.27220-2-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 26/03/2020 03:24, Pavel Tatashin wrote:
> Currently, dtb_mem is enabled only when CONFIG_KEXEC_FILE is
> enabled. This adds ugly ifdefs to c files.

~s/dtb_mem/ARCH_HAS_KIMAGE_ARCH/ ?
dtb_mem is just one member of struct kimage_arch.


> Always enabled dtb_mem, when it is not used, it is NULL.
> Change the dtb_mem to phys_addr_t, as it is a physical address.

Regardless,
Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
