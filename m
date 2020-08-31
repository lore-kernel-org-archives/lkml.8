Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6AAC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71BF62068E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="egHM9anV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbgHaSMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:12:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35866 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729238AbgHaSMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598897521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R674/72dzH0s8wu0q77/o8Nko89CHzZBE+f9ohuJkc0=;
        b=egHM9anVIRRhUxeBtMmAlY+jVs1veaqWvrOi5OL05bw+tPwAz1cQZk8lMKgEMRiXBqIQ6r
        JKwU0+LsTv8FMZipxplJLuPOX21fvIJgSZSpUzryvwiNzu2KyJKGmEAU5LpQp4C/Pj8M1P
        He+Z52tv6vdftpDsdc4V/tqv3mUJA5c=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549--_MdY09bNqK-xp1ZASBLMg-1; Mon, 31 Aug 2020 14:11:59 -0400
X-MC-Unique: -_MdY09bNqK-xp1ZASBLMg-1
Received: by mail-il1-f199.google.com with SMTP id m80so5708063ilb.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:11:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=R674/72dzH0s8wu0q77/o8Nko89CHzZBE+f9ohuJkc0=;
        b=M9ENJB3cubU6Aw9pOsvOlhGwNKex4DVuLuJ4lFCt+u1NBerpr702GzlwsI4jAixnuL
         CagnCbgq9ZckMhwEbQQhtABz1EI7xzlwFVdKecrBP5tdumWp77JrXcjpH45NVU/FK8Wr
         qt4W4rJeOjbdgCbTkH4w+XRufsbHOuNVPlDDHf59hfSWphNE1ndZocq0vIc5UlUh0Yph
         /mMsyWqkNsV4S3ZHwC2CXEwPeldTnhqWqrlRiozBboWOMyxb3aEkwlcNq7az6ag439+H
         +QQDt3K8sf+/X8EK21ZAtmAv4fT1oPFqjh0eubHG54XBVhlo3SiMZvhBMAat0GcGhHBQ
         nDIw==
X-Gm-Message-State: AOAM532yI9C7SFtGDr+sLmnixX1s8yJrDPhBkN7ct2zjGmUrk5m16Cmx
        2N7uzOXjw9SwPW9pV8tXY6M5pRbNQmKNcZ4qSehde+gErqde3bF2c1h0cYYxbY9eLF6YyqZKg/0
        nkDcJ4a6EnmSCQV2XrtRe0Okc
X-Received: by 2002:a92:cd0c:: with SMTP id z12mr2310933iln.95.1598897519246;
        Mon, 31 Aug 2020 11:11:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQnv2fWHOPseIkHEUWf3rehvfnqBXk0m4BeVGmJn1hPjW7PLrM3iOz+bnxyXwgsl/vzs1PFA==
X-Received: by 2002:a92:cd0c:: with SMTP id z12mr2310915iln.95.1598897519033;
        Mon, 31 Aug 2020 11:11:59 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id u4sm4405350iol.17.2020.08.31.11.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 11:11:58 -0700 (PDT)
Subject: Re: [PATCH] media: tc358743: initialize variable
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     matrandg@cisco.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        p.zabel@pengutronix.de, Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20200830163043.10317-1-trix@redhat.com>
 <CAKwvOdkvY62xVKQcVHxMTpskO=bB2sxwiOQb+TGF0-oU2Q6unA@mail.gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <23bc7c20-f736-a8fb-b89c-c9039380e55b@redhat.com>
Date:   Mon, 31 Aug 2020 11:11:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdkvY62xVKQcVHxMTpskO=bB2sxwiOQb+TGF0-oU2Q6unA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/31/20 10:31 AM, Nick Desaulniers wrote:
> On Sun, Aug 30, 2020 at 9:30 AM <trix@redhat.com> wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> clang static analysis flags this error
>>
>> tc358743.c:1468:9: warning: Branch condition evaluates
>>   to a garbage value
>>         return handled ? IRQ_HANDLED : IRQ_NONE;
>>                ^~~~~~~
>> handled should be initialized to false.
>>
>> Fixes: d747b806abf4 ("[media] tc358743: add direct interrupt handling")
>> Signed-off-by: Tom Rix <trix@redhat.com>
> I'm guessing there was more to the report that says that `handled`
> isn't necessarily initialized along any of the paths within
> tc358743_isr()?  But you should fix this for all callers of
> tc358743_isr(), such as tc358743_work_i2c_poll(), not just
> tc358743_irq_handler().

Interesting. The static analyzer did not catch this.

I will take another.

Thanks

Tom

>> ---
>>  drivers/media/i2c/tc358743.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/i2c/tc358743.c b/drivers/media/i2c/tc358743.c
>> index a03dcab5ce61..c724bd1591de 100644
>> --- a/drivers/media/i2c/tc358743.c
>> +++ b/drivers/media/i2c/tc358743.c
>> @@ -1461,7 +1461,7 @@ static int tc358743_isr(struct v4l2_subdev *sd, u32 status, bool *handled)
>>  static irqreturn_t tc358743_irq_handler(int irq, void *dev_id)
>>  {
>>         struct tc358743_state *state = dev_id;
>> -       bool handled;
>> +       bool handled = false;
>>
>>         tc358743_isr(&state->sd, 0, &handled);
>>
>> --
>> 2.18.1
>>
>

