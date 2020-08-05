Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80037C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E06B20842
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="WCRpQ+3t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgHET6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbgHEQno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:43:44 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083E9C08E835
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 06:14:49 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id g19so33766233ioh.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5NGswowN9lNt0B7Qm7pFhGL8MlFG4CkHrirwlJK6xy4=;
        b=WCRpQ+3tfoj4A2Hl+xWObW6Msn9x71auG4DLdg2jezSEoX3cmVit3924jRiOwkuth3
         HaY51PM6suSWR2Ql0Vd6UNdErJmtitkxUpYHJXBSnZN3YEZzktCiKPrfAm+V12nKs6x3
         lCEe5qpq5kCz2RchxzxuHe12iWIseZEKvaWxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5NGswowN9lNt0B7Qm7pFhGL8MlFG4CkHrirwlJK6xy4=;
        b=G+L38QxYbN6pB4UQmI/1kf0/cs9pk16YNLYEPh3oWDGYe9tyGsvYeYlmamxSvFA75Q
         gfkbUCeNRFXojUugvgATpDUNmC8CPfbg7QJMyfvyVlq2F06RhcktIyvAVpTw15T0NXR/
         nE17ZevU3PO49MjXE7ySdY+jYinK2jhT6jkBR9afqeuP3fja249Qexn9BRYAGswJKWaI
         vRmQ/4r6u9mKTt0mBRNoA/YSRdGYcrXFhJhhRL2I6IHSalwTmmBnXFJBt6rMTepXlxZz
         PKYTrpVGHJXkqncR3LYvgTZPbATwBnbC+K397YDtf9WD8UPwS03ZWAITw29TpJX2a1C6
         xFuw==
X-Gm-Message-State: AOAM5338IB/tmhp/XtS4kUk+9gFP3noBQ6tldpAC64tsnWa++dR886Xd
        pqQx6toKfJbpZLHUFUaVyZvBoCkVQgs=
X-Google-Smtp-Source: ABdhPJyiMBH7gV9Zc6QUzz25ejAv4noYllQlkHa87ohih1OIFGenFVCFdfiA/UVUi0O1y1XyGOrqPQ==
X-Received: by 2002:a5d:91d4:: with SMTP id k20mr3407822ior.9.1596633288660;
        Wed, 05 Aug 2020 06:14:48 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id y8sm1003253iom.26.2020.08.05.06.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 06:14:47 -0700 (PDT)
Subject: Re: [PATCH][next] greybus: Use fallthrough pseudo-keyword
From:   Alex Elder <elder@ieee.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20200727183258.GA28571@embeddedor>
 <63871608-e076-26b0-85df-cff11699c3a3@ieee.org>
Message-ID: <e36013ba-e19a-86c9-cb68-d7ad5559c292@ieee.org>
Date:   Wed, 5 Aug 2020 08:14:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <63871608-e076-26b0-85df-cff11699c3a3@ieee.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/20 5:37 PM, Alex Elder wrote:
> On 7/27/20 1:32 PM, Gustavo A. R. Silva wrote:
>> Replace the existing /* fall through */ comments and its variants with
>> the new pseudo-keyword macro fallthrough[1].
>>
>> [1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> 
> Thanks for the patch.  It looks good, but it raises
> another question I'd like discussion on.

It's been a week, and we heard back from Viresh (and Joe) on
this, but no one else.  Viresh left out the break statement on
the last case of the switch statement intentionally, arguing
that it is not needed (much like a return statement at the end
of a void function).  But he doesn't feel strongly enough
insist it should stay that way.  I'm sure the others omitted
the break statement intentionally as well.

Given no strong pushback, I'll ask you (Gustavo) to post a
second patch adding the missing break statements I described
(and look for any others I might have missed).  If you would
prefer not to do that, just say so, and I will send out such
a patch myself.

On your original patch, it looks good to me.  Thank you.

Reviewed-by: Alex Elder <elder@linaro.org>

> It seems that Johan likes default (or final) cases in
> switch statements without a "break" statement.  Viresh
> and Bryan appear to be fond of this too.
> 
> It's pedantic, but I don't like that.  Am I wrong?
>   --> Johan/Viresh/Bryan would you please comment?
> 
> If they aren't convincing (or don't care) I think break
> statements should also be added here:
> - In gb_interface_read_and_clear_init_status() for the
>   default case
> - In gb_interface_activate() for the default case.
> - In gb_svc_process_deferred_request() for the default
>   case
> 
> But let's wait to see what Johan (et al) says.  If you
> don't want to do that, say so and I'll do it later.
> 
> I looked at the code in drivers/staging/greybus/ and saw
> no need to add a "fallthrough" anywhere, but:
> - In fw_mgmt_backend_fw_version_operation() Viresh
>   seems to have skipped the break in the fault statement
> - In gb_uart_request_handler() Bryan did this too.
> 
> Depending on discussion, these could be fixed in a
> separate patch as well.
> 
> These cases aren't found by "checkpatch.pl" because it only
> looks at case "blocks" that are followed by another case.
> So the last case isn't checked.
> 
>                     -Alex
> 
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>   drivers/greybus/es2.c       | 2 +-
>>   drivers/greybus/interface.c | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/greybus/es2.c b/drivers/greybus/es2.c
>> index 366716f11b1a..1df6ab5d339d 100644
>> --- a/drivers/greybus/es2.c
>> +++ b/drivers/greybus/es2.c
>> @@ -759,7 +759,7 @@ static int check_urb_status(struct urb *urb)
>>       case -EOVERFLOW:
>>           dev_err(dev, "%s: overflow actual length is %d\n",
>>               __func__, urb->actual_length);
>> -        /* fall through */
>> +        fallthrough;
>>       case -ECONNRESET:
>>       case -ENOENT:
>>       case -ESHUTDOWN:
>> diff --git a/drivers/greybus/interface.c b/drivers/greybus/interface.c
>> index 67dbe6fda9a1..58ea374d8aaa 100644
>> --- a/drivers/greybus/interface.c
>> +++ b/drivers/greybus/interface.c
>> @@ -1233,7 +1233,7 @@ int gb_interface_add(struct gb_interface *intf)
>>       case GB_INTERFACE_TYPE_GREYBUS:
>>           dev_info(&intf->dev, "GMP VID=0x%08x, PID=0x%08x\n",
>>                intf->vendor_id, intf->product_id);
>> -        /* fall-through */
>> +        fallthrough;
>>       case GB_INTERFACE_TYPE_UNIPRO:
>>           dev_info(&intf->dev, "DDBL1 Manufacturer=0x%08x, Product=0x%08x\n",
>>                intf->ddbl1_manufacturer_id,
>>
> 

