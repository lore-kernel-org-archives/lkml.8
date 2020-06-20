Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089EEC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 03:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7A7922DD6
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 03:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=icurse.nl header.i=@icurse.nl header.b="N0oGiZ7k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732318AbgFTDKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 23:10:08 -0400
Received: from mail.ruun.network ([176.9.184.6]:38175 "EHLO mail.ruun.network"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732074AbgFTDKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 23:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=icurse.nl;
         s=x; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=4E7qcFZA21pH5yMV3SBZIPprvk6klq6E9B/lBjV5CzQ=; b=N0oGiZ7kMa5fk56iAMEtKMObDZ
        2+Btuc4IYoBA/EJ6PBKFoL5V7SY7TrO6dCpryI2aS5MsXLd6rIgk5ZNoIKvl9JDAg/80xiGcZaEAY
        PTHY02ElJVRSJrUPdHYXXFgBc1ao/TEOskdekC8zYQQSYMBEMBkQ9buQJ0DwRzSd8n0TBfoHaNQ6c
        egLEM5pddo4+0M/m3rDMwyl/UJEdTkbhJBCqTCJG6c4auhWNrRqbROrMcZY9DcQbkHA9XmJ2HZx+4
        v5EuLo29nVm3+k1HP+eNLEXD4a5zMOTzzdkuega0J42UFOOCSrRGAs0rzrbFte/aTTOuZDFWYEnG1
        hSnx1ogg==;
Received: from cpe-98-14-166-248.nyc.res.rr.com ([98.14.166.248] helo=cinderbox)
        by birchibald.ruun.network with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93.0.4)
        (envelope-from <jeffrey@icurse.nl>)
        id 1jmTtJ-0001Lx-OO; Sat, 20 Jun 2020 05:10:01 +0200
Date:   Fri, 19 Jun 2020 23:09:33 -0400
From:   Jeffrey Lin <jeffrey@icurse.nl>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm) Add Latitude 5480 to fan control
 whitelist
Message-ID: <20200619230933.52058bd7@cinderbox>
In-Reply-To: <20200619121821.dz4slqvy4gigm6ns@pali>
References: <20200619015529.285241-1-jeffrey@icurse.nl>
        <20200619121821.dz4slqvy4gigm6ns@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MiWU=0FfamrKQ2j1Ef4=yfb";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Authenticated-Id: jeffrey@icurse.nl
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MiWU=0FfamrKQ2j1Ef4=yfb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Jun 2020 14:18:21 +0200
Pali Roh=C3=A1r <pali@kernel.org> wrote:

>On Thursday 18 June 2020 21:55:29 Jeffrey Lin wrote:
>> This allows manual PWM control without the BIOS fighting back on Dell
>> Latitude 5480.
>>=20
>> Signed-off-by: Jeffrey Lin <jeffrey@icurse.nl> =20
>
>If it is working fine on your machine, you can add my:

Yes, the below patch works on my machine.  dmesg reports "dell_smm_hwmon:
enabling support for setting automatic/manual fan control" and writing 1 to
/sys/class/hwmon/hwmon4/pwm1_enable allows pwmconfig/fancontrol full contro=
l.

>
>Acked-by: Pali Roh=C3=A1r <pali@kernel.org>
>
>> ---
>>  drivers/hwmon/dell-smm-hwmon.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>=20
>> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwm=
on.c
>> index 16be012a95ed..ec448f5f2dc3 100644
>> --- a/drivers/hwmon/dell-smm-hwmon.c
>> +++ b/drivers/hwmon/dell-smm-hwmon.c
>> @@ -1187,6 +1187,14 @@ static struct dmi_system_id
>> i8k_whitelist_fan_control[] __initdata =3D { },
>>  		.driver_data =3D (void
>> *)&i8k_fan_control_data[I8K_FAN_34A3_35A3], },
>> +	{
>> +		.ident =3D "Dell Latitude 5480",
>> +		.matches =3D {
>> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Latitude 5480"),
>> +		},
>> +		.driver_data =3D (void
>> *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
>> +	},
>>  	{
>>  		.ident =3D "Dell Latitude E6440",
>>  		.matches =3D {
>> --=20
>> 2.27.0
>>  =20


--Sig_/MiWU=0FfamrKQ2j1Ef4=yfb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQKTBAEBCgB9FiEETxvPxdIN5HH4UagwI3cxl4eiYmsFAl7tfe9fFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDRG
MUJDRkM1RDIwREU0NzFGODUxQTgzMDIzNzczMTk3ODdBMjYyNkIACgkQI3cxl4ei
Ymv0gxAAk9g/vTP5iuQmrQBaBjWeemQIWpagkCfNWvxeZ1SvHHKJMjezWDP1kug5
KmgsMoZrKT+wWyls6pOdjVFv0kxjB6GAbmpozcStmWL3buzbBe3YfR7k2f9C4Rct
lTYjv6M5XmzGINaRW8ybTmcLcOYOwNfcxzBDjcz873/jr60XZkhVCIqffn62HNuD
nfEGW4X8OUBUTuQP4KGT7cDtaanOfLs1RWvmTBseEhJrGxz+LOx6/NtBUPM9Ztxn
45+YMDwczWwS/De2W1HxtQBcmu3VRMhr/7pctkmHT+0uR4nHpXPXw+h5CEtFA6IK
1tmLJ1bcnSKQB/pXEMUvtXZI/iYmGybYlxT8qYBYbiWBzBXXrqJrEcB9oTmQI8tk
MaD+rbfPvHayoxO/Rb3QNuxNeYkywzJ8vLzpk51n2EnaxrnP65RcDPYzU3DEKLHm
2bBoUt8t7BF1ytJU28caiM6rAlICozvwQLJlofRQT2TWXnCB9ik9Ez1cx5zGDHrq
S4O7731sQEad4NJ4sZXO3qtKQnfaG18uOVo3Jm1IbrpSUAKpiZ/Zh0rgdxXnYc7N
T0VBXSn0OLqg1FpZM0JxUNdeEcAmgT3NGCg0GpgyYL5vvJu4l6Ozt4rTeK9HiRRJ
0IQ0fnCcbDOFOLyYblTIJd3I/RPQHgTgbkIDcC7Q8R5EmvP/D1w=
=2GQf
-----END PGP SIGNATURE-----

--Sig_/MiWU=0FfamrKQ2j1Ef4=yfb--
