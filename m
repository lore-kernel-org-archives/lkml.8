Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CE5C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A7220719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="JxUPDc/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgCZReQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:34:16 -0400
Received: from mail-dm6nam10on2061.outbound.protection.outlook.com ([40.107.93.61]:6176
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726067AbgCZReP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:34:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHXQsO+aWjylqDYwFgmh8aXCqCu6/OerZ1tnuxmuOR+/tsS4zCTDx4+AiIIGzQoCEzZevmwXeA+1Cy0SR7CBKbfOK3wmDE/c2o5rzdT4dy0qpZ8eumTw6YlDNSSbtPuhnL/pFpUu+x1ImaffwNsKUePuv4sTPNqkyf6TCd0o83LZLieUwL5IPxU3+ouWCKgQW8ISzhvmjqx4FYntZtA8mPDVFl57tFB5NiJteGK4U6xud3rn3U9xM43D6vBncNfgCVb+ObSxgSAklfbsqGeQC4Tv2jt7+UY3+VMP3vtYpsJ0Oj44m78sUsPBzDj52VkM2YiaJhY87uOI/l9pAtQcbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/n8S4lu9AKlDfQupcDNESsb1v0EKBwU8sU7I/iWqAY=;
 b=YHJKKUR8tC8vWP5RSnLLCdcvKASQVeEt1oJ0nW76x90WdyOq9dPWjASErD/JBwEeINDoPTcfbB185zPx084rHupa6/euUfQWCMrFK1xwFtAH0OsGy5jsctrNDeJi9Loy2rxyqFNY22D+XKlr+KVkiBdGwhhgFhSAsen1B6DpsSHlaoAaBVHscjLjoMpaUShfN6d1rH/kSwkUPLHjXncbw0iK8RaZ/3yP/tnnQhmVVKoUsFgboEPYr2uaYvwCVJW5JCsvhKwWqm6mgU5Z832mJTP3OFDpcfm2KGGXsSR71DifL57USw+yKsKzKlmzQUx5QGOouevdCcKlMmFsS/Cadg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/n8S4lu9AKlDfQupcDNESsb1v0EKBwU8sU7I/iWqAY=;
 b=JxUPDc/tWMjxoqZYDueivOcn1lEVs+ZwAnHekDfolvrlfmNTKK7xl7kLMA6qWph6E8aUUjbqBSjhhYFc0Qr4H3c0MlBxBOVi/WW6ygPRgsn57h1xysFALFx/tJIkrOo0Jm/8S9EeTZTKzYpAWiwKdtRrfPGitUPM/+DQW8/SPCc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Li.Wang@windriver.com; 
Received: from DM6PR11MB3595.namprd11.prod.outlook.com (2603:10b6:5:142::16)
 by DM6SPR01MB0040.namprd11.prod.outlook.com (2603:10b6:5:101::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Thu, 26 Mar
 2020 17:34:13 +0000
Received: from DM6PR11MB3595.namprd11.prod.outlook.com
 ([fe80::4038:e1b8:4bd3:74f3]) by DM6PR11MB3595.namprd11.prod.outlook.com
 ([fe80::4038:e1b8:4bd3:74f3%5]) with mapi id 15.20.2835.023; Thu, 26 Mar 2020
 17:34:12 +0000
Subject: Re: [PATCH] arm64: mmu: no write cache for O_SYNC flag
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200326163625.30714-1-li.wang@windriver.com>
 <20200326165520.GD26987@mbp>
From:   "Wang, Li" <li.wang@windriver.com>
Message-ID: <f4a5a299-f159-2480-224e-2c4215162f5c@windriver.com>
Date:   Fri, 27 Mar 2020 01:34:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200326165520.GD26987@mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2P15301CA0018.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::28) To DM6PR11MB3595.namprd11.prod.outlook.com
 (2603:10b6:5:142::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.116] (120.244.141.26) by HK2P15301CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.2 via Frontend Transport; Thu, 26 Mar 2020 17:34:10 +0000
X-Originating-IP: [120.244.141.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbb54d91-0607-46af-817f-08d7d1abe610
X-MS-TrafficTypeDiagnostic: DM6SPR01MB0040:
X-Microsoft-Antispam-PRVS: <DM6SPR01MB004096958694F2261DC501BCEFCF0@DM6SPR01MB0040.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0354B4BED2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(346002)(136003)(366004)(396003)(376002)(6916009)(2906002)(86362001)(31696002)(8936002)(52116002)(66476007)(66556008)(66946007)(81156014)(8676002)(36756003)(5660300002)(966005)(31686004)(16526019)(26005)(186003)(956004)(16576012)(2616005)(316002)(478600001)(4326008)(6666004)(81166006)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6SPR01MB0040;H:DM6PR11MB3595.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: windriver.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: muogmVH5tHUzzTjmHPN0wTgHmcdrM0me2G5cTVfZANsqRRJQGbestg9Qrmn86iFz4Dg146L666AgbigW3BuHAqWhHRJmG1FTgcBJWkhk/hs4njZx2RsiTUXzgnHxL4/uK9VHtkyDtoJVLqVyelTF6Jrklvu/kQeDzRSb88GgDHLN5hyJtKUAymsRo7KMLkdIz8fMKSgcuzr6IhYdsx6ZNk/6ZKvEGsqkVZhtyDFA4cI0HLnmYsNdp+5Ws5h/ksWbRCVePyL0tSyVmult8z/3Kw7e/m2TMHm/9ONEabLuALl8Pv+L5C8nHQ4hyIMaY98rfQIwpGTA0u9at7UdJsvuIM2vCxLvqfKtWQZ2f+xXONjqjo5D2JWfDvDYytF3nhkG5CDbJICN5u76rIU5MHGB0n7YjxJd9jOhF1bPn4mVlcKBO3rDQ6P0sUfePfnllc9QOuIWhZSeyohtNCHxBPrS/C+Fmh0oD1q0Fwzs3JcHLq7ORDyg41t2m8hGAbtk05GCHO5pS9fxVPdf+pZ10X863g==
X-MS-Exchange-AntiSpam-MessageData: cAsRgrOGRmSZS+zh0GXCy6tZy4KaTjceyg/M8di8jhmEoSNO7NYbiF9VUHJWIfabp9Lxuer8s3L0uM2ZV0FUyaI3nzaEC/l1uqC2QTqRWDXiCSNgbVYzSYje8/J2NeSOREizMPGNV4RU8B04otudTQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb54d91-0607-46af-817f-08d7d1abe610
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2020 17:34:12.8277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZp9k8GF6T4ODzkk+HH32G+se6zVGZz7OTWWlFAHqOcG7rRORjLq71eJMjjk/4gDZWyLGRan2JDANMAeHI/gmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6SPR01MB0040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2020/3/27 0:55, Catalin Marinas 写道:
> On Thu, Mar 26, 2020 at 09:36:25AM -0700, Li Wang wrote:
>> reproduce steps:
>> 1.
>> disable CONFIG_STRICT_DEVMEM in linux kernel
>> 2.
>> Process A gets a Physical Address of global variable by
>> "/proc/self/pagemap".
>> 3.
>> Process B writes a value to the same Physical Address by mmap():
>> fd=open("/dev/mem",O_SYNC);
>> Virtual Address=mmap(fd);
>>
>> problem symptom:
>> after Process B write a value to the Physical Address,
>> Process A of the value of global variable does not change.
>> They both W/R the same Physical Address.
>>
>> technical reason:
>> Process B writing the Physical Address is by the Virtual Address,
>> and the Virtual Address comes from "/dev/mem" and mmap().
>> In arm64 arch, the Virtual Address has write cache.
>> So, maybe the value is not written into Physical Address.
>>
>> fix reason:
>> giving write cache flag in arm64 is in phys_mem_access_prot():
>> =====
>> arch/arm64/mm/mmu.c
>> phys_mem_access_prot()
>> {
>>    if (!pfn_valid(pfn))
>>      return pgprot_noncached(vma_prot);
>>    else if (file->f_flags & O_SYNC)
>>      return pgprot_writecombine(vma_prot);
>>    return vma_prot;
>> }
>> ====
>> the other arch and the share function drivers/char/mem.c of phys_mem_access_prot()
>> does not add write cache flag.
>> So, removing the flag to fix the issue
> Other architectures may have transparent caches and don't require
> different attributes.
>
>> Signed-off-by: Li Wang <li.wang@windriver.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>   arch/arm64/mm/mmu.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 128f70852bf3..d7083965ca17 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -81,8 +81,6 @@ pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>>   {
>>   	if (!pfn_valid(pfn))
>>   		return pgprot_noncached(vma_prot);
>> -	else if (file->f_flags & O_SYNC)
>> -		return pgprot_writecombine(vma_prot);
>>   	return vma_prot;
>>   }
>>   EXPORT_SYMBOL(phys_mem_access_prot);
> A better solution is for user space not to pass O_SYNC when opening
> /dev/mem. We've had this ABI for a long time (arch/arm/ and several
> other architectures do the same), why change it now?


1.

no pass O_SYNC in user space is not a good idea.

in fact, the codes come from 'devmem' command of busybox:

=====

busybox-1.24.1/miscutils$ vim devmem.c

fd = xopen("/dev/mem", O_SYNC);

=====

the codes are used for a long time.


2.

according to info of open man about "O_SYNC":

=====

http://man7.org/linux/man-pages/man2/open.2.html

the output data and associated file metadata have been transferred to 
the underlying hardware

=====

I think "O_SYNC" means no cache.


3.

/dev/mem of driver offers 2 ways to operate  physical memory.

one is mmap, the other is read/write.

when use read/write way, it operates uncached memory:

=====

kernel-source/drivers/char/mem.c

write_mem(){

/* it must also be accessed uncached */

}

=====


4.

arm64 arch is different with other arch about phys_mem_access_prot().

you can see no any other arch add cache flag in the function.

only arm and arm64 add write cache for O_SYNC flag.


x86/mm/pat.c

phys_mem_access_prot(){

return vma_prot;

}


powerpc/mm/mem.c

phys_mem_access_prot(){
         if (ppc_md.phys_mem_access_prot)
                 return ppc_md.phys_mem_access_prot(file, pfn, size, 
vma_prot);
         if (!page_is_ram(pfn))
                 vma_prot = pgprot_noncached(vma_prot);
         return vma_prot;
}


drivers/char/mem.c

phys_mem_access_prot()
{
#ifdef pgprot_noncached
         phys_addr_t offset = pfn << PAGE_SHIFT;

         if (uncached_access(file, offset))
                 return pgprot_noncached(vma_prot);
#endif
    return vma_prot;
}


Thanks,

LiWang.

