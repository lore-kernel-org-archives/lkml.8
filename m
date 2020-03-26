Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DF7C2D0E9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 02:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5787220714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 02:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqaVzTyY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgCZCdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 22:33:40 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42928 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgCZCdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 22:33:40 -0400
Received: by mail-qk1-f195.google.com with SMTP id e11so4979804qkg.9;
        Wed, 25 Mar 2020 19:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pAjWkVLZ0c+q8kDa5Uo4F2zTUraZS12qAh+h4XKR0QE=;
        b=LqaVzTyYodFJDB6r9E/8FuD6NvCZ/5NwLOFiYdR/DGYUgnpnWWwIyydXsEzyg4bJez
         5RpPMFfeADnGZ7qd9HyGBWXNcHmlx7uNhlHGbWZxGKoGCKyaw8BePg7UWS2sGxjfPdeQ
         eQLIhut3phGZB/Giek0ptdZEtPFofiN2OhoGDJpdfXZtAxCyNp8Q95UxP9+sAyvjqZJa
         2/wCgwQ+pWNzJlFBx+td81TWgKuhxz9/0L1oBeLhxx7OZpQ5b48rAhklVjeyPiuy/8nK
         f5ZJg3BO4/5DcSQ9a+b3AshasdfKmGFSe5h/avcuJEvRy/qzJCc+zrDgNs6gQCDHgWDd
         LsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pAjWkVLZ0c+q8kDa5Uo4F2zTUraZS12qAh+h4XKR0QE=;
        b=AHBDY55NBfaSt+5TV+5Nxl3ZyYJEJLhHgEdP2sigsFo5gjPmFAxs4SiPHla4N/ie28
         6+B0DRKLdHZAUmj8eOWzm5c98R7r85TKidVJDgAsKKHdw0lBOLyNpghw0gapmYa0cfFQ
         1Xyh8mLANdgYKYSRR6J0KyBCrTx5mYhBZ2a58vPBI3dfaG8simBar2/1sM5hYIGSLZD7
         GHpW2RhzAzPqM2ZtG6E2DcKMZ2/cLmi3tnQUIobPhgNNUfOA6b/0iU8YSzSzvy2Abf8U
         ULPq3IDfM66nJS/Q1sRVNzBP1hR0IW0HVps1pHCKJtR4TI6QqzQjlGBhSfRlUygOejtb
         1xpQ==
X-Gm-Message-State: ANhLgQ332UggmcZbaztlpb4+KCLN09cSJmt6/+QRtjCiQyvaSQfSyaoc
        /iBRstGyjh1R9ZEKMHKwr+A=
X-Google-Smtp-Source: ADFU+vtx14qTMAIGUcnDQXXMoZlQV2q3riOIKW1kwZsfvMVtUlBO1zFnR1fRkjUi7DTV/D9UzBHS6Q==
X-Received: by 2002:a37:3c9:: with SMTP id 192mr6124736qkd.330.1585190016525;
        Wed, 25 Mar 2020 19:33:36 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id o13sm534336qkg.111.2020.03.25.19.33.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 19:33:35 -0700 (PDT)
Subject: Re: f4056e705b ("of: unittest: add overlay gpio test to catch gpio
 .."): WARNING: held lock freed!
To:     kernel test robot <lkp@intel.com>,
        Frank Rowand <frank.rowand@sony.com>
Cc:     LKP <lkp@lists.01.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        philip.li@intel.com
References: <5e5dbc98.oBO6UKMRbgQnGwIO%lkp@intel.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <61df2448-732c-5d7a-d27c-630990364770@gmail.com>
Date:   Wed, 25 Mar 2020 21:33:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5e5dbc98.oBO6UKMRbgQnGwIO%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/20 8:10 PM, kernel test robot wrote:
> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> 
> commit f4056e705b2ef7f123a188f6aee23ade70e7d793
> Author:     Frank Rowand <frank.rowand@sony.com>
> AuthorDate: Thu Feb 20 12:40:20 2020 -0600
> Commit:     Rob Herring <robh@kernel.org>
> CommitDate: Wed Feb 26 10:42:04 2020 -0600
> 
>     of: unittest: add overlay gpio test to catch gpio hog problem

Fixed by the patch series at:

   https://lore.kernel.org/linux-devicetree/1585187131-21642-1-git-send-email-frowand.list@gmail.com/

Thank you for the report.

-Frank


>     
>     Geert reports that gpio hog nodes are not properly processed when
>     the gpio hog node is added via an overlay reply and provides an
>     RFC patch to fix the problem [1].
>     
>     Add a unittest that shows the problem.  Unittest will report "1 failed"
>     test before applying Geert's RFC patch and "0 failed" after applying
>     Geert's RFC patch.
>     
>     [1] https://lore.kernel.org/linux-devicetree/20191230133852.5890-1-geert+renesas@glider.be/
>     
>     Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>     Signed-off-by: Rob Herring <robh@kernel.org>
> 
> 2f7afc343d  of: property: Add device link support for power-domains and hwlocks
> f4056e705b  of: unittest: add overlay gpio test to catch gpio hog problem
> 76897807dc  dt-bindings: clock: Convert UniPhier clock to json-schema
> +---------------------------------------------------+------------+------------+------------+
> |                                                   | 2f7afc343d | f4056e705b | 76897807dc |
> +---------------------------------------------------+------------+------------+------------+
> | boot_successes                                    | 32         | 0          | 0          |
> | boot_failures                                     | 8          | 13         | 2          |
> | BUG:kernel_timeout_in_torture_test_stage          | 3          |            |            |
> | WARNING:at_kernel/workqueue.c:#wq_worker_sleeping | 4          |            |            |
> | EIP:wq_worker_sleeping                            | 4          |            |            |
> | BUG:kernel_hang_in_boot_stage                     | 1          |            |            |
> | WARNING:held_lock_freed                           | 0          | 13         | 2          |
> | is_freeing_memory#-#,with_a_lock_still_held_there | 0          | 13         | 2          |
> | BUG:kernel_NULL_pointer_dereference,address       | 0          | 13         | 2          |
> | Oops:#[##]                                        | 0          | 13         | 2          |
> | EIP:device_links_driver_cleanup                   | 0          | 13         | 2          |
> | Kernel_panic-not_syncing:Fatal_exception          | 0          | 13         | 2          |
> +---------------------------------------------------+------------+------------+------------+
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <lkp@intel.com>
> 
> [  380.048469] ### dt-test ### EXPECT / : GPIO line <<int>> (line-D-input) hogged as input
> [  380.081817] ### dt-test ### EXPECT \ : GPIO line <<int>> (line-C-input) hogged as input
> [  380.095866] ### dt-test ### EXPECT / : GPIO line <<int>> (line-C-input) hogged as input
> [  380.096714] ### dt-test ### FAIL of_unittest_overlay_gpio():2422 unittest_gpio_chip_request() called 0 times (expected 1 time)
> [  380.106856] 
> [  380.107033] =========================
> [  380.107392] WARNING: held lock freed!
> [  380.107759] 5.6.0-rc1-00020-gf4056e705b2ef #1 Not tainted
> [  380.108273] -------------------------
> [  380.108632] swapper/0/1 is freeing memory f3dc8200-f3dc83ff, with a lock still held there!
> [  380.109410] f3dc82c8 (&dev->mutex){....}, at: device_release_driver_internal+0x12/0x116
> [  380.110174] 2 locks held by swapper/0/1:
> [  380.110548]  #0: 41be5d38 ((of_reconfig_chain).rwsem){++++}, at: __blocking_notifier_call_chain+0x17/0x40
> [  380.111472]  #1: f3dc82c8 (&dev->mutex){....}, at: device_release_driver_internal+0x12/0x116
> [  380.112296] 
> [  380.112296] stack backtrace:
> [  380.112773] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.6.0-rc1-00020-gf4056e705b2ef #1
> [  380.113569] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [  380.114411] Call Trace:
> [  380.114694]  ? dump_stack+0x69/0x90
> [  380.115034]  ? debug_check_no_locks_freed+0xcf/0xe8
> [  380.115516]  ? slab_free_freelist_hook+0x7f/0xec
> [  380.115966]  ? kfree+0x22a/0x348
> [  380.116283]  ? unittest_gpio_remove+0x23/0x2e
> [  380.116711]  ? unittest_gpio_remove+0x23/0x2e
> [  380.117129]  ? device_release_driver_internal+0x9d/0x116
> [  380.117642]  ? bus_remove_device+0xa1/0xb0
> [  380.118039]  ? device_del+0x167/0x2fa
> [  380.118394]  ? class_dir_child_ns_type+0xb/0xb
> [  380.118832]  ? klist_iter_exit+0x11/0x1a
> [  380.119219]  ? platform_device_del+0x17/0x57
> [  380.119638]  ? platform_device_unregister+0xa/0x12
> [  380.120109]  ? of_platform_device_destroy+0x51/0x55
> [  380.120586]  ? of_platform_notify+0xa7/0xcc
> [  380.120992]  ? notifier_call_chain+0x2b/0x45
> [  380.121455]  ? __blocking_notifier_call_chain+0x2b/0x40
> [  380.121982]  ? blocking_notifier_call_chain+0x23/0x27
> [  380.122466]  ? of_reconfig_notify+0x14/0x2c
> [  380.122877]  ? __of_changeset_entry_notify+0x8d/0xd3
> [  380.123360]  ? __of_changeset_revert_notify+0x24/0x41
> [  380.123871]  ? of_overlay_remove+0x1a1/0x218
> [  380.124323]  ? of_unittest+0x1bf8/0x1fe7
> [  380.124755]  ? of_unittest_printf_one+0x11e/0x11e
> [  380.125231]  ? do_one_initcall+0x118/0x2cf
> [  380.125647]  ? kernel_init_freeable+0x139/0x188
> [  380.126084]  ? rest_init+0x11d/0x11d
> [  380.126439]  ? kernel_init+0x5/0xcc
> [  380.126813]  ? ret_from_fork+0x1e/0x30
> [  380.127392] BUG: kernel NULL pointer dereference, address: 00000000
> [  380.128064] #PF: supervisor read access in kernel mode
> [  380.128562] #PF: error_code(0x0000) - not-present page
> [  380.129075] *pde = 00000000 
> [  380.129356] Oops: 0000 [#1] PREEMPT SMP
> [  380.129728] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.6.0-rc1-00020-gf4056e705b2ef #1
> [  380.130480] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [  380.143418] EIP: device_links_driver_cleanup+0xcb/0xff
> [  380.143947] Code: 54 24 04 31 c9 b8 c8 01 c7 41 e8 19 aa cf ff 83 7b 18 04 5a 75 0d f6 43 1c 10 74 07 89 d8 e8 ae f5 ff ff c7 43 18 00 00 00 00 <8b> 47 04 89 fb e9 42 ff ff ff 8d 9e e4 00 00 00 89 d8 e8 31 f0 ff
> [  380.145732] EAX: f3dc82e0 EBX: 6b6b6b67 ECX: 00000000 EDX: 6b6b6b6b
> [  380.146331] ESI: f3dc820c EDI: fffffffc EBP: 00000000 ESP: f5155d20
> [  380.146981] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010246
> [  380.147633] CR0: 80050033 CR2: 00000000 CR3: 01d8e000 CR4: 001406d0
> [  380.148232] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [  380.148832] DR6: fffe0ff0 DR7: 00000400
> [  380.149203] Call Trace:
> [  380.149458]  ? device_release_driver_internal+0xa4/0x116
> [  380.150005]  ? bus_remove_device+0xa1/0xb0
> [  380.150419]  ? device_del+0x167/0x2fa
> [  380.150815]  ? class_dir_child_ns_type+0xb/0xb
> [  380.151306]  ? klist_iter_exit+0x11/0x1a
> [  380.151736]  ? platform_device_del+0x17/0x57
> [  380.152149]  ? platform_device_unregister+0xa/0x12
> [  380.152616]  ? of_platform_device_destroy+0x51/0x55
> [  380.153089]  ? of_platform_notify+0xa7/0xcc
> [  380.153501]  ? notifier_call_chain+0x2b/0x45
> [  380.153939]  ? __blocking_notifier_call_chain+0x2b/0x40
> [  380.154470]  ? blocking_notifier_call_chain+0x23/0x27
> [  380.154998]  ? of_reconfig_notify+0x14/0x2c
> [  380.155437]  ? __of_changeset_entry_notify+0x8d/0xd3
> [  380.155951]  ? __of_changeset_revert_notify+0x24/0x41
> [  380.156439]  ? of_overlay_remove+0x1a1/0x218
> [  380.156863]  ? of_unittest+0x1bf8/0x1fe7
> [  380.157269]  ? of_unittest_printf_one+0x11e/0x11e
> [  380.157730]  ? do_one_initcall+0x118/0x2cf
> [  380.158153]  ? kernel_init_freeable+0x139/0x188
> [  380.158609]  ? rest_init+0x11d/0x11d
> [  380.158980]  ? kernel_init+0x5/0xcc
> [  380.159331]  ? ret_from_fork+0x1e/0x30
> [  380.159723] Modules linked in:
> [  380.160025] CR2: 0000000000000000
> [  380.160354] ---[ end trace fa157650c0d14f0b ]---
> [  380.160804] EIP: device_links_driver_cleanup+0xcb/0xff
> 
>                                                           # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
> git bisect start 65e5f40b639d0788611a2e18ae27cadbce7eef70 f8788d86ab28f61f7b46eb6be375f8a726783636 --
> git bisect  bad 4e979fd94657ebcb12ceaeb74021db2ae0c44e99  # 17:02  B      0     8   27   3  Merge 'stblinux/defconfig/fixes' into devel-hourly-2020030110
> git bisect  bad 5c333c40ae2ad15257877a5b4c85f2001888d8bd  # 17:02  B      0     9   27   2  Merge 'georgi.djakov/icc-next' into devel-hourly-2020030110
> git bisect good a5e9a9f2b30c6b17d0e4c5368e21354f1c25baea  # 17:37  G     11     0    1   7  Merge 'linux-review/Gustavo-A-R-Silva/net-marvell-Replace-zero-length-array-with-flexible-array-member/20200225-081226' into devel-hourly-2020030110
> git bisect good 3761a240da8cfc7a2515c537e7078756a5d490aa  # 18:14  G     11     0    1   2  Merge 'linux-review/Athira-Rajeev/powerpc-perf-Use-SIER_USER_MASK-while-updating-SPRN_SIER-for-EBB-events/20200229-053024' into devel-hourly-2020030110
> git bisect  bad 46761b71e3f0897a438a914779c022bedf38aacd  # 18:14  B      1     7    0   3  Merge 'linux-review/Sergiu-Cuciurean/net-wireless-marvell-libertas-Use-new-structure-for-SPI-transfer-delays/20200228-162311' into devel-hourly-2020030110
> git bisect good a6b0da9ee130ff186536d2852ee17a001476e8c8  # 18:20  G     12     0    1   2  Merge 'linux-review/Gustavo-A-R-Silva/ipv6-Replace-zero-length-array-with-flexible-array-member/20200229-073152' into devel-hourly-2020030110
> git bisect good fef5536de043ba7b4798f37bf03d93ac3fb3b849  # 18:38  G     12     0    0   1  Merge 'linux-review/Balbir-Singh/Add-support-for-block-disk-resize-notification/20200226-050213' into devel-hourly-2020030110
> git bisect good 1fa9848c93094a60d230f9fcc37f5e8b7c903457  # 19:11  G     12     0    1   8  Merge 'linux-review/Jiri-Pirko/mlxsw-pci-Wait-longer-before-accessing-the-device-after-reset/20200229-023848' into devel-hourly-2020030110
> git bisect  bad 7291198059b3c748b855973e643cca9844895e00  # 19:11  B      1     9    0   2  Merge 'linux-review/George-Hilliard/Support-the-Allwinner-F1C100s-USB-stack/20200229-003545' into devel-hourly-2020030110
> git bisect  bad 4abfe6f04d93e4aac202007486266bd1a904cc43  # 19:11  B      1    10    0   0  dt-bindings: i2c: Convert UniPhier FI2C controller to json-schema
> git bisect good faf8e30acb219849725aa75302d36e0ffdb6a258  # 19:29  G     12     0    0   1  dt-bindings: arm: Add kryo260 compatible
> git bisect good 8acbbddcf9913149ef47b20f487289da02c4a291  # 20:02  G     12     0    2   5  dt-bindings: ata: rcar-sata: Convert to json-schema
> git bisect  bad 0ac1743979408a4999f32b777ce71f40fac040fa  # 21:42  B      0     3   21   0  of: unittest: annotate warnings triggered by unittest
> git bisect  bad f4056e705b2ef7f123a188f6aee23ade70e7d793  # 22:48  B      0     1   17   0  of: unittest: add overlay gpio test to catch gpio hog problem
> git bisect good 2f7afc343d49eea0bf88ea5fc8cb3afc392356c3  # 02:09  G     12     0    1   1  of: property: Add device link support for power-domains and hwlocks
> # first bad commit: [f4056e705b2ef7f123a188f6aee23ade70e7d793] of: unittest: add overlay gpio test to catch gpio hog problem
> git bisect good 2f7afc343d49eea0bf88ea5fc8cb3afc392356c3  # 02:56  G     36     0    5   7  of: property: Add device link support for power-domains and hwlocks
> # extra tests with debug options
> # extra tests on head commit of robh/for-next
> git bisect  bad 76897807dc79747161429c984528cf8c6670b328  # 10:08  B      0     2   18   0  dt-bindings: clock: Convert UniPhier clock to json-schema
> # bad: [76897807dc79747161429c984528cf8c6670b328] dt-bindings: clock: Convert UniPhier clock to json-schema
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org
> 

