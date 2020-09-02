Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4998DC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CC8A20829
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sh/HlCyh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgIBOKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:10:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59536 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727845AbgIBNy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599054864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=khHWBwp27MCsDubL2xJ27QUZt+RhTFOMCjX1dXeN/NI=;
        b=Sh/HlCyhYz0MxdSzsZ8qCJABRXvB0wA9LzSRD16xi8Bme7N7kTG1rXk2y5OyS4I0GqGBJI
        eDQmvsVlQVQJUVW2oU3mk4E0JuXQ9ruljvJGaSKhA21/YpD0HMyXvjAJ2Eyn0/Vli95AV/
        N0IAgu5X7/PnBitcorZYn2KzK+zs9pI=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-t00NSusWN1O6N_p8YLxEaQ-1; Wed, 02 Sep 2020 09:54:22 -0400
X-MC-Unique: t00NSusWN1O6N_p8YLxEaQ-1
Received: by mail-il1-f198.google.com with SMTP id v6so3550536ili.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 06:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=khHWBwp27MCsDubL2xJ27QUZt+RhTFOMCjX1dXeN/NI=;
        b=MtrdnDzY5xhPNacKvLqb3i3YfYVkYhe8fc7tubt7svhN/uxaORbKmY4JbbdFA5t7D+
         vlaIhmVIEUhRYJGZ7SWBkQIoLkX5m93RGQvRMyahtmjVBMeY89xyUEptQg3+yBkTHGnx
         WrJfa0bJfpiuzQzJebyYpRRrZGHqKK6/B96e9QyAJoKb9fd3osJQ6uWdb1RYbAx4LOHa
         j812MMk4teucpPKr+Pf79oBxi8+/+10gsC4TU99hR2v6Q5QMNTuoG8Y0DMpZrXPMVLyF
         ssU8Wo/A4apvRL/nGkq+R4v+fvrA9LV1jkeV2DP1zIzlAIkyxX04SiebKo9CsI/jjzwW
         qz2Q==
X-Gm-Message-State: AOAM532VYYfgUxC76rp51r1O1IbRhfL8i59vS7ghaHke40s4cEC0Jtx0
        JFuB1oBoUkiQhHYFdj4ddrjhUEsg4+mpJffI2BvkrOsfAtu+V5+qGK9JpLxaBDy8k3Kv+Wqbzq7
        s6gV/flN5vao0apCEb5h1rAM1
X-Received: by 2002:a05:6638:144:: with SMTP id y4mr3278101jao.61.1599054861763;
        Wed, 02 Sep 2020 06:54:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyeD2EUIkJh6TIy2+yZpYkZPNXyrjZKyqORwp6a/S9dENeA/0Rke6kCSnDOJiOYPCEl37GvZA==
X-Received: by 2002:a05:6638:144:: with SMTP id y4mr3278076jao.61.1599054861531;
        Wed, 02 Sep 2020 06:54:21 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id z4sm2255690ilh.45.2020.09.02.06.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 06:54:21 -0700 (PDT)
Subject: Re: [PATCH] media: tc358743: initialize variable
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     matrandg@cisco.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        p.zabel@pengutronix.de, Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20200830163043.10317-1-trix@redhat.com>
 <CAKwvOdkvY62xVKQcVHxMTpskO=bB2sxwiOQb+TGF0-oU2Q6unA@mail.gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <99da6454-2f40-1def-bfae-f82ae8ec0379@redhat.com>
Date:   Wed, 2 Sep 2020 06:54:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdkvY62xVKQcVHxMTpskO=bB2sxwiOQb+TGF0-oU2Q6unA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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

tc358743_work_i2c_poll does not use handled, so in theory it could pass a null, however at least one of the subhandler, tc358743_cec_isr, does not check if null is passed in.

so i think that covers the callers.

i think initializing handler in tc358743_work_i2c_poll is a not needed since it is unused.  but the null check in tc358743_cec_isr needs to be done. i'll post that as a separate patch once this one settles.

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

