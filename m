Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1A1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 515C5207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387509AbgERSI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:08:28 -0400
Received: from foss.arm.com ([217.140.110.172]:46554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732579AbgERSIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:08:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1230E101E;
        Mon, 18 May 2020 11:08:21 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D701B3F305;
        Mon, 18 May 2020 11:08:18 -0700 (PDT)
Subject: Re: [ACPI] b13663bdf9:
 BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/mutex.c
To:     Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        stable <stable@vger.kernel.org>, Len Brown <lenb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Ira Weiny <ira.weiny@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>, lkp@lists.01.org,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>
References: <20200511090034.GX5770@shao2-debian>
 <440dae1b-9146-0bc3-e8f2-bd3cb3aa89bb@intel.com>
 <CAPcyv4jKZp2bOZZ+ZMrcbFw9fPzeDu8waqwG6mBVpWwGq2DGtw@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <438c1743-5c8a-287d-3f97-e4a451ae8027@arm.com>
Date:   Mon, 18 May 2020 19:08:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jKZp2bOZZ+ZMrcbFw9fPzeDu8waqwG6mBVpWwGq2DGtw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On 12/05/2020 19:05, Dan Williams wrote:
> On Tue, May 12, 2020 at 9:28 AM Rafael J. Wysocki
> <rafael.j.wysocki@intel.com> wrote:
>> Dan,
>>
>> Has this been addressed in the v2?
> 
> No, this looks like a case I was concerned about, i.e. the GHES code
> is not being completely careful to avoid calling potentially sleeping
> functions with interrupts disabled. There is the nice comment that
> indicates that the fixmap should be used when ghes_notify_lock_irq()
> is held, but there seems to be no infrastructure to use / divert to
> the fixmap in the ghes_proc() path.

ghes_map()/ghes_unmap() use the fixmap for reading the firmware provided records,
but this came through apei_read(), which claims to be IRQ and NMI safe...


> That needs to be reworked first.
> It seems the implementation was getting lucky before to hit the cached
> acpi_ioremap in this path under rcu_read_lock(), but it appears it
> should have always been using the fixmap. Ying, James, is my read
> correct?

The path through this thing is pretty tortuous: The static HEST contains the address of
the pointer that firmware updates to point to CPER records when they are generated. This
pointer might be static (records are always in the same place), it might not.

The address in the tables is static. ghes.c maps it in ghes_new():
|	rc = apei_map_generic_address(&generic->error_status_address);

which happens before the ghes_add_timer()/request_irq()/ghes_nmi_add() stuff, so we should
always use the existing mapping.

__ghes_peek_estatus() reads the pointer with apei_read(), which should use the mapping
from ghes_new(), then uses ghes_copy_tofrom_phys() which uses the fixmap to read the CPER
records.


Does apei_map_generic_address() no longer keep the GAR/address mapped?
(also possible I've totally mis-understood how ACPIs caching of mappings works!)


Thanks,

James
