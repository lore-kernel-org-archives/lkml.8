Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACC6C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E16920644
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5i9PT7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgDGBlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:41:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44110 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgDGBlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:41:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id b72so35250pfb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vHM0IxpKvuoB4zxZTiEhwDZHzc9hSzInxuuPu3PHC9c=;
        b=D5i9PT7Z4GlrQSfr7aIUhZopeto/QXSMSvPjpMKQvCwmArlzKftef1U6pWWIAKeJ0C
         CKYIjFPpgL1qjRtoVzuUGyGzgNMFdTWkX5ofXdZJyypPGRI41ig97TEFLZC1fbPj6M0J
         p6JLXMoPEXJHTvOjMyCvy9JMfGUmD/ufWr5et3NAPCnMzF034yjS3lTzpFrvEpDMsLsn
         bAiOpDXCwBxlSK96VgxuyikJrlmoxcW+XRGL4mZMKW/O0ucEFbO4nn2pCoBWCsgqAhtd
         po06KcrGx62qzyt4XU49aVx6r+jVnbhCAt0509HFIKrndvQEwBXaAOlO1n2FdiYIC63E
         gELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vHM0IxpKvuoB4zxZTiEhwDZHzc9hSzInxuuPu3PHC9c=;
        b=a5lZLW/HVhYGyAaaRcJP8ohfE62jawZT+9/JrvIRNgggAPhBaCgsOmMtzyv6VVVD2d
         Z+Kq/6RAs46Hpa/7+sqlOEnCSWaBvhD5LWFX/ghQ6xW5aInAtJxaq9Swyewl6yBuAJ4A
         FpJS3UI2w9tE0KvVu4z0v+WsauS84iO7XQ2AAruTDzp6/wAGAnNgVzN9p790sLBKWpCw
         zbSNIgMDU2IkS0IcH/h2R5MUy+6+2HHtG5glxfW4KNH50sRVZJ8UClZQxfGa6gZZJ7XV
         GU7gI/UrRoW+pib7hEQCk887M0g63g6WGnqu9Ewixs/l7JJ3ixXK3oyUWKWvt4wPdntR
         61Bw==
X-Gm-Message-State: AGi0PuYMvpZswu1FA/6JZmCDKBtA9mkuaDFu3eSnL3YNH2WU5Xi44DvH
        ieMXuxqYT1YakXgJlssfNB5abDhX
X-Google-Smtp-Source: APiQypLnKLj5IXzFOAva8E897J/bAnPdgBZxmrOod9DvkVAJ2j6zKOAST8Rf6gKCudmjBioSd2l+zQ==
X-Received: by 2002:aa7:84cc:: with SMTP id x12mr256412pfn.82.1586223704419;
        Mon, 06 Apr 2020 18:41:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x4sm12463117pfi.202.2020.04.06.18.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 18:41:43 -0700 (PDT)
Subject: Re: hwmon: drivetemp: bogus values after wake up from suspend
To:     =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <1af049a1-63ae-ee55-05d5-0e55eb00bd0e@applied-asynchrony.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <03b3159b-e9ca-011d-d95c-6572cc07d895@roeck-us.net>
Date:   Mon, 6 Apr 2020 18:41:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1af049a1-63ae-ee55-05d5-0e55eb00bd0e@applied-asynchrony.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/20 9:23 AM, Holger Hoffstätte wrote:
> 
> I've been giving the drivetemp hwmon driver a try and am very happy
> with it; works right away and - much to my surprise - doesn't wake up
> HDDs that have gone to sleep. Nice!
> 
> I did notice one tiny thing though: after waking up from suspend, my SSD
> (Samsung 850 Pro) reports a few initial bogus values - suspiciously -128°,
> which is definitely not the temperature in my office. While this is more
> a cosmetic problem, it cramps my monitoring setup and leads to wrong graphs.
> Can't have that!
> 
> So I looked into the source and found that the values are (understandably)
> passed on unfiltered/uncapped. Since it's unlikely any active device has
> operating temperature below-zero, I figured the laziest way is to cap the
> value to positive:
> 
> diff -rup a/drivers/hwmon/drivetemp.c b/drivers/hwmon/drivetemp.c
> --- a/drivers/hwmon/drivetemp.c    2020-04-02 08:02:32.000000000 +0200
> +++ b/drivers/hwmon/drivetemp.c    2020-04-06 18:13:04.892554087 +0200
> @@ -147,7 +147,7 @@ static LIST_HEAD(drivetemp_devlist);
>  #define INVALID_TEMP        0x80
>  
>  #define temp_is_valid(temp)    ((temp) != INVALID_TEMP)
> -#define temp_from_sct(temp)    (((s8)(temp)) * 1000)
> +#define temp_from_sct(temp)    (max(0, ((s8)(temp)) * 1000))
>  
>  static inline bool ata_id_smart_supported(u16 *id)
>  {
> 
> The assumption is of course *theoretically* wrong since some
> equipment might indeed operate in negative C°. One way might be
> to use the device's "low" operating point first, but then that
> might not be available and we'd be back to capping to 0.
> I'm open to other suggestions. :)
> 

Looking into the code, 0x80 or -128 indeed reflects an invalid temperature.
Any chance you can apply the following to see if it helps ?

diff --git a/drivers/hwmon/drivetemp.c b/drivers/hwmon/drivetemp.c
index 370d0c74eb01..c27239eb28cf 100644
--- a/drivers/hwmon/drivetemp.c
+++ b/drivers/hwmon/drivetemp.c
@@ -264,6 +264,8 @@ static int drivetemp_get_scttemp(struct drivetemp_data *st, u32 attr, long *val)
                return err;
        switch (attr) {
        case hwmon_temp_input:
+               if (!temp_is_valid(buf[SCT_STATUS_TEMP]))
+                       return -ENODATA;
                *val = temp_from_sct(buf[SCT_STATUS_TEMP]);
                break;
        case hwmon_temp_lowest:

I am not sure what the best error code would be - suggestions welcome.

Thanks,
Guenter
