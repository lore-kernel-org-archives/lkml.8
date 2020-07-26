Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BC4C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 16:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBE4F2065F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 16:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="CYcPPtLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgGZQCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 12:02:49 -0400
Received: from mout.web.de ([212.227.15.3]:52861 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgGZQCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 12:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595779361;
        bh=6ex22Lpt6dz9RU1Gu+uUAb6XRftkRexW+Std2YUzVlI=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=CYcPPtLtVcF6zX7kd5KIrafWkeKPbP3NwTZCzw7SEtXp5uuXxoZabWE5gQUptNp0Y
         64OhEeMPPpheEOiUIZopJ+YXM6Zv0pvivRbbYjBBlF9fpAAob2Nqn3aLmklMfSgR54
         /Ycvh2zM4YklmgqXGRg0TEyfan70NaEkkbrLc6Aw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.103.185]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M5Oql-1kj2q60TpH-00zXfG; Sun, 26
 Jul 2020 18:02:41 +0200
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Update memdup_user.cocci
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Julia Lawall <julia.lawall@inria.fr>,
        Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
Message-ID: <1ae3eefe-fa5a-a497-f00b-5638f4191e90@web.de>
Date:   Sun, 26 Jul 2020 18:02:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0JVXVGg24w0MfiXB3KB1uk1/UfTVgmE6L2SIeQkeQHeieBEIGws
 WtaRATRrdbACw9XnOctlouQ1T6Y1HehQ/PqFfARbG5L6ZhgS0USSrHYepyQhbtAq8WhIVSq
 /nmweo+4h9gpimBE68mcYxadTxISQ1FK54gJXd1Hpm88QBcsGz0oIPVWBVfT+zQyyxkiZEz
 vtP9PAUAD1LoY2iT3rO8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cEu7cQK/GKE=:tKQdhWrtO7NHXBHZ5vEGLr
 wB+g2ZjdhiMF2ZWw1fY6DC23jqBO1rtTkF1mOGoxtO+y21siUpkNIdiuA/+cfVibx1kl7cKUL
 4SRaGK5pAmsvDpoTi3pz3JZuGIvlkJpC2fkv8zlqANAzB2Xfv8ARD+2fT/D14ZRfq2GiPIO+d
 eu9VCNNfvYLSlPzC3kjvg1JvFDVZbuIElecOy/MT5sOCN4weBT4p6Al2E7dfcofqiJVtZCerg
 WLFMS2YR6hgJllG9/H4ZmjhkRqbjeNW+bKnk+YAYVjr3tr+8Dx4C/KJxSA8PtF2PRnHIvsOgp
 Ju45InBRTmtA0cP2n/Fb0QL2575Df/xggdm3jHntaidMqx5URIHUN7XnkCDAzemxHXxhJtTUe
 fA7ejz5grBFVUHP+NOlY24Z/nzBnVXQ82FH5o038bGOWGQ6L7g7hTL4A93fxdJjJFRUEEw0cv
 V6xKwMpM/hE4+g0FeXN1Q9X/xfzPAZk4ExkViEJaO1FfiNOYj5Hct382jZiLLY3i7TbLN6DKd
 MW6GenS6CHHhGU5PV3d7nylECuxcCkIOujmx99B4pLR9Yg2qkquAdVGtci6NuScfDJ4wHF4lh
 XFFJzqLkzVoWPjdldQ2OHoh5l8rNFHyWmxjL6IMn9Dv/O/99hGRIbaCUPUtwgKlimQyLhJUwV
 AplCA7WOPnb5BixC8sRETAVmxUIhIB24PSJ3Jv52EyewaGIhzOms3Dv8/pR7plBkqIoIutSho
 SISnTidqGB1s352OKFFy0pARxU4YazhNELQmmOpURUzUevX7TiKX6FyVcspi/RU5AyYsCD3lB
 p32QLIpjKozCwvEDtxk7EJxme4xfIZzpv6Nwnt/LfoVM3ei5QMaHfva0DGvFSKmEpkQ5s7c4V
 /ShV9CBKOBRest3MAlRIy/dbmrnSkuv9Gw652tpTM24l6F2OnA0uPWJexKfK7E1y6L3gghYhm
 YJcsEI+D88/S7+EWI03IK/4IW5z7asBVEZd0lC2ztIcOxiaMCw4hFEcIjHaREntJNnzKMQJqp
 uvwEapRaH/kra61dTEsUKTeKeh5exziC2M+YNlPeDyX+y2TyL+FbH4dpwczxaVeXSGyiCHicL
 tR3TN43kZieb7UKR/sWPEV2dg1UR4pkD321YTJZyAgdk6elAbKOchnLe+QrKBSUX9PF/ZQ5e0
 fQ3KsJBn9H5RoScnsnl+envDVrp9MOk6k+ZxNf6vVH4Hbwv7zDHcqvJslqxLz1qX7O2eKmK/n
 Nmz6dkV2SqxoMuR9wqDzhCWwx6kzPELB6bPqKdg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> > Changes in v3:
> >  - add missing '-' for patch rule in kmalloc/kzalloc call args
> >  - selfcheck rule dropped from patchset
=E2=80=A6
> All three applied. =E2=80=A6

Will the software development discussion be continued by patches according=
 to
previously mentioned ideas and remaining open issues?

Regards,
Markus
