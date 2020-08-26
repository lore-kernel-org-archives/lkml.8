Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE157C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 00:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B50DD206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 00:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2BrDqwaM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgHZANr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 20:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgHZANp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 20:13:45 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A672C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 17:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Gs2cxssngByG89pViSAo1+L2dbs8m9mQvOVpn+U3G2s=; b=2BrDqwaMOar/R1I06H0535xd83
        Hmo808kwqEjorIjeH0G4FX64/zc9FXzlweQtVMZjPNMVr9aZ4R3PrS07cU8HgNh7yQKPK/SL7OlLG
        E3K5FveGJfeeJDTbsvYg3SrMUQiSfqpCOKD6419K3q+ukJ5+yZ26VQBQq6MVfFHXasDVFN7SumZnR
        VqvDIEtDbRm+roJy/lY9GawCShBv3lOV5yCOJUwK9Dmc1BLR/58pz0Wgewef62cnefHY+0AR6S59R
        kBk+J6nIZsFRwRH5SlKlkiBNqRTzlA2/1Wnp9UZxDLkNJ0HuUEoVaPEvbsQQXomrGC7kx0eElVGML
        i74xmMrA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAj4M-0003f3-T2; Wed, 26 Aug 2020 00:13:39 +0000
Subject: Re: [PATCH mmotm] x86/numa: fix build when CONFIG_ACPI is not set
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <70e5ee34-9809-a997-7b49-499e4be61307@infradead.org>
 <20200825165214.2b5e1fbf53d68fd3714c8050@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <68e4e428-9b66-cfac-ef20-0d30b29d0773@infradead.org>
Date:   Tue, 25 Aug 2020 17:13:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825165214.2b5e1fbf53d68fd3714c8050@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/20 4:52 PM, Andrew Morton wrote:
> On Tue, 25 Aug 2020 08:20:27 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Fix build errors when CONFIG_ACPI is not set/enabled by adding
>> <acpi/acpi_numa.h> in the #else (!CONFIG_ACPI) block.
>>
>> ../arch/x86/mm/numa.c: In function ‘numa_setup’:
>> ../arch/x86/mm/numa.c:43:3: error: implicit declaration of function ‘disable_srat’; did you mean ‘disable_irq’? [-Werror=implicit-function-declaration]
>>    disable_srat();
>>    ^~~~~~~~~~~~
>> ../arch/x86/mm/numa.c:45:3: error: implicit declaration of function ‘disable_hmat’; did you mean ‘disable_dma’? [-Werror=implicit-function-declaration]
>>    disable_hmat();
>>    ^~~~~~~~~~~~
>>
>> ...
>>
>> --- mmotm-2020-0824-1606.orig/include/linux/acpi.h
>> +++ mmotm-2020-0824-1606/include/linux/acpi.h
>> @@ -709,6 +709,8 @@ static inline u64 acpi_arch_get_root_poi
>>  #define ACPI_HANDLE_FWNODE(fwnode)	(NULL)
>>  #define ACPI_DEVICE_CLASS(_cls, _msk)	.cls = (0), .cls_msk = (0),
>>  
>> +#include <acpi/acpi_numa.h>
>> +
>>  struct fwnode_handle;
>>  
>>  static inline bool acpi_dev_found(const char *hid)
> 
> I don't think there's anything in -next that caused this?  It's in
> mainline also?
> 

Calls to disable_srat() and disable_hmat() are not in v5.9-rc2.
If they are in mainline, they were added after -rc2.

See these patches in mmotm:
x86-numa-add-nohmat-option.patch
x86-numa-cleanup-configuration-dependent-command-line-options.patch


-- 
~Randy

