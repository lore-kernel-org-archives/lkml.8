Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B056FC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 726412084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="doh02yXU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbgIDMEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 08:04:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39170 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730072AbgIDMEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 08:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599221070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bQF8TpzTrCZC/4WmcQgFOGP42L/HwxRy8XdEsjYv2Fc=;
        b=doh02yXUgHemxJoeYk2mN0/BShd7PkZO4NbSsNsXaOb5RN6VzVZRG6mNoEQWz76/fjUssJ
        Y2nWxYx2sPH2u0mlw8eeP4thgFxXekztsI1GL0iMB6nV4jbuM6bO9jSWSL66DYWVI8zuDt
        X7y9sxRMgjmV4qkx+JwJ1TJgqkc671w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-M35yCAC6M0-RDdpgjQVDPw-1; Fri, 04 Sep 2020 08:04:26 -0400
X-MC-Unique: M35yCAC6M0-RDdpgjQVDPw-1
Received: by mail-wr1-f70.google.com with SMTP id g6so2259484wrv.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 05:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=bQF8TpzTrCZC/4WmcQgFOGP42L/HwxRy8XdEsjYv2Fc=;
        b=jm2PFDTN6R6nM6w3AGLZ+PztPFqtk/47zj9tnkayyuXPGKCApqshcbFo55d/J+a/+T
         OYeWBHsPf4PeWSAI8R2JcjyZ7ubzEYHtTbNtQW3fwdljWSsLPlM55Zfytl1XlnfhpLjn
         jQzEFe6hlRfgV6omKMxPub0AoaJIjACouatnInGzWmwzNICS99WtytsnrXm3fA7o6Mmw
         baUUt6++4eChjdkDV1FLIfA0xjw+q1Msx1DK7+RTie9si3sRyVoJrIH06Y8pCsuvMNrg
         9VgXI+zIBxgVook0Re/zwBgf5BiiNcH78Z/RCzcQK+snKMnNTGtyVFyWpIkOuBp0p4dt
         D7nQ==
X-Gm-Message-State: AOAM5309sDdU/yEkVuQpNX/QaL5WyMc191X2yXpg4rmwA3W6/+i6PRJn
        NPE40uiYses3q/nvilEC2O08VWByRv568H1Ow1atKu8Fx83wUMQDsYS+1cCftDeIbcr42yrtU2a
        If0RacPRufIcQgI5J6rw7NK7o
X-Received: by 2002:a5d:4d82:: with SMTP id b2mr6979447wru.232.1599221065157;
        Fri, 04 Sep 2020 05:04:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6OmnqNpUehNDaSAUtieUjPCVL0IZ0+JGfXCMfKMxtkU9JZrgh+p5tgHXEK/+WuQHYKUUK6g==
X-Received: by 2002:a5d:4d82:: with SMTP id b2mr6979430wru.232.1599221064895;
        Fri, 04 Sep 2020 05:04:24 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id l19sm10783595wmi.8.2020.09.04.05.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 05:04:24 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Rustam Kovhaev <rkovhaev@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v2] KVM: fix memory leak in kvm_io_bus_unregister_dev()
In-Reply-To: <20200903172215.GA870347@thinkpad>
References: <20200902225718.675314-1-rkovhaev@gmail.com> <c5990c86-ab01-d748-5505-375f50a4ed7d@embeddedor.com> <20200903172215.GA870347@thinkpad>
Date:   Fri, 04 Sep 2020 14:04:23 +0200
Message-ID: <87ft7xoiig.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rustam Kovhaev <rkovhaev@gmail.com> writes:

> On Wed, Sep 02, 2020 at 06:34:11PM -0500, Gustavo A. R. Silva wrote:
>> Hi,
>> 
>> On 9/2/20 17:57, Rustam Kovhaev wrote:
>> > when kmalloc() fails in kvm_io_bus_unregister_dev(), before removing
>> > the bus, we should iterate over all other devices linked to it and call
>> > kvm_iodevice_destructor() for them
>> > 
>> > Reported-and-tested-by: syzbot+f196caa45793d6374707@syzkaller.appspotmail.com
>> > Link: https://syzkaller.appspot.com/bug?extid=f196caa45793d6374707
>> > Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>
>> > Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> 
>> I think it's worthwhile to add a Fixes tag for this, too.
>> 
>> Please, see more comments below...
>> 
>> > ---
>> > v2:
>> > - remove redundant whitespace
>> > - remove goto statement and use if/else
>> > ---
>> >  virt/kvm/kvm_main.c | 21 ++++++++++++---------
>> >  1 file changed, 12 insertions(+), 9 deletions(-)
>> > 
>> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> > index 67cd0b88a6b6..cf88233b819a 100644
>> > --- a/virt/kvm/kvm_main.c
>> > +++ b/virt/kvm/kvm_main.c
>> > @@ -4332,7 +4332,7 @@ int kvm_io_bus_register_dev(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
>> >  void kvm_io_bus_unregister_dev(struct kvm *kvm, enum kvm_bus bus_idx,
>> >  			       struct kvm_io_device *dev)
>> >  {
>> > -	int i;
>> > +	int i, j;
>> >  	struct kvm_io_bus *new_bus, *bus;
>> >  
>> >  	bus = kvm_get_bus(kvm, bus_idx);
>> > @@ -4349,17 +4349,20 @@ void kvm_io_bus_unregister_dev(struct kvm *kvm, enum kvm_bus bus_idx,
>> >  
>> >  	new_bus = kmalloc(struct_size(bus, range, bus->dev_count - 1),
>> >  			  GFP_KERNEL_ACCOUNT);
>> > -	if (!new_bus)  {
>> > +	if (new_bus) {
>> > +		memcpy(new_bus, bus, sizeof(*bus) + i * sizeof(struct kvm_io_range));
>> 
>> 				    ^^^
>> It seems that you can use struct_size() here (see the allocation code above)...
>> 
>> > +		new_bus->dev_count--;
>> > +		memcpy(new_bus->range + i, bus->range + i + 1,
>> > +		       (new_bus->dev_count - i) * sizeof(struct kvm_io_range));
>> 
>> 					   ^^^
>> ...and, if possible, you can also use flex_array_size() here.
>> 
>> Thanks
>> --
>> Gustavo
>> 
>> > +	} else {
>> >  		pr_err("kvm: failed to shrink bus, removing it completely\n");
>> > -		goto broken;
>> > +		for (j = 0; j < bus->dev_count; j++) {
>> > +			if (j == i)
>> > +				continue;
>> > +			kvm_iodevice_destructor(bus->range[j].dev);
>> > +		}
>> >  	}
>> >  
>> > -	memcpy(new_bus, bus, sizeof(*bus) + i * sizeof(struct kvm_io_range));
>> > -	new_bus->dev_count--;
>> > -	memcpy(new_bus->range + i, bus->range + i + 1,
>> > -	       (new_bus->dev_count - i) * sizeof(struct kvm_io_range));
>> > -
>> > -broken:
>> >  	rcu_assign_pointer(kvm->buses[bus_idx], new_bus);
>> >  	synchronize_srcu_expedited(&kvm->srcu);
>> >  	kfree(bus);
>> > 
>
> hi Gustavo, thank you for the review, i'll send the new patch.
> Vitaly, i think i will need to drop your "Reviewed-by", because there is
> going to be a bit more changes
>

Personally, I'd prefer to make struct_size()/flex_array_size() a
separate preparatory patch so the real fix is small but I don't have a
strong opinion. I'll take look at v3 so feel free to drop R-b if you
decide to make a combined patch and feel free to keep it if you make the
preparatory changes separate :-)

-- 
Vitaly

