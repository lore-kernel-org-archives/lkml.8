Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22764C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 11:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCC20208B3
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 11:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKY4Kdmi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgIFLky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 07:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgIFLke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 07:40:34 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3550EC061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 04:40:32 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c15so11716433wrs.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 04:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UflNccm9YvbRIabsTc4JZexRDtPYcjN+lnVl19jXxj4=;
        b=rKY4KdmiyhfERyh66I5AuVmr2wR+MkVzcWkRxACIHD6i4kYHvVuDO2sB/PjYxvNJd2
         1qwcsbtQl6MlyJ+UiG3rPulCGUEmBuXbcraC8Ah4V27KMbDu+dEydNO6gbv703iVFEmg
         K5Hvp3JmCvPIMtqT6Mdxqvrjs+8+rTU0fkoHI/fszd0d/O05XQCtakOh9n+4ZU1fR1T8
         S8V0LuGzsyb6lzOGjlygBqUbURhPvPYUh4oTrDdHHJ2HQwI5iJHod9LSM+mCLGNd6OpE
         DbexgnB7u921y4BNQ/oeUDvG4Wi2+d8RBTDSHQY7KEpfJrN86YdDqCz9hN1ga8f9gQlM
         iQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UflNccm9YvbRIabsTc4JZexRDtPYcjN+lnVl19jXxj4=;
        b=SFX+u1FqH9NMcJqMuUo+cWHDj2/uC/6zl7vAV31AIL9xcTfoXAA2sgLFaNsF+98IUU
         KiRtd6KWv3ygyiGNvDKRmMGkx5fgY96KK0wUN+vCQQ2k3N393uLm+DiQAcJVDPY/NSnm
         ZS9pLap5fygZVxifPXnVhBh2D9dTYMZ3R9LkamuTcZzC+V2hkcjYTM6dzlj10jHMoAsS
         g/mHRIf1BSEp1WiEX7Ls7n3KS63YeWjvPiXwfkEe+T4Ha016hBKJmZDtZ2FLcVgT3Boy
         EShjgKDUrx4wgFgC6VXJ3LgBSAkRVi3oo6mfMc3kSIuJFkXM6gbrzHVMfW4p9ccLW+u7
         015Q==
X-Gm-Message-State: AOAM530+HOu7hzjC/IdtuwWCwsl7E7TrVQAWwg6WN5xQmOg3wDO7lrkB
        SbrTGA5CR4T3ft+HNjJMzwU=
X-Google-Smtp-Source: ABdhPJwC0FA/FEGqgu4NWTAPoeJcUM6ltuXTT/PnyAk7pC1Lcb10P9mQtDsTr/3geDBK2J2Tu1xWsQ==
X-Received: by 2002:a5d:4645:: with SMTP id j5mr16259152wrs.230.1599392424182;
        Sun, 06 Sep 2020 04:40:24 -0700 (PDT)
Received: from [192.168.0.160] ([93.115.133.118])
        by smtp.gmail.com with ESMTPSA id a20sm20330699wmm.40.2020.09.06.04.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2020 04:40:23 -0700 (PDT)
Subject: Re: Multiple definitions of ARRAY_SIZE(arr)
To:     linux-kernel@vger.kernel.org
References: <d55df87a-c867-ae40-c27c-0894ffbba429@gmail.com>
Cc:     colomar.6.4.3@gmail.com
From:   Alejandro Colomar <colomar.6.4.3@gmail.com>
Message-ID: <96cfef64-b4d9-7c4b-8238-b57a2abd56e7@gmail.com>
Date:   Sun, 6 Sep 2020 13:40:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <d55df87a-c867-ae40-c27c-0894ffbba429@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here are a few more I could find using:
$ grep -rn "\/" | grep "sizeof.*sizeof" | grep -v ARRAY_SIZE |	\
			grep define | grep "\[0\]\|\*"

drivers/net/ethernet/huawei/hinic/hinic_ethtool.c:449:#define
ARRAY_LEN(arr) ((int)((int)sizeof(arr) / (int)sizeof(arr[0])))
drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c:33:#define
NUM_ELEMENTS(a) (sizeof(a) / sizeof((a)[0]))
drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c:46:#define
NUM_ELEMENTS(a) (sizeof(a) / sizeof((a)[0]))
drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c:58:#define
NUM_ELEMENTS(a) (sizeof(a) / sizeof((a)[0]))
drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c:52:#define
NUM_ELEMENTS(a) (sizeof(a) / sizeof((a)[0]))
scripts/dtc/libfdt/fdt_strerror.c:43:#define FDT_ERRTABSIZE
(sizeof(fdt_errtable) / sizeof(fdt_errtable[0]))
include/linux/sh_intc.h:100:#define _INTC_ARRAY(a) a, __same_type(a,
NULL) ? 0 : sizeof(a)/sizeof(*a)
include/acpi/actypes.h:497:#define ACPI_ARRAY_LENGTH(x)
(sizeof(x) / sizeof((x)[0]))
tools/firewire/nosy-dump.h:5:#define array_length(array) (sizeof(array)
/ sizeof(array[0]))
tools/perf/pmu-events/json.c:144:#define LOOKUP(a, i) ((i) <
(sizeof(a)/sizeof(*(a))) ? ((a)[i]) : "?")
tools/perf/arch/x86/util/dwarf-regs.c:92:#define ARCH_MAX_REGS
((sizeof(regoffset_table) / sizeof(regoffset_table[0])) - 1)
tools/testing/selftests/net/hwtstamp_config.c:53:#define N_TX_TYPES
((int)(sizeof(tx_types) / sizeof(tx_types[0])))
tools/testing/selftests/net/hwtstamp_config.c:74:#define N_RX_FILTERS
((int)(sizeof(rx_filters) / sizeof(rx_filters[0])))
tools/testing/selftests/openat2/helpers.h:16:#define ARRAY_LEN(X)
(sizeof (X) / sizeof (*(X)))
tools/bpf/bpf_dbg.c:82:# define array_size(x)	(sizeof(x) / sizeof((x)[0]))
samples/bpf/test_map_in_map_user.c:30:#define NR_TESTS
(sizeof(test_names) / sizeof(*test_names))


And a few more I could find using:
$ grep -rn "\/" | grep "sizeof.*sizeof" | grep -v ARRAY_SIZE |	\
			grep -v define | grep "\[0\]\|\*"

drivers/net/ethernet/intel/i40e/i40e_adminq.h:123:	if (!((u32)aq_rc <
(sizeof(aq_to_posix) / sizeof((aq_to_posix)[0]))))
drivers/net/ethernet/intel/iavf/iavf_adminq.h:123:	if (!((u32)aq_rc <
(sizeof(aq_to_posix) / sizeof((aq_to_posix)[0]))))
drivers/net/ethernet/mellanox/mlx4/qp.c:616:	for (k =
MLX4_QP_TABLE_ZONE_RSS + 1; k < sizeof(*bitmap)/sizeof((*bitmap)[0]);
drivers/net/ethernet/mellanox/mlx4/qp.c:742:		     i <
sizeof(qp_table->zones_uids)/sizeof(qp_table->zones_uids[0]);
drivers/gpu/drm/i915/gvt/vgpu.c:127:	num_types = sizeof(vgpu_types) /
sizeof(vgpu_types[0]);
drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c:2372:			for (k =
0; k <
sizeof(wb_arb_params->cli_watermark)/sizeof(wb_arb_params->cli_watermark[0]);
k++) {
drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c:39:	table_size =
sizeof(qp_table_##mode##_##bpc##bpc_##max)/sizeof(*qp_table_##mode##_##bpc##bpc_##max);
\
tools/perf/tests/bpf.c:320:			       sizeof(insns) / sizeof(insns[0]),
tools/perf/util/trace-event-parse.c:209:	for (i = 0; i <
(int)(sizeof(flags)/sizeof(flags[0])); i++)
tools/lib/traceevent/event-parse.c:3868:	for (i = 0; i <
(int)(sizeof(flags)/sizeof(flags[0])); i++)
tools/usb/usbip/src/usbipd.c:536:		sizeof(sockfdlist) /
sizeof(*sockfdlist));
tools/usb/ffs-aio-example/multibuff/device_app/aio_multibuff.c:299:	for
(i = 0; i < sizeof(iobuf)/sizeof(*iobuf); ++i)
tools/usb/ffs-aio-example/multibuff/device_app/aio_multibuff.c:327:		for
(i = 0; i < sizeof(iobuf)/sizeof(*iobuf); ++i) {
tools/usb/ffs-aio-example/multibuff/device_app/aio_multibuff.c:367:		
actual = (actual + 1)%(sizeof(iobuf)/sizeof(*iobuf));
tools/usb/ffs-aio-example/multibuff/device_app/aio_multibuff.c:372:	for
(i = 0; i < sizeof(iobuf)/sizeof(*iobuf); ++i)
tools/usb/ffs-test.c:669:	for (i = 1; i < sizeof threads / sizeof
*threads; ++i)
tools/usb/ffs-test.c:672:	for (i = 1; i < sizeof threads / sizeof
*threads; ++i)
tools/usb/ffs-test.c:677:	for (i = 1; i < sizeof threads / sizeof
*threads; ++i)
tools/testing/scatterlist/main.c:76:	assert(i == (sizeof(tests) /
sizeof(tests[0])) - 1);
tools/testing/selftests/net/psock_fanout.c:152:	attr.insn_cnt =
sizeof(prog) / sizeof(prog[0]);
tools/testing/selftests/net/reuseport_bpf_numa.c:89:	attr.insn_cnt =
sizeof(prog) / sizeof(prog[0]);
tools/testing/selftests/x86/test_vdso.c:267:	for (int clock = 0; clock <
sizeof(clocknames) / sizeof(clocknames[0]);
tools/testing/selftests/proc/proc-pid-vm.c:371:		for (i = 0; i <
sizeof(S)/sizeof(S[0]); i++) {
tools/testing/selftests/proc/proc-pid-vm.c:420:		for (i = 0; i <
sizeof(S)/sizeof(S[0]); i++) {
tools/testing/selftests/bpf/progs/test_rdonly_maps.c:67:	int i =
sizeof(rdonly_values.a) / sizeof(rdonly_values.a[0]);
tools/testing/selftests/bpf/prog_tests/obj_name.c:23:	for (i = 0; i <
sizeof(tests) / sizeof(tests[0]); i++) {
tools/testing/selftests/bpf/prog_tests/global_data.c:31:	for (i = 0; i <
sizeof(tests) / sizeof(tests[0]); i++) {
tools/testing/selftests/bpf/prog_tests/global_data.c:60:	for (i = 0; i <
sizeof(tests) / sizeof(tests[0]); i++) {
tools/testing/selftests/bpf/prog_tests/global_data.c:94:	for (i = 0; i <
sizeof(tests) / sizeof(tests[0]); i++) {
tools/testing/selftests/bpf/test_lru_map.c:883:	for (f = 0; f <
sizeof(map_flags) / sizeof(*map_flags); f++) {
tools/testing/selftests/bpf/test_lru_map.c:887:		for (t = 0; t <
sizeof(map_types) / sizeof(*map_types); t++) {
samples/seccomp/bpf-fancy.c:83:		.len = (unsigned
short)(sizeof(filter)/sizeof(filter[0])),
samples/seccomp/bpf-fancy.c:86:	bpf_resolve_jumps(&l, filter,
sizeof(filter)/sizeof(*filter));
samples/seccomp/dropper.c:42:		.len = (unsigned
short)(sizeof(filter)/sizeof(filter[0])),
samples/seccomp/bpf-direct.c:146:		.len = (unsigned
short)(sizeof(filter)/sizeof(filter[0])),
samples/timers/hpet_example.c:64:	for (i = 0; i < (sizeof (hpet_command)
/ sizeof (hpet_command[0])); i++)
samples/bpf/tracex5_user.c:22:		.len = (unsigned
short)(sizeof(filter)/sizeof(filter[0])),
samples/bpf/test_lru_dist.c:527:	for (f = 0; f < sizeof(map_flags) /
sizeof(*map_flags); f++) {
arch/powerpc/xmon/ppc-opc.c:6972:  sizeof (powerpc_opcodes) / sizeof
(powerpc_opcodes[0]);
arch/powerpc/xmon/ppc-opc.c:7211:  sizeof (vle_opcodes) / sizeof
(vle_opcodes[0]);
arch/powerpc/xmon/ppc-opc.c:7280:  sizeof (powerpc_macros) / sizeof
(powerpc_macros[0]);
arch/powerpc/kernel/traps.c:2298:	for (i = 0; i <
sizeof(ppc_emulated)/sizeof(*entries); i++) {
arch/s390/tools/gen_facilities.c:154:	for (i = 0; i <
sizeof(facility_defs) / sizeof(facility_defs[0]); i++)
arch/s390/tools/gen_opcode_table.c:141:	for (i = 0; i <
sizeof(insn_type_table) / sizeof(insn_type_table[0]); i++) {
arch/um/kernel/config.c.in:17:	for (i = 0; i <
sizeof(config)/sizeof(config[0]); i++)
arch/x86/entry/vdso/vdso2c.h:119:	for (i = 0; i < sizeof(special_pages)
/ sizeof(special_pages[0]); i++) {


There were a more entries on these, but looked like noise,
or were in a more obfuscated form that should be examined
case by case.  Might look deeper at them later.


Alex
