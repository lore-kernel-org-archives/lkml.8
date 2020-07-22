Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845FCC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 619F72065E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BgjibWMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbgGVKCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:02:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33234 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726153AbgGVKCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595412149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZGw3CBU/a4ir1CtsPUs3AFBzA7ryhOJkzP09PzVjVOA=;
        b=BgjibWMlHO+GfXh34XSqHTwa7EZ8i60SDcBVEN//SrrkvOMa8D3oFaRFv9IvNJHbr6+Bs5
        ljYHPNo8460q8URctlDgl15GkuNG4O7JpXvdKhpOsFtXu95iGs8lKNTL2J7dpdBWIkcmO3
        fOSoX3+gUu8wajKGqO+7MSrmarAhNMg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-oUwV_ReMPj6sI3Ul9wvYSg-1; Wed, 22 Jul 2020 06:02:27 -0400
X-MC-Unique: oUwV_ReMPj6sI3Ul9wvYSg-1
Received: by mail-wm1-f72.google.com with SMTP id q15so184929wmj.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZGw3CBU/a4ir1CtsPUs3AFBzA7ryhOJkzP09PzVjVOA=;
        b=GL2GB5SDLhvhRKPEVVr4e9r6hkrG9WVh4LIM3Wh0hbDGLSGyFXIrnoLcPG1nfOkBmj
         ob1SXHCNFIiw67iW7mYvSiMSMOnwyvKzbaj72oEffWLG4uVyZ9rtSR1P4mdODe5loFH7
         TtG7zH4P1HTNgUadroJ2KsmXnbvtvzZASPQI0jgMpdPdIg7Qn5IadG5H4RkWdq2L55rP
         d5zfXx+HOxjTUPNTxZWA/JhXldD8f2AXlSWAMkJSIbR1QVr+YX45sHwWBd5Lr7bztBg6
         WHHzs05XoY3VJz1KGFENpTyQBR1Px95jJbcfh3YJkhHKZUgb5pKysHEaqo8lW/aW9FJx
         3dww==
X-Gm-Message-State: AOAM531mRfOLU2bhj0V3FwIIDAjlL3hBi9qR2Y3RmV75LfcDJOZpjFkG
        DIIIfn8V3w6GF1J7KUKAqS2+f51WUCxk7SrRVB2uDvFDCzAlsub3adRmhB6Oz9wDhmyI6Mvo8WQ
        Vwrhzoqu3nJMBhcQGGL45wfG1
X-Received: by 2002:a5d:400b:: with SMTP id n11mr29421218wrp.74.1595412146517;
        Wed, 22 Jul 2020 03:02:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfVhxF9SUQiUMuOA9xfIf6oQ96QGOx+/lvuJEbzNKZX3oMCkgSiacKGOlzjllo+SDicLKdig==
X-Received: by 2002:a5d:400b:: with SMTP id n11mr29421205wrp.74.1595412146276;
        Wed, 22 Jul 2020 03:02:26 -0700 (PDT)
Received: from steredhat ([5.180.207.22])
        by smtp.gmail.com with ESMTPSA id x1sm41746598wrp.10.2020.07.22.03.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 03:02:25 -0700 (PDT)
Date:   Wed, 22 Jul 2020 12:02:04 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Kieran Bingham <kbingham@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: scripts/gdb: received an error when invoking lx-symbols
Message-ID: <20200722100204.z43tnn2rtfb5ow2x@steredhat>
References: <20200722091342.c3iss32caiuuizja@steredhat>
 <04728663-acde-bfb7-84dc-f97d628bc739@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04728663-acde-bfb7-84dc-f97d628bc739@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 11:19:42AM +0200, Jan Kiszka wrote:
> On 22.07.20 11:13, Stefano Garzarella wrote:
> > Hi Jan, Kieran,
> > with the last Linux 5.8-rc6 I have some problems with gdb scripts.
> > Everything is fine with Linux 5.7.
> > 
> > When I call lx-symbols, I received this error while loading modules
> > symbols:
> > 
> >      (gdb) set python print-stack full
> >      (gdb) target remote :1234
> >      Remote debugging using :1234
> >      arch_atomic_read (v=<optimized out>) at ../arch/x86/kernel/process.c:687
> >      687		trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
> >      (gdb) lx-symbols
> >      loading vmlinux
> >      scanning for modules in /home/stefano/repos/linux_vsock/build-tiny-config
> >      loading @0xffffffffc0169000: /home/stefano/repos/linux_vsock/build-tiny-config/drivers/net/tun.ko
> >      Traceback (most recent call last):
> >        File "/home/stefano/repos/linux_vsock/build-tiny-config/scripts/gdb/linux/symbols.py", line 174, in invoke
> >          self.load_all_symbols()
> >        File "/home/stefano/repos/linux_vsock/build-tiny-config/scripts/gdb/linux/symbols.py", line 161, in load_all_symbols
> >          [self.load_module_symbols(module) for module in module_list]
> >        File "/home/stefano/repos/linux_vsock/build-tiny-config/scripts/gdb/linux/symbols.py", line 161, in <listcomp>
> >          [self.load_module_symbols(module) for module in module_list]
> >        File "/home/stefano/repos/linux_vsock/build-tiny-config/scripts/gdb/linux/symbols.py", line 131, in load_module_symbols
> >          sections=self._section_arguments(module))
> >        File "/home/stefano/repos/linux_vsock/build-tiny-config/scripts/gdb/linux/symbols.py", line 98, in _section_arguments
> >          section_name_to_address = {
> >        File "/home/stefano/repos/linux_vsock/build-tiny-config/scripts/gdb/linux/symbols.py", line 99, in <dictcomp>
> >          attrs[n]['name'].string(): attrs[n]['address']
> >      gdb.error: There is no member named name.
> >      Error occurred in Python: There is no member named name.
> > 
> > I'll try to bisect.
> 
> Dig for changes in the data structure (module_sect_attr).

Thanks for the hint, I think I found the problem, I'll send a patch :-)

Stefano

