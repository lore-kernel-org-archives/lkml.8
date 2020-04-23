Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C36C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A9462077D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COuoas++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgDWM5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 08:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728286AbgDWM5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 08:57:39 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD8BC08E934
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 05:57:39 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 198so4665464lfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 05:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4IzPwc1p9rewfVDR02gT5iXJHo6WGDgE1h5tGgQZ7mU=;
        b=COuoas++m8kh9KGRXhiHJqYkkHYcP2R0N9n5x/wRuy2uQAOiKMUli60CJGPV8ZscFZ
         2UX2tqj9zWW4Y/0dTcTe9p757t/rMDVRNrurrUWydEh1XnEE9ot/ompCf8RWgCa5aGfN
         YamULePVFJRNtd3QFOqj3bGv726bt3Iz2EG+1lN2JL6trl3YggjbqDDuq2xlaeRrNn9r
         JTR27Whjw9ywKLa2pWK+CXNY+iVGP+b+p9BMwEpI2wT/3AZoVlKlola/yMOW1wxee7XT
         ADuxv8fMWvZHbcZMC2QPrK6FBFchlTHP6JCeeoj05kbeq7uppxFHQwltie7WwMKoeHmG
         6hVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4IzPwc1p9rewfVDR02gT5iXJHo6WGDgE1h5tGgQZ7mU=;
        b=qtWtEnkV4dbrQvyV3VYDA32gAPzpuzwWANmVzCstYYmqDZjNqxsn2vei1HYa+Ap+wV
         P5UvV9RTW0pCqZaGBmqO+lK9IUqSvYIsoWAgYIKHsdP8Lr0rQj5WYEv+Q4sIuumcVagU
         xpZ7wHmWMdXHMuYX/u/KAJc/0PD6ryiLryco5S5PMca40rPUjHg6TYWdQhJz33UOCw3n
         2/snNbaQf1H1ZEqrjvCziWOOkZzo9QU8a75dX2ljFfj+MhfeTgjxT2XCOuEMHfKo3Yay
         nLRpyi8HyRdiX/sbE0vZkQ1XEhYgzERWm2nfiX0iG1qFApz8Y2p46ZaQMy6nGSTdYkXu
         Ffag==
X-Gm-Message-State: AGi0PuYjkLtih9+nf0tTUrnlOEMlGGZJ+6+HFH6bmfgUIrb0ne7eqQA2
        zQG1PLasaJNBohEV9TQg69c=
X-Google-Smtp-Source: APiQypKjCMt6tyu6ESzGYYRAyReUyR+rMLEyV+2RwlMUA8K/CbCT76O9ynYNvxp9+GM34j8UL9NZMw==
X-Received: by 2002:ac2:4c9a:: with SMTP id d26mr2340685lfl.112.1587646657974;
        Thu, 23 Apr 2020 05:57:37 -0700 (PDT)
Received: from [192.168.0.160] (84.188.smarthome.spb.ru. [80.249.188.84])
        by smtp.gmail.com with ESMTPSA id s7sm1807991lfb.40.2020.04.23.05.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 05:57:36 -0700 (PDT)
Subject: Re: [PATCH] staging:r8188eu: avoid skb_clone for amsdu to msdu
 conversion
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        devel@driverdev.osuosl.org, Puranjay Mohan <puranjay12@gmail.com>,
        linux-kernel@vger.kernel.org,
        Saurav Girepunje <saurav.girepunje@gmail.com>
References: <20200418084112.3723-1-insafonov@gmail.com>
 <20200423112910.GA3768232@kroah.com>
From:   Ivan Safonov <insafonov@gmail.com>
Message-ID: <fc167249-b052-89f8-1cee-b7d9bcff0d2c@gmail.com>
Date:   Thu, 23 Apr 2020 16:02:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423112910.GA3768232@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/20 2:29 PM, Greg Kroah-Hartman wrote:
> On Sat, Apr 18, 2020 at 11:41:12AM +0300, Ivan Safonov wrote:
>> skb clones use same data buffer, so tail of one skb is corrupted by beginning of next skb.
> 
> Please properly wrap your changelog text at the correct column (72).
> 
> Also, your subject: line does not have the correct driver name :(

Correct driver name is 'r8188eu':

1. 
http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2016-June/090556.html 
:
> One other point, it is customary to start the patch subject with "staging: 
> rtl8188eu: ..." for drivers in staging. I also prefer using r8188eu rather than 
> rtl8188eu as the former is the actual name of the driver, but either will work.

2. ./drivers/staging/rtl8188eu/os_dep/usb_intf.c lines 483-522/522 (END):
> static struct usb_driver rtl8188e_usb_drv = {
>         .name = "r8188eu",
>         .probe = rtw_drv_init,
>         .disconnect = rtw_dev_remove,
>         .id_table = rtw_usb_id_tbl,
>         .suspend =  rtw_suspend,
>         .resume = rtw_resume,
>         .reset_resume = rtw_resume,
> };
> 
> module_usb_driver(rtl8188e_usb_drv)

Subject contain this name.

>>
>> Signed-off-by: Ivan Safonov <insafonov@gmail.com>
>> ---
>>   drivers/staging/rtl8188eu/core/rtw_recv.c | 19 ++++++-------------
>>   1 file changed, 6 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
>> index d4278361e002..a036ef104198 100644
>> --- a/drivers/staging/rtl8188eu/core/rtw_recv.c
>> +++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
>> @@ -1525,21 +1525,14 @@ static int amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)
>>   
>>   		/* Allocate new skb for releasing to upper layer */
>>   		sub_skb = dev_alloc_skb(nSubframe_Length + 12);
>> -		if (sub_skb) {
>> -			skb_reserve(sub_skb, 12);
>> -			skb_put_data(sub_skb, pdata, nSubframe_Length);
>> -		} else {
>> -			sub_skb = skb_clone(prframe->pkt, GFP_ATOMIC);
>> -			if (sub_skb) {
>> -				sub_skb->data = pdata;
>> -				sub_skb->len = nSubframe_Length;
>> -				skb_set_tail_pointer(sub_skb, nSubframe_Length);
>> -			} else {
>> -				DBG_88E("skb_clone() Fail!!! , nr_subframes=%d\n", nr_subframes);
>> -				break;
>> -			}
>> +		if (!sub_skb) {
>> +			DBG_88E("dev_alloc_skb() Fail!!! , nr_subframes=%d\n", nr_subframes);
>> +			break;
>>   		}
>>   
>> +		skb_reserve(sub_skb, 12);
>> +		skb_put_data(sub_skb, pdata, nSubframe_Length);
>> +
> 
> Have you tested this?

I have not test this change.

Ivan Safonov.
