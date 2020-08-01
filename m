Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1CCC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 04:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81CCF206D7
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 04:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="cLQnd51k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgHAEzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 00:55:15 -0400
Received: from st43p00im-zteg10072001.me.com ([17.58.63.167]:42230 "EHLO
        st43p00im-zteg10072001.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725280AbgHAEzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 00:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1596257713;
        bh=/lGfYgpgU3rjk/7nACkAZxTe8aQjFNEo8HGM/KtHBog=;
        h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:To;
        b=cLQnd51kHmbJI0SZ6MNm/5h3hB4QkA09HLVzHtCISCmn6CoCTQ6JTxVU1/TXkjA3Y
         cdIeFYByY7hBVsyRwNHEiPdg/TnG3vqn09SBZGTy1NNw856Rxlm7e71A8PmfJy3RO4
         FnDWqZKRj0x2rdbMueYE8QnPXYtuifYC6fIkrPob+gANhtKi4gYWFBM4e8mfrRVzl+
         rs2XQf7ux+FWokuRwRm7WcLmHP21aEauPFFrEbNBwAO3mVbhXtF6g8uQNggkiykLMp
         +HTAa9QfKePNiXq2FtlORlrBodGaWdNI7aKccNWpQ+QHzl2oml/fHVAMm7uS/0KyoA
         x2ozB+Vc5Vu5Q==
Received: from localhost (84-114-122-94.cable.dynamic.surfer.at [84.114.122.94])
        by st43p00im-zteg10072001.me.com (Postfix) with ESMTPSA id D9FDEC03F2;
        Sat,  1 Aug 2020 04:55:12 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   =?utf-8?Q?J=C3=BCrgen_Stauber?= <j.stauber@icloud.com>
Mime-Version: 1.0 (1.0)
Subject: Re: High load from process irq/65-i2c-INT3 - kernel module tps6598x
Date:   Sat, 1 Aug 2020 06:55:10 +0200
Message-Id: <2FD98070-4BF0-482B-979A-3E61574E63C3@icloud.com>
References: <20200728123200.GF883641@kuha.fi.intel.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200728123200.GF883641@kuha.fi.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
X-Mailer: iPhone Mail (18A5332f)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-01_01:2020-07-31,2020-08-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2004280000 definitions=main-2008010037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

unfortunately I didn=E2=80=99t find any UCMCx option within the UEFI bios.=20=


kr,
J=C3=BCrgen

> On 28.07.2020, at 14:32, Heikki Krogerus <heikki.krogerus@linux.intel.com>=
 wrote:
>=20
> =EF=BB=BFHi J=C3=BCrgen,
>=20
> I'm sorry about the late reply (vacation).
>=20
>> On Mon, Jul 20, 2020 at 06:31:04PM +0200, J=C3=BCrgen Stauber wrote:
>> Hi all,
>>=20
>> I was made aware in the following launchpad bug report, that I should rep=
ort
>> the issue directly with the upstream maintainers:
>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1883511
>> <https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1883511>
>>=20
>> As mentioned in the report, I experience high cpu load due to an interrup=
ted
>> irq/65-i2c-INT3 process. A short fix is to unload the kernel module tps65=
98x.
>>=20
>> Please be lenient with me, since I=E2=80=99ve got no glue whether I=E2=80=
=99m doing this
>> correctly.
>>=20
>> In case you need more details/logs/information, please let me know.
>=20
> There is one thing that you may be able to try. If you can enter the
> BIOS menu, then you should be able to disable an option called
> "UCMCx". Unfortunately I don't know the full path to that option in
> the BIOS menu of the NUC, or is entering the BIOS menu possible in the
> first place. It is also possible that there is no option "UCMCx" at
> all.
>=20
> Unfortunately I don't have access to NUC10 at the moment, but I'll try
> get one.
>=20
> Br,
>=20
> --=20
> heikki
