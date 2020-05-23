Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290D0C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 13:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC3C920727
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 13:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFNpO2k0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387851AbgEWNVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 09:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387815AbgEWNVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 09:21:03 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA9AC061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 06:21:03 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q9so6260219pjm.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 06:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7rYlOASI2Uf/pMeuWpxbRuRzIcEs6/uLqmpVmSboedI=;
        b=dFNpO2k0NbFZU8uPU4zo7xvgNqzHx6dQ9Estz6m9lYd/W1Ss/eMaatBTa/0rSjFhee
         0Sbgf6riP1GVvzjx8xeGi3zFa8TNijpbtH+8/oIKNWBc0SpgTtmcBrhxdJodN2R8oYuM
         BOG68yMJm5WvXDdaHsXBS1LlZbJEQ2yq7/T/onLZAi/F3YQwJHm789HJj0UsNMEbLZA2
         JOtTxPEdxwrw9RnmpHknXxR1DK8fiHcz5wG+aAhKY5YaQzFzhfOBW8P+eia9Y6wuHzuM
         L4dtS23qOsKCR9qz/uEcqyUafRYjFIaO0CQHPSlRrr1C/gG0u52ywl2b1BUbbANcB7z7
         XvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7rYlOASI2Uf/pMeuWpxbRuRzIcEs6/uLqmpVmSboedI=;
        b=H9wAe1iXrMWfDulPMGPMcuB9bmaGp7LdoQYfnrKRMspezL8gcX36+tVEv1jpmn54yN
         ip1w12BU2FUzU7Yv9PXV1nMtoRBcz4v01qq9SEdQEsLsWAuBEoLddHA2gadFtM80H2YO
         Y4LZ7Xf5wVg7igZLmrLj7f3Nn++Fo4TFYixQnRLl0iymw+CUYfGVltSfd/XodhZd42Tr
         sSxWbqnqbWMmdAIJeP6u8TUPMzgnFsNrjf2x3uWBLMW7MNl+oHHEuEg2Ywy8S7hXyY1P
         6ti76J/HjWQX401RjnfYZA32uwDJoWmN6qURGMnJ2f/q2/OGygLh/LAsulUt7lWxNJuv
         JNWA==
X-Gm-Message-State: AOAM533AB5s8gToHOsQER+0VNe67vFw+PhX18qq+EHJfULGw6qnnVg+D
        Vt/kGeAlRNSoYFEXA5c1XeI=
X-Google-Smtp-Source: ABdhPJxYeFGr+LmVvqhN9ypo/3g9yz9+eh1icvdBRtA51T9XdWXsSwoTmnAQayoIoEq5cbxCb6Lscw==
X-Received: by 2002:a17:90a:738e:: with SMTP id j14mr10385997pjg.107.1590240062997;
        Sat, 23 May 2020 06:21:02 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c24sm8972780pjs.51.2020.05.23.06.21.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 May 2020 06:21:02 -0700 (PDT)
Date:   Sat, 23 May 2020 06:21:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] kobject: Make sure the parent does not get released
 before its children
Message-ID: <20200523132101.GA76443@roeck-us.net>
References: <20200513151840.36400-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513151840.36400-1-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 06:18:40PM +0300, Heikki Krogerus wrote:
> In the function kobject_cleanup(), kobject_del(kobj) is
> called before the kobj->release(). That makes it possible to
> release the parent of the kobject before the kobject itself.
> 
> To fix that, adding function __kboject_del() that does

s/kboject/kobject/

> everything that kobject_del() does except release the parent
> reference. kobject_cleanup() then calls __kobject_del()
> instead of kobject_del(), and separately decrements the
> reference count of the parent kobject after kobj->release()
> has been called.
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Fixes: 7589238a8cf3 ("Revert "software node: Simplify software_node_release() function"")
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Tested-by: Brendan Higgins <brendanhiggins@google.com>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>

All my arm64be (arm64 big endian) boot tests crash with this patch
applied. Reverting it fixes the problem. Crash log and bisect results
(from pending-fixes branch) below.

Guenter

---
[   14.944149] ------------[ cut here ]------------
[   14.946182] Unable to handle kernel paging request at virtual address 006b6b6b6b6b6b6b
[   14.946194] Mem abort info:
[   14.946197]   ESR = 0x96000004
[   14.946200]   EC = 0x25: DABT (current EL), IL = 32 bits
[   14.946203]   SET = 0, FnV = 0
[   14.946205]   EA = 0, S1PTW = 0
[   14.946208] Data abort info:
[   14.946210]   ISV = 0, ISS = 0x00000004
[   14.946213]   CM = 0, WnR = 0
[   14.946216] [006b6b6b6b6b6b6b] address between user and kernel address ranges
[   14.946218] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[   14.946229] Modules linked in:
[   14.946239] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.7.0-rc6-00275-gdbacbfd47d67 #1
[   14.946242] Hardware name: linux,dummy-virt (DT)
[   14.946245] pstate: 00000085 (nzcv daIf -PAN -UAO)
[   14.946247] pc : string_nocheck+0x14/0x90
[   14.946250] lr : string+0x5c/0x70
[   14.946252] sp : ffff80001000b580
[   14.946255] x29: ffff80001000b580 x28: ffff800012d04fa4
[   14.946262] x27: ffff800011702686 x26: 0000000000000020
[   14.946269] x25: 00000000000003e0 x24: ffff800011702686
[   14.946275] x23: ffff800012d04f98 x22: 00000000ffffffd0
[   14.946282] x21: 04ffffff000affff x20: 6b6b6b6b6b6b6b6b
[   14.946289] x19: ffff800012d05378 x18: 0000000000000010
[   14.946296] x17: 0000000000001800 x16: 0000000000001000
[   14.946302] x15: 00000000ffffffff x14: ffff800011fa0a48
[   14.946309] x13: ffff80009000b5d7 x12: ffff800011fc45e0
[   14.946316] x11: ffff80001000b930 x10: ffff80001000b930
[   14.946322] x9 : ffff80001000b930 x8 : ffff80001000b930
[   14.946329] x7 : ffff80001000b930 x6 : 00000000ffffffff
[   14.946336] x5 : 0000000000000000 x4 : 0000000000000000
[   14.946343] x3 : 04ffffff000affff x2 : 6b6b6b6b6b6b6b6b
[   14.946349] x1 : ffff800012d05378 x0 : ffff800012d04fa4
[   14.946356] Call trace:
[   14.946359]  string_nocheck+0x14/0x90
[   14.946361]  string+0x5c/0x70
[   14.946364]  vsnprintf+0x340/0x700
[   14.946366]  vscnprintf+0x30/0x58
[   14.946369]  vprintk_store+0x64/0x230
[   14.946371]  vprintk_emit+0xd4/0x358
[   14.946374]  vprintk_default+0x3c/0x48
[   14.946376]  vprintk_func+0xec/0x230
[   14.946378]  vprintk+0x28/0x38
[   14.946381]  __warn_printk+0x7c/0xa0
[   14.946383]  kobject_put+0xe4/0x138
[   14.946386]  put_device+0x14/0x28
[   14.946388]  put_i2c_dev+0x9c/0xb0
[   14.946391]  i2cdev_detach_adapter.part.5+0x20/0x30
[   14.946394]  i2cdev_notifier_call+0x80/0x88
[   14.946396]  notifier_call_chain+0x54/0x98
[   14.946399]  blocking_notifier_call_chain+0x5c/0x80
[   14.946401]  device_del+0x84/0x3b0
[   14.946404]  device_unregister+0x18/0x38
[   14.946406]  i2c_del_adapter+0x1e0/0x238
[   14.946409]  i2c_mux_del_adapters+0xa0/0xf0
[   14.946412]  unittest_i2c_mux_remove+0x14/0x28
[   14.946414]  i2c_device_remove+0x54/0xe0
[   14.946417]  device_release_driver_internal+0xf8/0x1d0
[   14.946419]  driver_detach+0x50/0xe0
[   14.946422]  bus_remove_driver+0x58/0xb0
[   14.946424]  driver_unregister+0x30/0x60
[   14.946427]  i2c_del_driver+0x28/0x38
[   14.946429]  of_unittest+0x269c/0x2c00
[   14.946432]  do_one_initcall+0x88/0x418
[   14.946434]  kernel_init_freeable+0x29c/0x314
[   14.946437]  kernel_init+0x14/0x108
[   14.946439]  ret_from_fork+0x10/0x1c
[   14.946442] Code: a9bf7bfd 13003c66 910003fd 34000306 (39400045)
[   14.950079] ---[ end trace 793dbb9150f3d51a ]---

---
# bad: [dbacbfd47d67736d5ebd724391a8d0d82f36d30f] Merge remote-tracking branch 'drm-misc-fixes/for-linux-next-fixes'
# good: [fb33c6510d5595144d585aa194d377cf74d31911] Linux 5.6-rc6
git bisect start 'HEAD' 'v5.6-rc6'
# good: [f365ab31efacb70bed1e821f7435626e0b2528a6] Merge tag 'drm-next-2020-04-01' of git://anongit.freedesktop.org/drm/drm
git bisect good f365ab31efacb70bed1e821f7435626e0b2528a6
# good: [9c94b39560c3a013de5886ea21ef1eaf21840cb9] Merge tag 'ext4_for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4
git bisect good 9c94b39560c3a013de5886ea21ef1eaf21840cb9
# good: [c0259664c6879e1045d6d6703f37501690f6760f] netlabel: Kconfig: Update reference for NetLabel Tools project
git bisect good c0259664c6879e1045d6d6703f37501690f6760f
# good: [d5fef88ccbd3a2d3674e6cc868804a519ef9e5b6] Merge tag 'renesas-fixes-for-v5.7-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into arm/fixes
git bisect good d5fef88ccbd3a2d3674e6cc868804a519ef9e5b6
# good: [ce24729667cf8aaebf290613a6026a50a22c3eee] Merge tag 'linux-kselftest-5.7-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
git bisect good ce24729667cf8aaebf290613a6026a50a22c3eee
# good: [3c9e66568ad40dc17518fa00e2b28c3b450040d4] Merge tag 'arc-5.7-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc
git bisect good 3c9e66568ad40dc17518fa00e2b28c3b450040d4
# good: [4aada7791fa2bd3e927502bc67ba604b95bb21bf] Merge remote-tracking branch 'sound-current/for-linus'
git bisect good 4aada7791fa2bd3e927502bc67ba604b95bb21bf
# bad: [2611695ba42692c4d887d379309b9b33edc25055] Merge remote-tracking branch 'usb-chipidea-fixes/ci-for-usb-stable'
git bisect bad 2611695ba42692c4d887d379309b9b33edc25055
# good: [80aa3db7fe3cd90b18a227c9f25798c1743ffe1e] Merge remote-tracking branch 'sound-asoc-fixes/for-linus'
git bisect good 80aa3db7fe3cd90b18a227c9f25798c1743ffe1e
# good: [83c813e237b8edf0fe8184ccdf3dc9622202084c] Merge remote-tracking branch 'spi/for-5.7' into spi-linus
git bisect good 83c813e237b8edf0fe8184ccdf3dc9622202084c
# good: [b054578b1ea052664a1b19fde1c163d29b0856b5] Merge remote-tracking branch 'spi-fixes/for-linus'
git bisect good b054578b1ea052664a1b19fde1c163d29b0856b5
# bad: [e0dd35dbc905307e249cee2301304b6a194848ef] Merge remote-tracking branch 'driver-core.current/driver-core-linus'
git bisect bad e0dd35dbc905307e249cee2301304b6a194848ef
# good: [44e960490ddf868fc9135151c4a658936e771dc2] driver core: Fix handling of SYNC_STATE_ONLY + STATELESS device links
git bisect good 44e960490ddf868fc9135151c4a658936e771dc2
# bad: [4ef12f7198023c09ad6d25b652bd8748c965c7fa] kobject: Make sure the parent does not get released before its children
git bisect bad 4ef12f7198023c09ad6d25b652bd8748c965c7fa
# first bad commit: [4ef12f7198023c09ad6d25b652bd8748c965c7fa] kobject: Make sure the parent does not get released before its children
