Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB90C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E6362075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgHYGkH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 02:40:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55725 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729068AbgHYGkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 02:40:04 -0400
Received: from mail-pj1-f69.google.com ([209.85.216.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kASck-000689-3v
        for linux-kernel@vger.kernel.org; Tue, 25 Aug 2020 06:40:02 +0000
Received: by mail-pj1-f69.google.com with SMTP id g7so1135232pja.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 23:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=piHKc2fPSQ4MbF9wubCjfB1Fk6iimFoRYF73q4RIKo4=;
        b=CXoSAw9cOiy5qe5vF0kjoFq7GnPBGaiQXrB3Dsjw8uJnDJBd0eSCjSjHH+/ig6x1yJ
         /T5dtdWoVFXVU1B6h4boH8jgfh3KfgMua+1OQWkgpyBmn3U3DlaD+j15jZYJ9+M806Jk
         QAX7wMjhuDj1FPTedxoKoCim2D2gAbx+nAcQaUotHHPpzRik+7w2d0j/8fq8Z1bDpfw1
         2MTijwGYZWVq/vN+QlVELNf0yo5VtvLl2iL/1bSo0lwwzgJYYfrFDWWUSmi3ObNh0/9I
         ya3ct3lTJxK+3bdTzZjLAdEHdrfZ2fz3kBMnw/94vOBe4v8k59HKGOffHxkKDfvOUgnP
         Tvuw==
X-Gm-Message-State: AOAM532UH4MPfNa+GLZz4kWhxSKh/dTmi7mMctx22bzkIr8CiUH9sXQc
        ZbDTkfCOnu7o/7tgmpVLqbJPz8kGbmHNWYZzFLKnP/0K3ih4GV6pBjFZPwzLF2c0Rwl6KjD+T0H
        1qE2HO90d51eVuEiteey5yizJE42K2X/m4GGIfsARZg==
X-Received: by 2002:a63:4b5e:: with SMTP id k30mr5723125pgl.205.1598337600719;
        Mon, 24 Aug 2020 23:40:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzseWnZhEGmmZYtaFmo76Hw39HDPPRpN+UXTz/LyMdT8cUuOUtVeMtR58p5BQArrGxFPfHBEQ==
X-Received: by 2002:a63:4b5e:: with SMTP id k30mr5723103pgl.205.1598337600351;
        Mon, 24 Aug 2020 23:40:00 -0700 (PDT)
Received: from [10.101.46.234] (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id y128sm13656594pfy.74.2020.08.24.23.39.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 23:39:59 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] PCI/ASPM: Enable ASPM for links under VMD domain
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200825062320.GA27116@infradead.org>
Date:   Tue, 25 Aug 2020 14:39:55 +0800
Cc:     Bjorn Helgaas <bhelgaas@google.com>, jonathan.derrick@intel.com,
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
Message-Id: <08080FC7-861B-472A-BD7D-02D33926677F@canonical.com>
References: <20200821123222.32093-1-kai.heng.feng@canonical.com>
 <20200825062320.GA27116@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

> On Aug 25, 2020, at 2:23 PM, Christoph Hellwig <hch@infradead.org> wrote:
> 
> On Fri, Aug 21, 2020 at 08:32:20PM +0800, Kai-Heng Feng wrote:
>> New Intel laptops with VMD cannot reach deeper power saving state,
>> renders very short battery time.
> 
> So what about just disabling VMD given how bloody pointless it is?
> Hasn't anyone learned from the AHCI remapping debacle?
> 
> I'm really pissed at all this pointless crap intel comes up with just
> to make life hard for absolutely no gain.  Is it so hard to just leave
> a NVMe device as a standard NVMe device instead of f*^&ing everything
> up in the chipset to make OS support a pain and I/O slower than by
> doing nothing?

From what I can see from the hardwares at my hand, VMD only enables a PCI domain and PCI bridges behind it.

NVMe works as a regular NVMe under those bridges. No magic remapping happens here.

Kai-Heng
