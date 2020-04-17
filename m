Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2152C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 06:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B28E42063A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 06:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5gzAXzJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgDQGdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 02:33:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33504 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727904AbgDQGdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 02:33:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587105230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aRp3vqzXNggkBlbb5TjXuZYOr8GevPVbWARU6hChYxw=;
        b=a5gzAXzJIrV0XgpXiIwM454VPvFtu3tbmICqq68YzQBOoEqCgtJiWyrE64HVk8/vNQJmR6
        JgBoCNmvbaDvijkLc6KpYvHR7N+Fs9HWObAKPmwaQuRKYawNmvRIXz5iWbdcFbv+zDiYWQ
        lyL51RdZuF6rgP1R+5ruoDKcPnUg7w4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-x9QJ0It7NmSPoaWaPH5mLA-1; Fri, 17 Apr 2020 02:33:48 -0400
X-MC-Unique: x9QJ0It7NmSPoaWaPH5mLA-1
Received: by mail-wr1-f71.google.com with SMTP id y1so518149wrp.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 23:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aRp3vqzXNggkBlbb5TjXuZYOr8GevPVbWARU6hChYxw=;
        b=D+f7NJGW0SO/JFnjYO/pfQQou0t0ZUUtaBjPrfsW5E1qyYazdGurfJyNJbarkYlQC/
         NptF/o0TmQw7/tY5rtjMJdw5h6M+ex0OvGuQjdMX3532dDtLZWVT9M+8j/aIb+zv0Bvt
         APvSFqQy5IrCxlIF7ie4C+ao1nd8F5gm5mrDfHyypI93WO2ryTQQkt8opqR8T/eYpbIn
         3l62tDeI8MpiLOEhct1yp/b6OBouC/XtvbwnkMlZQAKsl5WgRfAVuZsTI7I8ifx24DR6
         eSM/JgFrWJkwl8ZRZCu4kL+hjDXTbwuf/H/hlvcXdxyhli2LIOH3P7p/SDCPZBweuTEh
         VmkQ==
X-Gm-Message-State: AGi0Pubandr+N2PxbBaB8IMIl3oBbVqtY+GSlsm2JWXHY3cEzCYY17cY
        tkfKozTzKqf+OElXN/38hMht0LIdwb1b1MbJFPjb+eq0E+QaEMjZtFQaDVssamSmPba5Eau3SVo
        woEBbFuyZULUYpUQ2fLSwMf84
X-Received: by 2002:a1c:5a06:: with SMTP id o6mr1725643wmb.34.1587105227187;
        Thu, 16 Apr 2020 23:33:47 -0700 (PDT)
X-Google-Smtp-Source: APiQypLC+56jzTsL7mtJ8WJVomZZD1bGAAbZ16bTvi8qD3oQHVUMVTlOszcQ+jGs26hCvKjQJ7zNyQ==
X-Received: by 2002:a1c:5a06:: with SMTP id o6mr1725618wmb.34.1587105226999;
        Thu, 16 Apr 2020 23:33:46 -0700 (PDT)
Received: from redhat.com (bzq-79-183-51-3.red.bezeqint.net. [79.183.51.3])
        by smtp.gmail.com with ESMTPSA id k184sm6461323wmf.9.2020.04.16.23.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 23:33:46 -0700 (PDT)
Date:   Fri, 17 Apr 2020 02:33:43 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, geert@linux-m68k.org,
        tsbogend@alpha.franken.de, benh@kernel.crashing.org,
        paulus@samba.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH V2] vhost: do not enable VHOST_MENU by default
Message-ID: <20200417022929-mutt-send-email-mst@kernel.org>
References: <20200415024356.23751-1-jasowang@redhat.com>
 <20200416185426-mutt-send-email-mst@kernel.org>
 <b7e2deb7-cb64-b625-aeb4-760c7b28c0c8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7e2deb7-cb64-b625-aeb4-760c7b28c0c8@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 11:12:14AM +0800, Jason Wang wrote:
> 
> On 2020/4/17 上午6:55, Michael S. Tsirkin wrote:
> > On Wed, Apr 15, 2020 at 10:43:56AM +0800, Jason Wang wrote:
> > > We try to keep the defconfig untouched after decoupling CONFIG_VHOST
> > > out of CONFIG_VIRTUALIZATION in commit 20c384f1ea1a
> > > ("vhost: refine vhost and vringh kconfig") by enabling VHOST_MENU by
> > > default. Then the defconfigs can keep enabling CONFIG_VHOST_NET
> > > without the caring of CONFIG_VHOST.
> > > 
> > > But this will leave a "CONFIG_VHOST_MENU=y" in all defconfigs and even
> > > for the ones that doesn't want vhost. So it actually shifts the
> > > burdens to the maintainers of all other to add "CONFIG_VHOST_MENU is
> > > not set". So this patch tries to enable CONFIG_VHOST explicitly in
> > > defconfigs that enables CONFIG_VHOST_NET and CONFIG_VHOST_VSOCK.
> > > 
> > > Acked-by: Christian Borntraeger<borntraeger@de.ibm.com>  (s390)
> > > Acked-by: Michael Ellerman<mpe@ellerman.id.au>  (powerpc)
> > > Cc: Thomas Bogendoerfer<tsbogend@alpha.franken.de>
> > > Cc: Benjamin Herrenschmidt<benh@kernel.crashing.org>
> > > Cc: Paul Mackerras<paulus@samba.org>
> > > Cc: Michael Ellerman<mpe@ellerman.id.au>
> > > Cc: Heiko Carstens<heiko.carstens@de.ibm.com>
> > > Cc: Vasily Gorbik<gor@linux.ibm.com>
> > > Cc: Christian Borntraeger<borntraeger@de.ibm.com>
> > > Reported-by: Geert Uytterhoeven<geert@linux-m68k.org>
> > > Signed-off-by: Jason Wang<jasowang@redhat.com>
> > I rebased this on top of OABI fix since that
> > seems more orgent to fix.
> > Pushed to my vhost branch pls take a look and
> > if possible test.
> > Thanks!
> 
> 
> I test this patch by generating the defconfigs that wants vhost_net or
> vhost_vsock. All looks fine.
> 
> But having CONFIG_VHOST_DPN=y may end up with the similar situation that
> this patch want to address.
> Maybe we can let CONFIG_VHOST depends on !ARM || AEABI then add another
> menuconfig for VHOST_RING and do something similar?
> 
> Thanks

Sorry I don't understand. After this patch CONFIG_VHOST_DPN is just
an internal variable for the OABI fix. I kept it separate
so it's easy to revert for 5.8. Yes we could squash it into
VHOST directly but I don't see how that changes logic at all.

-- 
MST

