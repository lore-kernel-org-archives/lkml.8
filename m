Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3770CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 108B420826
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbgEURhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 13:37:46 -0400
Received: from foss.arm.com ([217.140.110.172]:50828 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728019AbgEURhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 13:37:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E4F530E;
        Thu, 21 May 2020 10:37:45 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 790E43F68F;
        Thu, 21 May 2020 10:37:44 -0700 (PDT)
Date:   Thu, 21 May 2020 18:37:38 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     guohanjun@huawei.com, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com
Subject: Re: arm64/acpi: NULL dereference reports from UBSAN at boot
Message-ID: <20200521173738.GA29590@e121166-lin.cambridge.arm.com>
References: <20200521100952.GA5360@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521100952.GA5360@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 11:09:53AM +0100, Will Deacon wrote:
> Hi folks,
> 
> I just tried booting the arm64 for-kernelci branch under QEMU (version
> 4.2.50 (v4.2.0-779-g4354edb6dcc7)) with UBSAN enabled, and I see a
> couple of NULL pointer dereferences reported at boot. I think they're
> both GIC related (log below). I don't see a panic with UBSAN disabled,
> so something's fishy here.

May I ask you the QEMU command line please - just to make sure I can
replicate it.

> Please can you take a look when you get a chance? I haven't had time to see
> if this is a regression or not, but I don't think it's particularly serious
> as I have all sorts of horrible stuff enabled in my .config, since I'm
> trying to chase down another bug:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/plain/arch/arm64/configs/fuzzing.config?h=fuzzing/arm64-kernelci-20200519&id=c149cf6a51aa4f72d53fc681c6661094e93ef660
> 
> (on top of defconfig)
> 
> CONFIG_FAIL_PAGE_ALLOC may be to blame.

Not sure about that, they are both quite cryptic, I wonder if UBSAN
is not tricked by the ACPI_OFFSET macro - need to debug it further
to understand what's going on here.

Thanks,
Lorenzo

> Cheers,
> 
> Will
> 
> --->8
> 
> [    0.000000][    T0] ================================================================================
> [    0.000000][    T0] UBSAN: null-ptr-deref in drivers/acpi/acpica/tbfadt.c:459:37
> [    0.000000][    T0] member access within null pointer of type 'struct acpi_table_fadt'
> [    0.000000][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 5.7.0-rc6-00124-g96bc42ff0a82 #1
> [    0.000000][    T0] Call trace:
> [    0.000000][    T0]  dump_backtrace+0x0/0x384
> [    0.000000][    T0]  show_stack+0x28/0x38
> [    0.000000][    T0]  dump_stack+0xec/0x174
> [    0.000000][    T0]  handle_null_ptr_deref+0x134/0x174
> [    0.000000][    T0]  __ubsan_handle_type_mismatch_v1+0x84/0xa4
> [    0.000000][    T0]  acpi_tb_create_local_fadt+0x1d4/0x1418
> [    0.000000][    T0]  acpi_tb_parse_fadt+0x108/0x4b8
> [    0.000000][    T0]  acpi_tb_parse_root_table+0x380/0x578
> [    0.000000][    T0]  acpi_initialize_tables+0x140/0x194
> [    0.000000][    T0]  acpi_table_init+0x90/0xcc
> [    0.000000][    T0]  acpi_boot_table_init+0xfc/0x1c8
> [    0.000000][    T0]  setup_arch+0x2b4/0x3ec
> [    0.000000][    T0]  start_kernel+0x98/0x6f4
> [    0.000000][    T0] ================================================================================
> 
> [    0.000000][    T0] ================================================================================
> [    0.000000][    T0] UBSAN: null-ptr-deref in arch/arm64/kernel/smp.c:596:6
> [    0.000000][    T0] member access within null pointer of type 'struct acpi_madt_generic_interrupt'
> [    0.000000][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 5.7.0-rc6-00124-g96bc42ff0a82 #1
> [    0.000000][    T0] Call trace:
> [    0.000000][    T0]  dump_backtrace+0x0/0x384
> [    0.000000][    T0]  show_stack+0x28/0x38
> [    0.000000][    T0]  dump_stack+0xec/0x174
> [    0.000000][    T0]  handle_null_ptr_deref+0x134/0x174
> [    0.000000][    T0]  __ubsan_handle_type_mismatch_v1+0x84/0xa4
> [    0.000000][    T0]  acpi_parse_gic_cpu_interface+0x60/0xe8
> [    0.000000][    T0]  acpi_parse_entries_array+0x288/0x498
> [    0.000000][    T0]  acpi_table_parse_entries_array+0x178/0x1b4
> [    0.000000][    T0]  acpi_table_parse_madt+0xa4/0x110
> [    0.000000][    T0]  acpi_parse_and_init_cpus+0x38/0x100
> [    0.000000][    T0]  smp_init_cpus+0x74/0x258
> [    0.000000][    T0]  setup_arch+0x350/0x3ec
> [    0.000000][    T0]  start_kernel+0x98/0x6f4
> [    0.000000][    T0] ================================================================================
