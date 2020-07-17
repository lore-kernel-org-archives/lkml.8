Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA497C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B67722074B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ANuGBtdK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgGQTEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 15:04:16 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52768 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727821AbgGQTEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 15:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595012654;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VKQ3UPhST3OvzdKUW3dae3IGuD+EOft4yvMH2GzGai4=;
        b=ANuGBtdKw2VZjmvzvIePyyMeK/+DxxVu7KPI4ecH/ygLCOUkB5XgfXa0y7Dr2O4UAeJYo9
        qLAaXnQvqvqS/R/uYUlYHmsW61AdLc9mACN/UNtpVCmR13HeipREUa7BsivQDGpvL3BRUV
        /zPKCSG7G6nNSMy9jAc3I7el4butJD8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-iH3o28nQMJWax7GB-1EH9g-1; Fri, 17 Jul 2020 15:04:13 -0400
X-MC-Unique: iH3o28nQMJWax7GB-1EH9g-1
Received: by mail-qk1-f197.google.com with SMTP id u186so6673736qka.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 12:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=VKQ3UPhST3OvzdKUW3dae3IGuD+EOft4yvMH2GzGai4=;
        b=A5Imb77u+0+DWFYtinoNIEk7TDNtfQrqpl73H30PT1AfrgYEmO3HupdMQOrObxPbWy
         C/fQGW062gmqyltkIS8ayOD6F3VIbhm4nbhgJtlGI2u6uS1P4iKyZFHTWze55UH0baHm
         LiUEUbTkE1GHhVK+MmzX1RJFHuXgL5qU5rBIKj0TBc1oNZXl70y6L2QRMT/ttZ+HGK7E
         tHkq9Xp20E6tcP5xtEJxHB5mrkKZrxyAs6THPu3z92HmsldZ0ZqV4FLhiwDkbWndzMi8
         455LmTaCeujFl1KeHAYdmYBU6MY6b2UZ+lv7IBlSCxzUVJZhiK0CFKBWguH8M0uPTKJs
         xdng==
X-Gm-Message-State: AOAM531496tzPGc9A6aguRLTz87tzn5kJmnAlyCCnnh6szmR7eDz7mcF
        xdBbPsGpzUTKAg9z5K+bp9DMBe1oXzP8OIPfp5ZCFNJ6DcwciG57WcM3NLpdy6hLaPKbZPA7tS5
        paQVht+gFY+oQFZjkXhN4zrDe
X-Received: by 2002:a37:a046:: with SMTP id j67mr9892605qke.395.1595012652218;
        Fri, 17 Jul 2020 12:04:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgtOiKIUn5ao5bCnaTTskTcrkgF6EP4gHfCCcCRRv0vg7ItdvSMNS0FlNgUH04ZXSmho073g==
X-Received: by 2002:a37:a046:: with SMTP id j67mr9892576qke.395.1595012651933;
        Fri, 17 Jul 2020 12:04:11 -0700 (PDT)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id e9sm11311764qtq.70.2020.07.17.12.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 12:04:11 -0700 (PDT)
Message-ID: <ec6623032131fc3e656713b8ec644cdff89a8066.camel@redhat.com>
Subject: Re: nouveau regression with 5.7 caused by "PCI/PM: Assume ports
 without DLL Link Active train links in 100 ms"
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Karol Herbst <kherbst@redhat.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Patrick Volkerding <volkerdi@gmail.com>,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Date:   Fri, 17 Jul 2020 15:04:10 -0400
In-Reply-To: <20200716235440.GA675421@bjorn-Precision-5520>
References: <20200716235440.GA675421@bjorn-Precision-5520>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-07-16 at 18:54 -0500, Bjorn Helgaas wrote:
> [+cc Sasha -- stable kernel regression]
> [+cc Patrick, Kai-Heng, LKML]
> 
> On Fri, Jul 17, 2020 at 12:10:39AM +0200, Karol Herbst wrote:
> > On Tue, Jul 7, 2020 at 9:30 PM Karol Herbst <kherbst@redhat.com> wrote:
> > > Hi everybody,
> > > 
> > > with the mentioned commit Nouveau isn't able to load firmware onto the
> > > GPU on one of my systems here. Even though the issue doesn't always
> > > happen I am quite confident this is the commit breaking it.
> > > 
> > > I am still digging into the issue and trying to figure out what
> > > exactly breaks, but it shows up in different ways. Either we are not
> > > able to boot the engines on the GPU or the GPU becomes unresponsive.
> > > Btw, this is also a system where our runtime power management issue
> > > shows up, so maybe there is indeed something funky with the bridge
> > > controller.
> > > 
> > > Just pinging you in case you have an idea on how this could break Nouveau
> > > 
> > > most of the times it shows up like this:
> > > nouveau 0000:01:00.0: acr: AHESASC binary failed
> > > 
> > > Sometimes it works at boot and fails at runtime resuming with random
> > > faults. So I will be investigating a bit more, but yeah... I am super
> > > sure the commit triggered this issue, no idea if it actually causes
> > > it.
> > 
> > so yeah.. I reverted that locally and never ran into issues again.
> > Still valid on latest 5.7. So can we get this reverted or properly
> > fixed? This breaks runtime pm for us on at least some hardware.
> 
> Yeah, that stinks.  We had another similar report from Patrick:
> 
>   
> https://lore.kernel.org/r/CAErSpo5sTeK_my1dEhWp7aHD0xOp87+oHYWkTjbL7ALgDbXo-Q@mail.gmail.com
> 
> Apparently the problem is ec411e02b7a2 ("PCI/PM: Assume ports without
> DLL Link Active train links in 100 ms"), which Patrick found was
> backported to v5.4.49 as 828b192c57e8, and you found was backported to
> v5.7.6 as afaff825e3a4.
> 
> Oddly, Patrick reported that v5.7.7 worked correctly, even though it
> still contains afaff825e3a4.
> 
> I guess in the absence of any other clues we'll have to revert it.
> I hate to do that because that means we'll have slow resume of
> Thunderbolt-connected devices again, but that's better than having
> GPUs completely broken.
> 
> Could you and Patrick open bugzilla.kernel.org reports, attach dmesg
> logs and "sudo lspci -vv" output, and add the URLs to Kai-Heng's
> original report at https://bugzilla.kernel.org/show_bug.cgi?id=206837
> and to this thread?
> 
> There must be a way to fix the slow resume problem without breaking
> the GPUs.

Isn't it possible to tell whether a PCI device is connected through thunderbolt
or not? We could probably get away with just defaulting to 100ms for thunderbolt
devices without DLL Link Active specified, and then default to the old delay
value for non-thunderbolt devices.

> 
> Bjorn
> 

