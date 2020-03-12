Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62638C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 21:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F5D206CD
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 21:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20150623.gappssmtp.com header.i=@dilger-ca.20150623.gappssmtp.com header.b="zlpK91xL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCLV1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 17:27:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43746 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgCLV1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 17:27:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id c144so3893385pfb.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 14:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=PJoLagdQ+UzLDMrA130yBvJhU7geprBWK0KSlI3JMAs=;
        b=zlpK91xLR/RBHBb2FyrRyUW7r8w5Q4MqIHCDL+MQkQaM74qbGdjQ1bLv5nSw6o1MYM
         ylxA98+GGZ8OsD5mrROge3E4p1YMINKAw9UB0hljVrtLAOC2ywjDhzYFIK3A+wlJOXnH
         glukXKWV6C5GwhLZBuSpimbjjJon7OxaIOIIjtE6ufAc7CbiqbCVVoWt1lkE47XhmYKJ
         Dfzt6C0kX4nVka+qohqHE06h8qRWWpj2t30C3OUs/rIKoWwkCtU2FHtdj5aCGWsdBIiR
         Gz/ubCQk/nijo2AtDRbWZ7CWq88qSrZCH6YjQBQly3IODtj9RHUIY4HQxLlPRPNMg4w6
         usBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=PJoLagdQ+UzLDMrA130yBvJhU7geprBWK0KSlI3JMAs=;
        b=Snrd192FRG3a9S/K75P7YNhFncPK/6UJQ/GhdtQwUBWt8+K5KHauqrN7bCBc3L+FE+
         I4KRxnU2DqT6/PltfdI/0WHh5uRrGvYjyQuoXwXR+AK+d39rJ0dIhUjNO8POyQKCjnZh
         VHg/6hbqJrbuhZbaLVssNnytwEtvmBZWhp8BCCXJTSu7VlKun7CjsEHJQ0xD0nZTxOe4
         kJF2gOeD9TiRD8gTlHgG3+t5XHKkR+itHCtHY95ewC4Fv4Sdjg+FIVrYTgv1SJx41yAJ
         stTTRVNX9DGmoL9ihxv0OtucGUjqhHkRaivNsuGUYVWAtc6nKjkGRV0RVGNAf3ob/O9u
         foyw==
X-Gm-Message-State: ANhLgQ04OnE1j+bCS8oT4g5NcuAKBf+MZU04k/EbpK837WEPDjSztoGv
        /onHKUivSySZ+UycB6DRuddCtQ==
X-Google-Smtp-Source: ADFU+vv703IHpFMcX/saRcpg8yFTCgtb0/93afAdMzgrMxtE/RelAv+ei/xytP4xmWES7LZtE7tcUQ==
X-Received: by 2002:a62:8706:: with SMTP id i6mr10254524pfe.115.1584048471791;
        Thu, 12 Mar 2020 14:27:51 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id b2sm14178996pgd.45.2020.03.12.14.27.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2020 14:27:51 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <B95E9CA5-2E6A-4F8B-9B8F-BC4F4D49CBF3@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_29A8F571-9FB2-49DF-BF9C-D7D04802C64D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Fix missing 'bit' in comment
Date:   Thu, 12 Mar 2020 15:27:48 -0600
In-Reply-To: <ed0f14ce-25f8-7ef7-54a6-6b3f9fa4bdfc@redhat.com>
Cc:     Chucheng Luo <luochucheng@vivo.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org, wenhu.wang@vivo.com,
        trivial@kernel.org
To:     Hans de Goede <hdegoede@redhat.com>
References: <20200312074037.25829-1-luochucheng@vivo.com>
 <ed0f14ce-25f8-7ef7-54a6-6b3f9fa4bdfc@redhat.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_29A8F571-9FB2-49DF-BF9C-D7D04802C64D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 12, 2020, at 4:40 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>=20
> Hi,
>=20
> On 3/12/20 8:40 AM, Chucheng Luo wrote:
>> The missing word may make it hard for other developers to
>> understand it.
>> Signed-off-by: Chucheng Luo <luochucheng@vivo.com>
>=20
> Thanks for catching this:
>=20
> Acked-by: Hans de Goede <hdegoede@redhat.com>

Not to nit-pick, but these should properly be written as "32-bit" and =
"64-bit".
That can be easily fixed in the patch before upstream submission.

Cheers, Andreas

> Regards,
>=20
> Hans
>=20
>=20
>> ---
>>  fs/vboxsf/dir.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
>> index dd147b490982..be4f72625d36 100644
>> --- a/fs/vboxsf/dir.c
>> +++ b/fs/vboxsf/dir.c
>> @@ -134,7 +134,7 @@ static bool vboxsf_dir_emit(struct file *dir, =
struct dir_context *ctx)
>>  		d_type =3D vboxsf_get_d_type(info->info.attr.mode);
>>    		/*
>> -		 * On 32 bit systems pos is 64 signed, while ino is 32 =
bit
>> +		 * On 32 bit systems pos is 64 bit signed, while ino is =
32 bit
>>  		 * unsigned so fake_ino may overflow, check for this.
>>  		 */
>>  		if ((ino_t)(ctx->pos + 1) !=3D (u64)(ctx->pos + 1)) {
>=20


Cheers, Andreas






--Apple-Mail=_29A8F571-9FB2-49DF-BF9C-D7D04802C64D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl5qqVQACgkQcqXauRfM
H+B4exAAoFSPfhMNcJf0KQF/oKFpbfC5VMUkwVNyZIoIL9DDLMPs3+18a59VU+3i
2EF9hxvM5Wx1DQOb6ghYNeHT8VUJj2pOFTGiqOc5EMdFEQ8c7tI7dNGDy/ZG41Ii
r5NnKlXtYxPxw/zFWpu5O5f4nlRaZmp/BaquCf0qixSXWkZT+z2uD/WMDENvhoNp
zdUNmq1zo+/Gl2GXGYnhqvk5psxL3VT0F/StupgbwzLh4G0msHuP3kL5fY229//B
6GVjagT+C2JYSlRzUuNim9By2VbAfLsnem4cPnXjZ2o2t5m4mAUWrgRX5y4REwoh
fyEqoEGB/vtgXv2etvuAOvi1FrMycUo02ImLAKR2Pk/kTlYYpJCFWb8CotYjZ6Px
VNcMk80FJUgXROeK+oitdy6ADSRqa0em8lWmyosxYcLCQzfXL+jD8C6YbeP4TNqh
b2BcobFjXFVQGZD1HEJkJOeF+zYlsJKCoft77dMHUC7sLoOIi8kbEDtVLOOEkvQg
GmdQyaCLsrkoP8x1Ug3foFZjAn1G2b6pgJpagNLqWsiY2O8LR2mASgNxn9Sd6yY4
YhtzVMGCfVdNqm0Gdzm9F9/ZaTyQu9XVvCW6xgBBxqlmXVHoGA2GQ1C4rOiwpE99
J6WwCflT+SzEDCrQv+N/TlSYWij5TTIZ90le/qYdtdwI1Uv4MAk=
=vApv
-----END PGP SIGNATURE-----

--Apple-Mail=_29A8F571-9FB2-49DF-BF9C-D7D04802C64D--
