Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E77C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C10220675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJOd8BTu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387573AbgBMP7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:59:52 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25656 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728910AbgBMP7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581609585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YjESY5U+42gtKNpvEnDRTyHV+mXqJmvUAfYgrE7ny0Y=;
        b=JJOd8BTu72GcaOVKXV8mvXtCFIZQg9e3xZJGBi7qInkef1najIbQPVShs3JG+ORIZilHhu
        q1N/7l/vz0F4AUG4cmUH9sljAHHptH/eWaJ6oSZRJ6drYwg1g9uOwQb7pimR6zJahasDpG
        4aBEa6ramsDP5AsV8jiv6lUMfhhApw0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-jRvZCEz6MbOoYDZXPV1WAg-1; Thu, 13 Feb 2020 10:59:42 -0500
X-MC-Unique: jRvZCEz6MbOoYDZXPV1WAg-1
Received: by mail-qk1-f198.google.com with SMTP id q2so3992404qkq.19
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 07:59:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YjESY5U+42gtKNpvEnDRTyHV+mXqJmvUAfYgrE7ny0Y=;
        b=d1OVUgNj4RuXCUzoH/foMW5DLfOh/FhIeOBiFSrtbjcw3hQix4edJJ+VDr6Q0mHLQN
         Y9VKCByAYy0V56vuf0ZwDrscXvGl8FhA2QitBuZ8ZSk5D4vJhEHKvdCeYUy3ufjMIq66
         CyCAaQfZI47oidff5vF1I8Z96NuWxEYHuoHkIKhN6Te5XX1gUyoJZ45r94PokKRJks7R
         UmVqPo3PKRgSUDqOvHFHQYwa/Lj+cGG7snkD76MZlG/r6tpMglmfUGPU38tltMXk/z/J
         46qXtHcPxVwNhMDhekXFWUjd0GrkEfJxHCUjeS6n6+S9Iv0qk5jSkAHh/f5N3EpoarJz
         VQgA==
X-Gm-Message-State: APjAAAVUzJrygd5S684tJ4IOtBy/jly1QDwWQnqQerk11CzyoZ7162fZ
        jUBcfWWMC/mrPhmW8hKP4QwyPePJwfbvfYu2xc8GlXViaE/guzUFCSHYYNzzzZO0uSbYXAlqnWo
        DC20AhmIE5b51LzVxXHVNybve
X-Received: by 2002:a37:648c:: with SMTP id y134mr12655812qkb.112.1581609582441;
        Thu, 13 Feb 2020 07:59:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqwblUv4o0toVmVYl/HEAfrRzni+p8oGrxwrOCdC64VBDuyyCDEhJs814GPsgJHzOlkKNS9BGQ==
X-Received: by 2002:a37:648c:: with SMTP id y134mr12655792qkb.112.1581609582252;
        Thu, 13 Feb 2020 07:59:42 -0800 (PST)
Received: from redhat.com (bzq-79-176-28-95.red.bezeqint.net. [79.176.28.95])
        by smtp.gmail.com with ESMTPSA id b7sm1490925qka.67.2020.02.13.07.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 07:59:41 -0800 (PST)
Date:   Thu, 13 Feb 2020 10:59:34 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, tiwei.bie@intel.com,
        maxime.coquelin@redhat.com, cunming.liang@intel.com,
        zhihong.wang@intel.com, rob.miller@broadcom.com,
        xiao.w.wang@intel.com, haotian.wang@sifive.com,
        lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com,
        parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com,
        rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com,
        jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com,
        mhabets@solarflare.com
Subject: Re: [PATCH V2 3/5] vDPA: introduce vDPA bus
Message-ID: <20200213105743-mutt-send-email-mst@kernel.org>
References: <20200210035608.10002-4-jasowang@redhat.com>
 <20200211134746.GI4271@mellanox.com>
 <cf7abcc9-f8ef-1fe2-248e-9b9028788ade@redhat.com>
 <20200212125108.GS4271@mellanox.com>
 <12775659-1589-39e4-e344-b7a2c792b0f3@redhat.com>
 <20200213134128.GV4271@mellanox.com>
 <ebaea825-5432-65e2-2ab3-720a8c4030e7@redhat.com>
 <20200213150542.GW4271@mellanox.com>
 <20200213103714-mutt-send-email-mst@kernel.org>
 <20200213155154.GX4271@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213155154.GX4271@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 11:51:54AM -0400, Jason Gunthorpe wrote:
> The 'class' is supposed to provide all the library functions to remove
> this duplication. Instead of plugging the HW driver in via some bus
> scheme every subsystem has its own 'ops' that the HW driver provides
> to the subsystem's class via subsystem_register()

Hmm I'm not familiar with subsystem_register. A grep didn't find it
in the kernel either ...

-- 
MST

