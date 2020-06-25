Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5CAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 05:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C25520709
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 05:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDz4VRj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389730AbgFYFxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 01:53:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31056 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389239AbgFYFxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 01:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593064424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cDJsuG6GtXcaphjSiqDFSb49Cz2RH/+bn5qUN8ueiH8=;
        b=JDz4VRj5rxRaNAvTGw0dYyupS0052Am6iU3ejJ5/cVp+ttuFhfAvX3D/c0Ypf02dB5NLEF
        +ha+KLcS6FMBnZcTPiGgjaDMUzsJAeR/0PcuPKJi+VB5eMwXJcUWGeGV+lZWUn26/kF9Qv
        LZGiPt/LGiAL817TcvSBOzNa1ubcWDs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-s8fBKFQdMT26N4aa6Rwdiw-1; Thu, 25 Jun 2020 01:53:42 -0400
X-MC-Unique: s8fBKFQdMT26N4aa6Rwdiw-1
Received: by mail-wr1-f70.google.com with SMTP id i12so6041299wrx.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 22:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=cDJsuG6GtXcaphjSiqDFSb49Cz2RH/+bn5qUN8ueiH8=;
        b=JtptwE/U1b8+8ZEtNPGX2C8zZcbdo+fNBxVmHoUE82MnCrYRCqPeZ9x7WuuLOcrYvP
         TkBRan+6y04jjq2Xo/K+Z2JOZD/PWSgNnnjMc2cMaajpeuDIXrwjQrypcgJZCMr5JtxL
         0SI8RWU187smOhFppwFB4EB2gPocqYrwbCtpGOsfi+L3tLlgNTtTw8xiOJIVXh1KCYA2
         qgHNFteo6/NBUPaJYDwSnU3fcdX4KKJY/aMo4AduSYkwA5MVpwAZuzAYj+ypyvAJPpkj
         sNwlNCOhsaKYdORvOqkpsrS4Tkg5YIxSKtONZZkJQxzeCYd2cizhoYGegXcJMJJeYp1z
         VLQA==
X-Gm-Message-State: AOAM531DZRYyA5/UVQJ2gGQlzIjbN9nmjpN5/SMWtjejve3VB2mKtmld
        kkTkYbtasiOGEiZbWx+AfbF3+JTbg/l/2iORHSwbQN2dpklBAgxDPuB/vKpbS30hTtk8F7FpDJu
        rDP14QYouc6GaDHuEzsOIMcuO
X-Received: by 2002:adf:ee0f:: with SMTP id y15mr34182290wrn.76.1593064419350;
        Wed, 24 Jun 2020 22:53:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5hXGFY3NA9jZVCbIISwv3TbpYhel5ZeXFLWogioG7Fu9BtfYO7azSJNaCynxpxnD7oj6ImA==
X-Received: by 2002:adf:ee0f:: with SMTP id y15mr34182274wrn.76.1593064419144;
        Wed, 24 Jun 2020 22:53:39 -0700 (PDT)
Received: from [192.168.3.122] (p4ff23f47.dip0.t-ipconnect.de. [79.242.63.71])
        by smtp.gmail.com with ESMTPSA id d28sm32340485wrc.50.2020.06.24.22.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 22:53:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/spase: never partially remove memmap for early section
Date:   Thu, 25 Jun 2020 07:53:37 +0200
Message-Id: <4D73CD59-BFD5-401A-A001-41F7BF5641BA@redhat.com>
References: <CAPcyv4gMQsBSQ-kXM6H_zz96ZTJ5F0XnDfq6_mZTn4t9JwmEpA@mail.gmail.com>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>, Baoquan He <bhe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
In-Reply-To: <CAPcyv4gMQsBSQ-kXM6H_zz96ZTJ5F0XnDfq6_mZTn4t9JwmEpA@mail.gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 25.06.2020 um 01:47 schrieb Dan Williams <dan.j.williams@intel.com>:
>=20
> =EF=BB=BFOn Wed, Jun 24, 2020 at 3:44 PM Wei Yang
> <richard.weiyang@linux.alibaba.com> wrote:
> [..]
>>> So, you are right that there is a mismatch here, but I think the
>>> comprehensive fix is to allow early sections to be partially
>>> depopulated/repopulated rather than have section_activate() and
>>> section_deacticate() special case early sections. The special casing
>>> is problematic in retrospect as section_deactivate() can't be
>>> maintained without understand special rules in section_activate().
>>=20
>> Hmm... This means we need to adjust pfn_valid() too, which always return t=
rue
>> for early sections.
>=20
> Right, rather than carry workarounds in 3 locations, and the bug that
> has resulted from then getting out of sync, just teach early section
> mapping to allow for the subsection populate/depopulate.
>=20

I prefer the easy fix first - IOW what we Here here. Especially, pfn_to_onli=
ne_page() will need changes as well.

At least my ack stands.=

