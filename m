Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1824EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E681A206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591822124;
	bh=SM9LjAcqanTOcEHwR4TQbbU7HyR/Px6rEVi0/rCBJoo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DlAbVjGvKdOH74f4ZZy3FuipDEKl123zsrnE8FQO1u4EzPzGOAMk/lC5U9HRcp6Ry
	 IkiKAbYj/CpUvvgU8NoIunO2d3WeUOtNR2FRJ+wAgc1xmKc6cI2ZhG8uFgr697/LKT
	 Qmyh50L5IZUo9DZbzefFm28D9Xh1r/Z9G2XtelZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgFJUsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgFJUsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:48:42 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FB0C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 13:48:42 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id i27so4210189ljb.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 13:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wkhkcPvpAeE4x4kAO1HjblduVWOEiZ+eHHO4eca07FY=;
        b=IgN05Fh0uREALZZU/s8t66dRm0ApTxlnvcL6Nnx/SwIGy9zTKN1m9HDCNywJFvcZ2U
         1xEVjk51dwqTD6l0sgKb+Vtjqr4s6SbTFzUJ0kDAKBXdGB7diNzJzQphVdL+BPgjm0Ga
         CNO9Wx8KMuwTuBeK1fJ+X3/7/j11L4DzwfyzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wkhkcPvpAeE4x4kAO1HjblduVWOEiZ+eHHO4eca07FY=;
        b=K1YLbCjInZvPGRFyjiPUqPVmRX8Roi5Q7PFrMq1DxlAJwWD+kYNspd3sJuAA19woYH
         3KbkEROSVqR3h4xUR9rZ15p5tf5i0jeVul7eTj5Z+5/CEeI0jdOccUtutRSqGOCFYGTK
         5sBVhb796kPjkPP6VsvRJzuqQymkSGz7t+RC3kphYf4C7p4OEu1Yjn2ynWPOoWdMEqkR
         jH5vg5UUvC+hHBEVtMyxG9v+mWhX/ImHyH7esLD8evJDhyKjjS2aJtrpC9TyGQYWDg3Z
         R6VCUbn39Au8dlmoX/WbTKINTnBmUvBnbG7MGWmpQbZV0mkgL1zk3+FMi2SMfZNgdmRi
         r8gQ==
X-Gm-Message-State: AOAM530pcOy/3gg4E6HTKQ+eWXTqvbjnv8hcN4+xk5N7pNlEZD2Uodm2
        99vwkrqfdqATzc3Ydh66+FOMW9ymafY=
X-Google-Smtp-Source: ABdhPJzR5RI2s9VgIBHTR9/cazZgDN3umSviTjx4/icWHf0lCWDIiWb+zaDllrYVg6bzy7Itv2m8dQ==
X-Received: by 2002:a2e:b0fa:: with SMTP id h26mr2568929ljl.148.1591822120569;
        Wed, 10 Jun 2020 13:48:40 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id u15sm197773lfg.92.2020.06.10.13.48.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 13:48:39 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id n24so4206611lji.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 13:48:38 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr2510079ljn.70.1591822118508;
 Wed, 10 Jun 2020 13:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200610004455-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200610004455-mutt-send-email-mst@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 10 Jun 2020 13:48:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiyR6X=SkHXMM3BWcePBryF4pmBNYMFWAnz5CfZwAp_Wg@mail.gmail.com>
Message-ID: <CAHk-=wiyR6X=SkHXMM3BWcePBryF4pmBNYMFWAnz5CfZwAp_Wg@mail.gmail.com>
Subject: Re: [GIT PULL] virtio: features, fixes
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     KVM list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        anshuman.khandual@arm.com, anthony.yznaga@oracle.com,
        arei.gonglei@huawei.com, Qian Cai <cai@lca.pw>,
        clabbe@baylibre.com, Dan Williams <dan.j.williams@intel.com>,
        David Miller <davem@davemloft.net>,
        David Hildenbrand <david@redhat.com>, dyoung@redhat.com,
        Markus Elfring <elfring@users.sourceforge.net>,
        Alexander Potapenko <glider@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        guennadi.liakhovetski@linux.intel.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Herbert Xu <herbert@gondor.apana.org.au>, hulkci@huawei.com,
        imammedo@redhat.com, Jason Wang <jasowang@redhat.com>,
        Juergen Gross <jgross@suse.com>, kernelfans@gmail.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Len Brown <lenb@kernel.org>, lingshan.zhu@intel.com,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        kernel test robot <lkp@intel.com>, longpeng2@huawei.com,
        matej.genci@nutanix.com, Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>, osalvador@suse.com,
        Oscar Salvador <osalvador@suse.de>,
        pankaj.gupta.linux@gmail.com, pasha.tatashin@soleen.com,
        Pasha Tatashin <pavel.tatashin@microsoft.com>,
        Rafael Wysocki <rafael@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        stable <stable@vger.kernel.org>, stefanha@redhat.com,
        teawaterz@linux.alibaba.com, Vlastimil Babka <vbabka@suse.cz>,
        zou_wei@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 9, 2020 at 9:45 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
>   I also upgraded the machine I used to sign
> the tag (didn't change the key) - hope the signature is still ok. If not
> pls let me know!

All looks normal as far as I can tell,

                Linus
