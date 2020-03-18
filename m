Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8A4C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4624A20752
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqQ1RckF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgCRRUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:20:12 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:51691 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726680AbgCRRUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584552011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n3XT9uOrt7PH+M1GJzb9jqNp+v2UICWH0KuRq1shXUc=;
        b=JqQ1RckFSMl3ELI6OK/z6Mdp/kmcpU6LdACNoaD1ubBf4B+vQEmBGagDluBNBrxrN1sB0l
        kfw1fxxG6folI5Z0fYzqjKycOj5ddm4aZwY4eF97JxjOxVvt4mwCxsv237fO6yod5Q4ZpN
        q/jOagNuelEWsv86fZ2/szyPMFNeWNY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-OgobymGlO5ad5vU5Ik2vbg-1; Wed, 18 Mar 2020 13:20:06 -0400
X-MC-Unique: OgobymGlO5ad5vU5Ik2vbg-1
Received: by mail-wm1-f71.google.com with SMTP id s15so1346127wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n3XT9uOrt7PH+M1GJzb9jqNp+v2UICWH0KuRq1shXUc=;
        b=oM7whcD4geHPEFcuMD2GXGbH6Q8xL+2rQCm0gBNCef0+ZxCa1TvxU+iNqrdqxCV3SQ
         Az5QU656ATzP2BPQ8ag+JKsTPAazFneSyrotqdUMnPgdLSnHkhn3BoyqBMJ8f50Nrh4I
         Jg9hhCluVHwYjSOFSOjYgXZYd57Gijg+aplWTXN89IKRfJAtR1vZsJjwxeePHdqMEke7
         SFXUd1QnrIoX4nySAvqQAUArCOHpj5stBWNWYrj5sXCvcfmEVL4BrlxO2Sk7gU2YAPal
         AEb7SBsVfaq8doN/ZLUWVjB7VeZytN82w2A1+7gVTYR4IZKU+EfhcsQ2vuu+CNNz5CVA
         gtrg==
X-Gm-Message-State: ANhLgQ1jQU3ZdqsrSAqAmeIEZWnHCgA/gFPHvTYP7YjGp+dhLxaPhsVD
        RDhopvG2XHd+Et2xtloFFAiU9GOwZitrXtfjf2PzKwf9gGy05F/ODuG0rJP32yWLf4Ftp9TtxmF
        XIwimAa9wzfSQ0bYklfCulA7W
X-Received: by 2002:a05:6000:d1:: with SMTP id q17mr6725143wrx.409.1584552005533;
        Wed, 18 Mar 2020 10:20:05 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuZ21PQnKDISW6DXa9UKtqOe0KrEn2YQ1z7EL087QF5tRR4yPJScGJdLOCwadR//kwuf6j6qA==
X-Received: by 2002:a05:6000:d1:: with SMTP id q17mr6725115wrx.409.1584552005310;
        Wed, 18 Mar 2020 10:20:05 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id f12sm4835053wmh.4.2020.03.18.10.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 10:20:04 -0700 (PDT)
Subject: Re: [PATCH] HID: logitech-dj: issue udev change event on device
 connection
To:     Mario Limonciello <superm1@gmail.com>,
        =?UTF-8?Q?Filipe_La=c3=adns?= <lains@archlinux.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Hutterer <peter.hutterer@redhat.com>,
        Richard Hughes <hughsient@gmail.com>
References: <20200318161906.3340959-1-lains@archlinux.org>
 <CA+EcB1MoTXMaueJfRHf51A5PU4oiKSJXrHazfTEvifZK54OrLQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e8ea0c2e-445f-21e2-a248-3368f26bf391@redhat.com>
Date:   Wed, 18 Mar 2020 18:20:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CA+EcB1MoTXMaueJfRHf51A5PU4oiKSJXrHazfTEvifZK54OrLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/18/20 6:15 PM, Mario Limonciello wrote:
> On Wed, Mar 18, 2020 at 11:19 AM Filipe Laíns <lains@archlinux.org> wrote:
>>
>> As discussed in the mailing list:
>>
>>> Right now the hid-logitech-dj driver will export one node for each
>>> connected device, even when the device is not connected. That causes
>>> some trouble because in userspace we don't have have any way to know if
>>> the device is connected or not, so when we try to communicate, if the
>>> device is disconnected it will fail.
>>
>> The solution reached to solve this issue is to trigger an udev change
>> event when the device connects, this way userspace can just wait on
>> those connections instead of trying to ping the device.
>>
>> Signed-off-by: Filipe Laíns <lains@archlinux.org>
>> ---
>>   drivers/hid/hid-logitech-dj.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
>> index 48dff5d6b605..fcd481a0be1f 100644
>> --- a/drivers/hid/hid-logitech-dj.c
>> +++ b/drivers/hid/hid-logitech-dj.c
>> @@ -1464,6 +1464,8 @@ static int logi_dj_dj_event(struct hid_device *hdev,
>>                  if (dj_report->report_params[CONNECTION_STATUS_PARAM_STATUS] ==
>>                      STATUS_LINKLOSS) {
>>                          logi_dj_recv_forward_null_report(djrcv_dev, dj_report);
>> +               } else {
>> +                       kobject_uevent(&hdev->dev.kobj, KOBJ_CHANGE);
>>                  }
>>                  break;
>>          default:
>> --
>> 2.25.1
> 
> The problem that will remain here is the transition period for
> userspace to start to rely upon
> this.  It will have no idea whether the kernel is expected to send
> events or not.  What do you
> think about adding a syfs attribute to indicate that events are being
> sent?  Or something similar?

Then we would need to support that attribute forever. IMHO the best
option is to just make a uname call and check the kernel version, with
the code marked to be removed in the future when kernels older then
$version are no longer something we want to support.

Regards,

Hans

