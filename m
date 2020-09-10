Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE58CC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A4AD214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N0o4Jr5P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgIJUhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 16:37:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60128 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726781AbgIJUbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 16:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599769875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oG4VtYBGXuzb613fx5hBBNMTZQ49H6hy0YeFdmvTD8g=;
        b=N0o4Jr5PcYTMPx6n//feqv4Uglx21vVaPykquu5MNn4Dh+IzDcuxuQgiCVDjxkw2YAhZ6m
        zgbDPdutXNRV1OAlMnbgXmD9M5bU4FdpghIfYMDnPHScdJ3hytILcB0/Zts5NZxI4EpDgR
        0F1BFFCFhKxUiE2FvzJ51d0Y+wddX6o=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-hirjGdpVMoCeQMCuV-R7GQ-1; Thu, 10 Sep 2020 16:31:12 -0400
X-MC-Unique: hirjGdpVMoCeQMCuV-R7GQ-1
Received: by mail-ej1-f71.google.com with SMTP id e13so3387861ejk.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 13:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=oG4VtYBGXuzb613fx5hBBNMTZQ49H6hy0YeFdmvTD8g=;
        b=UbvsBQXVc9KxfjP/kXEY51rjTxuMn5ix5r+XzF9iCnJ0B8wr4+f/sKK9tZjV1YdI7F
         GHGkbWeZwY3UarUCOVMoMCNDBo+vgNnXwiRgtX1xetVAOvv52OB3Su+a0kxyOza97gXW
         wpZAAO5kxienDggm8q3NB3EpKtaboDeAAV9N1qz84HE5yLUZe0DH4TcHWzFUaVfOWd+p
         yJGInEHyiKPVYTuvBnIvmgz1VJiLnJqny3EvzJWWZt1h6aaxgc9sONWi53wjaXcITdWw
         DoNX60qBA0QrxjgjwVJcIs1OMUgCxGIMS7dopj6hi5PV3V4xjfG+rXg7/pLKGr0dUb0K
         P2XA==
X-Gm-Message-State: AOAM533ZRPkR+hyLaMOTNdP3KEXpZYDF3nr17GWu6yZjtMJUaazTYKMK
        hMFkZ2iU3xMnd1D4dwsiLoKtpSFRkUZHVlsuuN+VYxe92BTzRlk6mmtX4UDyzmL9Xu/fZoySrgO
        KG4d7a2FM3AAXmvCM0kE9OPlo
X-Received: by 2002:a17:906:4d4d:: with SMTP id b13mr10371714ejv.221.1599769871000;
        Thu, 10 Sep 2020 13:31:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwH4nFbqdIdClpGW3cyhzIHHW/NNlAPR9E4pCL3OlvSjq9ChPfVJPacAk9tIeJ6YFp4UpQGsg==
X-Received: by 2002:a17:906:4d4d:: with SMTP id b13mr10371701ejv.221.1599769870830;
        Thu, 10 Sep 2020 13:31:10 -0700 (PDT)
Received: from [192.168.3.122] (p5b0c6042.dip0.t-ipconnect.de. [91.12.96.66])
        by smtp.gmail.com with ESMTPSA id d6sm21881edm.31.2020.09.10.13.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 13:31:10 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: Ways to deprecate /sys/devices/system/memory/memoryX/phys_device ?
Date:   Thu, 10 Sep 2020 22:31:09 +0200
Message-Id: <3E00A442-7107-48DA-8172-EED95F6E1663@redhat.com>
References: <f14f7f00-0501-bb93-88cc-780ae4fbaad3@intel.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        =?utf-8?Q?Jan_H=C3=B6ppner?= <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-api@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <f14f7f00-0501-bb93-88cc-780ae4fbaad3@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
X-Mailer: iPhone Mail (17G68)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 10.09.2020 um 22:01 schrieb Dave Hansen <dave.hansen@intel.com>:
>=20
> =EF=BB=BFOn 9/10/20 3:20 AM, David Hildenbrand wrote:
>> I was just exploring how /sys/devices/system/memory/memoryX/phys_device
>> is/was used. It's one of these interfaces that most probably never
>> should have been added but now we are stuck with it.
>=20
> While I'm all for cleanups, what specific problems is phys_device causing?=

>=20

Mostly stumbling over it, understanding that it is basically unused with new=
 userspace for good reason, questioning its existence.

E.g., I am working on virtio-mem support for s390x. Displaying misleading/wr=
ong phys_device indications isn=E2=80=98t particularly helpful - especially o=
nce there are different ways to hotplug memory for an architecture.

> Are you hoping that we can just remove users of memoryX/* until there
> are no more left, and this is the easiest place to start?

At least reducing it to a minimum with clear semantics. Even with automatic o=
nlining there are still reasons why we need to keep the interface for now (e=
.g., reloading kexec to update the kdump headers on memory hot(un)plug). But=
 also standby memory handling on s399x requires it (->manual onlining).=

