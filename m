Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408F2C33CB0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA3D21744
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfcFbwBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbgAMPWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:22:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27121 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728843AbgAMPWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:22:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578928961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VOTGMvgDQlL7dRbs3ZO0Cylb6qsjQ7963pN+mQ0JZwc=;
        b=PfcFbwBseCR56yGf3vMdHiX/Xs05gX37iVXiXndqnFiL4Jv5XugqskjnzPfzZu+ltc9QGH
        z6rOpinEmysQLnHsRzKmvw1nQ4Y/N5Pwt3X9sPL4XEuCKcf68dp8Qifc4C2gbJ1f+P3Ink
        +u0DPhjBc5WE0qBbuH9eP3h6vOSzs68=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-Zp6_lPgHPfmOaQ5pUpe7Jg-1; Mon, 13 Jan 2020 10:22:40 -0500
X-MC-Unique: Zp6_lPgHPfmOaQ5pUpe7Jg-1
Received: by mail-wr1-f69.google.com with SMTP id c17so5090401wrp.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 07:22:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VOTGMvgDQlL7dRbs3ZO0Cylb6qsjQ7963pN+mQ0JZwc=;
        b=onXg3OitEvg71QF3KkSYRbQQme36CFLZwptkQvaV6Ijft+o0kOqn3IeEo6F4YZYMWX
         InvbMrwWCCoM+UEoFdmihzhFEK8T141w+JNYBnhvZzRI0wp/H6ZQchUpl4+ZfuCbhsC2
         UKAS5BSiNK3f+9uyF4LYYx10VvGXJAzyvRR744ltCVFUY3L3G0ptCb81aC79XNSUsqpm
         OzVHFlZOdAkflOxFzaQLOe0yrOSOnHHZQHG5Fo47AD8Uii+VBLhYLTEsfi+d7UYXt5yR
         K+LciXNSb5Z9rMJb6gOQGWIhVzooMfCcedo5GeKQBUYiiPHDn//ivv4y9dGlO68KZWGj
         4Fpw==
X-Gm-Message-State: APjAAAV93rPy7Er9R4BA7g30tx6ZQM9kiopqXv+zBlNYIbn0w2N5Wmzq
        w+NUHg3jYhZ5qSI2L/izeXaBtz4F1bpOmio0F71pcYSN12jUSjYq2F8BZt7ul0SE1qkHqFSp+pR
        /SKjJANqvw6UFUuW+pN9P0zz1
X-Received: by 2002:a1c:a406:: with SMTP id n6mr20939385wme.40.1578928958680;
        Mon, 13 Jan 2020 07:22:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqyUmkECQJyn5SeeaSEv+fAyzoafrVckwo+t9N110O05ZIO2UB7J1Jik4S2xxmzSNHA+roPuQw==
X-Received: by 2002:a1c:a406:: with SMTP id n6mr20939363wme.40.1578928958439;
        Mon, 13 Jan 2020 07:22:38 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id j12sm16877545wrw.54.2020.01.13.07.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 07:22:37 -0800 (PST)
Subject: Re: [PATCH v11 05/10] test_firmware: add support for
 firmware_request_platform
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20200111145703.533809-1-hdegoede@redhat.com>
 <20200111145703.533809-6-hdegoede@redhat.com>
 <20200113145328.GA11244@42.do-not-panic.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <54f70265-265b-ad23-7d2d-af0b27ab1475@redhat.com>
Date:   Mon, 13 Jan 2020 16:22:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200113145328.GA11244@42.do-not-panic.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13-01-2020 15:53, Luis Chamberlain wrote:
> On Sat, Jan 11, 2020 at 03:56:58PM +0100, Hans de Goede wrote:
>> Add support for testing firmware_request_platform through a new
>> trigger_request_platform trigger.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v11:
>> - Drop a few empty lines which were accidentally introduced
> 
> But you didn't address my other feedback.
> 
>> --- a/lib/test_firmware.c
>> +++ b/lib/test_firmware.c
>> @@ -507,6 +508,61 @@ static ssize_t trigger_request_store(struct device *dev,
>>   }
>>   static DEVICE_ATTR_WO(trigger_request);
>>   
>> +#ifdef CONFIG_EFI_EMBEDDED_FIRMWARE
>> +static ssize_t trigger_request_platform_store(struct device *dev,
>> +					      struct device_attribute *attr,
>> +					      const char *buf, size_t count)
>> +{
>> +	static const u8 test_data[] = {
>> +		0x55, 0xaa, 0x55, 0xaa, 0x01, 0x02, 0x03, 0x04,
>> +		0x55, 0xaa, 0x55, 0xaa, 0x05, 0x06, 0x07, 0x08,
>> +		0x55, 0xaa, 0x55, 0xaa, 0x10, 0x20, 0x30, 0x40,
>> +		0x55, 0xaa, 0x55, 0xaa, 0x50, 0x60, 0x70, 0x80
>> +	};
>> +	struct efi_embedded_fw fw;
>> +	int rc;
>> +	char *name;
>> +
>> +	name = kstrndup(buf, count, GFP_KERNEL);
>> +	if (!name)
>> +		return -ENOSPC;
>> +
>> +	pr_info("inserting test platform fw '%s'\n", name);
>> +	fw.name = name;
>> +	fw.data = (void *)test_data;
>> +	fw.length = sizeof(test_data);
>> +	list_add(&fw.list, &efi_embedded_fw_list);
>> +
>> +	pr_info("loading '%s'\n", name);
>> +
> 
> I mentioned this in my last review, and it seems you forgot to address
> this.

I did address this in my reply to your review, as explained there,
the check + free on test_firmware before calling firmware_request_platform()
is necessary because test_firmware may be non NULL when entering
the function (continued below) ...

> But now some more feedback:
> 
> These two:
> 
>> +	mutex_lock(&test_fw_mutex);
>> +	release_firmware(test_firmware);
> 
> You are doing this because this is a test, but a typical driver will
> do this after, and we don't loose anything in doing this after. Can you
> move the mutex lock and assign the pointer to a temporary used pointer
> for the call, *after* your call.
> 
> But since your test is not using any interfaces to query information
> about the firmware, and you are just doing the test in C code right
> away, instead of say, using a trigger for later use in userspace,
> you can just do away with the mutex lock and make the call use its
> own pointer:
> 
> 	rc = firmware_request_platform(&tmp_test_firmware, name, dev);
> 	if (rc) {
> 		...
> 	}
> 	/* Your test branch code goes here */
> 
> I see no reason why you use the test_firmware pointer.

I agree that using a private/local firmware pointer instead of
test_firmware and dropping the mutex calls is better. I will make
this change for v12 of this series.

I'll send out a v12 once the remarks from Andy Lutomirski's
have also been discussed.

Regards,

Hans


> 
>> +	test_firmware = NULL;
>> +	rc = firmware_request_platform(&test_firmware, name, dev);
>> +	if (rc) {
>> +		pr_info("load of '%s' failed: %d\n", name, rc);
>> +		goto out;
>> +	}
>> +	if (test_firmware->size != sizeof(test_data) ||
>> +	    memcmp(test_firmware->data, test_data, sizeof(test_data)) != 0) {
>> +		pr_info("firmware contents mismatch for '%s'\n", name);
>> +		rc = -EINVAL;
>> +		goto out;
>> +	}
>> +	pr_info("loaded: %zu\n", test_firmware->size);
>> +	rc = count;
>> +
>> +out:
>> +	mutex_unlock(&test_fw_mutex);
>> +
>> +	list_del(&fw.list);
>> +	kfree(name);
>> +
>> +	return rc;
>> +}
> 

