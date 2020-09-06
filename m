Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20020C43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 11:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C89C320760
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 11:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9RLSl+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgIFLIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 07:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgIFLG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 07:06:28 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA05C061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 04:05:52 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z4so11719679wrr.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 04:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=sXURuKdB3VULZ4Bj9H0oogd+JM16i76T2nWZbzsfcyM=;
        b=B9RLSl+McTo6/Xhc2S5K4nklx1ICnuNamOIQYGtfT58otK3WlVXrxiWWvAkXah/U5e
         YFY/5cxsOFbGEsdnJFR388U2CUdYwrTbllyL7gmKkJp22KnypR8wVtiZvsxZ5S3Pj/s8
         7k0nmw43qWIs8z4NT7/xXCQYhTwJB8JCXDpq9+PqGiIdcm9RZE8JOZjAyxPJ+iSNNk+e
         L5FObwS0RQRvTVMiWy5tf2gnUHe7G96mpONQgvlpzHF4Ni8YcP6dSytKzW83mMDOVyS5
         pR4OEmgW3GzunIfMw3BEdP9ofy+VXgX4fALcoKT179okvJEtxEQ7tomsE9HH8qQFMaGG
         wvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=sXURuKdB3VULZ4Bj9H0oogd+JM16i76T2nWZbzsfcyM=;
        b=VhZYnI1j7B0S3Hc/qLFwzuFVbYsynEpPPruJrrgmrVE1Hffij7Vmv87jKnHMjTI5+G
         DCsMqSf1NR5fx+F9EbVubN/Ol/b63fOZ6WCwzXUFp+69Tw28VFZsn12YrlDa0nESn7yi
         u2Gw0OvLtqgJ36vrcnnMcXf+kwTTMx9RIrjmgZsi0J91P/j7DM3mg6/o+7SiVrWn3Hr6
         WgK9fuH5URzNMP4Q3r1S3rOAw5oR+v2k//vdc/8lzTrTKuAPVmhRA3S2sONTMFV0JpEn
         /7lwZiQlfsvYxjOzeQuUR+rNxuwwgyziisMwWQQ4ezzEFlylV5JPUoT6BR79ATrF1F8O
         mieQ==
X-Gm-Message-State: AOAM530XM8Ts1q4I3GyGCClLiQW7w40Wob2Pruvp6PG27bcksJ2P7GMm
        Vq0mDWd28SpgG5A+57L8ETq5kBNX8Ig=
X-Google-Smtp-Source: ABdhPJyGGuyVBjtX6IKBFVtagtuQ9KMXXWI7DTqzPgXYUKEdycQpck3lrZpHWOgqSUCsC8RtJgKjGw==
X-Received: by 2002:a5d:6852:: with SMTP id o18mr16132271wrw.113.1599390339023;
        Sun, 06 Sep 2020 04:05:39 -0700 (PDT)
Received: from [192.168.0.160] ([93.115.133.118])
        by smtp.gmail.com with ESMTPSA id z13sm22582758wro.97.2020.09.06.04.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2020 04:05:38 -0700 (PDT)
To:     linux-kernel@vger.kernel.org
Cc:     colomar.6.4.3@gmail.com
From:   Alejandro Colomar <colomar.6.4.3@gmail.com>
Subject: Multiple definitions of ARRAY_SIZE(arr)
Message-ID: <d55df87a-c867-ae40-c27c-0894ffbba429@gmail.com>
Date:   Sun, 6 Sep 2020 13:05:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I was reading through kernel code, and found that there are many
definitions of `ARRAY_SIZE(arr)` all around the kernel.

Is there a reason for all of those to exist, or should they all just
include <linux/kernel.h>?  If so, I would be happy to patch them.

Moreover, only the <linux/kernel.h> one is safe because of
`__must_be_array(arr)`.

Here's what I found:

$ grep -rn "define ARRAY_SIZE("
fs/orangefs/orangefs-debug.h:21:#define ARRAY_SIZE(arr) (sizeof(arr) /
sizeof((arr)[0]))
fs/unicode/mkutf8data.c:63:#define ARRAY_SIZE(x) (sizeof(x) /
sizeof((x)[0]))
scripts/genksyms/genksyms.c:406:#define ARRAY_SIZE(arr) (sizeof(arr) /
sizeof((arr)[0]))
scripts/dtc/util.h:26:#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
scripts/mod/file2alias.c:713:#define ARRAY_SIZE(x) (sizeof(x) /
sizeof((x)[0]))
scripts/kconfig/preprocess.c:15:#define ARRAY_SIZE(arr)		(sizeof(arr) /
sizeof((arr)[0]))
scripts/kallsyms.c:28:#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
include/linux/kernel.h:47:#define ARRAY_SIZE(arr) (sizeof(arr) /
sizeof((arr)[0]) + __must_be_array(arr))
tools/gpio/gpio-utils.h:17:#define ARRAY_SIZE(arr) (sizeof(arr) /
sizeof((arr)[0]))
tools/iio/iio_utils.h:18:#define ARRAY_SIZE(arr) (sizeof(arr) /
sizeof(arr[0]))
tools/virtio/linux/kernel.h:50:#define ARRAY_SIZE(x)
(sizeof(x)/sizeof(x[0]))
tools/lib/traceevent/plugins/plugin_xen.c:103:#define ARRAY_SIZE(arr)
(sizeof(arr) / sizeof((arr)[0]))
tools/include/linux/kernel.h:107:#define ARRAY_SIZE(arr) (sizeof(arr) /
sizeof((arr)[0]) + __must_be_array(arr))
tools/power/cpupower/utils/cpupower.c:23:#define ARRAY_SIZE(x)
(sizeof(x)/sizeof(x[0]))
tools/usb/usbip/libsrc/usbip_device_driver.c:30:#define ARRAY_SIZE(arr)
(sizeof(arr) / sizeof((arr)[0]))
tools/spi/spidev_test.c:26:#define ARRAY_SIZE(a) (sizeof(a) /
sizeof((a)[0]))
tools/testing/selftests/seccomp/seccomp_benchmark.c:17:#define
ARRAY_SIZE(a)    (sizeof(a) / sizeof(a[0]))
tools/testing/selftests/sparc64/drivers/adi-test.c:28:# define
ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
tools/testing/selftests/net/reuseport_bpf.c:28:#define ARRAY_SIZE(arr)
(sizeof(arr) / sizeof((arr)[0]))
tools/testing/selftests/net/tcp_fastopen_backup_key.c:38:#define
ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
tools/testing/selftests/net/socket.c:34:#define ARRAY_SIZE(arr)
(sizeof(arr) / sizeof((arr)[0]))
tools/testing/selftests/net/rxtimestamp.c:21:#define ARRAY_SIZE(arr)
(sizeof(arr) / sizeof((arr)[0]))
tools/testing/selftests/kselftest_harness.h:590:#define ARRAY_SIZE(a)
(sizeof(a) / sizeof(a[0]))
tools/testing/selftests/timens/procfs.c:27:#define ARRAY_SIZE(arr)
(sizeof(arr) / sizeof((arr)[0]))
tools/testing/selftests/timens/timens.c:25:#define ARRAY_SIZE(arr)
(sizeof(arr) / sizeof((arr)[0]))
tools/testing/selftests/cgroup/cgroup_util.h:7:#define ARRAY_SIZE(arr)
(sizeof(arr) / sizeof((arr)[0]))
tools/testing/selftests/rseq/basic_percpu_ops_test.c:14:#define
ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
tools/testing/selftests/rseq/rseq.c:32:#define ARRAY_SIZE(arr)
(sizeof(arr) / sizeof((arr)[0]))
tools/testing/selftests/ir/ir_loopback.c:29:#define ARRAY_SIZE(arr)
(sizeof(arr) / sizeof((arr)[0]))
tools/testing/selftests/vm/va_128TBswitch.c:12:#define ARRAY_SIZE(arr)
(sizeof(arr) / sizeof((arr)[0]))
tools/testing/selftests/x86/protection_keys.c:54:#define ARRAY_SIZE(x)
(sizeof(x) / sizeof(*(x)))
tools/testing/selftests/bpf/progs/test_sysctl_loop1.c:13:#define
ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
tools/testing/selftests/bpf/progs/test_sysctl_loop2.c:13:#define
ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
tools/testing/selftests/bpf/progs/test_sysctl_prog.c:19:#define
ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
tools/testing/selftests/bpf/bpf_util.h:31:# define ARRAY_SIZE(x)
(sizeof(x) / sizeof((x)[0]))
tools/vm/page-types.c:209:#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
samples/seccomp/user-trap.c:24:#define ARRAY_SIZE(x) (sizeof(x) /
sizeof(*(x)))
samples/mic/mpssd/mpssd.c:40:#define ARRAY_SIZE(x) (sizeof(x) /
sizeof((x)[0]))
samples/bpf/cookie_uid_helper_example.c:34:#define ARRAY_SIZE(x)
(sizeof(x) / sizeof(*(x)))
arch/powerpc/boot/types.h:7:#define ARRAY_SIZE(x) (sizeof(x) /
sizeof((x)[0]))
arch/mips/boot/tools/relocs.h:32:#define ARRAY_SIZE(x) (sizeof(x) /
sizeof((x)[0]))
arch/um/include/shared/user.h:17:#define ARRAY_SIZE(x) (sizeof(x) /
sizeof((x)[0]))
arch/x86/tools/insn_sanity.c:19:#define ARRAY_SIZE(a)
(sizeof(a)/sizeof(a[0]))
arch/x86/tools/relocs.h:22:#define ARRAY_SIZE(x) (sizeof(x) /
sizeof((x)[0]))
arch/x86/boot/boot.h:31:#define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
Documentation/process/coding-style.rst:985:	#define ARRAY_SIZE(x)
(sizeof(x) / sizeof((x)[0]))
Documentation/translations/zh_CN/process/coding-style.rst:823:	#define
ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
Documentation/translations/it_IT/process/coding-style.rst:1001:	#define
ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))


Alex
