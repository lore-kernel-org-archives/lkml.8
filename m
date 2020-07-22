Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBA9C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13BA02077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDCYwlWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731495AbgGVJNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:13:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23517 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731472AbgGVJNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595409231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ZYZjRH/Es7S7krkOLC+4d8dzWEgBPyCz/UYU6pFdugw=;
        b=VDCYwlWwd1sQKkmH6BZH7BUJkdxHBfbKx90iQo8uXa+iSRkjZe64G6gsY7w9dRvPTXxwxe
        iO0PHPBPYB9/x/fUxSkEy4J7gGkgCLzs/5siVUTJoluAmQmIOPM8Edt5m3qmqf0WCMjGi3
        0aVzrUOXv9mgI6Nah+KKcYUSmCBa3qU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-Rgndl27MMOOnrt70oyruQw-1; Wed, 22 Jul 2020 05:13:50 -0400
X-MC-Unique: Rgndl27MMOOnrt70oyruQw-1
Received: by mail-wm1-f69.google.com with SMTP id e15so860150wme.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 02:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ZYZjRH/Es7S7krkOLC+4d8dzWEgBPyCz/UYU6pFdugw=;
        b=KrSotvl25Kq6CctAx98fLeaHRmIBH3ZnHz7P5K/PPxaWiwqLfw417IpkV+Jyw8TlSC
         kJE02AJyP7URE50X2hMVT2Xk1gLM8jXGlYLS1DRsXYV3snr/+r6JDRJJ7YP5+X9vAyEz
         vYCXKCpnNNv4way0XbHACUGdz3qy8IOhIpUgog4NZoOjxEi8f9IjQt0x9my0fME1HeKI
         MSdWKmoGailrKguZVV0b+DlvgrNWjod8BbrcQlg5SuWZOUeAgril9J9h3PiQMfcRLG6t
         QPgaODhrsW4npmDf5Dw9EAWTlB1vW2swanT5ieY31oUZIj1u5hadTXFJbIppubfCw8iS
         IztQ==
X-Gm-Message-State: AOAM531CdKdWOKGoNrqykYYYPZSRcZl+9G+deuvv1xm1lnkWkh88opqF
        K5PgvxulileLUHSJ1521/wLG/99a1CpICLpnrF890NVgn05JAJ/JIVyYpFN8YfnBlbpDWePtYBJ
        QOuRI6ruhuug22p41zeeWQqI7
X-Received: by 2002:a5d:4a0b:: with SMTP id m11mr10008445wrq.407.1595409229017;
        Wed, 22 Jul 2020 02:13:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyS5CUHzdzlW96rSCvkGGQDHMhWSHDh6017O1YZEfSgcuNfZ7jly9ctkINJZnYd0lJKeegaQ==
X-Received: by 2002:a5d:4a0b:: with SMTP id m11mr10008430wrq.407.1595409228738;
        Wed, 22 Jul 2020 02:13:48 -0700 (PDT)
Received: from steredhat ([5.180.207.22])
        by smtp.gmail.com with ESMTPSA id j24sm11173841wrb.49.2020.07.22.02.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 02:13:48 -0700 (PDT)
Date:   Wed, 22 Jul 2020 11:13:42 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: scripts/gdb: received an error when invoking lx-symbols
Message-ID: <20200722091342.c3iss32caiuuizja@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan, Kieran,
with the last Linux 5.8-rc6 I have some problems with gdb scripts.
Everything is fine with Linux 5.7.

When I call lx-symbols, I received this error while loading modules
symbols:

    (gdb) set python print-stack full
    (gdb) target remote :1234
    Remote debugging using :1234
    arch_atomic_read (v=<optimized out>) at ../arch/x86/kernel/process.c:687
    687		trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
    (gdb) lx-symbols 
    loading vmlinux
    scanning for modules in /home/stefano/repos/linux_vsock/build-tiny-config
    loading @0xffffffffc0169000: /home/stefano/repos/linux_vsock/build-tiny-config/drivers/net/tun.ko
    Traceback (most recent call last):
      File "/home/stefano/repos/linux_vsock/build-tiny-config/scripts/gdb/linux/symbols.py", line 174, in invoke
        self.load_all_symbols()
      File "/home/stefano/repos/linux_vsock/build-tiny-config/scripts/gdb/linux/symbols.py", line 161, in load_all_symbols
        [self.load_module_symbols(module) for module in module_list]
      File "/home/stefano/repos/linux_vsock/build-tiny-config/scripts/gdb/linux/symbols.py", line 161, in <listcomp>
        [self.load_module_symbols(module) for module in module_list]
      File "/home/stefano/repos/linux_vsock/build-tiny-config/scripts/gdb/linux/symbols.py", line 131, in load_module_symbols
        sections=self._section_arguments(module))
      File "/home/stefano/repos/linux_vsock/build-tiny-config/scripts/gdb/linux/symbols.py", line 98, in _section_arguments
        section_name_to_address = {
      File "/home/stefano/repos/linux_vsock/build-tiny-config/scripts/gdb/linux/symbols.py", line 99, in <dictcomp>
        attrs[n]['name'].string(): attrs[n]['address']
    gdb.error: There is no member named name.
    Error occurred in Python: There is no member named name.

I'll try to bisect.

Thanks,
Stefano

