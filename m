Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A14C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DDEC22224
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dLe9dBSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgGNMBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:01:44 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56591 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726332AbgGNMBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594728102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NzuBDHY8WxHVw+Kc5uxbtm+Tv/UGUbdolVzEdoMmBhE=;
        b=dLe9dBSR9M22lUiewVkUKzlGVErNUDlbdK76Jkp+dcTjjXG+OOBBtpV6ASU6Om/TIRqxDV
        IrMbodwMAweYCRh4kcBVo4r0JuUvnVSw17t7933z9Sm05osEfLD3hWU2y0Z3MZtk5kjsdp
        6nGO1Qs2jNe2tag6bvovoOKZulGkdLg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-_mSLh9LIO06BuCc_3WfXRg-1; Tue, 14 Jul 2020 08:01:37 -0400
X-MC-Unique: _mSLh9LIO06BuCc_3WfXRg-1
Received: by mail-wm1-f69.google.com with SMTP id s134so3613622wme.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 05:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NzuBDHY8WxHVw+Kc5uxbtm+Tv/UGUbdolVzEdoMmBhE=;
        b=S+URF2NwE+erbNCGzqyn6hAZtZc7i71l8ySUJLDY+fYYSJEv8KNaUuVhEP7NhnIoDP
         fUEfDtXmlapeM74SA/COscRnibiwdNXkX0LtsJt2xWvoZNbjX/PvcfJaMuenyXNPWaJu
         CItJR6ScFbdMubtUBc4gV4ltqEZRun4vbhQ07FQyGPWCP7/Venl4q1X4y7BLAJ88/02H
         CSedzH5EZCbcalnk3VwmHeCJ5GvSxcQKDxxIA+dxmeTtyurgR7Ejc7mhlg61lksICkWr
         IeW0fmwLUcuyKZ9wBodG9LfIY/1mwhUw7RyBn6r8OP9hGBIEq7ufAS3th2djGAEIJUek
         WbyQ==
X-Gm-Message-State: AOAM530VcOE38UoRnpnZJiUmrsgsDUC/0OxlXt9b75mrivjRuvfJo1CH
        UvdltYzS6IYg6J1i0fnep5SNNkh33u4XcZgvvByLuM/QX9RNN16ENlSWDqNBVtb1d4kWZrYbGJR
        USGAqKhrefTLRulL43vLvzpx0
X-Received: by 2002:a05:6000:46:: with SMTP id k6mr4915626wrx.102.1594728095803;
        Tue, 14 Jul 2020 05:01:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRWb7tTc7UzuLqaB4EtVaorEanJOKFyDzDcud2e1J9/uU8AvfG3tw0yBdSHRwNxyEMbrjmtQ==
X-Received: by 2002:a05:6000:46:: with SMTP id k6mr4915596wrx.102.1594728095573;
        Tue, 14 Jul 2020 05:01:35 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id v7sm29697902wrp.45.2020.07.14.05.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 05:01:34 -0700 (PDT)
Subject: Re: [PATCH 08/32] usb: typec: tcpm: tcpm: Remove dangling unused
 'struct tcpm_altmode_ops'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <20200706133341.476881-1-lee.jones@linaro.org>
 <20200706133341.476881-9-lee.jones@linaro.org>
 <ca14707c-7d40-07ac-da1d-ca27a2e93dcd@redhat.com>
 <20200706142051.GA3500@dell>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <65f27abc-69c8-3877-be5b-e5e478153af9@redhat.com>
Date:   Tue, 14 Jul 2020 14:01:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200706142051.GA3500@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/6/20 4:20 PM, Lee Jones wrote:
> On Mon, 06 Jul 2020, Hans de Goede wrote:
> 
>> Hi,
>>
>> On 7/6/20 3:33 PM, Lee Jones wrote:
>>> Looks as though a079973f462a3 ("usb: typec: tcpm: Remove tcpc_config
>>> configuration mechanism") pulled out the only use of 'tcpm_altmode_ops'
>>> last year.  No need to keep it around.
>>>
>>> Fixes the following W=1 kernel build warning(s):
>>>
>>>    drivers/usb/typec/tcpm/tcpm.c:1551:39: warning: ‘tcpm_altmode_ops’ defined but not used [-Wunused-const-variable=]
>>>    1551 | static const struct typec_altmode_ops tcpm_altmode_ops = {
>>>    | ^~~~~~~~~~~~~~~~
>>>
>>> Cc: Guenter Roeck <linux@roeck-us.net>
>>> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>
>> This is necessary for adding Display port over Type-C support
>> on devices using the tcpm code, rather then firmware, to do
>> the Type-C alt-mode negotiation.
>>
>> I have a local patch in my tree which adds support for this.
>>
>> But Heikki did not like my approach, so that patch
>> (which needs the bits you are removing) never landed
>> upstream:
>>
>> https://patchwork.kernel.org/patch/11199517/
>>
>> Which is somewhat old now.
> 
> Yes, that's a just a little old now.
> 
> If it drags on for much longer, perhaps consider taking it out for the
> time being and adding it back when you start to make use of it again?

Ok, I've just submitted a reworked patch-series upstream which
actually uses this code. So please drop this patch from your
patch-set.

Regards,

Hans


s

