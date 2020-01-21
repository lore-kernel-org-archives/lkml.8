Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81796C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57DCF20882
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VX2r/6ZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgAUKwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:52:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38540 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726052AbgAUKwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:52:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579603921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V6z6VMHQRuZ71QFFUl75dnxsvN2jLBKErbicOLLiKQU=;
        b=VX2r/6ZXSEDMeKId8nOGy5TIdamg5yakQ3+D0aFUqdr2lhrcuik1BMNEkAZgjMlTX587B0
        5DMgkLsMWuKR7tXUDSENpjdi9TGmJSSCnr9YDgML5BLe5rw0z/oLlP03eHCmW7Tr4KgD+N
        8ja7SqJK6ZGAUuhz9nBuKautxm1thAI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-E4IA0i3SP9iP7iMNt_uyPg-1; Tue, 21 Jan 2020 05:50:56 -0500
X-MC-Unique: E4IA0i3SP9iP7iMNt_uyPg-1
Received: by mail-wr1-f69.google.com with SMTP id f15so1151559wrr.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 02:50:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V6z6VMHQRuZ71QFFUl75dnxsvN2jLBKErbicOLLiKQU=;
        b=EU/zRmcNKZT2dPqfH1gjuElSLfCdmYEE7YpiNan3CViAKQndW5y8v3DOwKwzgiQzjm
         TLQUM7H5Jcdv2VDOoOI57zbgsZK6C1Y6lfS1d1fo4+L2QNTq+q0eWAaHCKXNIQFvuLz4
         FxBvBBWnZs9wm2DcR1dq/3KyKCVu/5ff3hW2bKpMWPIVnn4V+/rgI9n1ZyzKLB0jWDf7
         BBvoL4YiuP0MLsrSzAtavu40vNPnUxWZHFydDeVhqZ7fubaDXzuJHjJOfWazEOvphfWl
         5VlUXBOFFfFD6Mr4re0KGFWyoIX+AK7Z9kwdcX8vpsQ0Jr9BgeTb+gmiMkMy0WIduRGo
         7RFw==
X-Gm-Message-State: APjAAAWxv4P0Dwe2KY5YSANPcnfX0kno81Q9dxI1boMRQwNjBiLiG6KE
        Cqe6mtvpzZaLDHpHMAZAAnHGD2bYmac39LnRhA97SzlStW+Q/ICIp9+nvgQ51nqmZ9KW7usxYAB
        V55m27/VoQCWob176D4vsBR8U
X-Received: by 2002:a7b:cb01:: with SMTP id u1mr3853824wmj.156.1579603854818;
        Tue, 21 Jan 2020 02:50:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqxX1Xw2u+ogi7FugqbtA5dPIMYvwCnIn6jc/X1zPZECXUuxOc5Z3dQGa+aCINYeOlO8bo9l2g==
X-Received: by 2002:a7b:cb01:: with SMTP id u1mr3853798wmj.156.1579603854510;
        Tue, 21 Jan 2020 02:50:54 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b509:fc01:ee8a:ca8a? ([2001:b07:6468:f312:b509:fc01:ee8a:ca8a])
        by smtp.gmail.com with ESMTPSA id h8sm54673071wrx.63.2020.01.21.02.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 02:50:54 -0800 (PST)
Subject: Re: [PATCH 1/2] pvpanic: introduce crashloaded for pvpanic
To:     Markus Armbruster <armbru@redhat.com>,
        zhenwei pi <pizhenwei@bytedance.com>
Cc:     yelu@bytedance.com, libvir-list@redhat.com,
        gregkh@linuxfoundation.org, qemu-devel@nongnu.org,
        linux-kernel@vger.kernel.org, mprivozn@redhat.com
References: <20200110100634.491936-1-pizhenwei@bytedance.com>
 <20200110100634.491936-2-pizhenwei@bytedance.com>
 <87h80pi5hf.fsf@dusky.pond.sub.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <247586dd-576a-a0c9-9c43-5d9a310a4ddc@redhat.com>
Date:   Tue, 21 Jan 2020 11:50:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87h80pi5hf.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/20 09:22, Markus Armbruster wrote:
> zhenwei pi <pizhenwei@bytedance.com> writes:
> 
>> Add bit 1 for pvpanic. This bit means that guest hits a panic, but
>> guest wants to handle error by itself. Typical case: Linux guest runs
>> kdump in panic. It will help us to separate the abnormal reboot from
>> normal operation.
>>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
>>  docs/specs/pvpanic.txt | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/docs/specs/pvpanic.txt b/docs/specs/pvpanic.txt
>> index c7bbacc778..bdea68a430 100644
>> --- a/docs/specs/pvpanic.txt
>> +++ b/docs/specs/pvpanic.txt
>> @@ -16,8 +16,12 @@ pvpanic exposes a single I/O port, by default 0x505. On read, the bits
>>  recognized by the device are set. Software should ignore bits it doesn't
>>  recognize. On write, the bits not recognized by the device are ignored.
>>  Software should set only bits both itself and the device recognize.
> 
> Guest software, I presume.
> 
>> -Currently, only bit 0 is recognized, setting it indicates a guest panic
>> -has happened.
>> +
>> +Bit Definition
>> +--------------
>> +bit 0: setting it indicates a guest panic has happened.
>> +bit 1: named crashloaded. setting it indicates a guest panic and run
>> +       kexec to handle error by guest itself.
> 
> Suggest to scratch "named crashloaded."

bit 1: a guest panic has happened and will be handled by the guest;
       the host should record it or report it, but should not affect
       the execution of the guest.

?

Paolo

