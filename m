Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FF6C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A7724680
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S90Njzii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgCJVZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 17:25:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35330 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726100AbgCJVZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 17:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583875535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PjppQBeLTkZZCecEWozf+N5VWi5ByBEgDv2ZEv1V9p0=;
        b=S90NjziiQqH3QpOCTPI7/DYy2U9SvrjGdWSONKul1wM0aKTAEkBqVSjEKZ66V7+7d69B+L
        NT9hD/LI1Ak92rPAFU8AzWR9I+Qb84TCGhGqbaNp+KNXwLDJGVPXc6dBCo0mJ/y3Je1Nlb
        gU84QLppDl7rkXgMPKe0fk5j3uJKLvE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-znvxvvBaPqCeH77coEIvDg-1; Tue, 10 Mar 2020 17:25:33 -0400
X-MC-Unique: znvxvvBaPqCeH77coEIvDg-1
Received: by mail-qv1-f71.google.com with SMTP id fc5so4434qvb.17
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 14:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PjppQBeLTkZZCecEWozf+N5VWi5ByBEgDv2ZEv1V9p0=;
        b=gsozQzoDSVVB3Hoen6dgcGmHc1mi3jMiKcrAnOCS4RLn4vOF/ls2Sy0BxjjVgr/VFs
         ye/vkNzk/Kc4EVhyy11Ft8fP0urCfJRFizlhAa0m9bGWGvM0V1Aeyw6ax42P8WyTOi/q
         1lp+8K/XXV3HKNOQs/5cg3eR/SEw7UOuDnVG6p8XppdZPj7CEDH8oFYPARoaKOsNP35W
         bDYulKj9s7gOmmTVuuZUjsrfaUH2h9mcKy9Bmvafu08xwlLpxKdjSTBbl+P8qk4YVNJA
         AOy9YlLxisNTMW7Suxp0nWcHMHT4Fmc1Io8IvJABGEulD1EDUMpHcePfWPVQ0t0njOcX
         3HlQ==
X-Gm-Message-State: ANhLgQ1rwvkuj7G+pg6NHK5Zza8V/onV4PhTS43LY29lvmJX+AEaMoUy
        XqPnWcYpVNJDqqbW8WikdA2gvp3l5UaLpSaElCujMuArzeRbtk+ncuM/wM6h9mEh0WgIP3/lcku
        NzVLmM6f5CT9FfbguiW4OxHZ9
X-Received: by 2002:a05:6214:118d:: with SMTP id t13mr180507qvv.192.1583875532912;
        Tue, 10 Mar 2020 14:25:32 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsm9esHy6RRQ6NWExmJI592vF5/fX7Q0wtldkoyBFRw99jepEJ3weu40LWa8dfzm4aTO5HEjg==
X-Received: by 2002:a05:6214:118d:: with SMTP id t13mr180490qvv.192.1583875532728;
        Tue, 10 Mar 2020 14:25:32 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
        by smtp.gmail.com with ESMTPSA id n50sm3507706qtc.5.2020.03.10.14.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 14:25:31 -0700 (PDT)
Date:   Tue, 10 Mar 2020 17:25:25 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Tyler Sanderson <tysand@google.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Nadav Amit <namit@vmware.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] virtio-balloon: Switch back to OOM handler for
 VIRTIO_BALLOON_F_DEFLATE_ON_OOM
Message-ID: <20200310172114-mutt-send-email-mst@kernel.org>
References: <20200310113854.11515-1-david@redhat.com>
 <alpine.DEB.2.21.2003101204590.90377@chino.kir.corp.google.com>
 <890da35b-1ac2-9c2e-b42d-96d24d3e0f4c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <890da35b-1ac2-9c2e-b42d-96d24d3e0f4c@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 08:13:19PM +0100, David Hildenbrand wrote:
> > Should this have:
> > 
> > Cc: stable@vger.kernel.org # 4.19+
> 
> I guess as nothing will actually "crash" it's not worth stable.


No - it's a regression, it would be a stable candidate from that POV.
The issue is the patch size - stable rules say:

 - It cannot be bigger than 100 lines, with context.

This is about 200 lines with context.
In practice Fixes: is enough to make a bunch of downstreams pick it up.

-- 
MST

