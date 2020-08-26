Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CB0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 05:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D87C52078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 05:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgHZFyF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 01:54:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60815 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgHZFyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 01:54:04 -0400
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kAoNm-00066G-Vo
        for linux-kernel@vger.kernel.org; Wed, 26 Aug 2020 05:54:03 +0000
Received: by mail-pl1-f200.google.com with SMTP id g1so549505plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 22:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EmdjKgqWfq2MhvZ35uIwbwk7+c9+kD+Pfn+5Mk5tTXg=;
        b=g/kS7AYGh/kpLYfFdI3nwi777Qljk7VFR2kpUWzqSACw9BHSymKUg8e508DoBmmOXG
         HJd1HDBQnaH0uWfhEqysPu23/OesJ4oOJ5L77pc9AoQP3UqfBa7NonqJPBen0Hqto9Mp
         x292Gie1VTjnMKLiDl9kKnW0v6KEaxPDwof24/QigZP4l7JiwJ7BhpOM3TJG5kj4/2jF
         E4g2BZWehuESHWKRt0QyFZ/KAR8vsFg1zGNzbVn/okXYSvH1jcRWhsPihI5U+S0SM22Q
         H8z7L1upOj0kCrBsNEI1ogQsOUbkmYO4+wRJN9gJSN3AqkcegP1kS4f/MHEBOR+P8Up1
         HJ3w==
X-Gm-Message-State: AOAM533t+1dr3e5VPwdYuNU2MfBcJOtG8bRpXr1O4loHNWWgTTV+hytw
        l68MlcEwA5T+xxvoZ5JrIr7E2zJjbKEwbrV4Ec2UFKEXGbbGWOXe5oz/Cgi/HQi17GTJ32yLQyX
        +49HPaRZPzEOWON+4EjLgo8wBShZtSEuPRBuEZjTF7g==
X-Received: by 2002:a63:ab43:: with SMTP id k3mr9614174pgp.426.1598421241578;
        Tue, 25 Aug 2020 22:54:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWQ0K6DXgbsrodE9GY1fpyeSfHps2hpaL23s2K/K/vYlyurT/g+qDxjqQhoz46yUgoSqIK8A==
X-Received: by 2002:a63:ab43:: with SMTP id k3mr9614154pgp.426.1598421241178;
        Tue, 25 Aug 2020 22:54:01 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id t25sm1252070pfe.76.2020.08.25.22.53.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Aug 2020 22:54:00 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] PCI/ASPM: Enable ASPM for links under VMD domain
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200825065634.GA2691@infradead.org>
Date:   Wed, 26 Aug 2020 13:53:56 +0800
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        Mario.Limonciello@dell.com, Heiner Kallweit <hkallweit1@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Krzysztof Wilczynski <kw@linux.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Huffman, Amber" <amber.huffman@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <E9A18AC0-8A17-4131-BD61-F2563EB77571@canonical.com>
References: <20200821123222.32093-1-kai.heng.feng@canonical.com>
 <20200825062320.GA27116@infradead.org>
 <08080FC7-861B-472A-BD7D-02D33926677F@canonical.com>
 <20200825065634.GA2691@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 25, 2020, at 14:56, Christoph Hellwig <hch@infradead.org> wrote:
> 
> On Tue, Aug 25, 2020 at 02:39:55PM +0800, Kai Heng Feng wrote:
>> Hi Christoph,
>> 
>>> On Aug 25, 2020, at 2:23 PM, Christoph Hellwig <hch@infradead.org> wrote:
>>> 
>>> On Fri, Aug 21, 2020 at 08:32:20PM +0800, Kai-Heng Feng wrote:
>>>> New Intel laptops with VMD cannot reach deeper power saving state,
>>>> renders very short battery time.
>>> 
>>> So what about just disabling VMD given how bloody pointless it is?
>>> Hasn't anyone learned from the AHCI remapping debacle?
>>> 
>>> I'm really pissed at all this pointless crap intel comes up with just
>>> to make life hard for absolutely no gain.  Is it so hard to just leave
>>> a NVMe device as a standard NVMe device instead of f*^&ing everything
>>> up in the chipset to make OS support a pain and I/O slower than by
>>> doing nothing?
>> 
>> From what I can see from the hardwares at my hand, VMD only enables a PCI domain and PCI bridges behind it.
>> 
>> NVMe works as a regular NVMe under those bridges. No magic remapping happens here.
> 
> It definitively is less bad than the AHCI remapping, that is for sure.
> 
> But it still requires:
> 
> - a new OS driver just to mak the PCIe device show up
> - indirections in the irq handling
> - indirections in the DMA handling
> - hacks for ASPSM
> - hacks for X (there were a few more)
> 
> while adding absolutely no value.  Basically we have to add a large
> chunk of kernel code just to undo silicone/firmware Intel added to their
> platform to make things complicated.  I mean it is their platform and if
> they want a "make things complicated" option that is fine, but it should
> not be on by default.

Yes, I do want it to be a regular PCIe bridge... but it's not the reality here.
Almost all next-gen Intel laptops will have VMD enabled, so users are forced to have it.
I would really like to have this patch in upstream instead of carrying it as a downstream distro-only patch.

Kai-Heng

