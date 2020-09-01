Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A273C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 05:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 292F22078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 05:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hmjdaJHt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgIAFgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 01:36:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50809 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgIAFga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 01:36:30 -0400
Received: from carbon-x1.hos.anvin.org ([IPv6:2601:646:8600:3280:1098:42a1:36db:233c])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 0815ZoYg3466113
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 31 Aug 2020 22:35:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 0815ZoYg3466113
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020082401; t=1598938551;
        bh=D1w2z0wwywyGWyM+Ovcf5tkTNQaIiyhfu7pJSPgagqw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hmjdaJHtKRlZIZmdeAAIWNkOWb0IPHJnWi5DHteLmVli+6LQDT1xQh0K/lV0/ZXpG
         FFLum+W496p29BTSsrjWDbLU/oI8/isvPHoKwl/z+aR9Q/jpR1x3NcGC/geSBREpd3
         4Omravp5qtMacPfaHw6+k8eS6povBblhS0DVV+3aIrIkSHyKCYuEuR/CaTIgw3uP0n
         wegyrckQOK3pOzb+y8Zdy367JVMcVTi4E69xY73U13j+nriPNxpWqMO/b37IB6YO+I
         uznTOeUsfQ2Hs31MsDTL+HHygr/ME3vbj1UscxVFsPl1a4tUDtY9q1WA91YZ/sJaXM
         OBNMLe3/HJ3Dg==
Subject: Re: [PATCH] Documentation/x86/boot.rst: minor improvement
To:     Cao jin <caoj.fnst@cn.fujitsu.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, corbet@lwn.net
References: <20200901034157.5482-1-caoj.fnst@cn.fujitsu.com>
 <da11d436-8910-f560-e132-827132576f1d@cn.fujitsu.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <2cb35238-0008-4a89-7abf-8045bd753728@zytor.com>
Date:   Mon, 31 Aug 2020 22:35:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <da11d436-8910-f560-e132-827132576f1d@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you are going to fix the language...

On 2020-08-31 22:25, Cao jin wrote:
> Sorry, I mis-copied 2 addresses. make sure they are CCed.
> 
> On 9/1/20 11:41 AM, Cao jin wrote:
>> Typo fix & file name update
>>
>> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
>> ---
>>  Documentation/x86/boot.rst | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
>> index 7fafc7ac00d7..c04afec90486 100644
>> --- a/Documentation/x86/boot.rst
>> +++ b/Documentation/x86/boot.rst
>> @@ -1379,7 +1379,7 @@ can be calculated as follows::
>>  In addition to read/modify/write the setup header of the struct
>>  boot_params as that of 16-bit boot protocol, the boot loader should
>>  also fill the additional fields of the struct boot_params as described
>> -in zero-page.txt.
>> +in zero-page.rst.
>>  
>>  After setting up the struct boot_params, the boot loader can load
>>  64-bit kernel in the same way as that of 16-bit boot protocol, but
>> @@ -1391,7 +1391,7 @@ In 64-bit boot protocol, the kernel is started by jumping to the
>>  
>>  At entry, the CPU must be in 64-bit mode with paging enabled.

(Paging enabled is redundant here.)

>>  The range with setup_header.init_size from start address of loaded
>> -kernel and zero page and command line buffer get ident mapping;
>> +kernel and zero page and command line buffer get identity mapping;

The range with setup_header.init_size from start address of the loaded kernel,
the zero page, and the command line buffer get identity-mapped, anda GDT must
be loaded with the descriptors for selectors __BOOT_CS(0x10) and
__BOOT_DS(0x18): both descriptors must be 4G flat segment with __BOOT_CS
having execute/read
permission and __BOOT_DS...

Also, it might be useful to take a look to see if other data structures, like
setup_data and the initrd also need to be in the identity map.

	-hpa

