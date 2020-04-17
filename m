Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B03C2BB55
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 08:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C69B221EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 08:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E65N3BFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbgDQIaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 04:30:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33589 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729756AbgDQIaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 04:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587112198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sq2go4oE4wkjjJo/d/qCXW8H/F2CZmjvC27LSvnbq6k=;
        b=E65N3BFeCQ64cCR1AlsgBIt/+E+ikZXoAxQfpToXxAdkDByFokPrMXWCn5lJO3aob4IPC9
        z36Z9v6QNwseZoKzQijnNACMMS49ZhLzk2XDcYON02BJ91Vk8H57BtRPXrvkKkqstc6PZN
        mZybaFYAl8xuTPLUJI0ew3elDa6nTVc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-WoaY_FbxP7KMMm4Qj1_TwQ-1; Fri, 17 Apr 2020 04:29:56 -0400
X-MC-Unique: WoaY_FbxP7KMMm4Qj1_TwQ-1
Received: by mail-wm1-f70.google.com with SMTP id t62so659548wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 01:29:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sq2go4oE4wkjjJo/d/qCXW8H/F2CZmjvC27LSvnbq6k=;
        b=jmdZwcs0YaC0gCntDAor2Er05jUIcTiNucOTaIFrPfGgbjyxzD8bQ7arKhudDd7f9Y
         lgrVkwtTJOcZWDRtAA3IohEzyQZ4g/fvKRqc1LVbPcSqklO31nPA2lpntqT1mP8O4lKe
         tKSaBzMqZ1bUj0EDWHOr1lZaCqPN67honqL7yF7rAI5dWwlW84DabveA3h+B4ATcrFhj
         Tqg0BN3c441zpuLh3T0elTTcpEbo2CxktM6BA4qpYQjEobc4PKcWFxfuMiP0nUJBdbhg
         NLYiA2K9joiAP8c47+BPLn/yXDaFCQwwfO749Pi4sXMD9GTQ8N/pOTBbwlxGdt3Eg9qy
         uhYw==
X-Gm-Message-State: AGi0PuZJLroQY8H0odn7LA+1i9PxlXnO9sq++1GLkMBWmgWRHh7Gcafa
        TuDT+shCzT8uXSy9x841dN5XMn3boMIkPXkkclCx0CzZcNgla7RzdtomAITsS9D7adT69MefbuE
        XQrBGd+2hauV1rxjgQ8FbUhs3
X-Received: by 2002:a05:600c:2214:: with SMTP id z20mr2319810wml.189.1587112195127;
        Fri, 17 Apr 2020 01:29:55 -0700 (PDT)
X-Google-Smtp-Source: APiQypJKNV66xDbZPbEJ9pvldY03mzn5rKaoaGWZw2nM8sRe1qQQQA0lQolXxgIpPJn0ZvUYcb5Wmw==
X-Received: by 2002:a05:600c:2214:: with SMTP id z20mr2319790wml.189.1587112194907;
        Fri, 17 Apr 2020 01:29:54 -0700 (PDT)
Received: from redhat.com (bzq-79-183-51-3.red.bezeqint.net. [79.183.51.3])
        by smtp.gmail.com with ESMTPSA id k133sm7277794wma.0.2020.04.17.01.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 01:29:54 -0700 (PDT)
Date:   Fri, 17 Apr 2020 04:29:50 -0400
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
Message-ID: <20200417042912-mutt-send-email-mst@kernel.org>
References: <20200415024356.23751-1-jasowang@redhat.com>
 <20200416185426-mutt-send-email-mst@kernel.org>
 <b7e2deb7-cb64-b625-aeb4-760c7b28c0c8@redhat.com>
 <20200417022929-mutt-send-email-mst@kernel.org>
 <4274625d-6feb-81b6-5b0a-695229e7c33d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4274625d-6feb-81b6-5b0a-695229e7c33d@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 03:36:52PM +0800, Jason Wang wrote:
> 
> On 2020/4/17 下午2:33, Michael S. Tsirkin wrote:
> > On Fri, Apr 17, 2020 at 11:12:14AM +0800, Jason Wang wrote:
> > > On 2020/4/17 上午6:55, Michael S. Tsirkin wrote:
> > > > On Wed, Apr 15, 2020 at 10:43:56AM +0800, Jason Wang wrote:
> > > > > We try to keep the defconfig untouched after decoupling CONFIG_VHOST
> > > > > out of CONFIG_VIRTUALIZATION in commit 20c384f1ea1a
> > > > > ("vhost: refine vhost and vringh kconfig") by enabling VHOST_MENU by
> > > > > default. Then the defconfigs can keep enabling CONFIG_VHOST_NET
> > > > > without the caring of CONFIG_VHOST.
> > > > > 
> > > > > But this will leave a "CONFIG_VHOST_MENU=y" in all defconfigs and even
> > > > > for the ones that doesn't want vhost. So it actually shifts the
> > > > > burdens to the maintainers of all other to add "CONFIG_VHOST_MENU is
> > > > > not set". So this patch tries to enable CONFIG_VHOST explicitly in
> > > > > defconfigs that enables CONFIG_VHOST_NET and CONFIG_VHOST_VSOCK.
> > > > > 
> > > > > Acked-by: Christian Borntraeger<borntraeger@de.ibm.com>  (s390)
> > > > > Acked-by: Michael Ellerman<mpe@ellerman.id.au>  (powerpc)
> > > > > Cc: Thomas Bogendoerfer<tsbogend@alpha.franken.de>
> > > > > Cc: Benjamin Herrenschmidt<benh@kernel.crashing.org>
> > > > > Cc: Paul Mackerras<paulus@samba.org>
> > > > > Cc: Michael Ellerman<mpe@ellerman.id.au>
> > > > > Cc: Heiko Carstens<heiko.carstens@de.ibm.com>
> > > > > Cc: Vasily Gorbik<gor@linux.ibm.com>
> > > > > Cc: Christian Borntraeger<borntraeger@de.ibm.com>
> > > > > Reported-by: Geert Uytterhoeven<geert@linux-m68k.org>
> > > > > Signed-off-by: Jason Wang<jasowang@redhat.com>
> > > > I rebased this on top of OABI fix since that
> > > > seems more orgent to fix.
> > > > Pushed to my vhost branch pls take a look and
> > > > if possible test.
> > > > Thanks!
> > > 
> > > I test this patch by generating the defconfigs that wants vhost_net or
> > > vhost_vsock. All looks fine.
> > > 
> > > But having CONFIG_VHOST_DPN=y may end up with the similar situation that
> > > this patch want to address.
> > > Maybe we can let CONFIG_VHOST depends on !ARM || AEABI then add another
> > > menuconfig for VHOST_RING and do something similar?
> > > 
> > > Thanks
> > Sorry I don't understand. After this patch CONFIG_VHOST_DPN is just
> > an internal variable for the OABI fix. I kept it separate
> > so it's easy to revert for 5.8. Yes we could squash it into
> > VHOST directly but I don't see how that changes logic at all.
> 
> 
> Sorry for being unclear.
> 
> I meant since it was enabled by default, "CONFIG_VHOST_DPN=y" will be left
> in the defconfigs.

But who cares? That does not add any code, does it?

> This requires the arch maintainers to add
> "CONFIG_VHOST_VDPN is not set". (Geert complains about this)
> 
> Thanks
> 
> 
> > 

