Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20734C2D0ED
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 15:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE102073E
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 15:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPSdiZiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgC2Pl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 11:41:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37441 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbgC2Pl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 11:41:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so18006647wrm.4;
        Sun, 29 Mar 2020 08:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H2oEr4rtYq7eZA0dkqG0zoVVshpwZANdfGBsNxxUn38=;
        b=JPSdiZiRXV8x0YY6PaSnyNrrI6wCcO+UprNjXMSGLe8TVQ4nkWf/h87iB4mbM/FjpE
         MxFK1gGUdvWU5KJP/1Mha2Zou4bqyr97JtFerGq4nVfYqHCiLfIOVG+tLoXnY3liG9I0
         FkYONcVcPMW/VR0ZKoctrzPnPyWm1J2ehqZVlRxAh9qMbvu3pjhRJwsE3YKYBAV7nT8N
         vq2qEzYBDi1hj9OlewSTxqyKZj7IIyK2PJ1mUPvulP0fk+bYllI027qYpAD1nTqZUbfY
         ORSpuzeIBoZ5nIc5WAvSufxtJum0k0WARTpEn5jUl0oaR5cxt8X+IJcLgiWnhbj/9JPZ
         eXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H2oEr4rtYq7eZA0dkqG0zoVVshpwZANdfGBsNxxUn38=;
        b=hu0yE9AJB9UgtMTvgRAQYyTBe8P7HxUjJbwuylnp/Xui1HJrtemJg0/WoSEhIy8KVD
         xr/PJPUtXYNIOf0mg66T/HT2vcgJgg7TgLvqxk4XIwOFczv43RDx466QTgrCpudVKu2Q
         AdRmLxuFaUQ/jAYiGfyL3BGmwIXpctfOPjSCRLEDL3tq052T1ZRU9WFSOgCwWemCFqWV
         ODJ65u2n0lbneQEtUFsB5Dh8mmncWLZOIr/rhZvNw22bVCoRRr3c9PVN9Xsa2+e6Mzk1
         ZuvpCBO3RGMnMmqa9dMHVS+/2qyjTh2RnJmuBAroKDrFSFMMi/6CYsbNebU+7Uya7rTA
         59Sw==
X-Gm-Message-State: ANhLgQ3AeZgQYX+1BHJnaMAi54cKA598WtcIPXrbLeqUd4PeWbV4zWgq
        dDdwa8jWSQN4iS/cKZjl5GcwK/OZgJLOhr/0BNw=
X-Google-Smtp-Source: ADFU+vsV8jzRWuHYOAA089AR+shUjNO4rmsDCQRnKzdjlt6pysT09Bdt7QBzKnRQjbk2BQWoJRrPJ8I6vTTCRwZehdk=
X-Received: by 2002:a5d:674f:: with SMTP id l15mr10083350wrw.196.1585496485499;
 Sun, 29 Mar 2020 08:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200311171422.10484-1-david@redhat.com> <CAM9Jb+g6DEL1=L1ESfW+Jnr_rfO5rEtOwnp10eCLpajaAv8wvg@mail.gmail.com>
 <6858c4d8-7570-2c2b-5d53-1a7f994c14ee@redhat.com>
In-Reply-To: <6858c4d8-7570-2c2b-5d53-1a7f994c14ee@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Sun, 29 Mar 2020 17:41:14 +0200
Message-ID: <CAM9Jb+jbVciBwHBj09w4+sXbJ_dRwiXwe2DPUsx0P1fRsdAi0w@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] virtio-mem: paravirtualized memory
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Sebastien Boeuf <sebastien.boeuf@intel.com>,
        Samuel Ortiz <samuel.ortiz@intel.com>,
        Robert Bradford <robert.bradford@intel.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        teawater <teawaterz@linux.alibaba.com>,
        Igor Mammedov <imammedo@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Alexander Potapenko <glider@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Young <dyoung@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Len Brown <lenb@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Pingfan Liu <kernelfans@gmail.com>, Qian Cai <cai@lca.pw>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi David,
> >
> > Trying to test the series with the Qemu branch(virtio-mem) mentioned.
> > Unfortunately,
> > not able to hotplug memory. Is anything changed from your previous posting
> > or I am doing something wrong?
> >
> > After giving value to "requested-size", I see size as zero.
> >
> > (qemu) qom-set vm0 requested-size 10G
> > (qemu) info memory-devices
> > Memory device [virtio-mem]: "vm0"
> >   memaddr: 0x240000000
> >   node: 0
> >   requested-size: 10737418240
> >   size: 0
> >   max-size: 107374182400
> >   block-size: 2097152
> >   memdev: /objects/mem0
> >
> > Guest kernel: 5.6.0-rc4
> > Using same Qemu commandline arguments mentioned in cover-letter.
>
> Are you booting from an initrd? Are you compiling virtio-mem as a kernel
> module or into the kernel binary?
Ah was booting into wrong kernel version. Sorry! for the noise.

Working perfectly for me. Tried various cmbinations for both
hotplug/unplug with multiple
NUMA nodes and verified result in guest.

For the series, you can add:
Tested-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>


>
> --
> Thanks,
>
> David / dhildenb
>
