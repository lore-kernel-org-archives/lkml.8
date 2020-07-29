Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7F5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA1DC2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KyNB6o8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgG2OSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:18:41 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54201 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726709AbgG2OSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596032319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v3yRCdNgmRAYY03SE3GU+4EvBfKgO2Uc6QsVoa6VhTk=;
        b=KyNB6o8YYC+Kg5akZN+wDWTQnxAeVuQBVXl4rkeDzN6KgVdQ44anh6btYpC+bSWZyjOQr2
        m6lTMXgkLNH21QpL3WPlItwErckiJoPa18ckmmQh2Fl/k25eEXsj2nlms0IPEqB/p67/3i
        ddna4rDPzDkxOBBVTXX/hgqYQSFccwk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-UBPXAyquO1WbNull6QR39g-1; Wed, 29 Jul 2020 10:18:35 -0400
X-MC-Unique: UBPXAyquO1WbNull6QR39g-1
Received: by mail-wm1-f72.google.com with SMTP id h205so1077072wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 07:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v3yRCdNgmRAYY03SE3GU+4EvBfKgO2Uc6QsVoa6VhTk=;
        b=GaMqdJHs7N3kD7DZWmk9KAsMizuNp8ETbqB/lqGukMLG4Y8w+62TVHm/WYyejYhh7o
         kHRqgcEddtfmIzPAzlS1kdemqiGexWI9CZ6eoEILe25IJKdNssdQoVF181KztYtrYIhQ
         pq16W6olnUkO2PTbHYdyx5EN3WhJoL7ybkwrnbFT17LlR/uYaPzEnNxF5g5bXuRrpMdE
         G1FmLYdw/sNLYQ/kV9H1GtSkyWAtmrNPS+DKxYrk+qWrBzIEqgreEyxtItbjKFIFFLeF
         tkImG9NfU1ywIHxWazdLQHCzw6Wh5UseBQ/HMCbCvUfsvw0k8BMQX3jMS9YYreSmdoRM
         SL4A==
X-Gm-Message-State: AOAM532AfiDfO43E7HPH/2/vm4zdjtj6vJs50PHJqTp9rzJqV0zTQcXu
        gJD1eEEjvm1i6fPjhRwd07LViVB+W6DHWxwMzx8A3/lVczNezSgt33/pOCMCsb6QxwZ+VRnFyiN
        afFRlMPtxh95UZBtOxc/tS8iw
X-Received: by 2002:a7b:cb47:: with SMTP id v7mr8508124wmj.57.1596032314736;
        Wed, 29 Jul 2020 07:18:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmmwjulBzKNnKWk+ryRFt1ck/MUmSlh4QEF+dyEOk3V/1QmT4D6lnSPhVTqHYJjenQPDZGtQ==
X-Received: by 2002:a7b:cb47:: with SMTP id v7mr8508106wmj.57.1596032314505;
        Wed, 29 Jul 2020 07:18:34 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
        by smtp.gmail.com with ESMTPSA id q7sm5949774wra.56.2020.07.29.07.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 07:18:33 -0700 (PDT)
Date:   Wed, 29 Jul 2020 10:18:30 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: mmotm 2020-07-27-18-18 uploaded (mm/page_alloc.c)
Message-ID: <20200729101807-mutt-send-email-mst@kernel.org>
References: <20200728011914.S-8vAYUK0%akpm@linux-foundation.org>
 <ae87385b-f830-dbdf-ebc7-1afb82a7fed0@infradead.org>
 <20200728145553.2a69fa2080de01922b3a74e0@linux-foundation.org>
 <20200729082053.6c2fb654@canb.auug.org.au>
 <20200728153143.c94d5af061b20db609511bf3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728153143.c94d5af061b20db609511bf3@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 03:31:43PM -0700, Andrew Morton wrote:
> On Wed, 29 Jul 2020 08:20:53 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > Hi Andrew,
> > 
> > On Tue, 28 Jul 2020 14:55:53 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> > > config CONTIG_ALLOC
> > >         def_bool (MEMORY_ISOLATION && COMPACTION) || CMA
> > > 
> > > says this is an improper combination.  And `make oldconfig' fixes it up.
> > > 
> > > What's happening here?
> > 
> > CONFIG_VIRTIO_MEM selects CONFIG_CONTIG_ALLOC ...
> 
> Argh, select strikes again.
> 
> So I guess VIRTIO_MEM should also select COMPACTION?

+Cc the maintainer.

-- 
MST

