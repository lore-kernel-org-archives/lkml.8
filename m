Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70998C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DFC2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgBJPXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:23:05 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:56093 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgBJPXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:23:05 -0500
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 01AFM5Qp011146;
        Tue, 11 Feb 2020 00:22:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp);
 Tue, 11 Feb 2020 00:22:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 01AFM0c3011080
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 11 Feb 2020 00:22:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: task hung in wdm_flush
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Oliver Neukum <oneukum@suse.de>,
        syzbot <syzbot+854768b99f19e89d7f81@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        yuehaibing@huawei.com, =?UTF-8?Q?Bj=c3=b8rn_Mork?= <bjorn@mork.no>
References: <0000000000003313f0058fea8435@google.com>
 <8736ek9qir.fsf@miraculix.mork.no> <1574159504.28617.5.camel@suse.de>
 <87pnho85h7.fsf@miraculix.mork.no>
 <CACT4Y+YgLm2m0JG6qKKn9OpyXT9kKEPeyLSVGSfLbUukoCnB+g@mail.gmail.com>
 <CACT4Y+ZjiCDgtGVMow3WNzjuqBLaxy_KB4cM10wbfUnDdjBYfQ@mail.gmail.com>
 <CACT4Y+ZWDMkOmnXpBXFhU8XcHA_-ZcHdZpfrXcCWHRzcbQ39Gg@mail.gmail.com>
 <ebc7b5e0-e968-0bdb-d75d-346e0b763d14@i-love.sakura.ne.jp>
 <CACT4Y+bDNjj_RGLtvRCaV3k9+QX4eENyKyWWAbsHcbwR7CDrWQ@mail.gmail.com>
 <CACT4Y+ZaNNAiRvKCMJ9t4H+H23OcjSd5haAcXkG68L8F6Mq6Wg@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <bbf26ea3-c11c-1cd2-0072-b78634ae9579@i-love.sakura.ne.jp>
Date:   Tue, 11 Feb 2020 00:21:56 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZaNNAiRvKCMJ9t4H+H23OcjSd5haAcXkG68L8F6Mq6Wg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/02/11 0:06, Dmitry Vyukov wrote:
>> On Mon, Feb 10, 2020 at 4:03 PM Tetsuo Handa
>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>
>>> On 2020/02/10 21:46, Tetsuo Handa wrote:
>>>> On 2020/02/10 19:09, Dmitry Vyukov wrote:
>>>>> You may also try on the exact commit the bug was reported, because
>>>>> usb-fuzzer is tracking branch, things may change there.
>>>>
>>>> OK. I explicitly tried
>>>>
>>>>   #syz test: https://github.com/google/kasan.git e5cd56e94edde38ca4dafae5a450c5a16b8a5f23
>>>>
>>>> but syzbot still cannot reproduce this bug using the reproducer...
>>>
>>> It seems that there is non-trivial difference between kernel config in dashboard
>>> and kernel config in "syz test:" mails. Maybe that's the cause...
> 
> 
> syzkaller runs oldconfig when building any kernels:
> https://github.com/google/syzkaller/blob/master/pkg/build/linux.go#L56
> Is that difference what oldconfig produces?
> 

Here is the diff (with "#" lines excluded) between dashboard and "syz test:" mails.
I feel this difference is bigger than what simple oldconfig would cause.

$ curl 'https://syzkaller.appspot.com/text?tag=KernelConfig&x=8cff427cc8996115' | sort > dashboard
$ curl 'https://syzkaller.appspot.com/x/.config?x=c372cdb7140fc162' | sort > syz-test
$ diff -u dashboard syz-test | grep -vF '#' | grep '^[+-]'
--- dashboard   2020-02-11 00:19:14.793977153 +0900
+++ syz-test    2020-02-11 00:19:15.659977108 +0900
-CONFIG_BLK_DEV_LOOP_MIN_COUNT=16
+CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
-CONFIG_BUG_ON_DATA_CORRUPTION=y
-CONFIG_DEBUG_CREDENTIALS=y
-CONFIG_DEBUG_PER_CPU_MAPS=y
-CONFIG_DEBUG_PLIST=y
-CONFIG_DEBUG_SG=y
-CONFIG_DEBUG_VIRTUAL=y
+CONFIG_DEVMEM=y
+CONFIG_DEVPORT=y
+CONFIG_DMA_OF=y
-CONFIG_DYNAMIC_DEBUG=y
-CONFIG_DYNAMIC_MEMORY_LAYOUT=y
+CONFIG_HID_REDRAGON=y
+CONFIG_IRQCHIP=y
-CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
+CONFIG_LSM="yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
-CONFIG_MAC80211_HWSIM=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
+CONFIG_MAGIC_SYSRQ_SERIAL=y
+CONFIG_NET_TC_SKB_EXT=y
+CONFIG_OF=y
+CONFIG_OF_ADDRESS=y
+CONFIG_OF_GPIO=y
+CONFIG_OF_IOMMU=y
+CONFIG_OF_IRQ=y
+CONFIG_OF_KOBJ=y
+CONFIG_OF_MDIO=y
+CONFIG_OF_NET=y
-CONFIG_PGTABLE_LEVELS=5
+CONFIG_PGTABLE_LEVELS=4
+CONFIG_PWRSEQ_EMMC=y
+CONFIG_PWRSEQ_SIMPLE=y
+CONFIG_RTLWIFI_DEBUG=y
-CONFIG_SECURITYFS=y
+CONFIG_STRICT_DEVMEM=y
+CONFIG_THERMAL_OF=y
+CONFIG_USB_CHIPIDEA_OF=y
+CONFIG_USB_DWC3_OF_SIMPLE=y
-CONFIG_USB_RAW_GADGET=y
+CONFIG_USB_SNP_UDC_PLAT=y
-CONFIG_VIRTIO_BLK_SCSI=y
-CONFIG_VIRT_WIFI=y
-CONFIG_X86_5LEVEL=y
