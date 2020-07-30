Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA325C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82BC520829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKhoViOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbgG3OnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 10:43:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33426 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729387AbgG3OnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596120180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=whEyUcY+ZzprUC9AdTz54JwJP2QolK0F7VwewK1gE8M=;
        b=UKhoViOXz0j/L3IYS27aQzODnVKLMATPHW9vWgDE1Ui8OFHftewezRpMAyWsbgFSpCQbTA
        jqIvhjupVvfAJgkHCDAAXMJu57bD7tvu/Z588sfeigkzZdeaptg26920hVCJGucOwj0iUc
        1oxKVmBS9IqZI/g9Z/mDFJ6IZiOLQfE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-5HbZ5gVxMum6Si9jUlejew-1; Thu, 30 Jul 2020 10:42:58 -0400
X-MC-Unique: 5HbZ5gVxMum6Si9jUlejew-1
Received: by mail-wr1-f70.google.com with SMTP id v4so8074356wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 07:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=whEyUcY+ZzprUC9AdTz54JwJP2QolK0F7VwewK1gE8M=;
        b=QrdZZy2dzpJsOXZ0o8uVSsVkySn28LCoGl56S1TRCsS20Qd6ZrGpIdgL/7sdAaDTLS
         9NMgIbWHxy8sF1xIjyTIpHwf0hfhwjTfnp2vOXNKUuYdjbuwscK2YH0O9L7OCA56ziG/
         n4bNucLNWWJx+BAHwnqSm9HBQ2LVxIR8Gyghb80GsqnkGHT1onFgZGGL7Jr5pvDpDfjA
         36JkUqqajrxIrYrFImrSPAwanjcRG+mkr9e+KZhZzj/Wb+OOk9PjHOpqcfUmF2i2xaOE
         YIa0NpgA1IxDl/BJw/lLBshW8OzIpTCvKqqXa4/v4rqOw6gm5MLbbeTXmP8GbVLCd6ev
         r9eQ==
X-Gm-Message-State: AOAM531Nb4koU/0artwpXcbOXvpNIaQQ+Wm9vDMjw9cM7M6bmcclasuE
        TA1dh9ND5+g7j09zrvuRh89p3JLxyMLYAJVF4SCjypYS1K3LX6qRbh35a7aANMm0USmrkU5Sv3V
        W0MZpWmd45xg1lb19l703mnvl
X-Received: by 2002:a7b:c84f:: with SMTP id c15mr7299016wml.133.1596120176696;
        Thu, 30 Jul 2020 07:42:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlsyRAN9CQ3YKN7kgXOyI70ATEpeUOq7YqsJCVOWsQ4DXL/BY9zqB+0SSwpysdnIkVlm6Cjw==
X-Received: by 2002:a7b:c84f:: with SMTP id c15mr7299001wml.133.1596120176479;
        Thu, 30 Jul 2020 07:42:56 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id l1sm11128047wrb.12.2020.07.30.07.42.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 07:42:55 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] objtool: Move object file loading out of check
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mhelsley@vmware.com, mbenes@suse.cz
References: <20200730094143.27494-1-jthierry@redhat.com>
 <20200730094143.27494-2-jthierry@redhat.com>
 <20200730140936.uvw73r655356lhtm@treble>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <f0b948c8-c824-4d8e-6a0b-20cde05444d7@redhat.com>
Date:   Thu, 30 Jul 2020 15:42:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200730140936.uvw73r655356lhtm@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/30/20 3:09 PM, Josh Poimboeuf wrote:
> On Thu, Jul 30, 2020 at 10:41:40AM +0100, Julien Thierry wrote:
>> +struct objtool_file *objtool_setup_file(const char *_objname)
>> +{
>> +	if (objname) {
>> +		if (strcmp(objname, _objname)) {
>> +			WARN("won't handle more than one file at a time");
>> +			return NULL;
>> +		}
>> +		return &file;
>> +	}
>> +	objname = _objname;
>> +
>> +	file.elf = elf_open_read(objname, O_RDWR);
>> +	if (!file.elf)
>> +		return NULL;
>> +
>> +	INIT_LIST_HEAD(&file.insn_list);
>> +	hash_init(file.insn_hash);
>> +	file.c_file = find_section_by_name(file.elf, ".comment");
>> +	file.ignore_unreachables = no_unreachable;
>> +	file.hints = false;
>> +
>> +	return &file;
>> +}
> 
> How about calling it objtool_open_read()?  It's (sort of) a wrapper
> around elf_open_read().
> 

Sure, I'll update that.

Thanks,

-- 
Julien Thierry

