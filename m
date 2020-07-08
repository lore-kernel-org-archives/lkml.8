Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56E6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 11:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF9D2204EC
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 11:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMqySymr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgGHLhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 07:37:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28366 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbgGHLhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594208266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rxAR+Kw/axdKF/TCqNjdsfSjlHFkHPAsJVvK3OHUYjI=;
        b=iMqySymrN4VLJwOiF3gFjT4i/01jGEzUNC11b40wxKM2zQUoz/jziWoUErKknH5PVJiK6z
        QIAXtGGbv1/CoLwZelHxkz1uRSExlT3ZaOLKkirH/ysWw+ldVyuO+4AoGD1I7SSHMqEO9f
        Vo6/aG0zwKMZnw3WMhHe6mDmWQ/Vbsg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-AnT50AkiPCWRYNTjZ1dqPA-1; Wed, 08 Jul 2020 07:37:44 -0400
X-MC-Unique: AnT50AkiPCWRYNTjZ1dqPA-1
Received: by mail-ej1-f70.google.com with SMTP id yh3so36653976ejb.16
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 04:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rxAR+Kw/axdKF/TCqNjdsfSjlHFkHPAsJVvK3OHUYjI=;
        b=hpZxBm8Lc8dRmr8PTZLfLx2Ejxc1qE9YThYn85Wq58EbdqJ2zc1f8osNSHKPYpx5Cl
         jKMiXNBeY+cQJxPvhpQIZ/qvVNuM7bAS+zM4qUP0Bf+ipRjjhJRs/pglztHX33/rklck
         +pjSbZzBvh7WKCsi9yemiCzIAnakBUoFKcwOnc0I/dE65AjNhLvM6SWYP27bOyCY/CyM
         odNUxYj8BnHCml2TBEfbBf5ChJlwgOoefP0WZP6loZ+xF1VRAgHzzMapNiqWwxm9DKH0
         kM2Hdadhg6FDU876JutKaXfq2HyFXVNhGvr0OysamHDhpWSQ4hCOt6bIewjLObvoiGgF
         1RHA==
X-Gm-Message-State: AOAM531n5x01VAamtE11mpoRlsjS+9yaCneJyu9VfdHxCyzdE4QyLT5a
        HwYAOBj/Wz/mRYMyPGiplI8jPNlGveqsY/SgsDX7o1wYFV8CWV5Ilzt6YSHbzsi922Du1CDjZAm
        zfNeWx6qEyVcYzPLHlx8dcF/L
X-Received: by 2002:a05:6402:2212:: with SMTP id cq18mr69893287edb.173.1594208263053;
        Wed, 08 Jul 2020 04:37:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFQtyOEY2W5LUe5OTc7kdacGkjqoMvojBBviDdKbmaUN+MOmxhCG02SRaFc3o68AfY0fdJ/w==
X-Received: by 2002:a05:6402:2212:: with SMTP id cq18mr69893277edb.173.1594208262871;
        Wed, 08 Jul 2020 04:37:42 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id u13sm1813113ejc.72.2020.07.08.04.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 04:37:42 -0700 (PDT)
Subject: Re: [PATCH 0/4] Fix misused kernel_read_file() enums
From:   Hans de Goede <hdegoede@redhat.com>
To:     Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20200707081926.3688096-1-keescook@chromium.org>
 <3c01073b-c422-dd97-0677-c16fe1158907@redhat.com>
Message-ID: <f5e65f73-2c94-3614-2479-69b2bfda9775@redhat.com>
Date:   Wed, 8 Jul 2020 13:37:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <3c01073b-c422-dd97-0677-c16fe1158907@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/8/20 1:01 PM, Hans de Goede wrote:
> Hi,
> 
> On 7/7/20 10:19 AM, Kees Cook wrote:
>> Hi,
>>
>> In looking for closely at the additions that got made to the
>> kernel_read_file() enums, I noticed that FIRMWARE_PREALLOC_BUFFER
>> and FIRMWARE_EFI_EMBEDDED were added, but they are not appropriate
>> *kinds* of files for the LSM to reason about. They are a "how" and
>> "where", respectively. Remove these improper aliases and refactor the
>> code to adapt to the changes.
>>
>> Additionally adds in missing calls to security_kernel_post_read_file()
>> in the platform firmware fallback path (to match the sysfs firmware
>> fallback path) and in module loading. I considered entirely removing
>> security_kernel_post_read_file() hook since it is technically unused,
>> but IMA probably wants to be able to measure EFI-stored firmware images,
>> so I wired it up and matched it for modules, in case anyone wants to
>> move the module signature checks out of the module core and into an LSM
>> to avoid the current layering violations.
>>
>> This touches several trees, and I suspect it would be best to go through
>> James's LSM tree.
>>
>> Thanks!
> 
> 
> I've done some quick tests on this series to make sure that
> the efi embedded-firmware support did not regress.
> That still works fine, so this series is;
> 
> Tested-by: Hans de Goede <hdegoede@redhat.com>

I made a mistake during testing I was not actually running the
kernel with the patches added.

After fixing that I did find a problem, patch 4/4:
"module: Add hook for security_kernel_post_read_file()"

Breaks module-loading for me. This is with the 4 patches
on top of 5.8.0-rc4, so this might just be because I'm
not using the right base.

With patch 4/4 reverted things work fine for me.

So, please only add my Tested-by to patches 1-3.

Regards,

Hans



>> Kees Cook (4):
>>    firmware_loader: EFI firmware loader must handle pre-allocated buffer
>>    fs: Remove FIRMWARE_PREALLOC_BUFFER from kernel_read_file() enums
>>    fs: Remove FIRMWARE_EFI_EMBEDDED from kernel_read_file() enums
>>    module: Add hook for security_kernel_post_read_file()
>>
>>   drivers/base/firmware_loader/fallback_platform.c | 12 ++++++++++--
>>   drivers/base/firmware_loader/main.c              |  5 ++---
>>   fs/exec.c                                        |  7 ++++---
>>   include/linux/fs.h                               |  3 +--
>>   include/linux/lsm_hooks.h                        |  6 +++++-
>>   kernel/module.c                                  |  7 ++++++-
>>   security/integrity/ima/ima_main.c                |  6 ++----
>>   7 files changed, 30 insertions(+), 16 deletions(-)
>>

