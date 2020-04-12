Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139A4C2BB85
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 08:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB24320709
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 08:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OtU/Gxc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgDLIiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 04:38:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35708 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725873AbgDLIiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 04:38:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586680683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pa4kCZZR1TWcPuT6bVou7G+wE1hyHACGM2NIHCRQaQs=;
        b=OtU/Gxc4X7CoqrWOxPMKPDLMtKcg7VxJKKL3s3YoTBZ9XuMke0hJ5kAR6Y6U1m34FEg41a
        CWGcuJHpLX2xQbVDypQHp74uL9ZrfCIU+cNz1QeSTSRB+VeYnMYopb+agYQneknVZ8EbhU
        F1CrlIlI9mMXc7naJjPhmP5CfW7vXVs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-UrFoEcOROFO4X1NKHP5chA-1; Sun, 12 Apr 2020 04:38:02 -0400
X-MC-Unique: UrFoEcOROFO4X1NKHP5chA-1
Received: by mail-wr1-f72.google.com with SMTP id r11so3608087wrx.21
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 01:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pa4kCZZR1TWcPuT6bVou7G+wE1hyHACGM2NIHCRQaQs=;
        b=Zh892v3clnthxq8Y7rHAqZjG2fZ1MY9wcy4OhR+f/6Mofa2Qln5T4tnZENIjn58J2E
         zYjT8P4i8YFoPWlGUzjCCPOBvdHBSMSGQjnsxPLhnQ3vGk5CorotozKThUpKVE2ALEMu
         iO6ZETIbk31iFRKgp7hONvpzy1oDChuf1ytTegQn0byV1QLT6ONxvQqmihlLWHvBHsDc
         ic3nmCE2dlH9dsJ8CRpQTpUR+41sVq3Hwt5iq8Rs/5D92iZYi9iEqt3AR+vphkUT5XCd
         g5rZ9KkbQTeK4wEkk/KmVY2UO7agRwKqDMGTTMchvw5BMD/vfscZt2wra3PJPhkjK1/v
         XBig==
X-Gm-Message-State: AGi0PuZoapRTPE3MXaeb2kKJj3XAOi1SmI8Gz6/+9h4vNH37WwwtGrws
        i+c52uG6iztH+OCoZH1Gyko8ht29yZ2PG5ysRNjA1cHoCfBn5SgSgc7nAXsYHd8QYSb5atQy71J
        gx6AU91m6MHYYjUOdqvhE3Thy
X-Received: by 2002:a1c:c90a:: with SMTP id f10mr12983096wmb.179.1586680680915;
        Sun, 12 Apr 2020 01:38:00 -0700 (PDT)
X-Google-Smtp-Source: APiQypJpGQcwg9BNxwrWgtjJoNNurdp47wD0GtLgDgtuiAQDaLS5bakxHQGpI2dtKfuzN5LGIim6Aw==
X-Received: by 2002:a1c:c90a:: with SMTP id f10mr12983074wmb.179.1586680680653;
        Sun, 12 Apr 2020 01:38:00 -0700 (PDT)
Received: from redhat.com (bzq-79-183-51-3.red.bezeqint.net. [79.183.51.3])
        by smtp.gmail.com with ESMTPSA id y5sm10563354wru.15.2020.04.12.01.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2020 01:37:59 -0700 (PDT)
Date:   Sun, 12 Apr 2020 04:37:55 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     KVM list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, eperezma@redhat.com,
        "Cc: stable@vger.kernel.org, david@redhat.com, dverkamp@chromium.org,
        hch@lst.de, jasowang@redhat.com, liang.z.li@intel.com, mst@redhat.com,
        tiny.windzz@gmail.com," <jasowang@redhat.com>,
        lingshan.zhu@intel.com, Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        David Rientjes <rientjes@google.com>, tiwei.bie@intel.com,
        tysand@google.com,
        "Cc: stable@vger.kernel.org, david@redhat.com, dverkamp@chromium.org,
        hch@lst.de, jasowang@redhat.com, liang.z.li@intel.com, mst@redhat.com,
        tiny.windzz@gmail.com," <wei.w.wang@intel.com>,
        xiao.w.wang@intel.com, yuri.benditovich@daynix.com
Subject: Re: [GIT PULL] vhost: fixes, vdpa
Message-ID: <20200412041730-mutt-send-email-mst@kernel.org>
References: <20200406171124-mutt-send-email-mst@kernel.org>
 <CAHk-=wg7sMywb2V8gifhpUDE=DWQTvg1wDieKVc0UoOSsOrynw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg7sMywb2V8gifhpUDE=DWQTvg1wDieKVc0UoOSsOrynw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 11, 2020 at 09:38:05AM -0700, Linus Torvalds wrote:
> On Mon, Apr 6, 2020 at 2:11 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > The new vdpa subsystem with two first drivers.
> 
> So this one is really annoying to configure.
> 
> First it asks for vDPA driver for virtio devices (VIRTIO_VDPA) support.
> 
> If you say 'n', it then asks *again* for VDPA drivers (VDPA_MENU).
> 
> And then when you say 'n' to *that* it asks you for Vhost driver for
> vDPA-based backend (VHOST_VDPA).
> 
> This kind of crazy needs to stop.
> 
> Doing kernel configuration is not supposed to be like some truly
> horrendously boring Colossal Cave Adventure game where you have to
> search for a way out of maze of twisty little passages, all alike.
> 
>                 Linus

Hmm it's a good point.  Thanks, Linus!
I think this was copied from virtio which has drivers spread all over
the tree.

Jason, if VDPA_MENU is off, then we don't have any drivers. So what's
the point of selecting VDPA core from vhost/virtio then?

So how about this? Lightly tested. Jason, could you pls play with this
a bit more and let me know if you see any issues?

-->
vdpa: make vhost, virtio depend on menu

If user did not configure any vdpa drivers, neither vhost
nor virtio vdpa are going to be useful. So there's no point
in prompting for these and selecting vdpa core automatically.
Simplify configuration by making virtio and vhost vdpa
drivers depend on vdpa menu entry. Once done, we no longer
need a separate menu entry, so also get rid of this.
While at it, fix up the IFC entry: VDPA->vDPA for consistency
with other places.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
index cb6b17323eb2..3b43411361fe 100644
--- a/drivers/vhost/Kconfig
+++ b/drivers/vhost/Kconfig
@@ -64,7 +64,7 @@ config VHOST_VDPA
 	tristate "Vhost driver for vDPA-based backend"
 	depends on EVENTFD
 	select VHOST
-	select VDPA
+	depends on VDPA_MENU
 	help
 	  This kernel module can be loaded in host kernel to accelerate
 	  guest virtio devices with the vDPA-based backends.
diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 2aadf398d8cc..bf13755a5ba5 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -45,7 +45,7 @@ config VIRTIO_PCI_LEGACY
 
 config VIRTIO_VDPA
 	tristate "vDPA driver for virtio devices"
-	select VDPA
+	depend on VDPA_MENU
 	select VIRTIO
 	help
 	  This driver provides support for virtio based paravirtual

