Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57346C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F93020786
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PXpSrxGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgHQOGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgHQOGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:06:07 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88918C061342
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:06:07 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id r4so7581971pls.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PIAYKHjJ+03cKYu2JPL6HlkNqktpI5xr9LI9aCcZTZc=;
        b=PXpSrxGG5NQb2WIDkTqTa6tdyZ/m8BuvTDK83BWuHX+Q/99KGjVkYjMKxCJso/bu50
         P0gDNg0ERPM1lvTGmbNHMlupuOOGCwJVrYim4k+LNFSZCgVi/GVq6qP+3A1njqNrR9y2
         sogh8F7SHPR5/IpCnAwdk2PVu6UFxPq0YcDe7bd3Hh29Pgu0G6vzwzDO8iA1y0sbOvOD
         faZ9A0Np7vVm1f/+W02gT63w1ATQX7LsBkzw2K/KJBRm3uyU2UuMjQobY+Fsu/izTBQy
         bu6fZf/4/5iUnlQrPxDrB+CQZJDAsK8JytIs57AH2+y1az/qOeQ6SXQceb3nxa3sAXg2
         fsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PIAYKHjJ+03cKYu2JPL6HlkNqktpI5xr9LI9aCcZTZc=;
        b=ThHVpjfWTUgoOR3S0se8e/pRnqaV6vRnVllt0okzjP/5eZAyXRH+gl3gLCDgSWzklf
         fUy/3nJ++m70jNDBdRWa3mtK2ENOr+no7pbTb8MzDTNfVo9q1EM8rrlCzSK0ZcNe/csN
         nFg8jrqiAkRat3K/CVQ0qA/EhtLAp/lFn0/4Zb3ZiMC7ptkYrbFpaUzmwzYIBErOQuq+
         SrWL3pEH4OFyRdVyJAytY91NZJ7sKPT10HrAYxesQXZn+07QfdgDgZTPJUtfHfdp00qL
         11CswHAv9H4g90rD21O5NmBiXxFhhwjdJG8R25RZUgjR83z/AC+rVrNXi3nHj+7UnUiO
         b3xA==
X-Gm-Message-State: AOAM532SHwUyLvSTmm5wgpgCaHclbneAyHYKD7vn6b/9FE18N1OHHA9w
        x9wy9MCbCfvs0yrBrOHuJv4klA==
X-Google-Smtp-Source: ABdhPJxN5VWrIxn19ZuHvKElObS5gj6AQHW4rCT/F/d8vpnvb6ZtllMPtmvafGqmOsAuPRJ4TsELQQ==
X-Received: by 2002:a17:90b:384b:: with SMTP id nl11mr12500874pjb.91.1597673166975;
        Mon, 17 Aug 2020 07:06:06 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:ff2c:a74f:a461:daa2? ([2605:e000:100e:8c61:ff2c:a74f:a461:daa2])
        by smtp.gmail.com with ESMTPSA id d23sm13089251pgm.11.2020.08.17.07.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 07:06:06 -0700 (PDT)
Subject: Re: [PATCH v3] ata: use generic power management
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Christoph Hellwig <hch@lst.de>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Prabhakar Kushwaha <pkushwaha@marvell.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Slaby <jslaby@suse.cz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200817092245.10478-1-vaibhavgupta40@gmail.com>
 <20200817092511.GA10566@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <11190a0b-1009-caf8-9cbe-6cf296b614bf@kernel.dk>
Date:   Mon, 17 Aug 2020 07:06:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817092511.GA10566@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/20 2:25 AM, Vaibhav Gupta wrote:
> Hello,
> 
> I am working to upgrade power management framework support for PCI drivers, as
> my project under the Linux Kernel Mentorship Program.
> 
> The ultimate goal is to completely remove the legacy framework. And for this we
> need to remove ".suspend" and ".resume" pointers from "struct pci_driver".
> 
> The patch is doing the change for the same. The actual suspend() and
> resume() callbacks are defined in drivers/ata/libata-core.c and are exported.
> Which are then used by other files.
> 
> Thus removing those pointers, included 54 files in this patch. Although, the
> actual changes are done in few files only. The changes should work fine as I
> have done similar changes for other drivers too which made their way into the
> kernel. Still, tests on few ata devices are necessary.

Didn't we agree to split this up into separate patches??

> I tried but unfortunately, I couldn't find or arrange devices to test upon. I
> have added the authors of the previous commit(s) for respective drivers as
> recipients. It would be very helpful if someone can test it on a device.

Does qemu support any of the affected drivers?

-- 
Jens Axboe

