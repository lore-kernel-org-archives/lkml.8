Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E0DC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A020206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z714eEeB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730987AbgIAQ0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:26:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58941 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732080AbgIAQZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598977550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=02QkjKG1ciVZ/SZ1+fSg/UxfgUofnVY9E0gaoJNRSe8=;
        b=Z714eEeB82E3pQf2DqnrmDZ3EjX4Ue8oYMhZs4IKwfnPJcPLd03BuknMy7eGD/xsPyKx9i
        lwVzC8hhtnAmCmvv7LtU0VUzk2nwgO2kHlcCsBuBfjv/4h/ukefxIXVxjlsT5KswF4AsL3
        1WQMH+4rqzugNHDdxP4rXCn3wuxJd4E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-cjBms2HJPkCBZdTT_soHyw-1; Tue, 01 Sep 2020 12:25:46 -0400
X-MC-Unique: cjBms2HJPkCBZdTT_soHyw-1
Received: by mail-wr1-f69.google.com with SMTP id s8so778063wrb.15
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 09:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=02QkjKG1ciVZ/SZ1+fSg/UxfgUofnVY9E0gaoJNRSe8=;
        b=EbUP5qQNYRay2FvnaANF862Q6+NkW7a74xltZeLXDZun8bLnFjo5IZzq1bcw9PGFmg
         Rmv3Jn3JATYL0dXK74X2YQUeJmMIxkHVzANt6xXzAKOGfmBdmM6hZAoQ+/PPLzyq7FgA
         wm6BUQf1xP/G/oVMsBw49jp5mET7QXGMA2ZqbcVwwJys5BMA8SCafttx9nyT2RSIvVdA
         DTJULmCwBQ1MTGS2bVl91G1Rp59IjpDSHD9P075ByxpO/DGT3QI/jRKSbAzRO87j4fk0
         EUGxET+IrvtP5YaWHrg8l2SNoR5WiQKDSHq5rt+/a8ulQayXA40/nJfAlTlQGt3eCC+H
         rfdQ==
X-Gm-Message-State: AOAM531E/8OFMryBpTJn6EyHN0VzdxlBwkkioealgcD9cf5kxN4qFa5P
        cgEtseJ6CrkoLOO6ckMo7H67iD97sygHKPb56A9xfMrVo/Uy+brv5V+9GuO/T5gjLkgk9vlT99D
        SJfKTByRBbbuCR+XWDQu0yuow
X-Received: by 2002:adf:e8c3:: with SMTP id k3mr2794206wrn.228.1598977544777;
        Tue, 01 Sep 2020 09:25:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZBwMu9jEZcrJ5aoeYibQLoi7inHjh994XlsUOFj/MJ/rDb4MiJy+fC4tFpUaP66vXk9YJmg==
X-Received: by 2002:adf:e8c3:: with SMTP id k3mr2794187wrn.228.1598977544552;
        Tue, 01 Sep 2020 09:25:44 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id d11sm3116525wrw.77.2020.09.01.09.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 09:25:43 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Rustam Kovhaev <rkovhaev@gmail.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: fix memory leak in kvm_io_bus_unregister_dev()
In-Reply-To: <20200830043405.268044-1-rkovhaev@gmail.com>
References: <20200830043405.268044-1-rkovhaev@gmail.com>
Date:   Tue, 01 Sep 2020 18:25:42 +0200
Message-ID: <877dtdwjjt.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rustam Kovhaev <rkovhaev@gmail.com> writes:

> when kmalloc() fails in kvm_io_bus_unregister_dev(), before removing
> the bus, we should iterate over all other devices linked to it and call
> kvm_iodevice_destructor() for them
>
> Reported-and-tested-by: syzbot+f196caa45793d6374707@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=f196caa45793d6374707
> Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>
> ---
>  virt/kvm/kvm_main.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 67cd0b88a6b6..646aa7b82548 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -4332,7 +4332,7 @@ int kvm_io_bus_register_dev(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
>  void kvm_io_bus_unregister_dev(struct kvm *kvm, enum kvm_bus bus_idx,
>  			       struct kvm_io_device *dev)
>  {
> -	int i;
> +	int i, j;
>  	struct kvm_io_bus *new_bus, *bus;
>  
>  	bus = kvm_get_bus(kvm, bus_idx);
> @@ -4351,6 +4351,11 @@ void kvm_io_bus_unregister_dev(struct kvm *kvm, enum kvm_bus bus_idx,
>  			  GFP_KERNEL_ACCOUNT);
>  	if (!new_bus)  {
                     ^^^ redundant space 

>  		pr_err("kvm: failed to shrink bus, removing it completely\n");
> +		for (j = 0; j < bus->dev_count; j++) {
> +			if (j == i)
> +				continue;
> +			kvm_iodevice_destructor(bus->range[j].dev);
> +		}
>  		goto broken;

The name of the label is really misleading (as it is not actually a
failure path), I'd even suggest we get rid of this goto completely,
something like

	new_bus = kmalloc(struct_size(bus, range, bus->dev_count - 1),
			  GFP_KERNEL_ACCOUNT);
	if (new_bus)  {
	       memcpy(new_bus, bus, sizeof(*bus) + i * sizeof(struct kvm_io_range));
	       new_bus->dev_count--;
	       memcpy(new_bus->range + i, bus->range + i + 1,
	              (new_bus->dev_count - i) * sizeof(struct kvm_io_range));
        } else {
		pr_err("kvm: failed to shrink bus, removing it completely\n");
		for (j = 0; j < bus->dev_count; j++) {
			if (j == i)
				continue;
			kvm_iodevice_destructor(bus->range[j].dev);
	}

	rcu_assign_pointer(kvm->buses[bus_idx], new_bus);
	synchronize_srcu_expedited(&kvm->srcu);
	kfree(bus);
	return;


>  	}

None of the above should block the fix IMO, so:

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

