Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1DCC0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB152074B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNjnMmC5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731332AbgCKW3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 18:29:00 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44939 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729846AbgCKW3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 18:29:00 -0400
Received: by mail-pg1-f195.google.com with SMTP id 37so1963012pgm.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 15:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:from:message-id;
        bh=OK2jvg8iIbxudu6ND4J8JJtzzocg+9lZtyCUh0iqcfs=;
        b=cNjnMmC5+csrT7n7xkH0NSj4vC7lV5+mQsK86AkZsmXEL8Ddsi1g9QpZqX0U58NqwU
         l1FldLSUdDzYy4r/dsZw502g/jEVxZDXMGCGyOSz6Ynye0NVU6V9bUM5D0nGDY5nx89t
         IU7PTinO4JYfVw9DBNKRCkXzJpoqHKN1XImHX0JH294EkDNNpXFY6lxCJ9r3QvyhyP7m
         skJzw12CpiJEcqgJDNIqP2j3gJbtuBCL6oxOj7j+y8g1FqYtb8rbp/Ebk+yRcq+Vfnsa
         COCA92W6WcakTBHakyj02K5Mflnv/qSf6FffeFsJ1gcEhDOf2r9zSRGCdtxSey/g6XCY
         nXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:from:message-id;
        bh=OK2jvg8iIbxudu6ND4J8JJtzzocg+9lZtyCUh0iqcfs=;
        b=fFdjWFu2vEx/zy9NN6isGfbNYZ5j9LFaAi9uYGz8KBfbdQf2kXIYJo/hAB44YTus3l
         yheRU0UTOYCbGxVhUoV8LD452ng5+iptI7HHZI5i1wrVWfhtTC9b+nNDiq3y7jnAxSSg
         Oye77+ivVYrpK7vFrkGY0ht5nDGOK802revYuLaVLDnKNfCmPuKVFn28cEvYegw5/UnA
         kL8a3sFqKpianuUo/Xxj9xoJ+iWzXmV0WjFm1FsIANfKTHKY8UFno3VT/VZVdlryQ9Q6
         zbqIEETyN1z9PKXMROkcew7jTo9S58WTHX+Wj02JEQfPg2naEMCqvLbZAro/2C9U/w3u
         KoEQ==
X-Gm-Message-State: ANhLgQ0r/+EVW0LhFg+uOhrXI1qNWChwmCG1qyCrlHwlKrIaKIp/Obz4
        Haq7q04J2p0ckQpLHs9V4AE=
X-Google-Smtp-Source: ADFU+vtuQMMY52HPjZDuDX/2pzncUdQNWBbjslUBN7mA7FVQOPHA0VUEQXQ2n4V1ilOYcStsF3BG6A==
X-Received: by 2002:a62:e20e:: with SMTP id a14mr4963341pfi.138.1583965739153;
        Wed, 11 Mar 2020 15:28:59 -0700 (PDT)
Received: from [192.168.0.100] ([113.193.33.106])
        by smtp.gmail.com with ESMTPSA id z1sm641860pfa.16.2020.03.11.15.28.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Mar 2020 15:28:58 -0700 (PDT)
Date:   Thu, 12 Mar 2020 03:58:55 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <0fed25f914c6f39b024dd3bbc4f11892c40f4a60.camel@perches.com>
References: <20200311133811.2246-1-shreeya.patel23498@gmail.com> <0fed25f914c6f39b024dd3bbc4f11892c40f4a60.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Outreachy kernel] [PATCH] Staging: rtl8723bs: sdio_halinit: Remove unnecessary conditions
To:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, sbrivio@redhat.com,
        daniel.baluta@gmail.com, nramas@linux.microsoft.com,
        hverkuil@xs4all.nl, Larry.Finger@lwfinger.net
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
Message-ID: <1CF27D55-EEB4-4A75-B767-A30845BD5E1B@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Joe,

On March 11, 2020 10:56:29 PM GMT+05:30, Joe Perches <joe@perches=2Ecom> w=
rote:
>On Wed, 2020-03-11 at 19:08 +0530, Shreeya Patel wrote:
>> Remove if and else conditions since both are leading to the
>> initialization of "valueDMATimeout" and "valueDMAPageCount" with
>> the same value=2E
>
>You might consider removing the
>	/* Timeout value is calculated by 34 / (2^n) */
>comment entirely as it doesn't make much sense=2E
>

You want me to remove the other comments as well?
Since Julia suggested in another email that the comments are not useful if=
 we are removing the condition since they were applied to only one branch (=
 i=2Ee=2E "if" branch )


Thanks

>For what N is "(34 / (2 ^ N))" =3D 6 ?
>
>> diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit=2Ec
>b/drivers/staging/rtl8723bs/hal/sdio_halinit=2Ec
>[]
>> @@ -551,18 +551,11 @@ static void HalRxAggr8723BSdio(struct adapter
>*padapter)
>> =20
>>  	pregistrypriv =3D &padapter->registrypriv;
>> =20
>> -	if (pregistrypriv->wifi_spec) {
>> -		/*  2010=2E04=2E27 hpfan */
>> -		/*  Adjust RxAggrTimeout to close to zero disable RxAggr,
>suggested by designer */
>> -		/*  Timeout value is calculated by 34 / (2^n) */
>> -		valueDMATimeout =3D 0x06;
>> -		valueDMAPageCount =3D 0x06;
>> -	} else {
>> -		/*  20130530, Isaac@SD1 suggest 3 kinds of parameter */
>> -		/*  TX/RX Balance */
>> -		valueDMATimeout =3D 0x06;
>> -		valueDMAPageCount =3D 0x06;
>> -	}
>> +	/*  2010=2E04=2E27 hpfan */
>> +	/*  Adjust RxAggrTimeout to close to zero disable RxAggr, suggested
>by designer */
>> +	/*  Timeout value is calculated by 34 / (2^n) */
>> +	valueDMATimeout =3D 0x06;
>> +	valueDMAPageCount =3D 0x06;

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
