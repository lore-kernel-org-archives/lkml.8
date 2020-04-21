Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661EEC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B72E206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WRMf4EWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgDUNGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:06:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42219 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726628AbgDUNGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587474387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=CHQQNs+DIb8rW6PxcU8VQcmtKJ64o0JkJTvv3NBj7+s=;
        b=WRMf4EWG66oxXWyp/cyUc02+Y05YbGHjVr8GQwWcOXwHMXJBS2esTmMjiDCBHU/XrJKqIr
        XgxiacoITrYd9TI6qeLEhMK8qaJd2749/ZUFMZ2BFtTEK4AnFcfuwm9wDd+Kd443b8tQn9
        CNXOigI53QXbEr09eIJNmYdOMPy6Ifw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-ysxf6EViNZaQkXbhc98HpA-1; Tue, 21 Apr 2020 09:06:24 -0400
X-MC-Unique: ysxf6EViNZaQkXbhc98HpA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9C88149C0;
        Tue, 21 Apr 2020 13:06:22 +0000 (UTC)
Received: from [10.36.113.245] (ovpn-113-245.ams2.redhat.com [10.36.113.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 329153A0;
        Tue, 21 Apr 2020 13:06:21 +0000 (UTC)
Subject: Re: [PATCH RFC 1/2] mm/memory_hotplug: no need to init new pgdat with
 node_start_pfn
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
References: <20200416104707.20219-1-david@redhat.com>
 <20200416104707.20219-2-david@redhat.com>
 <20200421123011.GE27314@dhcp22.suse.cz>
 <ac246ba8-9a61-0e0b-3aff-caf78743e81f@redhat.com>
 <20200421125250.GG27314@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <c5b693e0-61b7-ca05-68b5-eb19c517759f@redhat.com>
Date:   Tue, 21 Apr 2020 15:06:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200421125250.GG27314@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.04.20 14:52, Michal Hocko wrote:
> On Tue 21-04-20 14:35:12, David Hildenbrand wrote:
>> On 21.04.20 14:30, Michal Hocko wrote:
>>> Sorry for the late reply
>>>
>>> On Thu 16-04-20 12:47:06, David Hildenbrand wrote:
>>>> A hotadded node/pgdat will span no pages at all, until memory is mov=
ed to
>>>> the zone/node via move_pfn_range_to_zone() -> resize_pgdat_range - e=
.g.,
>>>> when onlining memory blocks. We don't have to initialize the
>>>> node_start_pfn to the memory we are adding.
>>>
>>> You are right that the node is empty at this phase but that is alread=
y
>>> reflected by zero present pages (hmm, I do not see spanned pages to b=
e
>>> set 0 though). What I am missing here is why this is an improvement. =
The
>>> new node is already visible here and I do not see why we hide the
>>> information we already know.
>>
>> "information we already know" - no, not before we online the memory.
>=20
> Is this really the case? All add_memory_resource users operate on a
> physical memory range.

Having the first add_memory() to magically set node_start_pfn of a hotplu=
gged
node isn't dangerous, I think we agree on that. It's just completely
unnecessary here and at least left me confused why this is needed at all-
because the node start/end pfn is only really touched when
onlining/offlining memory (when resizing the zone and the pgdat).

>=20
>> Before onlining, it's just setting node_start_pfn to *some value* to b=
e
>> overwritten in move_pfn_range_to_zone()->resize_pgdat_range().
>=20
> Yes the value is overwritten but I am not sure this is actually correct
> thing to do. I cannot remember why I've chosen to do that. It doesn't
> really seem unlikely to online node in a higher physical address.
>=20

Well, we decided to glue the node span to onlining/offlining of memory.
So, the value really has no meaning without any of that memory being
online/the node span being 0.

> Btw. one thing that I have in my notes, I was never able to actually
> test the no numa node case. Because I have always been testing with nod=
e
> being allocated during the boot. Do you have any way to trigger this
> path?

Sure, here is my test case

#! /bin/bash
sudo qemu-system-x86_64 \
    --enable-kvm \
    -m 4G,maxmem=3D20G,slots=3D2 \
    -smp sockets=3D2,cores=3D2 \
    -numa node,nodeid=3D0,cpus=3D0-1,mem=3D4G -numa node,nodeid=3D1,mem=3D=
0G \
    -kernel /home/dhildenb/git/linux/arch/x86_64/boot/bzImage \
    -append "console=3DttyS0 rd.shell rd.luks=3D0 rd.lvm=3D0 rd.md=3D0 rd=
.dm=3D0 page_owner=3Don" \
    -initrd /boot/initramfs-5.4.7-200.fc31.x86_64.img \
    -machine pc \
    -nographic \
    -nodefaults \
    -chardev stdio,id=3Dserial \
    -device isa-serial,chardev=3Dserial \
    -chardev socket,id=3Dmonitor,path=3D/var/tmp/monitor,server,nowait \
    -mon chardev=3Dmonitor,mode=3Dreadline \
    -device virtio-balloon \
    -object memory-backend-ram,id=3Dmem0,size=3D512M \
    -object memory-backend-ram,id=3Dmem1,size=3D512M \
    -device pc-dimm,id=3Ddimm0,memdev=3Dmem0,node=3D1 \
    -device pc-dimm,id=3Ddimm1,memdev=3Dmem1,node=3D1

Instead of coldplugging the DIMMs to node 1, you could also hotplug them =
later
(let me know if you need information on how to do that). I use this test =
to
verify that the node is properly onlined/offlined once I unplug/replug th=
e two
DIMMs (e.g., after onlining/offlining the memory blocks).

--=20
Thanks,

David / dhildenb

