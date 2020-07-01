Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4699C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 11:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95DA62067D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 11:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbgGAL6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 07:58:23 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:53304 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730381AbgGAL6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 07:58:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U1MtS5r_1593604696;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U1MtS5r_1593604696)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 01 Jul 2020 19:58:16 +0800
Date:   Wed, 1 Jul 2020 19:58:16 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        dan.j.williams@intel.com, akpm@linux-foundation.org,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/sparse: only sub-section aligned range would be
 populated
Message-ID: <20200701115816.GB4979@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200630021436.43281-1-richard.weiyang@linux.alibaba.com>
 <202007010217.Rut2zTnF%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007010217.Rut2zTnF%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 02:11:10AM +0800, kernel test robot wrote:
>Hi Wei,
>
>Thank you for the patch! Perhaps something to improve:
>
>[auto build test WARNING on mmotm/master]
>
>url:    https://github.com/0day-ci/linux/commits/Wei-Yang/mm-sparse-only-sub-section-aligned-range-would-be-populated/20200630-101713
>base:   git://git.cmpxchg.org/linux-mmotm.git master
>config: x86_64-allnoconfig (attached as .config)
>compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project cf1d04484344be52ada8178e41d18fd15a9b880c)
>reproduce (this is a W=1 build):
>        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>        chmod +x ~/bin/make.cross
>        # install x86_64 cross compiling tool for clang build
>        # apt-get install binutils-x86-64-linux-gnu
>        # save the attached .config to linux build tree
>        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 
>
>If you fix the issue, kindly add following tag as appropriate
>Reported-by: kernel test robot <lkp@intel.com>
>

Sorry, I don't follow up with this error report.

It looks like a build error, while I just removes some check and the build
pass from my side. Confused with this error report.

>All warnings (new ones prefixed by >>):
>
>   include/linux/signal.h:137:2: note: expanded from macro '_SIG_SET_BINOP'
>   case 1: ^
>   include/linux/signal.h:177:1: warning: unannotated fall-through between switch labels
>   _SIG_SET_OP(signotset, _sig_not)
>   ^
>   include/linux/signal.h:167:2: note: expanded from macro '_SIG_SET_OP'
>   case 2: = ^
>   include/linux/signal.h:177:1: warning: unannotated fall-through between switch labels
>   include/linux/signal.h:169:2: note: expanded from macro '_SIG_SET_OP'
>   case 1: = ^
>   include/linux/signal.h:190:2: warning: unannotated fall-through between switch labels
>   case 1: = 0;
>   ^
>   include/linux/jhash.h:95:2: note: insert '__attribute__((fallthrough));' to silence this warning
>   case 6: b += /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc /home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src /media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr /var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/ lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
>   ^
>   __attribute__((fallthrough));
>   include/linux/jhash.h:95:2: note: insert 'break;' to avoid fall-through
>   case 6: b += /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc /home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src /media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr /var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/ lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
>   ^
>   break;
>   include/linux/jhash.h:96:2: warning: unannotated fall-through between switch labels
>   case 5: b += /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc /home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src /media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr /var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/ lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
>   ^
>   15include/linux/signal.h:190:2: note: insert '__attribute__((fallthrough));' to silence this warning
>   case 1: = 0;
>   ^
>   __attribute__((fallthrough));
>   include/linux/signal.h:190:2: note: insert 'break;' to avoid fall-through
>   case 1: = 0;
>   ^
>   break;
>   include/linux/signal.h:203:2: warninginclude/linux/jhash.h:96:2: note: insert '__attribute__((fallthrough));' to silence this warning
>   case 5: b += /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc /home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src /media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr /var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/ lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
>   ^
>   __attribute__((fallthrough));
>   include/linux/jhash.h:96:2: note: insert 'break;' to avoid fall-through
>   case 5: b += /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc /home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src /media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr /var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/ lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
>   ^
>   break;
>   include/linux/jhash.h:97:2: warning: unannotated fall-through between switch labels
>   case 4: a += /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc /home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src /media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr /var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/ lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
>   ^
>   : unannotated fall-through between switch labels
>   case 1: = -1;
>   ^
>   warnings generated.
>   include/linux/signal.h:203:2: note: insert '__attribute__((fallthrough));' to silence this warning
>   case 1: = -1;
>   ^
>   __attribute__((fallthrough));
>   include/linux/signal.h:15203:2: note: insert 'break;' to avoid fall-through
>   case 1: = -1;
>   ^
>   break;
>   include/linux/jhash.h:97:2: note: insert '__attribute__((fallthrough));' to silence this warning
>   case 4: a += /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc /home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src /media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr /var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/ lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
>   ^
>   __attribute__((fallthrough));
>   include/linux/jhash.h:97:2: note: insert 'break;' to avoid fall-through
>   case 4: a += /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc /home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src /media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr /var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/ lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
>   ^
>   break;
>   include/linux/jhash.h:98:2: warning: unannotated fall-through between switch labels
>   case 3: a += /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc /home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src /media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr /var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/ lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
>   ^
>   include/linux/signal.h:233:2: warning: unannotated fall-through between switch labels
>   case 1: ;
>   ^
>   warnings generated.
>   In file included from kernel/printk/printk.c:61:
>   kernel/printk/internal.h:54:20: warninginclude/linux/jhash.h:98:2: note: insert '__attribute__((fallthrough));' to silence this warning
>   case 3: a += /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc /home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src /media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr /var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/ lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
>   ^
>   __attribute__((fallthrough));
>   include/linux/jhash.h:98:2: note: no previous prototype for function 'vprintk_func'
>   __printf(1, 0) int vprintk_func(const char va_list args) { return 0; }
>   ^
>   kernel/printk/internal.h: insert 'break;' to avoid fall-through
>   case 3: a += /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc /home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src /media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr /var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/ lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
>   ^
>   break;
>   include/linux/jhash.h:99:2: warning: unannotated fall-through between switch labels
>   case 2: a += /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc /home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src /media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr /var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/ lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
>   ^
>   :54:16: note: declare 'static' if the function is not intended to be used outside of this translation unit
>   __printf(1, 0) int vprintk_func(const char va_list args) { return 0; }
>   ^
>   static
>   kernel/printk/printk.cinclude/linux/signal.h:233:2: note: insert '__attribute__((fallthrough));' to silence this warning
>   case 1: ;
>   ^
>   __attribute__((fallthrough));
>   include/linux/signal.h:233:2: note: insert 'break;' to avoid fall-through
>   case 1: ;
>   ^
>   break;
>   include/linux/signal.h:245:2: warning: unannotated fall-through between switch labels
>   case 1: ;
>   ^
>>> :165:5: warning: no previous prototype for function 'devkmsg_sysctl_set_loglvl'
>   int devkmsg_sysctl_set_loglvl(struct ctl_table int write,
>   ^
>   kernel/printk/printk.c:165:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>   int devkmsg_sysctl_set_loglvl(struct ctl_table int write,
>   ^
>   static
>   include/linux/jhash.h:99:2: note: insert '__attribute__((fallthrough));' to silence this warning
>   case 2: a += /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc /home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src /media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr /var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/ lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
>   ^
>   __attribute__((fallthrough));
>   include/linux/jhash.h:99:2: note: insert 'break;' to avoid fall-through
>   case 2: a += /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc /home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src /media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr /var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/ lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
>   ^
>   break;
>   include/linux/jhash.h:100:2: warning: unannotated fall-through between switch labels
>   case 1: a +=
>   ^
>   include/linux/signal.h:245:2: note: insert '__attribute__((fallthrough));' to silence this warning
>   case 1: ;
>   ^
>   __attribute__((fallthrough));
>   include/linux/signal.h:245:2: note: insert 'break;' to avoid fall-through
>   case 1: ;
>   ^
>   break;
>   kernel/printk/printk.cinclude/linux/jhash.h:100:2: note: insert '__attribute__((fallthrough));' to silence this warning
>   case 1: a +=
>   ^
>   __attribute__((fallthrough));
>   include/linux/jhash.h:100:2: note: insert 'break;' to avoid fall-through
>   case 1: a +=
>   ^
>   break;
>   include/linux/jhash.h:102:2: warning: unannotated fall-through between switch labels
>   case 0: /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc /home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src /media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr /var Nothing left to add arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/ lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
>   ^
>   include/linux/jhash.h:102:2: note: insert 'break;' to avoid fall-through
>   case 0: /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc /home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src /media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr /var Nothing left to add arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/ lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
>   ^
>   break;
>   :2406:10: warning: 'sprintf' will always overflow; destination buffer has size 0, but format string expands to at least 33
>   len = sprintf(text,
>   ^
>   include/linux/jhash.h:136:2: warning: unannotated fall-through between switch labels
>   case 2: b += /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc /home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src /media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr /var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/ lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
>   ^
>   include/linux/jhash.h:136:2: note: insert '__attribute__((fallthrough));' to silence this warning
>   case 2: b += /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc /home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src /media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr /var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/ lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
>   ^
>   __attribute__((fallthrough));
>   include/linux/jhash.h:136:2: note: insert 'break;' to avoid fall-through
>   case 2: b += /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /dev /etc /home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /lkp-src /media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tmp /usr /var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init/ ipc/ kernel/ lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
>   ^
>   break;
>   include/linux/jhash.h:137:2: warning: unannotated fall-through between switch labels
>   case 1: a +=
>   ^
>   In file included from kernel/capability.c:13:
>   In file included from include/linux/audit.h:13:
>   In file included from include/linux/ptrace.h:7:
>   In file included from include/linux/sched/signal.h:6:
>   include/linux/signal.h:147:1: warning: unannotated fall-through between switch labels
>   _SIG_SET_BINOP(sigorsets, _sig_or)
>   ^
>   include/linux/signal.h:133:2: note: expanded from macro '_SIG_SET_BINOP'
>   case 2: ^
>   include/linux/signal.h:147:1: warning: unannotated fall-through between switch labels
>   include/linux/signal.h:137:2: note: expanded from macro '_SIG_SET_BINOP'
>   case 1: ^
>   include/linux/signal.h:150:1: warning: unannotated fall-through between switch labels
>   _SIG_SET_BINOP(sigandsets, _sig_and)
>   ^
>   include/linux/signal.h:133:2:In file included from note: expanded from macro '_SIG_SET_BINOP'
>   case 2: ^
>   include/linux/signal.h:150:1: warning: unannotated fall-through between switch labels
>   include/linux/signal.h:137:2: note: expanded from macro '_SIG_SET_BINOP'
>   case 1: ^
>   include/linux/signal.h:153:1: warning: unannotated fall-through between switch labels
>   _SIG_SET_BINOP(sigandnsets, _sig_andn)
>   ^
>   include/linux/signal.h:133:2: note: expanded from macro '_SIG_SET_BINOP'
>   case 2: kernel/sysctl_binary.c:15:
>   In file included from include/linux/netdevice.h:37:
>   In file included from include/linux/ethtool.h:18:
>   In file included from include/uapi/linux/ethtool.h:19:
>   In file included from include/linux/if_ether.h:19:
>   include/linux/skbuff.h:3690:2: warning: unannotated fall-through between switch labels
>   case 24: diffs |= __it_diff(a, b, 64);
>   ^
>--
>           ^
>           __attribute__((fallthrough)); 
>   include/linux/mm.h:166:2: note: insert 'break;' to avoid fall-through
>           case 56:
>           ^
>           break; 
>   In file included from kernel/printk/printk.c:36:
>   In file included from include/linux/syscalls.h:76:
>   include/linux/signal.h:147:1: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
>   _SIG_SET_BINOP(sigorsets, _sig_or)
>   ^
>   include/linux/signal.h:133:2: note: expanded from macro '_SIG_SET_BINOP'
>           case 2:                                                         \
>           ^
>   include/linux/signal.h:147:1: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
>   include/linux/signal.h:137:2: note: expanded from macro '_SIG_SET_BINOP'
>           case 1:                                                         \
>           ^
>   include/linux/signal.h:150:1: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
>   _SIG_SET_BINOP(sigandsets, _sig_and)
>   ^
>   include/linux/signal.h:133:2: note: expanded from macro '_SIG_SET_BINOP'
>           case 2:                                                         \
>           ^
>   include/linux/signal.h:150:1: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
>   include/linux/signal.h:137:2: note: expanded from macro '_SIG_SET_BINOP'
>           case 1:                                                         \
>           ^
>   include/linux/signal.h:153:1: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
>   _SIG_SET_BINOP(sigandnsets, _sig_andn)
>   ^
>   include/linux/signal.h:133:2: note: expanded from macro '_SIG_SET_BINOP'
>           case 2:                                                         \
>           ^
>   include/linux/signal.h:153:1: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
>   include/linux/signal.h:137:2: note: expanded from macro '_SIG_SET_BINOP'
>           case 1:                                                         \
>           ^
>   include/linux/signal.h:177:1: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
>   _SIG_SET_OP(signotset, _sig_not)
>   ^
>   include/linux/signal.h:167:2: note: expanded from macro '_SIG_SET_OP'
>           case 2: set->sig[1] = op(set->sig[1]);                          \
>           ^
>   include/linux/signal.h:177:1: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
>   include/linux/signal.h:169:2: note: expanded from macro '_SIG_SET_OP'
>           case 1: set->sig[0] = op(set->sig[0]);                          \
>           ^
>   include/linux/signal.h:190:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
>           case 1: set->sig[0] = 0;
>           ^
>   include/linux/signal.h:190:2: note: insert '__attribute__((fallthrough));' to silence this warning
>           case 1: set->sig[0] = 0;
>           ^
>           __attribute__((fallthrough)); 
>   include/linux/signal.h:190:2: note: insert 'break;' to avoid fall-through
>           case 1: set->sig[0] = 0;
>           ^
>           break; 
>   include/linux/signal.h:203:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
>           case 1: set->sig[0] = -1;
>           ^
>   include/linux/signal.h:203:2: note: insert '__attribute__((fallthrough));' to silence this warning
>           case 1: set->sig[0] = -1;
>           ^
>           __attribute__((fallthrough)); 
>   include/linux/signal.h:203:2: note: insert 'break;' to avoid fall-through
>           case 1: set->sig[0] = -1;
>           ^
>           break; 
>   include/linux/signal.h:233:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
>           case 1: ;
>           ^
>   include/linux/signal.h:233:2: note: insert '__attribute__((fallthrough));' to silence this warning
>           case 1: ;
>           ^
>           __attribute__((fallthrough)); 
>   include/linux/signal.h:233:2: note: insert 'break;' to avoid fall-through
>           case 1: ;
>           ^
>           break; 
>   include/linux/signal.h:245:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
>           case 1: ;
>           ^
>   include/linux/signal.h:245:2: note: insert '__attribute__((fallthrough));' to silence this warning
>           case 1: ;
>           ^
>           __attribute__((fallthrough)); 
>   include/linux/signal.h:245:2: note: insert 'break;' to avoid fall-through
>           case 1: ;
>           ^
>           break; 
>   In file included from kernel/printk/printk.c:61:
>   kernel/printk/internal.h:54:20: warning: no previous prototype for function 'vprintk_func' [-Wmissing-prototypes]
>   __printf(1, 0) int vprintk_func(const char *fmt, va_list args) { return 0; }
>                      ^
>   kernel/printk/internal.h:54:16: note: declare 'static' if the function is not intended to be used outside of this translation unit
>   __printf(1, 0) int vprintk_func(const char *fmt, va_list args) { return 0; }
>                  ^
>                  static 
>>> kernel/printk/printk.c:165:5: warning: no previous prototype for function 'devkmsg_sysctl_set_loglvl' [-Wmissing-prototypes]
>   int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
>       ^
>   kernel/printk/printk.c:165:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>   int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
>   ^
>   static 
>   kernel/printk/printk.c:2406:10: warning: 'sprintf' will always overflow; destination buffer has size 0, but format string expands to at least 33 [-Wfortify-source]
>                           len = sprintf(text,
>                                 ^
>   18 warnings generated.
>
>---
>0-DAY CI Kernel Test Service, Intel Corporation
>https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
Wei Yang
Help you, Help me
