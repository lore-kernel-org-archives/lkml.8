Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EAAC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C16A220729
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nda5Gaqh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbgGUPCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 11:02:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47680 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726710AbgGUPCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595343720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mSIJqWa6gC/bRdgGTlEg6I1iiFHrJPO8X4/n8B0VJ9k=;
        b=Nda5GaqhA26gAUvQOiiVuv5CLb1nMr/9We8VKvxj1kezCWbLFkwDKZkU6MVLH1Ldj4B43z
        /exCwjMzKtEhIZmaArgCevLjTafzeTxg5W3i+ilaPGEjEiw7W+wjcphRDpAm6C2kq7L879
        +b4lHQFzsVn9UBIOTUqeas+caVWWx/k=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-tte_76usOPCuExBWZxqXiA-1; Tue, 21 Jul 2020 11:01:58 -0400
X-MC-Unique: tte_76usOPCuExBWZxqXiA-1
Received: by mail-qk1-f200.google.com with SMTP id q3so5467869qkj.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 08:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=mSIJqWa6gC/bRdgGTlEg6I1iiFHrJPO8X4/n8B0VJ9k=;
        b=byxMcoz2CqyKig2TbMXuS9/h74OpKaZoyXufsfnbbA7oldJYVh9WVplpbxVe5Fa3TT
         GITCxaJ3hc5NzfVB6Nxf+ZICS7HJaZ6dF9ribNv8wVoOIiKJ3EPZUfaAi8AX03s4Z84g
         au+W+7WKTdmRslr19QvSq0zcopy5aMH34DWYPRJM+BkSyt7jHvAZKUM0Ve0AIjt9ywt6
         wdfODeBFvdGwTYLghhDAGZhz1zJHON/VUj+f15D6OlfGk/sLLdt2W5fHnnOdvUKdV0vD
         UFJMOlDjHnkSaEG0lTbVdxbOTK+wMWo4wYUqrQCLobVIxBZzwuKeeVcAvl1diMwMntT2
         oIDQ==
X-Gm-Message-State: AOAM5307PbFa1dYR2dUsFSwTkEZ0/V0EWAN4m37eyZEifufmdk+6XI6n
        avJxXc7dIEB+PiuZM6+P7AdZOg9+9q2DEhZhPp86H7FwbvgaIDygyTTqYRqjTSJ3PT+/P8TwePd
        ilbhG1TvjzqJ7xjvRO2egxwe2
X-Received: by 2002:a37:a51:: with SMTP id 78mr16530730qkk.121.1595343717897;
        Tue, 21 Jul 2020 08:01:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJH5IxpTv0tqc1DLQ+iSUR4KYz9tNO0jJWsz8BvtZ9Y/QpYN7MJ20Jq9ljgK+EQmQWXFPL4g==
X-Received: by 2002:a37:a51:: with SMTP id 78mr16530715qkk.121.1595343717650;
        Tue, 21 Jul 2020 08:01:57 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id f4sm22024521qtp.38.2020.07.21.08.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 08:01:57 -0700 (PDT)
Message-ID: <f951fba07ca7fa2fdfd590cd5023d1b31f515fa2.camel@redhat.com>
Subject: Re: nouveau regression with 5.7 caused by "PCI/PM: Assume ports
 without DLL Link Active train links in 100 ms"
From:   Lyude Paul <lyude@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Karol Herbst <kherbst@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Patrick Volkerding <volkerdi@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Date:   Tue, 21 Jul 2020 11:01:55 -0400
In-Reply-To: <20200721122247.GI5180@lahna.fi.intel.com>
References: <CACO55tuA+XMgv=GREf178NzTLTHri4kyD5mJjKuDpKxExauvVg@mail.gmail.com>
         <20200716235440.GA675421@bjorn-Precision-5520>
         <CACO55tuVJHjEbsW657ToczN++_iehXA8pimPAkzc=NOnx4Ztnw@mail.gmail.com>
         <CACO55tso5SVipAR=AZfqhp6GGkKO9angv6f+nd61wvgAJtrOKg@mail.gmail.com>
         <20200721122247.GI5180@lahna.fi.intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sure thing. Also, feel free to let me know if you'd like access to one of the
systems we saw breaking with this patch - I'm fairly sure I've got one of them
locally at my apartment and don't mind setting up AMT/KVM/SSH

On Tue, 2020-07-21 at 15:22 +0300, Mika Westerberg wrote:
> Hi,
> 
> [Sorry for the delay, I was on vacation]
> 
> On Fri, Jul 17, 2020 at 01:32:10PM +0200, Karol Herbst wrote:
> > Filed at https://bugzilla.kernel.org/show_bug.cgi?id=208597
> 
> Thanks for reporting.
> 
> I'll check your logs and try to figure if there is something we can do
> to make both nouveau and TBT working at the same time.
> 
> > oddly enough I wasn't able to reproduce it on my XPS 9560, will ping
> > once something breaks.
-- 
Cheers,
	Lyude Paul (she/her)
	Software Engineer at Red Hat

