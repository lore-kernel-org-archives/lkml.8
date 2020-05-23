Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE3AC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 19:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65F562073B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 19:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGBvsA05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387593AbgEWTeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 15:34:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27714 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727918AbgEWTeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 15:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590262462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZwVeospWQzWBd2Ckz6qsa+cBIBayXfsa3U5rcqOkNSc=;
        b=hGBvsA05+/RATfO0md7Bm9LDTyR3azhsdHRSQPMlBDjP1KkcoNzoUNg/0P9TDANFqOkvzk
        aXhY4rlqE7Tr9+2q/8U/ZupVNt7+tIIy8AIj86waJjniBDGF1Vl4AzRq+RnUGYm0Idg1TJ
        iIfkZtPQAYsZDG/0AhSHno/fikS/gok=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-0zSs8ditNRmF3q3UmKZuhg-1; Sat, 23 May 2020 15:34:20 -0400
X-MC-Unique: 0zSs8ditNRmF3q3UmKZuhg-1
Received: by mail-qk1-f200.google.com with SMTP id p126so14474816qke.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 12:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZwVeospWQzWBd2Ckz6qsa+cBIBayXfsa3U5rcqOkNSc=;
        b=fOUnFaq0GVhnquJL5MdRmjcVedCAWzAA9l2FfCTD01RLr7PEP5iiu5KUL+F8ipgGSg
         /FAONj9j/acaK5XOLa/Xm8je41Az96zptolUBbLdT2PSMIdLzww08da6Fxp4jqVwU4xD
         SbL2q+pdQc/BVzLZTyf/7tVjdwHyuk5hlWAoj/30lNXikbX9DTdn1QeapiNOIpurINh/
         ogVVNfsZGyo5nH+xkf5/iY/XBU5maRVoJj/hLpfDv/PWiSIaiekgNjJgtJbPOzVjxVsB
         DVnmtdqLH2gpr7OUifQYQxg3c8PW8PAkEU00FVjhbwvFxqUbq2pKScz+S86Mg1WC4nti
         piyQ==
X-Gm-Message-State: AOAM532Hm0lqY6tHEYYT90CM00TOLZM6BOBOlFVmJyDWMQJIsU5tslkC
        v3WXJ89TLBqttRLIVC6awU0PnTMGOn7kIdOYIgxLKEtqu5cp4rXmQRbMSGc+950w1uxnMW6XlDl
        hebkPAKPWlrqfwO8aI5pGOWZK
X-Received: by 2002:a37:490:: with SMTP id 138mr20187715qke.199.1590262460144;
        Sat, 23 May 2020 12:34:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXoWZIY0o5CFf8fx4b1C6Zs4/6XKmwWKD3ydRMLJhK+DLPOyxQZBXyhKbfchOrVAsReukLiA==
X-Received: by 2002:a37:490:: with SMTP id 138mr20187698qke.199.1590262459865;
        Sat, 23 May 2020 12:34:19 -0700 (PDT)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca. [72.137.123.47])
        by smtp.gmail.com with ESMTPSA id s45sm725970qte.26.2020.05.23.12.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 12:34:18 -0700 (PDT)
Date:   Sat, 23 May 2020 15:34:17 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, jgg@ziepe.ca, cai@lca.pw
Subject: Re: [PATCH v3 3/3] vfio-pci: Invalidate mmaps and block MMIO access
 on disabled memory
Message-ID: <20200523193417.GI766834@xz-x1>
References: <159017449210.18853.15037950701494323009.stgit@gimli.home>
 <159017506369.18853.17306023099999811263.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <159017506369.18853.17306023099999811263.stgit@gimli.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Alex,

On Fri, May 22, 2020 at 01:17:43PM -0600, Alex Williamson wrote:
> @@ -1346,15 +1526,32 @@ static vm_fault_t vfio_pci_mmap_fault(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct vfio_pci_device *vdev = vma->vm_private_data;
> +	vm_fault_t ret = VM_FAULT_NOPAGE;
> +
> +	mutex_lock(&vdev->vma_lock);
> +	down_read(&vdev->memory_lock);

I remembered to have seen the fault() handling FAULT_FLAG_RETRY_NOWAIT at least
in the very first version, but it's not here any more...  Could I ask what's
the reason behind?  I probably have missed something along with the versions,
I'm just not sure whether e.g. this would potentially block a GUP caller even
if it's with FOLL_NOWAIT.

Side note: Another thing I thought about when reading this patch - there seems
to have quite some possibility that the VFIO_DEVICE_PCI_HOT_RESET ioctl will
start to return -EBUSY now.  Not a problem for this series, but maybe we should
rememeber to let the userspace handle -EBUSY properly as follow up too, since I
saw QEMU seemed to not handle -EBUSY for host reset path right now.

Thanks,

-- 
Peter Xu

