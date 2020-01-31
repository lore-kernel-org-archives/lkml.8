Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1021AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70BE2063A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbgAaN6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 08:58:01 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56818 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbgAaN6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 08:58:00 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 2A8AC2955AD
Subject: Re: next/master bisection: baseline.login on qemu_x86_64
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
References: <5e3325a1.1c69fb81.f0110.2b89@mx.google.com>
Cc:     broonie@kernel.org, tomeu.vizoso@collabora.com,
        enric.balletbo@collabora.com, mgalka@collabora.com,
        khilman@baylibre.com, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <54f5679d-949c-1e13-3d21-3c8d657b25a4@collabora.com>
Date:   Fri, 31 Jan 2020 13:57:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <5e3325a1.1c69fb81.f0110.2b89@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

Please see the bisection report below about a boot failure.

Reports aren't automatically sent to the public while we're
trialing new bisection features on kernelci.org but this one
looks valid.


The main kernel error from the log is:

  [    0.225243] general protection fault, probably for non-canonical address 0x9896808086a201: 0000 [#1] SMP PTI


Thanks,
Guillaume

On 30/01/2020 18:51, kernelci.org bot wrote:
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> *                                                               *
> * If you do send a fix, please include this trailer:            *
> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> *                                                               *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> 
> next/master bisection: baseline.login on qemu_x86_64
> 
> Summary:
>   Start:      c32e1d01a152 Add linux-next specific files for 20200130
>   Plain log:  https://storage.kernelci.org//next/master/next-20200130/x86_64/x86_64_defconfig/gcc-8/lab-baylibre/baseline-qemu_x86_64.txt
>   HTML log:   https://storage.kernelci.org//next/master/next-20200130/x86_64/x86_64_defconfig/gcc-8/lab-baylibre/baseline-qemu_x86_64.html
>   Result:     987f028b8637 char: hpet: Use flexible-array member
> 
> Checks:
>   revert:     PASS
>   verify:     PASS
> 
> Parameters:
>   Tree:       next
>   URL:        git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   Branch:     master
>   Target:     qemu_x86_64
>   CPU arch:   x86_64
>   Lab:        lab-baylibre
>   Compiler:   gcc-8
>   Config:     x86_64_defconfig
>   Test case:  baseline.login
> 
> Breaking commit found:
> 
> -------------------------------------------------------------------------------
> commit 987f028b8637cfa7658aa456ae73f8f21a7a7f6f
> Author: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Date:   Mon Jan 20 17:53:26 2020 -0600
> 
>     char: hpet: Use flexible-array member
>     
>     Old code in the kernel uses 1-byte and 0-byte arrays to indicate the
>     presence of a "variable length array":
>     
>     struct something {
>         int length;
>         u8 data[1];
>     };
>     
>     struct something *instance;
>     
>     instance = kmalloc(sizeof(*instance) + size, GFP_KERNEL);
>     instance->length = size;
>     memcpy(instance->data, source, size);
>     
>     There is also 0-byte arrays. Both cases pose confusion for things like
>     sizeof(), CONFIG_FORTIFY_SOURCE, etc.[1] Instead, the preferred mechanism
>     to declare variable-length types such as the one above is a flexible array
>     member[2] which need to be the last member of a structure and empty-sized:
>     
>     struct something {
>             int stuff;
>             u8 data[];
>     };
>     
>     Also, by making use of the mechanism above, we will get a compiler warning
>     in case the flexible array does not occur last in the structure, which
>     will help us prevent some kind of undefined behavior bugs from being
>     unadvertenly introduced[3] to the codebase from now on.
>     
>     [1] https://github.com/KSPP/linux/issues/21
>     [2] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
>     [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>     
>     Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>     Link: https://lore.kernel.org/r/20200120235326.GA29231@embeddedor.com
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
> index 9ac6671bb514..aed2c45f7968 100644
> --- a/drivers/char/hpet.c
> +++ b/drivers/char/hpet.c
> @@ -110,7 +110,7 @@ struct hpets {
>  	unsigned long hp_delta;
>  	unsigned int hp_ntimer;
>  	unsigned int hp_which;
> -	struct hpet_dev hp_dev[1];
> +	struct hpet_dev hp_dev[];
>  };
>  
>  static struct hpets *hpets;
> -------------------------------------------------------------------------------
> 
> 
> Git bisection log:
> 
> -------------------------------------------------------------------------------
> git bisect start
> # good: [f86cd20c9454847a524ddbdcdec32c0380ed7c9b] io_uring: fix linked command file table usage
> git bisect good f86cd20c9454847a524ddbdcdec32c0380ed7c9b
> # bad: [c32e1d01a152aee976763ccf7c7ced53ca45b78f] Add linux-next specific files for 20200130
> git bisect bad c32e1d01a152aee976763ccf7c7ced53ca45b78f
> # bad: [5b6f2ce0fed33dce8b1074233c83af8651d9e355] Merge remote-tracking branch 'arm/for-next'
> git bisect bad 5b6f2ce0fed33dce8b1074233c83af8651d9e355
> # good: [bd2463ac7d7ec51d432f23bf0e893fb371a908cd] Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
> git bisect good bd2463ac7d7ec51d432f23bf0e893fb371a908cd
> # good: [aac96626713fe167c672f9a008be0f514aa3e237] Merge tag 'usb-5.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
> git bisect good aac96626713fe167c672f9a008be0f514aa3e237
> # good: [975f9ce9a067a82b89d49e63938e01b2773ac9d4] Merge tag 'driver-core-5.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
> git bisect good 975f9ce9a067a82b89d49e63938e01b2773ac9d4
> # bad: [c497d106c844b44e931b2c87793c2ee499c702aa] Merge remote-tracking branch 'v4l-dvb-fixes/fixes'
> git bisect bad c497d106c844b44e931b2c87793c2ee499c702aa
> # bad: [00a647bc99a384fbc20645104db0e188c0d10fab] Merge remote-tracking branch 'bpf/master'
> git bisect bad 00a647bc99a384fbc20645104db0e188c0d10fab
> # good: [eb143f8756e77c8fcfc4d574922ae9efd3a43ca9] binder: fix log spam for existing debugfs file creation.
> git bisect good eb143f8756e77c8fcfc4d574922ae9efd3a43ca9
> # good: [587065dcac64e88132803cdb0a7f26bb4a79cf46] fs/adfs: bigdir: Fix an error code in adfs_fplus_read()
> git bisect good 587065dcac64e88132803cdb0a7f26bb4a79cf46
> # bad: [8e309ad9d60bd97f8a3b0313b2a09c9f184e624d] Merge remote-tracking branch 'fixes/master'
> git bisect bad 8e309ad9d60bd97f8a3b0313b2a09c9f184e624d
> # bad: [15d6632496537fa66488221ee5dd2f9fb318ef2e] Merge branch 'urgent-for-mingo' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu
> git bisect bad 15d6632496537fa66488221ee5dd2f9fb318ef2e
> # good: [74777eaf7aef0f80276cb1c3fad5b8292c368859] Merge branch 'core/documentation' into core/urgent, to pick up single commit
> git bisect good 74777eaf7aef0f80276cb1c3fad5b8292c368859
> # bad: [701a9c8092ddf299d7f90ab2d66b19b4526d1186] Merge tag 'char-misc-5.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
> git bisect bad 701a9c8092ddf299d7f90ab2d66b19b4526d1186
> # bad: [0db4a15d4c2787b1112001790d4f95bd2c5fed6f] mei: me: add jasper point DID
> git bisect bad 0db4a15d4c2787b1112001790d4f95bd2c5fed6f
> # bad: [987f028b8637cfa7658aa456ae73f8f21a7a7f6f] char: hpet: Use flexible-array member
> git bisect bad 987f028b8637cfa7658aa456ae73f8f21a7a7f6f
> # first bad commit: [987f028b8637cfa7658aa456ae73f8f21a7a7f6f] char: hpet: Use flexible-array member
> -------------------------------------------------------------------------------
> 

