Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1158C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CAB020825
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cY9YdZC8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgH1Pg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:36:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54013 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725969AbgH1Pgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 11:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598629008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=90baatzSPBpORTYvIrGD2xeuQLVBCo5SpxPsADar6cc=;
        b=cY9YdZC8q+Lx/HkcgXcR3Dopnz76bIN1N221AK3n3XBJSbPJMb7w+iBadQEBkBmfNr89EP
        bm7H8EFsiyZTP46Un4zNoGhBaRGdYddJNp/eLh5ct1ScHOcyn3k4l1IKczRW0af2KgZfur
        Vq/R1TdMn8rz45evMlLiQOEVKXZBYmI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-0F_hfzQpPxqnoHCAPIbn3Q-1; Fri, 28 Aug 2020 11:36:47 -0400
X-MC-Unique: 0F_hfzQpPxqnoHCAPIbn3Q-1
Received: by mail-qk1-f200.google.com with SMTP id x20so1227557qki.20
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 08:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=90baatzSPBpORTYvIrGD2xeuQLVBCo5SpxPsADar6cc=;
        b=Hnua8wbe0neek6cXuB4NrOeRPr4MKDkQtf9jrMEGEqDfV9J8Y+d9PnuU0oWLB8RUK9
         Z/tn5krRtg6TDHOfl64EepkH8vXy4l4yx/bszFt/TdilIuNVRXsJI7FSxHfg9ekO5HJe
         tVHaPRDpjiF8/a+fp/6PrpNTlUsIitgfPK3VHA/6Bh/DveeZ8UC9qcUoYAZK6rrAhSFb
         BUFX9hHlUPVG61QWMGZL7RzjxgFU8jnS8cz6koqZTtd155+Kh82qsJJ1jPfch8GbtBw6
         OUiO6zOX1sFr2Gh6QDt4vGDHyfvhVnlSyS3xrE6QBA8PocU1ejKC21ql4HB4G5tswiEk
         1Sbw==
X-Gm-Message-State: AOAM531tkT/dHP0dYVrgfjRuE7r+7JbLMcImXH+Q8w8EhlvrIHOEjyxs
        wXyIL9isBOEZ6lTQLj+Lik1PMmydONys/S/hZF9uSeANOfN7SwPPiFpsPJAA6SqGlpb8+Y8v3zc
        YBlgQodu6EGAE2Tt+MdctbAzF
X-Received: by 2002:a37:2747:: with SMTP id n68mr1704425qkn.176.1598629006498;
        Fri, 28 Aug 2020 08:36:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoB5eKwE3Dt2wDr4pX5sS6NGxMfZLnhKR9BLUmh6g1fCcYwnzpg+4LvBZtX7Iehhbd+ES20Q==
X-Received: by 2002:a37:2747:: with SMTP id n68mr1704402qkn.176.1598629006231;
        Fri, 28 Aug 2020 08:36:46 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j74sm1111465qke.7.2020.08.28.08.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 08:36:45 -0700 (PDT)
Subject: Re: [PATCH] media: ov7670: check status of ov7670_read
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Huckleberry <nhuck15@gmail.com>
References: <20200828145518.26324-1-trix@redhat.com>
 <CAKwvOd=S=aw6KoRvzhUMi4fR799kaPwAKoigjuR9fS-JSYSGPA@mail.gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <db41a471-b5cd-6ffe-c24f-ba14d9125920@redhat.com>
Date:   Fri, 28 Aug 2020 08:36:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOd=S=aw6KoRvzhUMi4fR799kaPwAKoigjuR9fS-JSYSGPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/28/20 8:13 AM, Nick Desaulniers wrote:
> On Fri, Aug 28, 2020 at 7:55 AM <trix@redhat.com> wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> clang static analysis flags this representative problem
>>
>> drivers/media/i2c/ov7670.c:1463:9: warning: Assigned
>>   value is garbage or undefined
>>         *value = gain;
>>                ^ ~~~~
>>
>> gain is set by a successful call to ov7670_read()
> Indeed, it looks like gain is only valid if the return value from
> ov7670_read() is >= 0.  Would it be simpler to just initialize gain to
> 0 in ov7670_g_gain?

It looks like ov7670_read() subroutines both convert > 0 returns to 0.

Setting gain, and similar cases, to 0 means it is ok the setting side effect.  maybe it would be ok if this was a void return or there was some known poison value.  I did not look into that.  There are other routines that are more than a simple get() and i wanted to use the same fix for all of them.

yeah on clang static analysis making it into kbuild!  I have been doing these fixes for a couple of months.  with a just-built clang, i run 'scan-build make randomconfig', 'scan-build make', then run scan-view on the html.  the randomconfig accounts for the very scattered fixes i have posted.  generally i would say kernel is doing pretty well, maybe 20 to 1 false to real problems.

Tom

>
> Side question; I'm super happy to see someone sending patches for
> things identified by clang's static analyzer.  I'm curious, Tom, how
> did you run it?  Did you use the recently landed in kbuild-next
> support for the make target `make clang-analyzer`?
>
>> So check that ov7670_read() is successful.
>>
>> The remaining static analysis problems are false positives.
>> There appears to be a limitation with checking the
>> aggregated returns.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>  drivers/media/i2c/ov7670.c | 17 +++++++++++++----
>>  1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/media/i2c/ov7670.c b/drivers/media/i2c/ov7670.c
>> index b42b289faaef..001d4b09db72 100644
>> --- a/drivers/media/i2c/ov7670.c
>> +++ b/drivers/media/i2c/ov7670.c
>> @@ -929,6 +929,8 @@ static int ov7670_set_hw(struct v4l2_subdev *sd, int hstart, int hstop,
>>         ret =  ov7670_write(sd, REG_HSTART, (hstart >> 3) & 0xff);
>>         ret += ov7670_write(sd, REG_HSTOP, (hstop >> 3) & 0xff);
>>         ret += ov7670_read(sd, REG_HREF, &v);
>> +       if (ret)
>> +               return ret;
>>         v = (v & 0xc0) | ((hstop & 0x7) << 3) | (hstart & 0x7);
>>         msleep(10);
>>         ret += ov7670_write(sd, REG_HREF, v);
>> @@ -938,6 +940,8 @@ static int ov7670_set_hw(struct v4l2_subdev *sd, int hstart, int hstop,
>>         ret += ov7670_write(sd, REG_VSTART, (vstart >> 2) & 0xff);
>>         ret += ov7670_write(sd, REG_VSTOP, (vstop >> 2) & 0xff);
>>         ret += ov7670_read(sd, REG_VREF, &v);
>> +       if (ret)
>> +               return ret;
>>         v = (v & 0xf0) | ((vstop & 0x3) << 2) | (vstart & 0x3);
>>         msleep(10);
>>         ret += ov7670_write(sd, REG_VREF, v);
>> @@ -1460,6 +1464,8 @@ static int ov7670_g_gain(struct v4l2_subdev *sd, __s32 *value)
>>         unsigned char gain;
>>
>>         ret = ov7670_read(sd, REG_GAIN, &gain);
>> +       if (ret)
>> +               return ret;
>>         *value = gain;
>>         return ret;
>>  }
>> @@ -1470,11 +1476,14 @@ static int ov7670_s_gain(struct v4l2_subdev *sd, int value)
>>         unsigned char com8;
>>
>>         ret = ov7670_write(sd, REG_GAIN, value & 0xff);
>> +       if (ret)
>> +               return ret;
>>         /* Have to turn off AGC as well */
>> -       if (ret == 0) {
>> -               ret = ov7670_read(sd, REG_COM8, &com8);
>> -               ret = ov7670_write(sd, REG_COM8, com8 & ~COM8_AGC);
>> -       }
>> +       ret = ov7670_read(sd, REG_COM8, &com8);
>> +       if (ret)
>> +               return ret;
>> +       ret = ov7670_write(sd, REG_COM8, com8 & ~COM8_AGC);
>> +
>>         return ret;
>>  }
>>
>> --
>> 2.18.1
>>
>

