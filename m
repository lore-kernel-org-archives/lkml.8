Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2666FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 797AF2065D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihkW/azm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389776AbgEMQ5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 12:57:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24956 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727120AbgEMQ5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589389061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TsxSghf7MNf8lrzt7f1NuiWBq67H+L8HsCSjzXb5Uq4=;
        b=ihkW/azmA417lidWGUCorMcKpWTK3iQutfOULZuCcHRPdLHd/mMR+R+SjxdOEuo9YeZoBt
        p1JhoZzUkuLcGqe3mcI4io+QEchq6ljBkByyrEfhZImI9GMNMpQ52Kn9q+Q1e/sh8+99xG
        uQa3hymYimEuRxnCvDB+RBg9BngwtQ8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-HjHzM1r3M2KzAdZEw5iwWQ-1; Wed, 13 May 2020 12:57:37 -0400
X-MC-Unique: HjHzM1r3M2KzAdZEw5iwWQ-1
Received: by mail-wm1-f69.google.com with SMTP id n66so1897210wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 09:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TsxSghf7MNf8lrzt7f1NuiWBq67H+L8HsCSjzXb5Uq4=;
        b=fBENK2RwFjCpvCtf+1z0d9zbgk5VRcWKSogwPwiB10Eosjq43Z+JqCjY7CZ6QY1Zq8
         fnSxEd+KuS262jIaBQ2SVcQd3ak3F9A9GKHJuTXxrt6MF5FRHjodXHjewPqAIzZYQ8K6
         tqZB5PggfH294OudxiD/6uTiaNA+rSOoYMP34gRz/58ZYcWuSYmyRvKApWdJ84KnBE9L
         d4gyoPVuNxNOPTYNHNPtXNmXs3eTMrpBkVbWVIxos7ga3SCv1W3MLoWjApN/6fYFO6W9
         CmCrm/tria+iiXMXRQ9N1ilEo0I/K8GNLncKfDeReCzVYF2MqnE8iJqxtjn2Q0XV9T6S
         wQ6w==
X-Gm-Message-State: AOAM533GuKTvblQc0mj8pRogGt4vAz6FF6N1P3lonICGPJ0O/A9B4y9C
        XqmzUprt0EkdzahEEZXdQNzWoauPLoCgXPIldvQuDRP76DdklybD2f+ZMIcmytCkGEV2em7x9Ix
        2HWlXRMX2qg4CJvqsYALA3Ott
X-Received: by 2002:a1c:6383:: with SMTP id x125mr6588338wmb.165.1589389056759;
        Wed, 13 May 2020 09:57:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyj8p+RYxwgl01K8TGQDzDHFIR3LmsqjtBpKkaLFIMPU6LGzrOZS6f+FmTJj1vlAutHicKbLQ==
X-Received: by 2002:a1c:6383:: with SMTP id x125mr6588310wmb.165.1589389056434;
        Wed, 13 May 2020 09:57:36 -0700 (PDT)
Received: from [192.168.1.27] (lfbn-lyo-1-134-107.w86-202.abo.wanadoo.fr. [86.202.218.107])
        by smtp.gmail.com with ESMTPSA id r3sm13050153wmh.48.2020.05.13.09.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 09:57:35 -0700 (PDT)
Subject: Re: [RFC][PATCH 3/5] objtool: Add support for relocations without
 addends
To:     Matt Helsley <mhelsley@vmware.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1588888003.git.mhelsley@vmware.com>
 <17ee3f6f2a246008aaae70f92df24ae92fa0e21e.1588888003.git.mhelsley@vmware.com>
 <f79a3872-b9ad-a966-71fb-4451e0901281@redhat.com>
 <20200513162648.GJ9040@rlwimi.vmware.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <61c35ce2-47b3-1f62-d4ec-da9984289c5d@redhat.com>
Date:   Wed, 13 May 2020 17:55:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200513162648.GJ9040@rlwimi.vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/13/20 5:26 PM, Matt Helsley wrote:
> On Tue, May 12, 2020 at 06:04:50PM +0100, Julien Thierry wrote:
>> Hi Matt,
>>
>> On 5/11/20 6:35 PM, Matt Helsley wrote:
>>> Currently objtool only collects information about relocations with
>>> addends. In recordmcount, which we are about to merge into objtool,
>>> some supported architectures do not use rela relocations. Since
>>> object files use one or the other the list can be reused.
>>>
>>> Signed-off-by: Matt Helsley <mhelsley@vmware.com>
>>> ---
>>>    tools/objtool/elf.c | 55 ++++++++++++++++++++++++++++++++++++---------
>>>    tools/objtool/elf.h |  5 ++++-
>>>    2 files changed, 49 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
>>> index c4857fa3f1d1..cd841e3df87d 100644
>>> --- a/tools/objtool/elf.c
>>> +++ b/tools/objtool/elf.c
>>> @@ -465,12 +465,14 @@ static int read_relas(struct elf *elf)
>>>    	unsigned long nr_rela, max_rela = 0, tot_rela = 0;
>>>    	list_for_each_entry(sec, &elf->sections, list) {
>>> -		if (sec->sh.sh_type != SHT_RELA)
>>> +		if ((sec->sh.sh_type != SHT_RELA) &&
>>> +		     (sec->sh.sh_type != SHT_REL))
>>>    			continue;
>>> -		sec->base = find_section_by_name(elf, sec->name + 5);
>>> +		sec->base = find_section_by_name(elf, sec->name +
>>> +				((sec->sh.sh_type != SHT_REL) ? 5 : 4));
>>>    		if (!sec->base) {
>>> -			WARN("can't find base section for rela section %s",
>>> +			WARN("can't find base section for relocation section %s",
>>>    			     sec->name);
>>>    			return -1;
>>>    		}
>>> @@ -486,13 +488,26 @@ static int read_relas(struct elf *elf)
>>>    			}
>>>    			memset(rela, 0, sizeof(*rela));
>>> -			if (!gelf_getrela(sec->data, i, &rela->rela)) {
>>> -				WARN_ELF("gelf_getrela");
>>> -				return -1;
>>> +			switch(sec->sh.sh_type) {
>>> +			case SHT_REL:
>>> +				if (!gelf_getrel(sec->data, i, &rela->rel)) {
>>> +					WARN_ELF("gelf_getrel");
>>> +					return -1;
>>> +				}
>>> +				rela->addend = 0;
>>> +				break;
>>> +			case SHT_RELA:
>>> +				if (!gelf_getrela(sec->data, i, &rela->rela)) {
>>> +					WARN_ELF("gelf_getrela");
>>> +					return -1;
>>> +				}
>>> +				rela->addend = rela->rela.r_addend;
>>> +				break;
>>> +			default:
>>> +				break;
>>>    			}
>>>    			rela->type = GELF_R_TYPE(rela->rela.r_info);
>>> -			rela->addend = rela->rela.r_addend;
>>>    			rela->offset = rela->rela.r_offset;
>>>    			symndx = GELF_R_SYM(rela->rela.r_info);
>>>    			rela->sym = find_symbol_by_index(elf, symndx);
>>> @@ -717,17 +732,27 @@ int elf_rebuild_rela_section(struct section *sec)
>>>    	struct rela *rela;
>>>    	int nr, idx = 0, size;
>>>    	GElf_Rela *relas;
>>> +	GElf_Rel *rels;
>>>    	nr = 0;
>>>    	list_for_each_entry(rela, &sec->rela_list, list)
>>>    		nr++;
>>> +	/*
>>> +	 * Allocate a buffer for relocations with addends but also use
>>> +	 * it for other relocations too. The section type determines
>>> +	 * the size of the section, the buffer used, and the entries.
>>> +	 */
>>>    	size = nr * sizeof(*relas);
>>>    	relas = malloc(size);
>>>    	if (!relas) {
>>>    		perror("malloc");
>>>    		return -1;
>>>    	}
>>> +	rels = (void *)relas;
>>> +	if (sec->sh.sh_type == SHT_REL) {
>>> +		size = nr * sizeof(*rels);
>>> +	}
>>
>> This looks a bit error prone to me.
>>
>> What about having:
>>
>>      void *rel_buf;
>>      [...]
>>      size = nr * (sec->sh.sh_type == SHT_REL ? sizeof(GElf_Rel) :
>> sizeof(GElf_Rela));
> 
> I like reducing to a single size expression but I'm not a fan of hard-coding
> the GElf_Rel[a] types here -- I prefer sizeof(*relas) and sizeof(*rels)
> since that makes it clear the sizes will match the types of the pointers
> that will be used to access them. So I've changed it to:
> 
> 	size = nr * ((sec->sh.sh_type == SHT_REL) ? sizeof(*rels) : sizeof(*relas));
> 
>>      rel_buf = malloc(size);
>>      [...]
>>
>> And then casting rel_buf to the correct pointer type in the fitting switch
>> cases?
> 
> I'm thinking it's simpler with fewer variables. I don't think
> moving the cast into the switch cases makes it any clearer. It's also
> odd because we'll keep re-initializing relas or rels to rel_buf each loop
> iteration. Finally, this approach has the advantage that, when reviewing
> the patch, it's clear that the original code handling RELA relocation entries
> isn't changing -- you can see it's just shifting into one of the cases
> (below).
> 
> Do you still prefer introducing rel_buf?

On a completely personal taste, yes. I do not like having two local 
variables in the same scope pointing at the same data but with an 
implied "you should only use one or the other under the right 
circumstances".

But my main concern was having an allocation of a certain size and then 
modifying the size (might have been valid if sizeof(GElf_Rel) <= 
sizeof(GElf_Rela), but I must admit I did not bother to check). Since 
you've addressed that issue, the rest is just a matter of taste so 
better left to the maintainers.

Thanks,

-- 
Julien Thierry

