Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC04C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63AA522B47
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbgHUNup convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:50:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59151 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgHUNul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:50:41 -0400
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1k97RG-0007WP-QD
        for linux-kernel@vger.kernel.org; Fri, 21 Aug 2020 13:50:38 +0000
Received: by mail-pf1-f198.google.com with SMTP id g6so1449182pfi.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ixzpb7ZTHJuiKoZP8ciVIDdnuS6WspeERPksthDch4Y=;
        b=ExneXAfN4VgoEnygR4PMQ+5ACGMPX1sHeg/LjdS3nAI067TV6jCgjrKq8B4ekLHPv8
         1KRm7aSqW8MocC7JAZKnETxiyav+MBdYaNPqGYBhJEXIoftbCrd/tJTy6HzvqhEL9ZK3
         dSfA8Ze0NqP/u6nlaIwJzfA2RQ6moUxarwKcDNfo8iARZHU/cMHlx3F9sLgvlsz27BZW
         zd7PHRZNCs+fhR5hk5WWrI3LxqkaZbtwgF3rwILeGnf0MHKASiErPRVuiIN1NLcLraMB
         jgAeHU4wYA2VgFItKGxnZIdCu/yEJnbyImhyfdNndjv2lZTmtiZktHBGrmWuz6nweI6E
         21ZQ==
X-Gm-Message-State: AOAM531Mhst7rFtiA3EY7OWPwOD9oOcliyaIVMSD0g5lcRUlM0fed9Iu
        /kdKSNznjSmebxh1B6HmT0g9SJtI62z7kDEw77IpGu/LgqU3/PNhcD8FCaBQ2MsOAR3WFFKvRFf
        Ft2aJSW8g46sVHagIWEpKmscHHeXTKBv1fK9PnCMNog==
X-Received: by 2002:aa7:9096:: with SMTP id i22mr2636813pfa.310.1598017836965;
        Fri, 21 Aug 2020 06:50:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxz9IMJ2Q79QQio5v7ZYraOE2lxE3lXGA5Fa/cyXoTyQecljb6qYd041APJoAVi65wVQprz5Q==
X-Received: by 2002:aa7:9096:: with SMTP id i22mr2636791pfa.310.1598017836623;
        Fri, 21 Aug 2020 06:50:36 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id r186sm2928966pfr.162.2020.08.21.06.50.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 06:50:35 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [Regression] "iommu/amd: Relax locking in dma_ops path" makes tg3
 ethernet transmit queue timeout
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200821134300.GM3354@suse.de>
Date:   Fri, 21 Aug 2020 21:50:33 +0800
Cc:     iommu@lists.linux-foundation.org,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <5D7A63DF-D360-4453-845C-924F4C13E3DB@canonical.com>
References: <4E9B03FB-9DA5-4831-B4CE-A0AA645D3F22@canonical.com>
 <20200518133209.GM8135@suse.de>
 <381D21C9-C913-4C33-A6F4-0440B5D11670@canonical.com>
 <8D375E06-A763-4B5E-9C6D-DA5EBC62530E@canonical.com>
 <CFC22DE4-E342-4F32-B758-6A690755C498@canonical.com>
 <20200821134300.GM3354@suse.de>
To:     Joerg Roedel <jroedel@suse.de>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

> On Aug 21, 2020, at 21:43, Joerg Roedel <jroedel@suse.de> wrote:
> 
> Hi Kai,
> 
> On Mon, Jun 29, 2020 at 08:33:22PM +0800, Kai-Heng Feng wrote:
>> I am still seeing the issue on v5.8-rc3. The issue goes away as soon
>> as "iommu=off" is added.
> 
> Can you probably help with debugging this issue? I've had no luck so far
> getting my hands on a machine with tg3 hardware and an AMD IOMMU.

Of course, I still have the system at my side.

The offending commit is 92d420ec028d ("iommu/amd: Relax locking in dma_ops path"), however be62dbf554c5 ("iommu/amd: Convert AMD iommu driver to the dma-iommu api") removed .map_page entirely so I don't know where to start.

Kai-Heng

> 
> Regards,
> 
> 	Joerg

