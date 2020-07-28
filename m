Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DEDC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32ECC207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPPpZmKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbgG1TMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 15:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbgG1TMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:12:05 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0937FC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:12:05 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id f24so1271724ejx.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=pTNKvNJnyr1789TjsCTJ5I+nP8dMNTIbVhytErurEIw=;
        b=EPPpZmKHe6FQnO29dVsWuAZNxjy+xeRHQiBIIM0Rg4VgIIIdT7C773iA3ocX8P3BCg
         liqMWeDTHPjHvmmznO2jUPmWyPXNxbYK+unfRRoPF9Fw1VI/LSvhL9Q7VBCLRyLAx20L
         zPhZK/Y6F/DrqU3by2rtHDXao/V5g5f55yjNGl14IvBRPbzWy28JMJ71xEWOmhWgEAda
         Z7hd+XYrqWoST7rtxB14i7U2BMiJv/yiJYhv7QJjthBB0iTHd+w659h4BRBYwCSpUWAh
         MaN15PPKQoG+VSosJfB13oyiRhCf8XeWNoEPoqYl5g1y5aKNZombV+mE4LrW8ikNvZli
         EoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=pTNKvNJnyr1789TjsCTJ5I+nP8dMNTIbVhytErurEIw=;
        b=Il0lMcxHEXUyPrpp9uoCASrEKtPdKCKuZd0DCIicU4nnGuLZI2xQitGzfuEJxfldUU
         r7rsRw1N+puZUEesS/mpldn8OE3/b+RS869qzlGdvkvaQx68eluOwuR370OX4PUL8Y6w
         U2C/A4A9LbDItq8dBLPUZbI/iv+kdsSSOpYl/YHxnG7MWxDJaYjt/IV5gbs8RrbZsLdE
         n5kYrRjrIRwdtuBtX87CGTmF1Ot4GCgskPbSYfhR+dhtFXcry9R/fN9TmNmvYz+rBZrR
         OP6oIZDCK19GftdDG2R2STcg9H0TC6E6OJpQIq7lONV2lPzr6VxYRAYDsLoqBE8Uc8zC
         wxXQ==
X-Gm-Message-State: AOAM532j7CQUsdSxSGNdzF50oDvG0JLHSrrFikJRSOk0wW3F2IbybRUc
        Hgl1S4AuobuKe5qRViH5nFdRr8oo+i0UTaNWy+MCGtS9
X-Google-Smtp-Source: ABdhPJxNeBkPcQ9/bE7eXBbOZivl05wQVQYyWZSK47iCJB3XrG04FUcY+5cNKSYy3esP6F9shsQVkgB0te1F8xUVgVE=
X-Received: by 2002:a17:906:9592:: with SMTP id r18mr2932167ejx.464.1595963523082;
 Tue, 28 Jul 2020 12:12:03 -0700 (PDT)
MIME-Version: 1.0
From:   Marc Dionne <marc.c.dionne@gmail.com>
Date:   Tue, 28 Jul 2020 16:11:51 -0300
Message-ID: <CAB9dFds+EdaTor7EfmrHCNPVQTZ8BjX91a+jz0qP1uZAAcgaOw@mail.gmail.com>
Subject: BUG in iscisd with 5.8-rc kernels
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since some point in the current 5.8 cycle, iscsid sometimes crashes
and fails to come up after a reboot.

Here is a sample BUG:

 kernel: BUG: scheduling while atomic: iscsid/763/0x00000200

 kernel: Call Trace:
 kernel:  dump_stack+0x6b/0x88
 kernel:  __schedule_bug.cold+0x4c/0x58
 kernel:  __schedule+0x646/0x800
 kernel:  schedule+0x4a/0xb0
 kernel:  __lock_sock+0x69/0x90
 kernel:  ? finish_wait+0x80/0x80
 kernel:  lock_sock_nested+0x4f/0x60
 kernel:  inet_getname+0x98/0xd0
 kernel:  iscsi_sw_tcp_conn_get_param+0x9b/0x110 [iscsi_tcp]
 kernel:  show_conn_ep_param_ISCSI_PARAM_CONN_ADDRESS+0x6d/0x90
[scsi_transport_iscsi]
 kernel:  dev_attr_show+0x16/0x40
 kernel:  sysfs_kf_seq_show+0x98/0xf0
 kernel:  seq_read+0xa8/0x420
 kernel:  vfs_read+0x9d/0x180
 kernel:  ksys_read+0x4f/0xc0
 kernel:  do_syscall_64+0x47/0x80
 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Not areas I'm familiar with, but looking at
iscsi_sw_tcp_conn_get_param, it uses this pattern:

    spin_lock_bh(&conn->session->frwd_lock)
    kernel_getsockname()/kernel_getpeername()
    spin_unlock_bh(&conn->session->frwd_lock)

.. and inet_getname since 1b66d253610c7 ("bpf: Add get{peer, sock}name
attach types for sock_addr") has a new BPF_CGROUP_RUN_SA_PROG_LOCK()
that will try to lock_sock the socket, while a spinlock is held.  I
suspect that when this needs to sleep, it triggers the BUG.

I cc'ed the author of that commit, not sure if any other lists would
be useful to cc.

Marc
