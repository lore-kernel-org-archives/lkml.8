Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4D0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 19:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ACB3206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 19:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DzUT2XUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgFDT1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 15:27:15 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50768 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726446AbgFDT1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 15:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591298832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q49Z4256vOBoq7DStqgcJEK9UupKdzcyujqiCc4dd9o=;
        b=DzUT2XUkMO/dsYzB1jh/D4h7qN/eFnj4gqwFJbGyXoOvnn42OLXrDVlQssYV171X/rCoAX
        px58Gma9tXyYbvE7+1i+i2M4tDiQauA28N75qTv04uQTZPMYRtnji50+XOdIO7g2puEHxY
        Sf35INhZ+O0394hWDKetzpllhAav+PU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-JZN-XJmxMe23SM7RdBEA1Q-1; Thu, 04 Jun 2020 15:27:09 -0400
X-MC-Unique: JZN-XJmxMe23SM7RdBEA1Q-1
Received: by mail-wm1-f70.google.com with SMTP id v23so2273807wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 12:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q49Z4256vOBoq7DStqgcJEK9UupKdzcyujqiCc4dd9o=;
        b=GvJa6W3q8sTU2VvjGSJbmJUZqZDqOqQqeoQuNPGtEdaf9LRMop9EDYS+8u8uTJVvjP
         rUoQorKg1ZSDQPu4I1HdjOekWwPZ+x4aAQ+2jAGvWnmKQZ1JsPho8p1IwyLz343BJ79p
         GGWsfr/M4iKJrtnmlbwyDn9CK7EvqhQYYCY9Mm1oB/ancSb36uqQcDkPIEREC6Q6Gruf
         mHpFuhJD2K7OVxAKbaeRMdm7lvogJhhE0bnBFnMvIfkcg6Oihko1kOE7YZG9xdax63VC
         HzNxq8N2nM78z02bUmNd2w9J3tkAcSWNS0xHv//UkZxIGJhouHyLw8VQYz3ADUCThVO4
         +Zhw==
X-Gm-Message-State: AOAM530kwPWUxZi0Izg5m1gLVhlODb24w6zgLMkCdoI+2ZNTOyyqMBl4
        ssBpG578pD6+1zihuhxzkg7PJIQcXFxVukzgunNqu/Th9D1eooItg5l+Ih7+PkpiQNTwRLVHGVE
        klrrLuxy4Ql/LMSiHnTVXUZjB
X-Received: by 2002:a05:600c:c3:: with SMTP id u3mr5149985wmm.108.1591298828084;
        Thu, 04 Jun 2020 12:27:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvcnPpK6VBqKCpJV3bB7l7vAoUXzeRhj0mnBk/bmYIFW6j4ZT+bUa1mlOaLtCHj4EUtktr1A==
X-Received: by 2002:a05:600c:c3:: with SMTP id u3mr5149966wmm.108.1591298827858;
        Thu, 04 Jun 2020 12:27:07 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id y37sm10879481wrd.55.2020.06.04.12.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 12:27:07 -0700 (PDT)
Date:   Thu, 4 Jun 2020 15:27:05 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Joe Perches <joe@perches.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: MAINTAINERS: Wrong ordering in VIRTIO BALLOON
Message-ID: <20200604152654-mutt-send-email-mst@kernel.org>
References: <alpine.DEB.2.21.2005120717260.3701@felia>
 <bb2eea77-72df-6c53-5397-de057ffc9dd8@redhat.com>
 <80146d5713f8579a92b4da1e2b7d7626999dd9be.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80146d5713f8579a92b4da1e2b7d7626999dd9be.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 09:23:45AM -0700, Joe Perches wrote:
> On Tue, 2020-05-12 at 08:38 +0200, David Hildenbrand wrote:
> > On 12.05.20 07:21, Lukas Bulwahn wrote:
> > > Hi David,
> > > 
> > > with your commit 6d6b93b9afd8 ("MAINTAINERS: Add myself as virtio-balloon 
> > > co-maintainer"), visible on next-20200508, ./scripts/checkpatch.pl -f 
> > > MAINTAINERS complains:
> > > 
> > > WARNING: Misordered MAINTAINERS entry - list file patterns in alphabetic order
> > > #17982: FILE: MAINTAINERS:17982:
> > > +F:	include/uapi/linux/virtio_balloon.h
> > > +F:	include/linux/balloon_compaction.h
> > > 
> > > This is due to wrong ordering of the entries in your submission. If you 
> > > would like me to send you a patch fixing that, please just let me know.
> > > 
> > > It is a recent addition to checkpatch.pl to report ordering problems in 
> > > MAINTAINERS, so you might have not seen that at submission time.
> > 
> > Thanks for the notification Lukas,
> > 
> > b962ee8622d0 ("checkpatch: additional MAINTAINER section entry ordering
> > checks") is not in Linus' tree yet AFAIKS.
> > 
> > I can see that 3b50142d8528 ("MAINTAINERS: sort field names for all
> > entries") is upstream. I do wonder if we should just do another batch
> > update after the checkpatch patch is upstream instead, I guess more will
> > pile up?
> > 
> > @mst, joe, what do you prefer?
> > 
> > 1. I can resend the original patch.
> > 2. Lukas can send a fixup that we might want to squash.
> > 3. We wait until the checkpatch change goes upstream and to a final
> > batch update.
> 
> A fixup patch would work.
> 
> I think if Linus every once in awhile just before an -rc1 runs
> scripts/parse-maintainers like:
> 
> commit 3b50142d8528 ("MAINTAINERS: sort field names for all entries")
> 
> then these sorts of individual patches would not matter much.
> 
> This first time the script was run, I think there was just 1 patch
> conflict from -next to Linus' tree, and that scripted change was
> fairly large.
> 
> As the changes will generally be smaller in the future, it's unlikely
> there will be a significant number of conflicts.
> 


ok so just send a fixup patch pls.

