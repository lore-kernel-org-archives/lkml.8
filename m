Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675CEC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 390032077D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gycs5Jdk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgE2Swh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 14:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgE2Swg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 14:52:36 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF80C03E969;
        Fri, 29 May 2020 11:52:36 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id h95so934636pje.4;
        Fri, 29 May 2020 11:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=hzq5CP06WE+rDQgMLM3t1qmEAoMARZTAExLtoppQY3s=;
        b=Gycs5Jdkqw5y4aA6YTe0aznWpCkMlZyRDPypCEmvOBdwBFX6i3XcJWwe7lm/WO/GBO
         1AvSgQxNCngwWH+VR5TUxuAW5T6jgrD5tWbA/ciT2KjuPVFqMubuc/byw95UNRKdipEx
         8eu3GoyM9a4BTQd4Tw3TCZkBHPDnwOJRRifO8jmduL8V5J7loVskh+NeU1/5BAaL6IM5
         dGNq6xfDuPsttWgJ+3LEJ0OV/kXyMl0XNn66uES9P+VqTuAOd/6oUMr8Rwl+imlkXv/T
         3pMu/AYkxboWp5pyvRMtXTi5EEzq6lT0SV3bnnOq7fZcTWwhTceupsPxShexmp7hPyhs
         Yvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=hzq5CP06WE+rDQgMLM3t1qmEAoMARZTAExLtoppQY3s=;
        b=ED4wLR0g0WKFC8nJgHqf6ztG/QPcjHZRpRQnis8QMIQVHe+Lzvm8J6EJn+RjhvTE9S
         9itz6+WUvK7g7PL5qrzYRU2ORH3RGchxilRwAGxunnOH7xgLk2pq6kxGUhAstFhTpPT+
         f5CebiZt+5L5GjoJCU+PrAoqrlZ5FcxhaFzHOmlRmgLMh9t0cpndRKylpCNyQT7fBOTH
         EvGaJLvtutGHXr9wvUeRmcNj8QuPUSiFKDh06l4tX3BRcIhQMfVHoAcP04ZaR0YDyH4x
         5E2lnAd49u6jCRnaAoMnNQTEytepSfrrAvXa2msh9FRwpe/ODXD3ACAxmuD9kS1oVpx5
         bQag==
X-Gm-Message-State: AOAM533T7Hy4kgOK6+ZEYlOO6+YLg6nQjGvo8zfIayys4GmlDN33cMgN
        rxjo6jcNGAQBqSg+RA33NqM=
X-Google-Smtp-Source: ABdhPJySY1MJ/4FGL1qpg5ojXX5NRDuqHrhGcK+iN4Uvb1UvVjRA8TVDXXm3AHDVaMF2yV13gndnCQ==
X-Received: by 2002:a17:90a:3ad1:: with SMTP id b75mr11081675pjc.216.1590778355795;
        Fri, 29 May 2020 11:52:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g18sm7401759pgn.47.2020.05.29.11.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 11:52:35 -0700 (PDT)
Subject: Re: [PATCH v2] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
To:     Patrick Williams <patrick@stwcx.xyz>
Cc:     Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>,
        linux-hwmon@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        manikandan.e@hcl.com, saipsdasari@fb.com, patrickw3@fb.com,
        vijaykhemka@fb.com
References: <20200529124607.GA3469@cnn>
 <49485085-7cc7-9e29-a719-98d1e184378b@roeck-us.net>
 <20200529174210.GF17541@heinlein>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <356db3d6-bc56-bd58-428f-d8e94311abee@roeck-us.net>
Date:   Fri, 29 May 2020 11:52:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200529174210.GF17541@heinlein>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3DlYDZqgzYYzdUTaYkmBSX1UFcTispULy"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3DlYDZqgzYYzdUTaYkmBSX1UFcTispULy
Content-Type: multipart/mixed; boundary="PzSnpketLU5sr73i8NHQan8wbmrYTvdCO"

--PzSnpketLU5sr73i8NHQan8wbmrYTvdCO
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 5/29/20 10:42 AM, Patrick Williams wrote:
> Hi Guenter,
>=20
> Thanks for the initial look at this.
>=20
> One question for you below...
>=20
> On Fri, May 29, 2020 at 10:30:16AM -0700, Guenter Roeck wrote:
>> On 5/29/20 5:46 AM, Manikandan Elumalai wrote:
>>> +		/* Enable TEMP1 by default */
>>> +		config |=3D ADM1278_TEMP1_EN;
>>> +		ret =3D i2c_smbus_write_byte_data(client,
>>> +					ADM1275_PMON_CONFIG,
>>> +					config);
>>> +		if (ret < 0) {
>>> +		dev_err(&client->dev,
>>> +			"Failed to enable temperature config\n");
>>> +		return -ENODEV;
>>> +		}
>>
>> This can be handled in a single operation, together with ADM1278_VOUT_=
EN
>> below. There is no need for two separate write operations.
>=20
> I don't know if you noticed here but the change ends up enabling
> TEMP1_EN in all cases.  Is this acceptable?  If not, do you have any
> preference on how it is selected for enablement?
>=20

I did. We are doing the same for output voltage already, so I am not that=

much concerned about it. If it is, we might consider adding _enable
attribute support (see Documentation/hwmon/sysfs-interface.rst) to the
PMBus core (presumably as virtual PMBus commands) and let the user
enable/disable individual attributes as needed.

What _should_ really be done, of course, is that the BIOS/ROMMON
configures the chip as desired. Obviously that is not happening here.

Guenter

>>>  		/* Enable VOUT if not enabled (it is disabled by default) */
>>>  		if (!(config & ADM1278_VOUT_EN)) {
>>> @@ -681,9 +697,6 @@ static int adm1275_probe(struct i2c_client *clien=
t,
>>>  			}
>>>  		}
>>> =20
>>> -		if (config & ADM1278_TEMP1_EN)
>>> -			info->func[0] |=3D
>>> -				PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
>>>  		if (config & ADM1278_VIN_EN)
>>>  			info->func[0] |=3D PMBUS_HAVE_VIN;
>>>  		break;
>>>
>>
>=20



--PzSnpketLU5sr73i8NHQan8wbmrYTvdCO--

--3DlYDZqgzYYzdUTaYkmBSX1UFcTispULy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEiHPvMQj9QTOCiqgVyx8mb86fmYEFAl7RWfEACgkQyx8mb86f
mYFj8Q/9FXJVYh+JNzgnGbNsTDqIEFGwqd0O5cn8rIPErMDkibL45IqGfyrgLX/K
im/Uwe0c/S6wij2YpP1MHxpLYcQJWUR+pv2WxOf9jzVXRBpXDB+nBtxSE1DWlIvJ
aEPO9TSSEp8Qmy2CQ9QIFKnxiQQ2n1hxrFmEQH0pkulAwL5rx6ZzfWC/laZsu/j4
6ZKTtfqc36MscC6KwxcWtSjY8shHAAQof2XILFXC95lYUCO6fHwcAuHvWaXbeyoh
3rrIHu75NTlYzT8fZtgAzHJ7AlSvSTTy98aYETxFNgLqoZq0i8SIpwYci6JrPraz
JXtegLXtISvse145ayXshtBJ3tr3+lW4S7fpU0JY3jXcECIgdi+tZ2dNQT+7Tqt+
BH9Me/wt67PMk+baSeQH48NYrSIjNitnxH5b35xjGqcPvNbTTKY0MzWjn0a6BvwE
pDaDUQXlNrmDXKu+ot47dNpXdGtR3fOxh6VAiFPIfePXyKB7hVBUesDH1+/iEc8/
QZYOUL/OVHxIIKcxGXtDta8Zoz7TwdKplfkmIdLHovHrAtU0EtGV+BeOD6budsTl
DaL2J2jJ1UvPJbjmGWI423QMtyljV+8lvYgEdEB3ytNqfuQaCHhKZsKBIrgwul9f
bXOLZKHFgcaZKEtGqGRyvnbSKONebZHDdwQXV51utOhnT0eN900=
=rTYV
-----END PGP SIGNATURE-----

--3DlYDZqgzYYzdUTaYkmBSX1UFcTispULy--
