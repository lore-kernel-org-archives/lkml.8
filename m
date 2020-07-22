Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A48FC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E735205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731393AbgGVJTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:19:51 -0400
Received: from david.siemens.de ([192.35.17.14]:58714 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726153AbgGVJTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:19:50 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 06M9JhuR029038
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jul 2020 11:19:43 +0200
Received: from [167.87.24.251] ([167.87.24.251])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 06M9JgCb000681;
        Wed, 22 Jul 2020 11:19:43 +0200
Subject: Re: scripts/gdb: received an error when invoking lx-symbols
To:     Stefano Garzarella <sgarzare@redhat.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20200722091342.c3iss32caiuuizja@steredhat>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <04728663-acde-bfb7-84dc-f97d628bc739@siemens.com>
Date:   Wed, 22 Jul 2020 11:19:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091342.c3iss32caiuuizja@steredhat>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.07.20 11:13, Stefano Garzarella wrote:
> Hi Jan, Kieran,
> with the last Linux 5.8-rc6 I have some problems with gdb scripts.
> Everything is fine with Linux 5.7.
> 
> When I call lx-symbols, I received this error while loading modules
> symbols:
> 
>      (gdb) set python print-stack full
>      (gdb) target remote :1234
>      Remote debugging using :1234
>      arch_atomic_read (v=<optimized out>) at ../arch/x86/kernel/process.c:687
>      687		trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
>      (gdb) lx-symbols
>      loading vmlinux
>      scanning for modules in /home/stefano/repos/linux_vsock/build-tiny-config
>      loading @0xffffffffc0169000: /home/stefano/repos/linux_vsock/build-tiny-config/drivers/net/tun.ko
>      Traceback (most recent call last):
>        File "/home/stefano/repos/linux_vsock/build-tiny-config/scripts/gdb/linux/symbols.py", line 174, in invoke
>          self.load_all_symbols()
>        File "/home/stefano/repos/linux_vsock/build-tiny-config/scripts/gdb/linux/symbols.py", line 161, in load_all_symbols
>          [self.load_module_symbols(module) for module in module_list]
>        File "/home/stefano/repos/linux_vsock/build-tiny-config/scripts/gdb/linux/symbols.py", line 161, in <listcomp>
>          [self.load_module_symbols(module) for module in module_list]
>        File "/home/stefano/repos/linux_vsock/build-tiny-config/scripts/gdb/linux/symbols.py", line 131, in load_module_symbols
>          sections=self._section_arguments(module))
>        File "/home/stefano/repos/linux_vsock/build-tiny-config/scripts/gdb/linux/symbols.py", line 98, in _section_arguments
>          section_name_to_address = {
>        File "/home/stefano/repos/linux_vsock/build-tiny-config/scripts/gdb/linux/symbols.py", line 99, in <dictcomp>
>          attrs[n]['name'].string(): attrs[n]['address']
>      gdb.error: There is no member named name.
>      Error occurred in Python: There is no member named name.
> 
> I'll try to bisect.

Dig for changes in the data structure (module_sect_attr).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
