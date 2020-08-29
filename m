Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9368DC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 18:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E03F206B5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 18:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgH2SGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 14:06:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:36584 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728265AbgH2SGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 14:06:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 27FA5AEE7;
        Sat, 29 Aug 2020 18:06:50 +0000 (UTC)
Subject: Re: [drm/mgag200] 913ec479bb: vm-scalability.throughput 26.2%
 improvement
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        kernel test robot <rong.a.chen@intel.com>
Cc:     John Donnelly <John.p.donnelly@oracle.com>,
        Emil Velikov <emil.velikov@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
References: <20200826085847.GL4299@shao2-debian>
 <76926ade-15fb-75a3-17aa-a2b5a68471c8@suse.de>
 <99c7683c-f428-378d-2b19-ef51270a5d8e@oracle.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <f9664139-e28c-ba8e-b4e4-d505baf9069a@suse.de>
Date:   Sat, 29 Aug 2020 20:06:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <99c7683c-f428-378d-2b19-ef51270a5d8e@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5y5pW3va54DoE0vaSoXbKA03gqqNKljlw"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5y5pW3va54DoE0vaSoXbKA03gqqNKljlw
Content-Type: multipart/mixed; boundary="FBNiFtfPYXx1RuSfm3uJxXQubrMy0QkKB";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Mike Kravetz <mike.kravetz@oracle.com>,
 kernel test robot <rong.a.chen@intel.com>
Cc: John Donnelly <John.p.donnelly@oracle.com>,
 Emil Velikov <emil.velikov@collabora.com>,
 LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org, lkp@intel.com,
 ying.huang@intel.com, feng.tang@intel.com, zhengjun.xing@intel.com
Message-ID: <f9664139-e28c-ba8e-b4e4-d505baf9069a@suse.de>
Subject: Re: [drm/mgag200] 913ec479bb: vm-scalability.throughput 26.2%
 improvement
References: <20200826085847.GL4299@shao2-debian>
 <76926ade-15fb-75a3-17aa-a2b5a68471c8@suse.de>
 <99c7683c-f428-378d-2b19-ef51270a5d8e@oracle.com>
In-Reply-To: <99c7683c-f428-378d-2b19-ef51270a5d8e@oracle.com>

--FBNiFtfPYXx1RuSfm3uJxXQubrMy0QkKB
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 27.08.20 um 16:56 schrieb Mike Kravetz:
> On 8/27/20 2:16 AM, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 26.08.20 um 10:58 schrieb kernel test robot:
>>> Greeting,
>>>
>>> FYI, we noticed a 26.2% improvement of vm-scalability.throughput due =
to commit:
>>
>> I guess this resolves the once-measured performance penalty of similar=

>> magnitude. But do we really understand these tests? When I sent out
>> patches to resolve the problem, nothing changed. And suddenly the
>> performance is back to normal.
>>
>> Best regards
>> Thomas
>>
>>>
>>>
>>> commit: 913ec479bb5cc27f99f24d5fd111b3ef29a4deb9 ("drm/mgag200: Repla=
ce VRAM helpers with SHMEM helpers")
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git maste=
r
>>>
>>>
>>> in testcase: vm-scalability
>>> on test machine: 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz=
 with 80G memory
>>> with following parameters:
>>>
>>> 	runtime: 300s
>>> 	size: 8T
>>> 	test: anon-cow-seq-hugetlb
>>> 	cpufreq_governor: performance
>>> 	ucode: 0x11
>=20
> Hello Thomas,
>=20
> Did drm changes really impact anon-cow-seq-hugetlb performance?
>=20
> My change c0d0381ade79 ("hugetlbfs: use i_mmap_rwsem for more pmd shari=
ng
> synchronization") caused a -33.4% regression of anon-cow-seq-hugetlb.  =
A
> recent change 34ae204f185 (hugetlbfs: remove call to huge_pte_alloc wit=
hout
> i_mmap_rwsem) was tested by Zhengjun Xing and improved performance by 2=
0
> something percent.  That seems in line with this report/improvement.

Some of DRM's memory management might be affected by hugetable changes.
While I cannot really point to a specific location, it's not impossible
that there's a connection.

>=20
> Perhaps the tooling is not always accurate in determining the commit wh=
ich
> causes the performance changes?
> Perhaps I am misreading information in the reports?
>=20

=46rom what I remember, some of these tests print to the console, which
has always been slow, and has generally been a bad idea for performance
tests. I guess these tests are not very accurate.

Best regards
Thomas

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=FCrnberg, Germany
(HRB 36809, AG N=FCrnberg)
Gesch=E4ftsf=FChrer: Felix Imend=F6rffer


--FBNiFtfPYXx1RuSfm3uJxXQubrMy0QkKB--

--5y5pW3va54DoE0vaSoXbKA03gqqNKljlw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFIBAEBCAAyFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl9KmQ8UHHR6aW1tZXJt
YW5uQHN1c2UuZGUACgkQaA3BHVMLeiMYqgf+ILMWVgHSnMx5b0vvYcvjM7TuLnj8
F/hK2GxD3sP01ZI2R/+SwoPFJOpbl4rq2kq7k/BxqBgNNmuyR29iZQWpcmGeHW6u
Q/zzRsaMSlk1PnO1haPqAlU5XQUT1dTn9zr1JUD1Us92UDJsdJmm9ZZx8pZNY4Mp
lJ6jnhNxqrCgGicc2t8gBEJexlmaEeql2GjhPYncJGybdH+U9ZCcWhQI/i/ZPc/x
wQiq6ZC6nO0uuoVOwOtaKoJStxY9h7kef1wwiK19rU1bbESwrMdB5qEMaS0mkRxB
v8PSVccSyH22MJvlPfuwJkfA2O0UCOyiG5Ylk/Hud/QyXasfkFp+hgzasw==
=v21Y
-----END PGP SIGNATURE-----

--5y5pW3va54DoE0vaSoXbKA03gqqNKljlw--
