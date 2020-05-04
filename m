Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61CEC47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 03:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B544320787
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 03:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aj6+XjLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgEDDEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 23:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbgEDDEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 23:04:01 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F7FC061A0E
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 20:04:01 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id i14so4057213qka.10
        for <linux-kernel@vger.kernel.org>; Sun, 03 May 2020 20:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e7sgBnBT1wP45v5viJmIT67GFvpsSurDqbZz1YoZUIs=;
        b=Aj6+XjLroMtzqqWVTf9yQI4wRHT0VL8XMEar76BYr8AclX+XtT5Qti+y3oZZW015HW
         mH23e+8LC7CCk2oAKlQBJp6uiv5l2YfKYNG7j9FHx8bIwL8cmItI6+8h8EckjHhOEuEX
         CVgmY7MhMqySp6NjlloRpjxLP9UcABulb2kGCeMTUdarbR4r+Air43q+uSdA+2nLAd7y
         pyiWx9VSPs78/MDpJ5TEGpl7FzdBoaaTzkRcSedICzWY/NgVw+Cu8reoZPMr/ifJQLr3
         oS/3gbuCJ156IErS/n9Ja3NiZQTGftkibKu1POfgcHp9BwaqH3t464NJw26N0VVdwXZT
         gjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e7sgBnBT1wP45v5viJmIT67GFvpsSurDqbZz1YoZUIs=;
        b=bUCMKSiG5zEkCOOtBGPl50FWcvnoiIjG6xz/8DVIkec8g8PRYOtww8pyTA8PRVCO4H
         /Ab1hWoTrJ2IL5RDTasEq7jGdlT8VD8MqQ6ss/TJmLqeoOeEbdznTwpfJI7qL0tGwmQv
         hvKVtOb1QCkqDeVgg5RjydHA1Q5z6y50Zv3/gCVDSiBH58Y/GcymzNfbe3kn+8iU7Q0W
         S417VIeThWhElwfCxmASJHOmifeowIsGhg/EC1NCO2Lz4qG62SV21Srj+/6nWWnPODKk
         JQjkgAnZQ1XaggN30mybxFMJDIas+gcjs8LtkvaN6mgkQ0mR084kWwanLGMyb9NIqkNR
         oNQQ==
X-Gm-Message-State: AGi0PuZWDL6bnOWErTm8emm6vb/NWcM9NIQdjfHWhXFxjtzC+SFlDaA3
        Uicf4mux5CmfTfvUtBIhuFzb6aHK99oeS5kJa0o=
X-Google-Smtp-Source: APiQypJ9pcf6NPr9u5AZtq+fbHXE8dQimRLrtcQROrIaSTUQgfrCZ9kdwR6D3907lKqIydwzwWustn8oufsSAvnj/ig=
X-Received: by 2002:a05:620a:15c1:: with SMTP id o1mr13733706qkm.187.1588561440426;
 Sun, 03 May 2020 20:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <1588130803-20527-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1588130803-20527-7-git-send-email-iamjoonsoo.kim@lge.com> <20200501122655.GC21897@infradead.org>
In-Reply-To: <20200501122655.GC21897@infradead.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Mon, 4 May 2020 12:03:49 +0900
Message-ID: <CAAmzW4MFH2sq_N5fyuRvi+=nGn4aHZMXSFBtUeuwnv3AFggpWQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] mm/hugetlb: separate PageHighMem() and
 PageHighMemZone() use case
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Laura Abbott <labbott@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 5=EC=9B=94 1=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 9:26, Ch=
ristoph Hellwig <hch@infradead.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed, Apr 29, 2020 at 12:26:39PM +0900, js1304@gmail.com wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > Until now, PageHighMem() is used for two different cases. One is to che=
ck
> > if there is a direct mapping for this page or not. The other is to chec=
k
> > the zone of this page, that is, weather it is the highmem type zone or =
not.
> >
> > Now, we have separate functions, PageHighMem() and PageHighMemZone() fo=
r
> > each cases. Use appropriate one.
> >
> > Note that there are some rules to determine the proper macro.
> >
> > 1. If PageHighMem() is called for checking if the direct mapping exists
> > or not, use PageHighMem().
> > 2. If PageHighMem() is used to predict the previous gfp_flags for
> > this page, use PageHighMemZone(). The zone of the page is related to
> > the gfp_flags.
> > 3. If purpose of calling PageHighMem() is to count highmem page and
> > to interact with the system by using this count, use PageHighMemZone().
> > This counter is usually used to calculate the available memory for an
> > kernel allocation and pages on the highmem zone cannot be available
> > for an kernel allocation.
> > 4. Otherwise, use PageHighMemZone(). It's safe since it's implementatio=
n
> > is just copy of the previous PageHighMem() implementation and won't
> > be changed.
> >
> > I apply the rule #3 for this patch.
> >
> > Acked-by: Roman Gushchin <guro@fb.com>
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>
> Why do we care about the zone here?  This only cares about having
> kernel direct mapped pages as far as I can tell.

My understaning is that what we want to do here is to first free memory
that can be used for kernel allocation. If direct mapped page is on the zon=
e
that cannot be used for kernel allocation, there is no meaning to free
this page first. So, we need to take a care of the zone here.

Thanks.
