Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E142CC34031
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C039724656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgBTHJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 02:09:58 -0500
Received: from lizzard.sbs.de ([194.138.37.39]:44914 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgBTHJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 02:09:58 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 01K79rg6007338
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 08:09:53 +0100
Received: from [167.87.7.122] ([167.87.7.122])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 01K79pNX027400;
        Thu, 20 Feb 2020 08:09:52 +0100
Subject: Re: [ANNOUNCE] Jailhouse 0.12 released
To:     Peng Fan <peng.fan@nxp.com>,
        Jailhouse <jailhouse-dev@googlegroups.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>
References: <dd4344b9-ca04-0ef2-0810-6b98e30f68b4@siemens.com>
 <AM0PR04MB4481C65800CCE42E448B7D2788130@AM0PR04MB4481.eurprd04.prod.outlook.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9bdd0eae-dbaf-f5a3-d067-81b0ae88522f@siemens.com>
Date:   Thu, 20 Feb 2020 08:09:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4481C65800CCE42E448B7D2788130@AM0PR04MB4481.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.02.20 03:39, Peng Fan wrote:
>> Subject: [ANNOUNCE] Jailhouse 0.12 released
>>
>> This release is an important milestone for Jailhouse because it comes with a
>> reworked inter-cell communication device with better driver support and
>> even an experimental virtio transport model for this.
> 
> Great to know this.

If there is interest, please provide feedback, ideally also in the 
circle where I started spec discussions and QEMU implementation.

> 
>>
>> While this shared memory device model is still in discussion with virtio and
>> QEMU communities, thus may undergo some further smaller changes, it was
>> important to move forward with it because there is an increasing demand for
>> it on the Jailhouse side. We now support multi-peer connection, have a secure
>> (unprivileged) and efficient UIO driver and can even start working on virtio
>> integration - without having to touch the hypervisor any further. More
>> information also in [1].
> 
> Do we need to use qemu for virtio backend?
> 

Nope, in fact there are only primitive demo backends for block and 
console available that make use of UIO, see

http://git.kiszka.org/?p=linux.git;a=blob;f=tools/virtio/virtio-ivshmem-block.c;h=c97aa5076a6d22ccd01862f3e4db0e12641825c3;hb=refs/heads/queues/ivshmem2

and

http://git.kiszka.org/?p=linux.git;a=blob;f=tools/virtio/virtio-ivshmem-console.c;h=c79be22c6a7aa4c2eb49561e8c0d7c9a052e393d;hb=refs/heads/queues/ivshmem2

I was hoping to find something useful in ACRN but didn't succeed. So I 
hacked up these two (basically in two evenings, that's why these two are 
copy&paste). For the future, when the transport is more stable, looking 
into a vhost mapping could be beneficial, specifically for networking. 
Another direction could be https://github.com/rust-vmm/vm-virtio.

>>
>> The release has another important new, and that is SMMUv3 for ARM64
>> target, as well as the TI-specific MPU-like Peripheral Virtualization Unit (PVU).
>> SMMUv2 support is unfortunately still waiting in some NXP downstream
>> branch for being pushed upstream.
> 
> Alice in Cc is doing this effort together with i.MX8QM upstreaming.
> 

Great, looking forward!

>>
>> Note that there are several changes to the configuration format that require
>> adjustments of own configs. Please study related changes in our reference
>> configurations or, on x86, re-generate the system configuration.
>>
>> Due to all these significant changes, statistics for this release look about more
>> heavyweight than usual:
>> 195 files changed, 7185 insertions(+), 2612 deletions(-)
> 
> Yeah!! Besides this, any people still interested in booting jailhouse before Linux?
> I have achieved this on i.MX8MM with Linux + gic-demo cell, with a baremetal
> program and using U-Boot FIT to load all images.

Yes, there is definitely interest, for various reasons. One can be cache 
coloring. We are also considering to look into this boot mode in the 
context of the just started RISC-V port. And there might be a case on 
x86 again, but the boot environment is still not clear to me there 
(likely not UEFI).

If you have a prototype for ARM64 and U-Boot, that would be great to see 
it, maybe let more people play with it. Eventually, I want to start 
discussing requirements and potentially required new interfaces.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
