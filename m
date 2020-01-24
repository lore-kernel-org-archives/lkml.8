Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACDBC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C602071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cTaNWEQ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391581AbgAXS6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 13:58:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39237 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387900AbgAXS6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 13:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579892288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=anaQqX02I469KNzwo+b0Dl94mtQRRmd8YLug/5n6qB4=;
        b=cTaNWEQ3JrNU09vAJt+CoqJFFS0cv5ITJsIWzrpp3RMdxW3lfgBe1XaHE+RheA06EzQb1c
        vuCGB8fw8+oGs2oU4mKkvnQ9/2/eXFEc59GCvTznJbVvyjCPtS/6uJiCUUYua37z6bwcoX
        l68m52Ld9jpj3+gaJ5vy2fNxaD7e0PM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-TTKkxTQGO7WBIXtzVyKsFg-1; Fri, 24 Jan 2020 13:58:07 -0500
X-MC-Unique: TTKkxTQGO7WBIXtzVyKsFg-1
Received: by mail-wr1-f69.google.com with SMTP id f15so1888459wrr.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 10:58:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=anaQqX02I469KNzwo+b0Dl94mtQRRmd8YLug/5n6qB4=;
        b=bAynGxdg3d7Q8SE7e8sKQI4pqrePXMSe8CSgVozChvglxf2mxTEI86XNSpZYweeYTL
         oQFa8srfQyQ8gwHW9bVl63wPUKX3cD43HLH8w2m1vwhgVf/IdsdyNSiAaJ3hjsFvTB/h
         NgKEFau1X8Ne3GxGhS+vMAoecTzl2w2Ik8iR3Hwkk8tgJKKPtixISgoAjxBZpGlOCwmR
         IOMGqkW9Iny5iZx3dbOrB7cgWzRmrs/oiIjeqyIJ6fWKcWIhhZDdOxHVFVRFzsB03ci6
         +rhMN4cbLDaHEG+5GvLIG6Tk12n1niB429e9Tzf2G86weW9ECEVZVHHoTTkQSLR4Jm5Q
         C33Q==
X-Gm-Message-State: APjAAAVdmUG7bo94kDZ1rzDI5RWfC9dtNey7tEztwywHvKVebf6j1nRP
        6gGe4a71+tzFF/HosuDrVznVd+YiAgzFhYbQAHQk0tgBcB9J9lk5W2MogavVeCredAScLkvcfrN
        aBSQ+7Ztl5dqf6KNEKnKSCKh0
X-Received: by 2002:a1c:e007:: with SMTP id x7mr522479wmg.3.1579892285940;
        Fri, 24 Jan 2020 10:58:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqxQ9AeBFmC2yckDBmMhBOcyDgCNsC2hIZp7+uSKKFkyLJ4ddXGJYSoEfuCmeBraa4faJtASVw==
X-Received: by 2002:a1c:e007:: with SMTP id x7mr522461wmg.3.1579892285691;
        Fri, 24 Jan 2020 10:58:05 -0800 (PST)
Received: from [192.168.3.122] (p5B0C6CBC.dip0.t-ipconnect.de. [91.12.108.188])
        by smtp.gmail.com with ESMTPSA id m7sm8550440wrr.40.2020.01.24.10.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 10:58:05 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1] driver core: check for dead devices before onlining/offlining
Date:   Fri, 24 Jan 2020 19:58:03 +0100
Message-Id: <77F513E2-220E-4122-B0BB-26FB64D0C598@redhat.com>
References: <CAPcyv4gJRuk7pZFvqJNY3niJeoW6CtFwp_sZauBSTdWPP+i+wA@mail.gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>
In-Reply-To: <CAPcyv4gJRuk7pZFvqJNY3niJeoW6CtFwp_sZauBSTdWPP+i+wA@mail.gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 24.01.2020 um 19:41 schrieb Dan Williams <dan.j.williams@intel.com>:
>=20
> =EF=BB=BFOn Fri, Jan 24, 2020 at 9:14 AM David Hildenbrand <david@redhat.c=
om> wrote:
>>=20
>>> On 20.01.20 11:49, David Hildenbrand wrote:
>>> We can have rare cases where the removal of a device races with
>>> somebody trying to online it (esp. via sysfs). We can simply check
>>> if the device is already removed or getting removed under the dev->lock.=

>>>=20
>>> E.g., right now, if memory block devices are removed (remove_memory()),
>>> we do a:
>>>=20
>>> remove_memory() -> lock_device_hotplug() -> mem_hotplug_begin() ->
>>> lock_device() -> dev->dead =3D true
>>>=20
>>> Somebody coming via sysfs (/sys/devices/system/memory/memoryX/online)
>>> triggers a:
>>>=20
>>> lock_device_hotplug_sysfs() -> device_online() -> lock_device() ...
>>>=20
>>> So if we made it just before the lock_device_hotplug_sysfs() but get
>>> delayed until remove_memory() released all locks, we will continue
>>> taking locks and trying to online the device - which is then a zombie
>>> device.
>>>=20
>>> Note that at least the memory onlining path seems to be protected by
>>> checking if all memory sections are still present (something we can then=

>>> get rid of). We do have other sysfs attributes
>>> (e.g., /sys/devices/system/memory/memoryX/valid_zones) that don't do any=

>>> such locking yet and might race with memory removal in a similar way. Fo=
r
>>> these users, we can then do a
>>>=20
>>> device_lock(dev);
>>> if (!device_is_dead(dev)) {
>>>      /* magic /*
>>> }
>>> device_unlock(dev);
>>>=20
>>> Introduce and use device_is_dead() right away.
>>>=20
>>=20
>> So, I just added the following:
>>=20
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index 01cd06eeb513..49c4d8671073 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -1567,6 +1567,7 @@ static ssize_t online_store(struct device *dev,
>> struct device_attribute *attr,
>>        if (ret < 0)
>>                return ret;
>>=20
>> +       msleep(10000);
>>        ret =3D lock_device_hotplug_sysfs();
>>        if (ret)
>>                return ret;
>>=20
>> Then triggered
>>        echo 1 > /sys/devices/system/memory/memory51/online
>> And quickly afterwards unplugged the DIMM.
>>=20
>> Good news is that we get (after 10 seconds)
>>        sh: echo: write error: No such device
>>=20
>> Reason is that unplug will not finish before all sysfs attributes have
>> been exited by other threads.
>=20
> The unplug thread gets blocked for 10 seconds waiting for this thread
> in online_store() to exit?
>=20

Yes, that=E2=80=98s what I observed.=

