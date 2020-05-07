Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91634C28CBC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 01:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B97B2075A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 01:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fECPcz9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgEGBtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 21:49:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39617 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725826AbgEGBtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 21:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588816160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TK5/TPkCA1YNIr46wnEPWN0J5TK8aDr7sImaoLSYw5c=;
        b=fECPcz9fhmekTNETwLqqym4u6xoPxeVaytJdJtjMywQoboCG2k8L1erjdZG3QhwOV5mpxw
        KwR8/BpvA1oyeCFAsKTQ9StWmO8UpoqBeIcxTgh+6RnUp3VpAGeS7lpgqF38HMw1mtmuWP
        vkRmE3B+OBgPAXGmj7EvhEv58YVH+2o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-GDF1pxX9MseiT_uydVw24A-1; Wed, 06 May 2020 21:49:18 -0400
X-MC-Unique: GDF1pxX9MseiT_uydVw24A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DC67107ACCA;
        Thu,  7 May 2020 01:49:17 +0000 (UTC)
Received: from [10.10.64.2] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0071310246E7;
        Thu,  7 May 2020 01:49:15 +0000 (UTC)
Subject: Re: [PATCH] efi/libstub/x86: Free EFI map buffer in allocate_e820()
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     eric.snowberg@oracle.com, Ingo Molnar <mingo@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200505190016.4350-1-lszubowi@redhat.com>
 <CAMj1kXHsvy09V0rK2Qh0eiR4Vi5ZDn=5ordNvEBH4c-Xk00QgQ@mail.gmail.com>
From:   Lenny Szubowicz <lszubowi@redhat.com>
Message-ID: <b2eb1c06-eb7c-8cfc-6cc8-9c66cf396813@redhat.com>
Date:   Wed, 6 May 2020 21:49:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXHsvy09V0rK2Qh0eiR4Vi5ZDn=5ordNvEBH4c-Xk00QgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/20 3:23 AM, Ard Biesheuvel wrote:
> On Tue, 5 May 2020 at 21:00, Lenny Szubowicz <lszubowi@redhat.com> wrote:
>>
>> In allocate_e820(), free the EFI map buffer that has been returned
>> by efi_get_memory_map(). The returned size of the EFI map buffer
>> is used to allocate an adequately sized e820ext buffer, if it's
>> needed. But the contents of that EFI map buffer is not used at all
>> and the local pointer to it is gone on return from allocate_e820().
>>
>> Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
>> ---
>>   drivers/firmware/efi/libstub/x86-stub.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
>> index 05ccb229fb45..4efe3e7a218d 100644
>> --- a/drivers/firmware/efi/libstub/x86-stub.c
>> +++ b/drivers/firmware/efi/libstub/x86-stub.c
>> @@ -623,6 +623,9 @@ static efi_status_t allocate_e820(struct boot_params *params,
>>          if (status != EFI_SUCCESS)
>>                  return status;
>>
>> +       /* Allocated EFI map buf is not used here. Just need its size. */
>> +       efi_bs_call(free_pool, map);
>> +
> 
> Wouldn't it be better to call BS->GetMemoryMap() directly here, with a
> zero size for the input buffer?

I agree, that's a good suggestion. V2 coming shortly after testing.

> 
>>          nr_desc = buff_size / desc_size;
>>
>>          if (nr_desc > ARRAY_SIZE(params->e820_table)) {
>> --
>> 2.18.4
>>
> 

