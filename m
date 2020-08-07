Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95227C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 04:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 771D222D06
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 04:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgHGEXA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 00:23:00 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:52662 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725379AbgHGEXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 00:23:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0U4zfFVC_1596774176;
Received: from 30.27.116.2(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0U4zfFVC_1596774176)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 Aug 2020 12:22:57 +0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/3] scripts/sorttable: Change section type of orc_lookup
 to SHT_PROGBITS
From:   changhuaixin <changhuaixin@linux.alibaba.com>
In-Reply-To: <20200806150810.GA2127855@gmail.com>
Date:   Fri, 7 Aug 2020 12:22:56 +0800
Cc:     changhuaixin <changhuaixin@linux.alibaba.com>, bp@alien8.de,
        hpa@zytor.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, luto@amacapital.net,
        michal.lkml@markovi.net, mingo@redhat.com,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        x86@kernel.org, yamada.masahiro@socionext.com, jpoimboe@redhat.com
Content-Transfer-Encoding: 8BIT
Message-Id: <C605557D-951C-4FA7-9CE2-940B92FD198D@linux.alibaba.com>
References: <20200723034643.33537-1-changhuaixin@linux.alibaba.com>
 <20200723034643.33537-2-changhuaixin@linux.alibaba.com>
 <2714DF66-5F65-4CB1-A232-B88E4D5AF566@linux.alibaba.com>
 <20200806150810.GA2127855@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 6, 2020, at 11:08 PM, Ingo Molnar <mingo@kernel.org> wrote:
> 
> 
> * changhuaixin <changhuaixin@linux.alibaba.com> wrote:
> 
>> Hi, Ingo
>> 
>> Another way to write SHT_PROGBITS is using elf_create_section to write orc_lookup table headers, when orc_unwind_ip table and orc_unwind table are written. Is this a better solution?
>> 
>> diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
>> index 3f98dcfbc177..860d4dcec8e6 100644
>> --- a/tools/objtool/orc_gen.c
>> +++ b/tools/objtool/orc_gen.c
>> @@ -183,6 +183,10 @@ int create_orc_sections(struct objtool_file *file)
>>        u_sec = elf_create_section(file->elf, ".orc_unwind",
>>                                   sizeof(struct orc_entry), idx);
>> 
>> +       /* make flags of section orc_lookup right */
>> +       if (!elf_create_section(file->elf, ".orc_lookup", sizeof(int), 0))
>> +               return -1;
>> +
>>        /* populate sections */
>>        idx = 0;
>>        for_each_sec(file, sec) {
> 
> Looks much nicer IMO.
> 
> Mind turning this into a proper patch that does it plus reverts the 
> hack?
> 
A new patchset is sent.

Thanks,
huaixin

> Thanks,
> 
> 	Ingo

