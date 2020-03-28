Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD62C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 18:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F33220714
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 18:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="mZK8iXS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgC1SVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 14:21:05 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:36595 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgC1SVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 14:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1585419662;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=201XcJutOCoesKuDpsFmIpB9/9V6Sc+xigsUbwSoqqE=;
        b=mZK8iXS6d3uECfaSCCGtjYfzTCR1+oMdgJhDYG0yxZmsfVyUqBcGxqHzSEDEWIDYTj
        V3md6L+H9nBzkKFOeJPspkDihPpynJudihCkZYAIvTotOStuS8dC8qQlDhxo+IOg07HE
        bzETk0lZZZUV2glEqbpGZz7tXiKEQIw6xLYkpBh3n0ZkJ5vcyn/jZZg5I5Qtos7t4zdo
        naGo6bgKHqZ3y8UnkAtM8jf2YjWnU+FnXptBP8uQV80ZeNWbECRUExyp1oi/GafYYviF
        c/TSlPv8OBDVNpdPoODfBQOetRTWQi+qJ5iAj6ExuGN4sVxb5HP8R9egrluNdQD3+ihG
        mn8A==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Qpw97WFDlWcXA4N8z4="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 46.2.1 DYNA|AUTH)
        with ESMTPSA id m02241w2SIL19Td
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Sat, 28 Mar 2020 19:21:01 +0100 (CET)
Subject: Re: CHKDT error by f95cad74acdb ("dt-bindings: clocks: Convert Allwinner legacy clocks to schemas")
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20200328182008.5ac2f99e@kemnade.info>
Date:   Sat, 28 Mar 2020 19:21:01 +0100
Cc:     Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EF62F8D0-A205-4D64-8540-44F843720797@goldelico.com>
References: <A65A26D8-9F66-4D46-B1E1-84ECECF079E3@goldelico.com> <20200328182008.5ac2f99e@kemnade.info>
To:     Andreas Kemnade <andreas@kemnade.info>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 28.03.2020 um 18:20 schrieb Andreas Kemnade <andreas@kemnade.info>:
>=20
> Hi Nikolaus,
>=20
> On Sat, 28 Mar 2020 13:26:24 +0100
> "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
>=20
>> Hi Rob,
>> I am trying to check my new bindings with v5.6-rc7 but get this =
before
>> the process tries mine:
>>=20
>> make dt_binding_check dtbs_check
>> ...
>>=20
>>  CHKDT   Documentation/devicetree/bindings/bus/renesas,bsc.yaml - due =
to target missing
>>  CHKDT   Documentation/devicetree/bindings/bus/simple-pm-bus.yaml - =
due to target missing
>>  CHKDT   =
Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ahb-clk.yaml =
- due to target missing
>> =
/Volumes/CaseSensitive/master/Documentation/devicetree/bindings/clock/allw=
inner,sun4i-a10-ahb-clk.yaml: Additional properties are not allowed =
('deprecated' was unexpected)
>> make[2]: *** =
[Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ahb-clk.examp=
le.dts] Error 1
>> make[1]: *** [dt_binding_check] Error 2
>> make: *** [sub-make] Error 2
>>=20
>> What am I doing wrong?
>> Is there an option to skip such errors and continue?
>> Is there an option to just test my bindings and yaml file?
>>=20
> maybe your tools are outdated, so rerun
>=20
> pip3 install =
git+https://github.com/devicetree-org/dt-schema.git@master

Yes, that one solves the problem!

A better error message of CHKDT would have been helpful. Or an =
auto-update.

Now I just get a lot of messages like

  CHKDT   =
Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml =
- due to: =
Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
=
Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml:=
: $id: relative path/filename doesn't match actual path or filename
	expected: =
http://devicetree.org/schemas/arm/sunxi/allwinner,sun4i-a10-mbus.yaml:#
  CHKDT   =
Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ahb-clk.yaml =
- due to target missing
=
Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ahb-clk.yaml::=
 $id: relative path/filename doesn't match actual path or filename
	expected: =
http://devicetree.org/schemas/clock/allwinner,sun4i-a10-ahb-clk.yaml:#
...

but they do not abort the process, except for an error found in my yaml =
document.
So now I can start debugging.

BR and thanks,
Nikolaus

