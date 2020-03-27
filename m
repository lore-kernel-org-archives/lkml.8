Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B2AC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A1A20A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="iNu0+/gr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgC0QuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 12:50:19 -0400
Received: from mail-dm6nam12on2072.outbound.protection.outlook.com ([40.107.243.72]:27998
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727242AbgC0QuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:50:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBPVyJEqKUlAQVYGuyt44jbauZh3kiq+WRfYuqW3hMZjKXrL97V5YCgjnJtE19jVUPXbU853fzeqK6V7JCqZ705uBgHeX++RvdaZ/9GvLcBm+QE0nSMenll6XyzLtKTUeaXqO6GBAw5gAMhbnadwX++h8XWyVyNiaHZCkTUu9y4PBXCYWqbodn5WfHT5mKvqO5vmFUypsHEssiLwcLaEy3rnBuuvLDQyamb4LeHigt5bKwUQjKJP2aO1W2617oZiLu7pP2RJCsfT8eTA1o1VmDsIeTGI34bO1uoXPVK1gEAB5HlVViUpGR1YObFRg5zFz1nP+cUr0tJdq1XWS3rpww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LFqiO5qG5YYDkhm8lTNwaev9cw/vu90KnMaH9OFfFw=;
 b=SdXzujwns9e0aH9j3CjRsoBgpAV1ZSlEQl5zi0NDYnUfDLkInnoARNTxQSkFAvV+WUyDq8MmgYHZBT3gDf6DhQgBSIeMzYLPdLu3erP5/KUx6sMtwAyQ+XUVs8KZMUs+cqEwscQJAA+JJWwWL0R3YVt/kp1/piw1aO1yejgmGILAezWh8DWmtQKr0lZnMvx/zePmJGK5cyQHOAirrkwf+p0GGtI7BduMDfsCmUWLy95LR67KGuJk+KXUKuhbaSGE1XtKB3gc7q2KHDl9+/CT5NIzL4GeZcXQOP5yCt17HF2A5DQx1BcY4idEa4Q/SZDzKCHQiuZNzY4jki8SzGlQAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LFqiO5qG5YYDkhm8lTNwaev9cw/vu90KnMaH9OFfFw=;
 b=iNu0+/grTcSkrkcTMnkTROapy+whi5mpRPZiOWQMVoFAwP5Ugo3721724GQR/74toSDpxDa5GhbrrFs0LHF96wuLh3R/rXsG0KKjBW7M21eA1abgspP9wfJNBFWN1laWuUYKf4SKq7yqbGPYVUofxtLvW/6BBOR+6OIB+gO3DWs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Li.Wang@windriver.com; 
Received: from DM6PR11MB3595.namprd11.prod.outlook.com (2603:10b6:5:142::16)
 by DM6PR11MB3177.namprd11.prod.outlook.com (2603:10b6:5:c::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Fri, 27 Mar 2020 16:47:40 +0000
Received: from DM6PR11MB3595.namprd11.prod.outlook.com
 ([fe80::4038:e1b8:4bd3:74f3]) by DM6PR11MB3595.namprd11.prod.outlook.com
 ([fe80::4038:e1b8:4bd3:74f3%5]) with mapi id 15.20.2835.023; Fri, 27 Mar 2020
 16:47:40 +0000
Subject: Re: [PATCH] arm64: mmu: no write cache for O_SYNC flag
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200326163625.30714-1-li.wang@windriver.com>
 <20200327142937.GB94838@C02TD0UTHF1T.local>
From:   "Wang, Li" <li.wang@windriver.com>
Message-ID: <6fc201bf-ad0c-3dae-783e-c9c9e4ac034e@windriver.com>
Date:   Sat, 28 Mar 2020 00:47:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200327142937.GB94838@C02TD0UTHF1T.local>
Content-Type: multipart/mixed;
 boundary="------------456B615C93724A699A05DEC0"
X-ClientProxiedBy: HKAPR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:203:d0::28) To DM6PR11MB3595.namprd11.prod.outlook.com
 (2603:10b6:5:142::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.116] (120.244.141.26) by HKAPR04CA0018.apcprd04.prod.outlook.com (2603:1096:203:d0::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend Transport; Fri, 27 Mar 2020 16:47:37 +0000
X-Originating-IP: [120.244.141.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca9bfc6b-1a16-4242-69aa-08d7d26e8fc1
X-MS-TrafficTypeDiagnostic: DM6PR11MB3177:
X-Microsoft-Antispam-PRVS: <DM6PR11MB3177A2E932E57EBB6D3A70B6EFCC0@DM6PR11MB3177.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(346002)(396003)(366004)(376002)(81166006)(81156014)(8936002)(6666004)(54906003)(316002)(6916009)(36756003)(5660300002)(52116002)(33964004)(66946007)(66556008)(6486002)(8676002)(66476007)(235185007)(16576012)(66616009)(31686004)(186003)(966005)(2906002)(2616005)(26005)(86362001)(478600001)(31696002)(956004)(4326008)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB3177;H:DM6PR11MB3595.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: windriver.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kvCcQu/ZxTvCaNfsIHUCIG2AZ5OyR8tIa+yME/l+hpAC3dePAsKHREWwu4NKeUlY0KzMli0MnUgpb/IqjmvBKuDH2zuVFVB+EK/9lnyho+ZOptyzT+tfzvvrIcYljtlDgyLOGAP7tB8diHEFTZLxC0MsZpB2GTIX6VNfIjPmFyUdQUm36aA/wzSdzFt8ENCv/icSV/lvKcEYFnRSHF7kTtKtzYr3eTYMNghLsZIw4LDEsZ8BHXk33EdzAx6lkgLGOzSgfCyxgct5hBB8rMJXMyFPEcOt8gUYL+PSEntgikWBqd5V0Rv9kIHLuIOjnJgyjFoVxvnL+1Fzj/I9sIBhqpJGAtrXOK0xxcDq5SAsT6nrkoRiDuD5OJsoPUjRDz9kIU9otUEiDAC3i9ebiBHjPKE5XBII8nnaxhDbqgdw6l7Ty7Q77S6UKIlmKVMiRwdFfq1vJ1Q04rdIiGv7NPu/1eTcEDkBfzsUfZUvZyxisojWZXjboJSh+7nRNRf5wcNA/ua/r52TJgcWyXQ14TzAxA==
X-MS-Exchange-AntiSpam-MessageData: jYtovzZCUk1fs5rYV/m1WOn/bYcEF6SULYtTms5POAcqZmSoAnYjsYvT6ckD4uOjXohEbi7RFvyPskrv1bGCIFl2hgTC9+hG5vGUZpBr4YiRBD01DnzpZ0urWDa+30FOjr6r88QVMCbhWIPOjOtsdg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca9bfc6b-1a16-4242-69aa-08d7d26e8fc1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 16:47:40.0444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Xzyt6rLtkMMHLirtYAvK4mXG9gth9mFvw44VAD8u2sAfgeny26SnVKOVqlbOeOQ0QCntrgRuYjdLvn+JvaMNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------456B615C93724A699A05DEC0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2020/3/27 22:29, Mark Rutland 写道:
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
> Is this just to demonstrate the behaviour, or is this meant to be
> indicative of a real use-case? I'm struggling to see the latter.
>
>> problem symptom:
>> after Process B write a value to the Physical Address,
>> Process A of the value of global variable does not change.
>> They both W/R the same Physical Address.
> If Process A is not using the same attributes as process B, there is no
> guarantee of coherency. How did process A map this memory?


about 2 Process:

Process A:

the memory is not declared by map function, it is just a global variable.

only by /proc/self/pagemap to get its Physical Address.

I attached the codes(wrl-cache-coh-test.c)

Process B:

it is command of "devmem" in busybox, it writes a value to Physical Address.

it uses open(O_SYNC) and mmap.


>> technical reason:
>> Process B writing the Physical Address is by the Virtual Address,
>> and the Virtual Address comes from "/dev/mem" and mmap().
>> In arm64 arch, the Virtual Address has write cache.
>> So, maybe the value is not written into Physical Address.
> I don't think that's true. I think what's happening here is:
>
> * Process A has a Normal WBWA Cacheable mapping.
> * Process B as a Normal Non-cacheable mapping.
> * Process B's write does not snoop any caches, and goes straight to
>    memory.
> * Process A reads a value from cache, which does not include process B's
>    write.
>
> That's a natural result of using mismatched attributes, and is
> consistent with the O_SYNC flag meaning that the write "is transferred
> to the underlying hardware".


if you agree that O_SYNC flag means "is transferred to the underlying 
hardware",

the arm64 does not do that:

when use O_SYNC flag under arm64 arch, it adds write cache feature,

so, it is no guarantee "transferred to hardware".

=====

arch/arm64/mm/mmu.c
phys_mem_access_prot(){
   else if (file->f_flags & O_SYNC)
     return pgprot_writecombine(vma_prot);}

=====


by my test without the write cache, even if Process A is not using the 
same attributes as process B,

it has guarantee of coherency:

when Process B change value, Process B can see the change, too.


Thanks,

LiWang.


my email server seems to reject to send to 
linux-arm-kernel@lists.infradead.org,

the info is in another email not showing in 
linux-arm-kernel@lists.infradead.org:


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
> This will change behaviour that other software may be relying upon, and
> as above I do not believe this actually solves the problem you describe.
>
> Thanks,
> Mark.
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
>> -- 
>> 2.24.1
>>

--------------456B615C93724A699A05DEC0
Content-Type: text/plain; charset=UTF-8;
 name="cache-test.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="cache-test.c"

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRpbnQuaD4KI2luY2x1ZGUgPHVuaXN0ZC5o
PgoKc3RhdGljIHVpbnRwdHJfdCB2aXJ0X3RvX3BoeXNfYWRkcmVzcyh1aW50cHRyX3QgdmFkZHIp
CnsKCUZJTEUgKnBhZ2VtYXA7Cgl1aW50cHRyX3QgcGFkZHIgPSAwOwoJb2ZmX3Qgb2Zmc2V0ID0g
KHZhZGRyIC8gc3lzY29uZihfU0NfUEFHRVNJWkUpKSAqIHNpemVvZih1aW50NjRfdCk7Cgl1aW50
NjRfdCBlOwoKCS8qIGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL0RvY3VtZW50YXRpb24vdm0v
cGFnZW1hcC50eHQgKi8KCWlmICgocGFnZW1hcCA9IGZvcGVuKCIvcHJvYy9zZWxmL3BhZ2VtYXAi
LCAiciIpKSkgewoJCWlmIChsc2VlayhmaWxlbm8ocGFnZW1hcCksIG9mZnNldCwgU0VFS19TRVQp
ID09IG9mZnNldCkgewoJCQlpZiAoZnJlYWQoJmUsIHNpemVvZih1aW50NjRfdCksIDEsIHBhZ2Vt
YXApKSB7CgkJCQlpZiAoZSAmICgxVUxMIDw8IDYzKSkgeyAvKiBwYWdlIHByZXNlbnQgPyAqLwoJ
CQkJCS8qIHBmbiBtYXNrICovCgkJCQkJcGFkZHIgPSBlICYgKCgxVUxMIDw8IDU0KSAtIDEpOwoJ
CQkJCXBhZGRyID0gcGFkZHIgKiBzeXNjb25mKF9TQ19QQUdFU0laRSk7CgkJCQkJLyogYWRkIG9m
ZnNldCB3aXRoaW4gcGFnZSAqLwoJCQkJCXBhZGRyIHw9ICh2YWRkciAmIChzeXNjb25mKF9TQ19Q
QUdFU0laRSkgLSAxKSk7CgkJCQl9CgkJCQllbHNlCgkJCQkJcHJpbnRmKCIlczogTm8gcGFnZSBw
cmVzZW50XG4iLCBfX2Z1bmNfXyk7CgkJCX0KCQkJZWxzZQoJCQkJcHJpbnRmKCIlczogZnJlYWQg
ZmFpbGVkXG4iLCBfX2Z1bmNfXyk7CgkJfQoJCWVsc2UKCQkJcHJpbnRmKCIlczogbHNlZWsgZGlk
IG5vdCBmaW5kXG4iLCBfX2Z1bmNfXyk7CgoJCWZjbG9zZShwYWdlbWFwKTsKCX0KCWVsc2UKCQlw
cmludGYoIiVzOiBQYWdlbWFwIG9wZW4gZmFpbGVkXG4iLCBfX2Z1bmNfXyk7CgoJcmV0dXJuIHBh
ZGRyOwp9Cgp2b2xhdGlsZSB1aW50MzJfdCB2YXI9MDsKCmludCBtYWluKCkKewogICB2b2lkKiBw
aHlzX2FkZHIgPSB2aXJ0X3RvX3BoeXNfYWRkcmVzcygmdmFyKTsKICAgcHJpbnRmKCIlcCAlcFxu
IiwgJnZhciwgcGh5c19hZGRyKTsKICAgd2hpbGUoIHZhcj09MCApCiAgICAgIHNsZWVwKDEpOwog
ICBwcmludGYoImRvbmVcbiIpOwogICBmZmx1c2goc3Rkb3V0KTsKICAgcmV0dXJuIDA7Cn0K

--------------456B615C93724A699A05DEC0--
