Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791D6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 11:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55325206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 11:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ARhiUqJH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgFELkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 07:40:10 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36391 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725997AbgFELkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 07:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591357207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bP4BwMd/o1/f8MtvJilZ34AAESzOCga+hYzIgdxawGo=;
        b=ARhiUqJHrJt2rV68U2tIJ6YozaojJogYXtQv/7Xppl2CMBIsHMygjbjmkoiEkPmtmgHnWk
        GX+a5+sVDQHAJ2mB37WIESiTggmsFgJ2/7dxQj4Z9CsAVlfT1beDfTmcLpfsLVW5T3Lx8F
        d2OTFA7nSVw14TlY+Dh9maPTiTi05Ho=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-lG2Hl1QIMxW1-ATRexNRQA-1; Fri, 05 Jun 2020 07:40:02 -0400
X-MC-Unique: lG2Hl1QIMxW1-ATRexNRQA-1
Received: by mail-wr1-f70.google.com with SMTP id d6so3672517wrn.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 04:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bP4BwMd/o1/f8MtvJilZ34AAESzOCga+hYzIgdxawGo=;
        b=tCUTM40oaleTKIm0bL7qoRjnf1Ov8o0ZDIbKSGZkSO5botaKfGNZE1KBR8sw8KvgOj
         koK6r/sDrYmIyZ3aQIS4Nm9r9T9iH4JtrGPe5YhRgMGJRkMks9lJajCkc3NsyhnqXEry
         NKkqOCgxXYRsZrj1dVKTZ2pwZHEzGs5LdsCMDsJoZu3iiYXtZl+p65jybCuw7RIQ5zW6
         wy1FD/Rs53dXOcpEw2mqJiNrtzUzZYjeJffaevo9GaRpkfQk/snwZZcHZ+zzTdoqEjGW
         2pn4c2BQZA3D2UKJlRcrfacZ4aeT3CPmtm9OmBJBKW4Nl2q/sRh/jc0qrZwbDVKaiuN5
         Ywag==
X-Gm-Message-State: AOAM5330siFxlUcrjibuIwVmM9wfizGIYYd0Ko5wdxoe+6sayxdbBPk8
        zJV4sMCdRCBRVje/BbiDETyx5/0cOJaOOkNzDrINDLKhvhwEVa6UgR0JzdLzuzt22W1pTW6nlGf
        e6kxf7MnAmIg0PE4LVQhVDJVb
X-Received: by 2002:a05:600c:2317:: with SMTP id 23mr2321309wmo.139.1591357201526;
        Fri, 05 Jun 2020 04:40:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuVoWW4TZmAuta52q2Iph8hJndlMVhJQEbU23SsLSXTx950R5srV5HvtKn8a7qLWESk/QSpg==
X-Received: by 2002:a05:600c:2317:: with SMTP id 23mr2321294wmo.139.1591357201352;
        Fri, 05 Jun 2020 04:40:01 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id c70sm752864wme.32.2020.06.05.04.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 04:40:00 -0700 (PDT)
Subject: Re: [PATCH 4/4] objtool: orc_gen: Move orc_entry out of instruction
 structure
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, mhelsley@vmware.com
References: <20200604163938.21660-1-jthierry@redhat.com>
 <20200604163938.21660-5-jthierry@redhat.com>
 <alpine.LSU.2.21.2006051115020.10354@pobox.suse.cz>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <3b79ffe8-dd5f-7356-ff1d-dc679ce304f7@redhat.com>
Date:   Fri, 5 Jun 2020 12:39:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.2006051115020.10354@pobox.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/5/20 10:17 AM, Miroslav Benes wrote:
> Hi,
> 
> a nit below...
> 
> On Thu, 4 Jun 2020, Julien Thierry wrote:
> 
>> One orc_entry is associated with each instruction in the object file,
>> but having the orc_entry contained by the instruction structure forces
>> architectures not implementing the orc subcommands to provide a dummy
>> definition of the orc_entry.
>>
>> Avoid that by having orc_entries in a separate list, part of the
>> objtool_file.
> 
>>   int create_orc(struct objtool_file *file)
>>   {
>>   	struct instruction *insn;
>>   
>>   	for_each_insn(file, insn) {
>> -		struct orc_entry *orc = &insn->orc;
>>   		struct cfi_reg *cfa = &insn->cfi.cfa;
>>   		struct cfi_reg *bp = &insn->cfi.regs[CFI_BP];
>> +		struct orc_entry *orc;
>> +		struct orc_data *od;
>> +
>> +		if (!insn->sec->text)
>> +			continue;
> 
> You have the same check added by the previous check a couple of lines
> below.
> 
>> +		od = calloc(1, sizeof(*od));
>> +		if (!od)
>> +			return -1;
>> +		od->insn = insn;
>> +		list_add_tail(&od->list, &file->orc_data_list);
>> +
>> +		orc = &od->orc;
>>   
>>   		if (!insn->sec->text)
>>   			continue;
> 
> Here.
> 
> The rest looks good to me, but I should probably check again with a
> clearer head.
> 

Ah, I must have messed up the patch splitting/rebasing somewhere. Thanks 
for pointing it out, this patch shouldn't add the check (but od 
allocation should happen after the existing check). I'll fix that.

> Overall, the patch set is a nice improvement.
> 

Thanks!

-- 
Julien Thierry

