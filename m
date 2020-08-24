Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F582C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 14:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40D25205CB
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 14:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFmVm/cp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgHXOfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 10:35:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43092 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725916AbgHXOfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 10:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598279718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P7czuGX0a61xYHDRfRoXX+/7/pFB5lc7BVVK0c9Yptk=;
        b=MFmVm/cpXW6Xj005eJbD4z7Tfvw4W5pNn6+GpQEgXMHbW5tiRqgkPbHc8MmkNyb2NrKJRI
        8zVNgOEe+2X/gDPEmObKajKlbXnbawE2RaeSWoKHkuzB9xWFo07m8VY28EBTlH0cXMz35R
        ZDBFqC7a2COYCh11xYnLYZXpmj8lsMk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-FKpisqmEO7ydMbA66lYidQ-1; Mon, 24 Aug 2020 10:35:16 -0400
X-MC-Unique: FKpisqmEO7ydMbA66lYidQ-1
Received: by mail-ej1-f70.google.com with SMTP id o18so2588430ejr.14
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 07:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P7czuGX0a61xYHDRfRoXX+/7/pFB5lc7BVVK0c9Yptk=;
        b=K9EaWQ8UkpeWgVte55BAvj2hM8pvt1ig+KJvZLSDaMpp7t+HnRZNckZJUf+do9cBWZ
         FDGx4/3tQIPe0oN53j5pZCGfkDNmJzw7pYMN10VHJT93ZAv7tCPrmMj46pwbV2SEL3V2
         7HfbUlo7qCXQdrSjYcvY/kro7vz8gKlHS0jHdpv9G2RjsCbroc8e5XhneZpAsfRrZSAr
         zwqiWZ7Zp8Knd5U6IcFomI1JFZI8pHtbfXJRa6x4S7sME9SAXlDhpbiKBakXcHy9XUaO
         sldi7zllTFaKngATnJW1uv423IJcX1jotidl1gHARCxFR+9JyI1sRltXLmNASo88MX6u
         6ZCA==
X-Gm-Message-State: AOAM532dDNBmGNw9KZayPZeQ04gU5arFUkTkYSVy9XC6RGq4Jon2r5AZ
        jzgP0G5UkjRhNAmiRmySq1FhZkdHm1ct2dmXc5EZ17sM/a5yQOhujFSXVltYRqiDQG8WpO4yI4R
        eQsPOyjkvKH66VWqlq2KVB/js
X-Received: by 2002:aa7:c60a:: with SMTP id h10mr1711531edq.140.1598279715104;
        Mon, 24 Aug 2020 07:35:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwylH32+YN+PEJDvCkB+BRg8BdP+9sh8RH0QPKLMm+4We8vu00g3ojtbnGxtl+ukiOByRYm/Q==
X-Received: by 2002:aa7:c60a:: with SMTP id h10mr1711515edq.140.1598279714936;
        Mon, 24 Aug 2020 07:35:14 -0700 (PDT)
Received: from x1.localdomain ([78.108.130.193])
        by smtp.gmail.com with ESMTPSA id c18sm10239445eja.13.2020.08.24.07.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 07:35:14 -0700 (PDT)
Subject: Re: [PATCH] virt: vbox: Use current_uid() in
 vbg_misc_device_requestor()
To:     Denis Efremov <efremov@linux.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20200824125330.487083-1-efremov@linux.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4f9ecef2-4ab1-e2c3-b8d4-0f24e999bd23@redhat.com>
Date:   Mon, 24 Aug 2020 16:35:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824125330.487083-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/24/20 2:53 PM, Denis Efremov wrote:
> Modify vbg_misc_device_requestor() to use current_uid() wrapper.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>

Thank you, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/virt/vboxguest/vboxguest_linux.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virt/vboxguest/vboxguest_linux.c b/drivers/virt/vboxguest/vboxguest_linux.c
> index 32c2c52f7e84..6215a688edaf 100644
> --- a/drivers/virt/vboxguest/vboxguest_linux.c
> +++ b/drivers/virt/vboxguest/vboxguest_linux.c
> @@ -35,7 +35,7 @@ static u32 vbg_misc_device_requestor(struct inode *inode)
>   			VMMDEV_REQUESTOR_CON_DONT_KNOW |
>   			VMMDEV_REQUESTOR_TRUST_NOT_GIVEN;
>   
> -	if (from_kuid(current_user_ns(), current->cred->uid) == 0)
> +	if (from_kuid(current_user_ns(), current_uid()) == 0)
>   		requestor |= VMMDEV_REQUESTOR_USR_ROOT;
>   	else
>   		requestor |= VMMDEV_REQUESTOR_USR_USER;
> 

