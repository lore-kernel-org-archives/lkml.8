Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65D5C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8F020784
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U2kQIH6Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgCaSiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 14:38:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57965 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726194AbgCaSiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 14:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585679892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DCBEU8xfWPGRP7T0kzGMhyTHNf5Ar1K3myE5Isk/Yus=;
        b=U2kQIH6QuSGzblMF5xFeKHOCx77Fb/0U+bkfuDRh1d9gVnBJHrr5SoWBrJJzf1pL/X/Qf0
        14VnvSAJ8bQBJr4yf1U7f/v9I8TZbpooa7lIl6Nhq1M22GSaqVcHaz9We7X52Vq0hcvCVK
        GSq9vDvVMlKEJfhWPET6EkwR/GkVM4E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-t4dFhyDKO5-xkEsKZKbklg-1; Tue, 31 Mar 2020 14:38:01 -0400
X-MC-Unique: t4dFhyDKO5-xkEsKZKbklg-1
Received: by mail-wr1-f69.google.com with SMTP id c8so11455468wru.20
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 11:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DCBEU8xfWPGRP7T0kzGMhyTHNf5Ar1K3myE5Isk/Yus=;
        b=PpjqidbUBAMDq+rW+NjDF4w++crPYn+NaoQFJFn/RDZx/rZEdJNwnpZ8j76WCXkzdz
         JC8g/ee5cIW9FkhyoQtTrUbb7RS0cMwryKLS6XBqPahUZC+wSMWjvbDsZERCyuZZRo47
         hIZBUeMxRyLSeD5vywS28Ot0rpGxsxsRnU0U2CLqZjwcHkLtZ75y4tf1+JO9qXTn8veV
         20xY2uZqqHURbDJqnLb17isrz63Qd1WY4h8zcVbQm8dloOm8Hj+Qg7b6re8I8Q3pzA0a
         eLsJ5pBIIJkIX0mBKvWip0TZvs4MTQmanZlgsB3NzGdbUWrn6Fp4f6XIaAJn+rp9SARl
         5YXw==
X-Gm-Message-State: ANhLgQ3EYMNWs+Lno+LNKbiPF8bLglFQVzY8iKlDp+HbfbC7tjRFnptA
        lgxAjynARlgtF2dvRXwIKLTfZeqYgtrJg9OKujFW1vXv5pffHu3Bm59oaEI2mTX3N6cZL1TM5rT
        Mow0DVNrpLZ6b78k0947Kd2pn
X-Received: by 2002:a5d:470b:: with SMTP id y11mr21278434wrq.282.1585679879820;
        Tue, 31 Mar 2020 11:37:59 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv7BkgR0ghsMi1Xgc6DnC2NK7tqfIaM77t9wkjqEFGZ1NVpf3iEEFN2O7dAkJUYQEvEgprBcw==
X-Received: by 2002:a5d:470b:: with SMTP id y11mr21278415wrq.282.1585679879621;
        Tue, 31 Mar 2020 11:37:59 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id l17sm28536847wrm.57.2020.03.31.11.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 11:37:58 -0700 (PDT)
Date:   Tue, 31 Mar 2020 14:37:56 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>
Subject: Re: mmotm 2020-03-30-18-46 uploaded (VDPA + vhost)
Message-ID: <20200331143437-mutt-send-email-mst@kernel.org>
References: <20200331014748.ajL0G62jF%akpm@linux-foundation.org>
 <969cacf1-d420-223d-7cc7-5b1b2405ec2a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <969cacf1-d420-223d-7cc7-5b1b2405ec2a@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 11:27:54AM -0700, Randy Dunlap wrote:
> On 3/30/20 6:47 PM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2020-03-30-18-46 has been uploaded to
> > 
> >    http://www.ozlabs.org/~akpm/mmotm/
> > 
> > mmotm-readme.txt says
> > 
> > README for mm-of-the-moment:
> > 
> > http://www.ozlabs.org/~akpm/mmotm/
> > 
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> > 
> > You will need quilt to apply these patches to the latest Linus release (5.x
> > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> > http://ozlabs.org/~akpm/mmotm/series
> > 
> > The file broken-out.tar.gz contains two datestamp files: .DATE and
> > .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> > followed by the base kernel version against which this patch series is to
> > be applied.
> > 
> > This tree is partially included in linux-next.  To see which patches are
> > included in linux-next, consult the `series' file.  Only the patches
> > within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included in
> > linux-next.
> > 
> > 
> > A full copy of the full kernel tree with the linux-next and mmotm patches
> > already applied is available through git within an hour of the mmotm
> > release.  Individual mmotm releases are tagged.  The master branch always
> > points to the latest release, so it's constantly rebasing.
> > 
> > 	https://github.com/hnaz/linux-mm
> 
> on i386:
> 
> ld: drivers/vhost/vdpa.o: in function `vhost_vdpa_init':
> vdpa.c:(.init.text+0x52): undefined reference to `__vdpa_register_driver'
> ld: drivers/vhost/vdpa.o: in function `vhost_vdpa_exit':
> vdpa.c:(.exit.text+0x14): undefined reference to `vdpa_unregister_driver'
> 
> 
> 
> drivers/virtio/vdpa/ is not being built. (confusing!)
> 
> CONFIG_VIRTIO=m
> # CONFIG_VIRTIO_MENU is not set
> CONFIG_VDPA=y

Hmm. OK. Can't figure it out. CONFIG_VDPA is set why isn't
drivers/virtio/vdpa/ built?
we have:


obj-$(CONFIG_VDPA) += vdpa/

and under that:

obj-$(CONFIG_VDPA) += vdpa.o


> CONFIG_VDPA_MENU=y
> # CONFIG_VDPA_SIM is not set
> CONFIG_VHOST_IOTLB=y
> CONFIG_VHOST_RING=m
> CONFIG_VHOST=y
> CONFIG_VHOST_SCSI=m
> CONFIG_VHOST_VDPA=y
> 
> Full randconfig file is attached.
> 
> (This same build failure happens with today's linux-next, Mar. 31.)
> 
> @Yamada-san:  Is this a kbuild problem (or feature)?
> 
> -- 
> ~Randy
> Reported-by: Randy Dunlap <rdunlap@infradead.org>

