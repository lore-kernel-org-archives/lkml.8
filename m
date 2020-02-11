Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7049C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 977CB20870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sl6W4amj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbgBKOBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 09:01:54 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38399 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729742AbgBKOBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 09:01:53 -0500
Received: by mail-qt1-f194.google.com with SMTP id c24so7976168qtp.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 06:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y/BadYpECLUdWrQWnEHX25mgncmJfuysCIDqnuczrAk=;
        b=sl6W4amjj3ULSa0duaz/GaF9sRD+HniXTrk8LTBCboI2KvwvnyLMORWRCs4K+dZlZT
         T1f9kHEjuIh0lz3PEVYPSTz9R1ZmiQHUBePJXucm2un8ygS+PNn3ffjpTm3rIEVzdRxi
         s9naMaPNWn6wkFShRl4LkpK239QTPDlj8gKZqa+GfFO2vg+ePKFMtRVY0BcMqOB3ruMK
         oXl13ab9Iu9fud1YExcjkncZbggZOQcvRZ1F2LGfkfalU6/wTaoGTLs5ZSFl8WpPmyCa
         1fE4W5Z6TNZ6CAoYfaZsaIKgj4lkrazjDRerS/EwbkNHjqu7ct46GnmsVkD4x12QUHj8
         mxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y/BadYpECLUdWrQWnEHX25mgncmJfuysCIDqnuczrAk=;
        b=rEA/+pOyv5BmMWjEfRWlll/dwDeN0I7/VITZEWYXOBl0wwz+FGBTJpXeAeDdFqhCaz
         Y+GId1GrekADahG8/rg95nwG5NPrk27BdAeh/eYh3w+jLzHgCsli4E0gyaO4U9vvQdda
         GuXODqxFa9DSOyzvFkvy/1B/FM5SkTJPkm3AANcaJTPJI3iQOzfvvVoBazh5XXZOlo3+
         cfoTDPRqhQwretm+9K1/eZuBMv5iC1bRvmmKvLydT8zGYT11ttfkefSe5bMCnYOl6sSh
         ZBS38Dny8xYooOilBV48suSEvF3aqr/s5s4KXwoChsSPGqxvLqMSmX8YWXVMhVMo0dLa
         2B/g==
X-Gm-Message-State: APjAAAVltBeEa79U9erMptsE2Nug5isObB7Hrsbdg1j5BoJzScgBIUjC
        eO5OB23G4OVmqjH3YTIMiOAdDthdbrqi40mmSZ6b7w==
X-Google-Smtp-Source: APXvYqweNYSa/wrakmiOWVZk+K+1yhLLQ/TfkZzrAOVJstFKgWSIpPWJpdUmPwCkTdFURpQZZ4VIxfXyuBfdRE4AU0k=
X-Received: by 2002:ac8:340c:: with SMTP id u12mr2498173qtb.257.1581429711919;
 Tue, 11 Feb 2020 06:01:51 -0800 (PST)
MIME-Version: 1.0
References: <0000000000003313f0058fea8435@google.com> <8736ek9qir.fsf@miraculix.mork.no>
 <1574159504.28617.5.camel@suse.de> <87pnho85h7.fsf@miraculix.mork.no>
 <CACT4Y+YgLm2m0JG6qKKn9OpyXT9kKEPeyLSVGSfLbUukoCnB+g@mail.gmail.com>
 <CACT4Y+ZjiCDgtGVMow3WNzjuqBLaxy_KB4cM10wbfUnDdjBYfQ@mail.gmail.com>
 <CACT4Y+ZWDMkOmnXpBXFhU8XcHA_-ZcHdZpfrXcCWHRzcbQ39Gg@mail.gmail.com>
 <ebc7b5e0-e968-0bdb-d75d-346e0b763d14@i-love.sakura.ne.jp>
 <CACT4Y+bDNjj_RGLtvRCaV3k9+QX4eENyKyWWAbsHcbwR7CDrWQ@mail.gmail.com>
 <CACT4Y+ZaNNAiRvKCMJ9t4H+H23OcjSd5haAcXkG68L8F6Mq6Wg@mail.gmail.com> <bbf26ea3-c11c-1cd2-0072-b78634ae9579@i-love.sakura.ne.jp>
In-Reply-To: <bbf26ea3-c11c-1cd2-0072-b78634ae9579@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 11 Feb 2020 15:01:37 +0100
Message-ID: <CACT4Y+Yv-T-MfW=mgzuD99tsfkmE5Tk6bBhio9KNtPTmXM4cEw@mail.gmail.com>
Subject: Re: INFO: task hung in wdm_flush
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
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
        yuehaibing@huawei.com, =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 4:22 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2020/02/11 0:06, Dmitry Vyukov wrote:
> >> On Mon, Feb 10, 2020 at 4:03 PM Tetsuo Handa
> >> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>>
> >>> On 2020/02/10 21:46, Tetsuo Handa wrote:
> >>>> On 2020/02/10 19:09, Dmitry Vyukov wrote:
> >>>>> You may also try on the exact commit the bug was reported, because
> >>>>> usb-fuzzer is tracking branch, things may change there.
> >>>>
> >>>> OK. I explicitly tried
> >>>>
> >>>>   #syz test: https://github.com/google/kasan.git e5cd56e94edde38ca4dafae5a450c5a16b8a5f23
> >>>>
> >>>> but syzbot still cannot reproduce this bug using the reproducer...
> >>>
> >>> It seems that there is non-trivial difference between kernel config in dashboard
> >>> and kernel config in "syz test:" mails. Maybe that's the cause...
> >
> >
> > syzkaller runs oldconfig when building any kernels:
> > https://github.com/google/syzkaller/blob/master/pkg/build/linux.go#L56
> > Is that difference what oldconfig produces?
> >
>
> Here is the diff (with "#" lines excluded) between dashboard and "syz test:" mails.
> I feel this difference is bigger than what simple oldconfig would cause.
>
> $ curl 'https://syzkaller.appspot.com/text?tag=KernelConfig&x=8cff427cc8996115' | sort > dashboard

I think you took a wrong config as a base.
This 8cff427cc8996115 was only used for crashes without reproducers as
far as I see, so it can't be used for patch testing.
I would expect the one used for last patch testing is this one:
https://syzkaller.appspot.com/text?tag=KernelConfig&x=8847e5384a16f66a
associated with this crash:
ci2-upstream-usb2019/09/23 13:26https://github.com/google/kasan.git
usb-fuzzere0bd8d79d96e88f3

I checked at least CONFIG_DYNAMIC_DEBUG, and it matches what was used
for patch testing.
So everything seems right to me as far as I see.



> $ curl 'https://syzkaller.appspot.com/x/.config?x=c372cdb7140fc162' | sort > syz-test
> $ diff -u dashboard syz-test | grep -vF '#' | grep '^[+-]'
> --- dashboard   2020-02-11 00:19:14.793977153 +0900
> +++ syz-test    2020-02-11 00:19:15.659977108 +0900
> -CONFIG_BLK_DEV_LOOP_MIN_COUNT=16
> +CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
> -CONFIG_BUG_ON_DATA_CORRUPTION=y
> -CONFIG_DEBUG_CREDENTIALS=y
> -CONFIG_DEBUG_PER_CPU_MAPS=y
> -CONFIG_DEBUG_PLIST=y
> -CONFIG_DEBUG_SG=y
> -CONFIG_DEBUG_VIRTUAL=y
> +CONFIG_DEVMEM=y
> +CONFIG_DEVPORT=y
> +CONFIG_DMA_OF=y
> -CONFIG_DYNAMIC_DEBUG=y
> -CONFIG_DYNAMIC_MEMORY_LAYOUT=y
> +CONFIG_HID_REDRAGON=y
> +CONFIG_IRQCHIP=y
> -CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
> +CONFIG_LSM="yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
> -CONFIG_MAC80211_HWSIM=y
> +CONFIG_MAGIC_SYSRQ=y
> +CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> +CONFIG_MAGIC_SYSRQ_SERIAL=y
> +CONFIG_NET_TC_SKB_EXT=y
> +CONFIG_OF=y
> +CONFIG_OF_ADDRESS=y
> +CONFIG_OF_GPIO=y
> +CONFIG_OF_IOMMU=y
> +CONFIG_OF_IRQ=y
> +CONFIG_OF_KOBJ=y
> +CONFIG_OF_MDIO=y
> +CONFIG_OF_NET=y
> -CONFIG_PGTABLE_LEVELS=5
> +CONFIG_PGTABLE_LEVELS=4
> +CONFIG_PWRSEQ_EMMC=y
> +CONFIG_PWRSEQ_SIMPLE=y
> +CONFIG_RTLWIFI_DEBUG=y
> -CONFIG_SECURITYFS=y
> +CONFIG_STRICT_DEVMEM=y
> +CONFIG_THERMAL_OF=y
> +CONFIG_USB_CHIPIDEA_OF=y
> +CONFIG_USB_DWC3_OF_SIMPLE=y
> -CONFIG_USB_RAW_GADGET=y
> +CONFIG_USB_SNP_UDC_PLAT=y
> -CONFIG_VIRTIO_BLK_SCSI=y
> -CONFIG_VIRT_WIFI=y
> -CONFIG_X86_5LEVEL=y
