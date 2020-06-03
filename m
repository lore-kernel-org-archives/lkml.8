Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C69EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 05:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E230B2067B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 05:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="LYbxMZRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgFCFFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 01:05:19 -0400
Received: from mout.web.de ([212.227.15.14]:33961 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgFCFFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 01:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591160686;
        bh=EBSTXtu1ei7txhmEeQVcUPxSCEHlwUnoocCsxoIbpao=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LYbxMZRHWYrWU6DF9r0XzgnH+55/csk6qmK/letqWGH//KONPdxut8FSdIv0463eO
         lyIgu19mi7P71folsmAYPRXboyqKFCuU8UM8Irpas9E4L/Nfw9Zx3zY8YY2JlRMl3C
         6k+4DnDXr7chrgoDcFx0Ifzic+vO3fLzN9x1Jp3Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.82.231]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MumNL-1iove91CyJ-00rm2g; Wed, 03
 Jun 2020 07:04:46 +0200
Subject: Re: drm/nouveau/clk/gm20b: Understanding challenges around
 gm20b_clk_new()
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>, Kangjie Lu <kjlu@umn.edu>
References: <dd729c13-fbc8-22e7-7d8e-e3e126f66943@web.de>
 <40d8fb01.db721.17269d3d620.Coremail.dinghao.liu@zju.edu.cn>
 <20200602102955.GZ30374@kadam> <65e3d2b7-b0ad-f387-b8fe-d83ea816a0f6@web.de>
 <20200602153900.GW22511@kadam>
 <5d580094.f274c.17277fc124e.Coremail.dinghao.liu@zju.edu.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <75a33776-cd69-edba-8d20-ffcf99ca1879@web.de>
Date:   Wed, 3 Jun 2020 07:04:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <5d580094.f274c.17277fc124e.Coremail.dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HBphbPr3xWqK/Noy1A3QhHsm7WTySxNbm5b0+Lz/09Uxie+7c74
 08LVOOCIidrsRqtFHthQf8yJLXYQE6of6jPr0+jOjYLfXIisO1I5FNUnF+AwEOcB00d4fyf
 htrEcuVkeXjxl1ISV917SvJ6ASBw6Htsnlbxi8/JtkRRX3PHOiLdTuq7ppZ6U8rFzG2dGzZ
 6iXA5Sv/6Iq9uCLZLOMSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gNMoRoqYDhw=:YreU4RNV1//AIvRoXibpUs
 ZJScl4cCA2FKNuW6dzPKzWQzqbheRt34gyh0FCzF6RGi1FT2V2nZOBdrYsp430bblouzen2+D
 hlwYScEn+w6Se7nB9H60MZ2YDRqvMmRKGgeiOhy7AF+JfQOgVxgvkiZujDFxKUCpkdvXBTrmP
 OqmPio2t4NbLuEnNXH+NMbpUTpESWHU1/qyzzioZCt0qH0WjzK5OvTpV1DIsetNh6XQOS4sQT
 oitVQNVKz+XQ0VfvIXG4RPJLdb3JSuJBqxze8rGWcntt4mybLDeYP7OR4jGR39SThFPdzE/8j
 p6chZ0TUrxDFaw0i3t/ijwxsQPEvliAu1XALWQBp/eKlB4h91LmFh+/d/pxWlq2engf00LSBf
 8D5JiHPGR5h87RurXjcmm+bk4BRbL6Ss0bb7bVPJ9mqc2NnWCNEcbbWYp7zP+SnqIUdUkTe1Z
 QFOaS9dzxfJvRbXSJsoNQm0m2n6M0Ugi6Nn57jJlf0tW/FWsAoNEMucrgvKW92dt3+YjGmruz
 x0edkoTczwnf15duIYfuVxtF/HdAvhBe/B3aWcIIULfGt+OuLnRvddTy/XfKoPVMgQh3aqh47
 2UdLOeIYWrTWQmwkxgWpL6O9Rh1yvp5H04ILtb9PWhgmWgnhrhAlOfe5O/wTVKRH8Lfzol711
 7j5J92CcqlePEfXVaTcfCFZqa+LFJJ7v10BWkN44T46dbljLV7LvsOHoS0M3AVKyjHMXGH7K7
 URXh7fuEencRCStZUyljfjI6Xgep8g5KXs75r6bZ/hgsJY3NdEKjtDpx7AiXMeZaRC6RxWW/2
 H718b125RhxzscLS5kP7wLMiHEKAwDRgSaohiMeCW7965muBHIBgs2SJ/LZnvARp/PzoR6kL5
 1UW2BrPI6qVG/AJq3RCx8t0N/AO9gGeppZziBtb6ewIwljl8i0Iu/Jz96j3frdpg9yRM8vbfL
 KUtSMIj0mNxeUp1Oe5JIPaQnLWl/LRpUnpldYPejXb/jqA1w6Q8k8udG61l6noI40aHgaBUD6
 SWo12vnQReIJO9fONvng40Lcobcw1n8yyxAbzEmDk1E6N2V+jO5YQPgw79M6hYF2D6lkykKK0
 1HzNrOohI4EV39+1QB7xHslQ3METXfXjX2vdAft5aDiqjJfDufNg+FgCbV2ueLCJmfpBnJUGz
 KILiDlMgBTU7j0tvWOCYm35PvF7KjF089isThMSHpHagAsduiN7/D9kcQXDcnfrWNg7Phrhcp
 ld1INWv3x9GXTUtmm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Ben has explained this problem:
> https://lore.kernel.org/patchwork/patch/1249592/
> Since the caller will check "pclk" on failure, we don't need to free
> "clk" in gm20b_clk_new() and I think this patch is no longer needed.

* I am curious if it can become easier to see the relationships for
  these variables according to mentioned =E2=80=9Cdestructor=E2=80=9D call=
s.

* Did you notice opportunities to improve source code analysis
  (or software documentation) accordingly?

Regards,
Markus
