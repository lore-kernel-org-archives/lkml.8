Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5141AC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 12:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1687B20882
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 12:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Juvgi+3k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbgIJMbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 08:31:52 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44104 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730618AbgIJM2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 08:28:12 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08ACRrDn038516;
        Thu, 10 Sep 2020 07:27:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599740873;
        bh=RLqBomBVKlGqdgICBb7RcNvbvmqq3ihITsF7qL6O9Fk=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=Juvgi+3kHSXmMgRzfS2dIRVX9TPQAvxsLYt4xgtTHIModx6AAgKbbubIRRXS5qWMJ
         AHYgpiVCEoyQDL+5YlKl5XxRccbZbxtpBlZ9Sl7HyOoPt9MdNSCrolmviMPzlG7Lzn
         17RVV3tdM8GJKWaWZ2zkBNYGWik83kW16Ab6yXvI=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08ACRrLE111327
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Sep 2020 07:27:53 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 10
 Sep 2020 07:27:53 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 10 Sep 2020 07:27:53 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08ACRpZh057346;
        Thu, 10 Sep 2020 07:27:51 -0500
Subject: Re: [PATCH 2/2] ASoC: ti: j721e-evm: Add support for j7200-cpb audio
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     kernel test robot <lkp@intel.com>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>
References: <20200910075433.26718-3-peter.ujfalusi@ti.com>
 <202009101750.MT0BQY74%lkp@intel.com>
 <e32444ee-542d-1daf-0fa3-be4d280aef35@ti.com>
X-Pep-Version: 2.0
Message-ID: <9379c7b5-1cf4-3d10-ce6e-0a1b0b16bc72@ti.com>
Date:   Thu, 10 Sep 2020 15:27:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <e32444ee-542d-1daf-0fa3-be4d280aef35@ti.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/09/2020 14.48, Peter Ujfalusi wrote:
> Hi,
>=20
> On 10/09/2020 12.54, kernel test robot wrote:
>> Hi Peter,
>>
>> I love your patch! Perhaps something to improve:
>>
>> [auto build test WARNING on asoc/for-next]
>> [also build test WARNING on v5.9-rc4 next-20200909]
>> [If your patch is applied to the wrong git tree, kindly drop us a note=
=2E
>> And when submitting patch, we suggest to use '--base' as documented in=

>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    https://github.com/0day-ci/linux/commits/Peter-Ujfalusi/ASoC-t=
i-j721e-evm-Support-for-j7200-variant/20200910-155534
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.=
git for-next
>> config: m68k-allmodconfig (attached as .config)
>> compiler: m68k-linux-gcc (GCC) 9.3.0
>> reproduce (this is a W=3D1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/=
sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-9.3.0 make.c=
ross ARCH=3Dm68k=20
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> sound/soc/ti/j721e-evm.c:532:3: warning: this decimal constant is un=
signed only in ISO C90
>>      532 |   [J721E_CLK_PARENT_48000] =3D 2359296000, /* PLL4 */
>>          |   ^
>>
>> # https://github.com/0day-ci/linux/commit/63afa4709f3914bb58dd727c1119=
c447a23ce150
>> git remote add linux-review https://github.com/0day-ci/linux
>> git fetch --no-tags linux-review Peter-Ujfalusi/ASoC-ti-j721e-evm-Supp=
ort-for-j7200-variant/20200910-155534
>> git checkout 63afa4709f3914bb58dd727c1119c447a23ce150
>> vim +532 sound/soc/ti/j721e-evm.c
>>
>>    527=09
>>    528	static const struct j721e_audio_match_data j7200_cpb_data =3D {=

>>    529		.board_type =3D J721E_BOARD_CPB,
>>    530		.num_links =3D 2, /* CPB pcm3168a */
>>    531		.pll_rates =3D {
>>  > 532			[J721E_CLK_PARENT_48000] =3D 2359296000, /* PLL4 */

Suffixing with 'u' silences the warning for C90, I'll send v2

>=20
> struct j721e_audio_match_data {
> 	enum j721e_board_type board_type;
> 	int num_links;
> 	unsigned int pll_rates[2];
> };
>=20
> pll_rates _is_ unsigned int.
>=20
>>    533		},
>>    534	};
>>    535=09
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>
>=20
> - P=E9ter
>=20
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>=20

- P=E9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

