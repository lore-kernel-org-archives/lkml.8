Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC02C2BA14
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274E52078E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QpMmA0a3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387765AbgDBIRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 04:17:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41110 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387661AbgDBIRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585815460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qrXk8LVQd/CXKhg1TsCqsO3eX0JuDNOSoaTAXR1nr78=;
        b=QpMmA0a3ViOskkEX0qZIgwy8adP+b9m+zeWJh/ydJdfeKttDVaiTaJRwHWlV1mP4y2qUMh
        WUxGpVWMYOZ0Cr4Y/7xsFnjDcDe7GwnXXk/TG9ayptY9Noy0VAOzOMkOOzScuuraVFiwnk
        MUoJInVYyAfngKi5LtONidV9kUhWE6E=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-oE_NL-NoPdKG6EivgrLtkw-1; Thu, 02 Apr 2020 04:17:39 -0400
X-MC-Unique: oE_NL-NoPdKG6EivgrLtkw-1
Received: by mail-qt1-f200.google.com with SMTP id g25so2495104qts.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 01:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qrXk8LVQd/CXKhg1TsCqsO3eX0JuDNOSoaTAXR1nr78=;
        b=Yiv64t+u0xKoXYfxAhMQItsoFeaG92IrAM4mVhNpug75KX30Ul15XwtpODX+3ijK6V
         dp/PpppHUZ67/joHEaGoJkEbmzN1MVT6Q5xoiIGAVg/Yh/rRJtPS9BpHZubdCXzp7K8m
         hQhS8HKEgK7CC3kPVefPmhLpaDixdQjBkrjIQCd8BtfFPyYkZ/uvIPrwKcCUlL+ksia5
         pHTIqZ6RD/3PHP0vtd2eyJMz57u0qEC+PVBNWlB0SsqQB3J/nbMpDYFJ1T0aRGe4V+OM
         RLzrRDRcs9rXqS2LwX3Eq+daX0b7MFsPPST8xBeZGmeCEFVuaPnD+DoJ3MXFzuNE60Oj
         uS1Q==
X-Gm-Message-State: AGi0PuYvAZ+9ryXwLCKulNE1XAKsemFaXfYthuwQZxC7Ow1R13YqJTZc
        f46HLPzrq0Q3fiOB58Kl3w8rr2QHU3KDxJiRBEOrG8jde+ciaSFW6H9Sp96hT1G8/+nHx5UYCpZ
        M43HANZo4woZaKYD5eSd5fLrCQaKCnd0XUB2a1xLX
X-Received: by 2002:ac8:740b:: with SMTP id p11mr1626583qtq.379.1585815457648;
        Thu, 02 Apr 2020 01:17:37 -0700 (PDT)
X-Google-Smtp-Source: APiQypIWKQ0r7BLw/mXFg9PX+PpdHbG2jGnLDwo9XSxTQBg5Q2ggffGwidECmAS47ycvsUD64mF34zIwUE9GnhztrQo=
X-Received: by 2002:ac8:740b:: with SMTP id p11mr1626573qtq.379.1585815457383;
 Thu, 02 Apr 2020 01:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200331192804.6019-1-eperezma@redhat.com> <c4d2b0b4-0b6d-cd74-0eb5-e7fdfe063d42@de.ibm.com>
 <CAJaqyWc+fNzHE_p-pApZtj2ypNQfFLawCWf8GJmP8e=k=C+EgA@mail.gmail.com>
 <916e60f8-45fe-5cc1-d5a1-defdcd00d75b@de.ibm.com> <6d16572f-34e9-4806-a5f8-94d8f75db352@de.ibm.com>
In-Reply-To: <6d16572f-34e9-4806-a5f8-94d8f75db352@de.ibm.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Thu, 2 Apr 2020 10:17:01 +0200
Message-ID: <CAJaqyWdwqdyfY_ZrWXEGogoUKajEPpT3FdsDMdEUCZ0tt4Dh9w@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] vhost: Reset batched descriptors on SET_VRING_BASE call
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kvm list <kvm@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 9:13 PM Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
> >> Would it be possible to investigate when qemu launches the offending ioctls?
> >
> > During guest reboot. This is obvious, no?
> >
>

Got it. I thought you received it after the reboot AND once you sent
the firsts packets, since you said that some pings worked. But now
that this point is clear, I think we can move forward :). Thank you
very much!


>
> For example during reboot we do re-setup the virt queues:
>
> #1  0x00000000010f3e7a in vhost_kernel_set_vring_base (dev=0x21f5f30, ring=0x3ff84d74e88) at /home/cborntra/REPOS/qemu/hw/virtio/vhost-backend.c:126
> #2  0x00000000010f2f92 in vhost_virtqueue_start (idx=0, vq=0x21f6180, vdev=0x241d570, dev=0x21f5f30) at /home/cborntra/REPOS/qemu/hw/virtio/vhost.c:1016
> #3  vhost_dev_start (hdev=hdev@entry=0x21f5f30, vdev=vdev@entry=0x241d570) at /home/cborntra/REPOS/qemu/hw/virtio/vhost.c:1646
> #4  0x00000000011c265a in vhost_net_start_one (dev=0x241d570, net=0x21f5f30) at /home/cborntra/REPOS/qemu/hw/net/vhost_net.c:236
> #5  vhost_net_start (dev=dev@entry=0x241d570, ncs=0x2450f40, total_queues=total_queues@entry=1) at /home/cborntra/REPOS/qemu/hw/net/vhost_net.c:338
> #6  0x00000000010cfdfe in virtio_net_vhost_status (status=15 '\017', n=0x241d570) at /home/cborntra/REPOS/qemu/hw/net/virtio-net.c:250
> #7  virtio_net_set_status (vdev=0x241d570, status=<optimized out>) at /home/cborntra/REPOS/qemu/hw/net/virtio-net.c:331
> #8  0x00000000010eaef4 in virtio_set_status (vdev=vdev@entry=0x241d570, val=<optimized out>) at /home/cborntra/REPOS/qemu/hw/virtio/virtio.c:1956
> #9  0x000000000110ba78 in virtio_ccw_cb (sch=0x2422c30, ccw=...) at /home/cborntra/REPOS/qemu/hw/s390x/virtio-ccw.c:509
> #10 0x00000000011053fc in css_interpret_ccw (sch=sch@entry=0x2422c30, ccw_addr=<optimized out>, suspend_allowed=suspend_allowed@entry=false) at /home/cborntra/REPOS/qemu/hw/s390x/css.c:1108
> #11 0x000000000110557c in sch_handle_start_func_virtual (sch=0x2422c30) at /home/cborntra/REPOS/qemu/hw/s390x/css.c:1162
> #12 do_subchannel_work_virtual (sch=0x2422c30) at /home/cborntra/REPOS/qemu/hw/s390x/css.c:1256
> #13 0x0000000001168592 in ioinst_handle_ssch (cpu=cpu@entry=0x234b920, reg1=<optimized out>, ipb=<optimized out>, ra=ra@entry=0) at /home/cborntra/REPOS/qemu/target/s390x/ioinst.c:218
> #14 0x0000000001170012 in handle_b2 (ipa1=<optimized out>, run=0x3ff97880000, cpu=0x234b920) at /home/cborntra/REPOS/qemu/target/s390x/kvm.c:1279
> #15 handle_instruction (run=0x3ff97880000, cpu=0x234b920) at /home/cborntra/REPOS/qemu/target/s390x/kvm.c:1664
> #16 handle_intercept (cpu=0x234b920) at /home/cborntra/REPOS/qemu/target/s390x/kvm.c:1747
> #17 kvm_arch_handle_exit (cs=cs@entry=0x234b920, run=run@entry=0x3ff97880000) at /home/cborntra/REPOS/qemu/target/s390x/kvm.c:1937
> #18 0x00000000010972dc in kvm_cpu_exec (cpu=cpu@entry=0x234b920) at /home/cborntra/REPOS/qemu/accel/kvm/kvm-all.c:2445
> #19 0x00000000010784f6 in qemu_kvm_cpu_thread_fn (arg=0x234b920) at /home/cborntra/REPOS/qemu/cpus.c:1246
> #20 qemu_kvm_cpu_thread_fn (arg=arg@entry=0x234b920) at /home/cborntra/REPOS/qemu/cpus.c:1218
> #21 0x00000000013891fa in qemu_thread_start (args=0x2372f30) at /home/cborntra/REPOS/qemu/util/qemu-thread-posix.c:519
> #22 0x000003ff93809ed6 in start_thread () from target:/lib64/libpthread.so.0
> #23 0x000003ff93705e46 in thread_start () from target:/lib64/libc.so.6
>

