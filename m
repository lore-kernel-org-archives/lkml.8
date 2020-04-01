Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FE3C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407FA20776
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cpha4d1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732663AbgDANnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 09:43:31 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20117 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732542AbgDANna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 09:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585748609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XzafInbiLtrFaORuQrAgxZGHTGoP3uSncshCN4K23O4=;
        b=cpha4d1muKQIn6ga8W1EVhtRr1UqgVEw3UAOH+Rt9rMmqJDlG5BCpa1Mid8B6KYvjnHpdQ
        zLUWwDblCYcXTHogONNJXa3qVYr8N4xV68Ue8J2+6mLJTCaziQiNSiurEiwi2XubeuzmpG
        X2FpMLx5KndLs4+bGf4w21YsL6CfvXE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-Qpqvbq95O8eNh1qcOcdo3Q-1; Wed, 01 Apr 2020 09:43:25 -0400
X-MC-Unique: Qpqvbq95O8eNh1qcOcdo3Q-1
Received: by mail-wr1-f70.google.com with SMTP id d1so14558436wru.15
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 06:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XzafInbiLtrFaORuQrAgxZGHTGoP3uSncshCN4K23O4=;
        b=HsgqNOG1GtqGeKSYuzifE/iUndgkDabHpanKfZTITquRRVxPK6iQZy6R0Xg/IsADo3
         3qEFPMKnDuWzUB6sRMHBnG750lFMc7AystXfx/EjJ1POsyGJkPDIDHxL+e3OPb/MgLTD
         0rkJ10vHo+6DDmqOJQMaOA/cyZFXe350WqvOMNv2AiQ1O+8kaDaIj5Mq0jLh3BsYdccF
         eDLFVriaQnZBxawH49O7tgPxwK79T2DSc/tTiUHG/iQyOTfPzCggVxJIy0x66TP/LN16
         rCLdUjdvZzdJ43xq3kUAnozOw92KD09bYI2JCKfYG1Q+6oYR8HMl2R6I0QtT5S7hiBIV
         qmfg==
X-Gm-Message-State: AGi0PuY6yUqLHnVwAlQTw07NwtpJzR8pTDGpd1vEroH9F6bUglHXav4n
        aJb/ydIcsBWNzKCPfp9NVqFAnKVTn5hWdJw7GkfcfEm/r0fZx/5u8NBry8rRvUD9NDtcWdmrNvz
        J4W4qH/gf55QzgcGkQH75nmxw
X-Received: by 2002:a1c:f619:: with SMTP id w25mr4318052wmc.59.1585748604230;
        Wed, 01 Apr 2020 06:43:24 -0700 (PDT)
X-Google-Smtp-Source: APiQypLVugSzcMieYFJ31lPsez4OgD6abejhefiSvRKpEEbB98h0d4ofSIHHNeoqIJRQ8NYTeoTL7Q==
X-Received: by 2002:a1c:f619:: with SMTP id w25mr4318039wmc.59.1585748604021;
        Wed, 01 Apr 2020 06:43:24 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:58d:8400:ecf6:58e2:9c06:a308? ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id l185sm2742164wml.44.2020.04.01.06.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 06:43:23 -0700 (PDT)
Subject: Re: [PATCH v2 04/10] objtool: check: Ignore empty alternative groups
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, raphael.gault@arm.com
References: <20200327152847.15294-1-jthierry@redhat.com>
 <20200327152847.15294-5-jthierry@redhat.com>
 <alpine.LSU.2.21.2004011450100.15809@pobox.suse.cz>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <1f53ee68-3bcc-7de9-beb9-df812b2e3613@redhat.com>
Date:   Wed, 1 Apr 2020 14:43:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.2004011450100.15809@pobox.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/1/20 1:53 PM, Miroslav Benes wrote:
> On Fri, 27 Mar 2020, Julien Thierry wrote:
> 
>> Atlernative section can contain entries for alternatives with no
>> instructions. Objtool will currently crash when handling such an entry.
>>
>> Just skip that entry, but still give a warning to discourage useless
>> entries.
>>
>> Signed-off-by: Julien Thierry <jthierry@redhat.com>
>> ---
>>   tools/objtool/check.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
>> index 74353b2c39ce..5c03460f1f07 100644
>> --- a/tools/objtool/check.c
>> +++ b/tools/objtool/check.c
>> @@ -904,6 +904,12 @@ static int add_special_section_alts(struct objtool_file *file)
>>   		}
>>   
>>   		if (special_alt->group) {
>> +			if (!special_alt->orig_len) {
>> +				WARN_FUNC("empty alternative entry",
>> +					  orig_insn->sec, orig_insn->offset);
>> +				continue;
>> +			}
>> +
>>   			ret = handle_group_alt(file, special_alt, orig_insn,
>>   					       &new_insn);
>>   			if (ret)
> 
> Probably the first time I am looking at alternatives handling in objtool,
> so I must be missing something, but is this even possible now? I mean
> get_alt_entry() in special.c sets alt->orig_len when alt->group is true
> (which means .alternatives section) to something which cannot be zero.
> 

What I see is:

	if (alt->group) {
		alt->orig_len = *(unsigned char *)(sec->data->d_buf + offset +
						   entry->orig_len);
		alt->new_len = *(unsigned char *)(sec->data->d_buf + offset +
                                                   entry->new_len);
	}


And as far as I can tell, "alt->orig_len" can be 0 if the entry in the 
.altinstructions section of the .o file has the length set to 0.

I don't know how the alternative section generation works on x86, but on 
arm64 it's just a computed assembly offset which can be 0.

> Is this a preparatory patch for arm64, where this could happen? If yes, it
> would be better to mention it in the changelog.
> 

It used to happen on arm64, but the fix [1] was picked.

I can add that link to the commit if necessary.

[1] https://lkml.org/lkml/2020/1/9/708

Cheers,

-- 
Julien Thierry

