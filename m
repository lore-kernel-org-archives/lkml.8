Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6EAC5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B596E206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuYQEQQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgDVHm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725907AbgDVHm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:42:56 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B6AC03C1A6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 00:42:55 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b62so1463105qkf.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 00:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kAXzsYpxPS43LHrpXQbto4xsDVlXHnjmUkedd7hIV/M=;
        b=XuYQEQQZfNZ8gR/7qgQT58edf9Ay27cjB5EVpDpX//ke8nbDEg+C+WMPMonT2QELAh
         H0xbSzBzvHDLq4A/WnLDuksOsUkEacF58r6rBcW7uA8Py/C7Fp1HBHeoNeNJ1PSIcg6G
         K93WBP4xMmSuXTr1AkTqAnMU0GLcTC1G7gDQvSnQ3mB2Ugxxudcn08oAqoAVCAGXfzdI
         ZwmMZGaC2iI67wm/T+FXDZNWjOiKoz36fUsYH5Dq/1Lse0LOaVTjh6txdbCJJChmIaGn
         X2D5V4c27S7rViqw4ItXIA++PYhsvphYAhhHJOZpF8J8qfirXPo3I7fwAePc4QNDPbI1
         2rQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kAXzsYpxPS43LHrpXQbto4xsDVlXHnjmUkedd7hIV/M=;
        b=VozdKX+ot4xGVojQG+l6/sFcfCNc7B5sbazpr4CFiWf0PR78CUliJnZtJuX3vM4/bM
         VYMS0bc7/2fzpkWPA3SyB8Eis1pz6d7QY8z1OMQOYecomgzIeuWDBGTsP+NJWwzbmyIl
         zGNif7cScDNsMfWwh9+FwtJatmn0IOdvZIvcp8vBj8NpxnybaWgHL5g6EXOVtinkuhab
         bgLb4ZkqYd15LHq81umXDxQRDX4InNGJAy1Ipq9OGxrZe9UJZMVybcGeGOF2A2eJEIK2
         W6QncBXMRISt7fmrE7ySCxy0CWLs0FEGpyKbSKh/RvSkztA1ALpom9MqYl3MeECMZrTw
         hyuQ==
X-Gm-Message-State: AGi0PuZLBMVNFpDoXJ4iU2Bhj3iL5wGLgTr/7iuT2Lrt3nLtr8g+17ZB
        E4DwZ3ngtP8fy9O7Uhe5/wsEfJd+ZsAzn5K8p+o=
X-Google-Smtp-Source: APiQypKOiidieP4y3bHD0e8yplYtL7wUGBvsM9YQRTVKBP2BRWGMbZUmn96kWq0bUTcuc4C+mzfwRAhkHkFI59CAiUU=
X-Received: by 2002:a37:7847:: with SMTP id t68mr23244146qkc.343.1587541375009;
 Wed, 22 Apr 2020 00:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <1587369582-3882-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1587369582-3882-2-git-send-email-iamjoonsoo.kim@lge.com> <20200421090005.GA23085@infradead.org>
 <20200422010234.GA23005@carbon.DHCP.thefacebook.com>
In-Reply-To: <20200422010234.GA23005@carbon.DHCP.thefacebook.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Wed, 22 Apr 2020 16:42:44 +0900
Message-ID: <CAAmzW4PnhyVCjEC9XD24_MnAm3dP+OB2h1-2Lou_Uy6odzBbRg@mail.gmail.com>
Subject: Re: [PATCH 01/10] mm/page-flags: introduce PageHighMemZone()
To:     Roman Gushchin <guro@fb.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Laura Abbott <labbott@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 4=EC=9B=94 22=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 10:02, =
Roman Gushchin <guro@fb.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, Apr 21, 2020 at 02:00:05AM -0700, Christoph Hellwig wrote:
> > I don't think the names are very good.  I'd keep PageHighMem for the
> > existing highmem zone, and add something like PageDirectMapped or
> > similar for ay page that has a valid direct mapping address.  This will
> > also come in handy if we plan to go ahead with the xpfo work.
> >
>
> I agree. It also looks like the only remaining place with PageHighMem()
> is using "if (!PageHighMem(page))", so "if (PageDirectlyMapped(page))" wo=
uld be
> even better.

As mentioned in previous reply to Christoph, I will change the name after
everything is settle down.

> Joonsoo, the series in general looks very good to me. Please, feel free
> to add "Acked-by: Roman Gushchin <guro@fb.com>".

Thanks for reviewing this!

Thanks.
