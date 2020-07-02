Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5711CC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3596120CC7
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgGBPp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:45:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:37932 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbgGBPp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:45:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 33EEAAEB1;
        Thu,  2 Jul 2020 15:45:25 +0000 (UTC)
Subject: Re: [PATCH v2 0/4] Remove 32-bit Xen PV guest support
To:     Brian Gerst <brgerst@gmail.com>
Cc:     xen-devel <xen-devel@lists.xenproject.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>
References: <20200701110650.16172-1-jgross@suse.com>
 <CAMzpN2hvK2T7Qje51MPjMyTggxT7_=EFnt7gAmJEa1Zq+t3LtA@mail.gmail.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <e277e875-c159-4281-e9b7-08c91882d1fb@suse.com>
Date:   Thu, 2 Jul 2020 17:45:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAMzpN2hvK2T7Qje51MPjMyTggxT7_=EFnt7gAmJEa1Zq+t3LtA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.07.20 16:48, Brian Gerst wrote:
> On Wed, Jul 1, 2020 at 7:07 AM Juergen Gross <jgross@suse.com> wrote:
>>
>> The long term plan has been to replace Xen PV guests by PVH. The first
>> victim of that plan are now 32-bit PV guests, as those are used only
>> rather seldom these days. Xen on x86 requires 64-bit support and with
>> Grub2 now supporting PVH officially since version 2.04 there is no
>> need to keep 32-bit PV guest support alive in the Linux kernel.
>> Additionally Meltdown mitigation is not available in the kernel running
>> as 32-bit PV guest, so dropping this mode makes sense from security
>> point of view, too.
> 
> One thing that you missed is removing VDSO_NOTE_NONEGSEG_BIT from
> vdso32/note.S.  With that removed there is no difference from the
> 64-bit version.

Oh, this means we can probably remove arch/x86/xen/vdso.h completely.

> 
> Otherwise this series looks good to me.

Thanks,


Juergen
