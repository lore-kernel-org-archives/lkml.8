Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAEEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 10:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42A68207CB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 10:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="bN9vlqT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731922AbgEZKer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 06:34:47 -0400
Received: from mout.web.de ([212.227.17.12]:56249 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728515AbgEZKeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 06:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590489277;
        bh=7u9oSDrBiM+Eeht4sUhZouVaeeN5mZTWOWmSmZsMWXU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bN9vlqT5JLfPXBl3TM2SKwKw2dsXmq7UgacpL0KF0MfIWxf7FvSFG/9tcq837es5O
         GtAKf9TlOHlBkvMvde1Yd3uS8T4Z2WVQRKw0hjJCgnNa/3qONoWAAPMjhzvnFoqIqN
         8/gu9VTgEQDQUBaHML6/e/duDzjEm6nBXlAtANnQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.141.233]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MSJGB-1jTGS60RKd-00TS48; Tue, 26
 May 2020 12:34:37 +0200
Subject: Re: [v3] workqueue: Fix double kfree for rescuer
To:     Zhang Qiang <qiang.zhang@windriver.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>, Tejun Heo <tj@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <20200525093019.2253-1-qiang.zhang@windriver.com>
 <CAJhGHyC4XcNL8yzWZKZ=73wZJej4JwCaAHGV8qjYn-AqcEAEjQ@mail.gmail.com>
 <9e7c20bd-8161-0790-36de-108c6dae65df@windriver.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <093e5131-fdee-54fd-e2e1-a632435005b7@web.de>
Date:   Tue, 26 May 2020 12:34:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <9e7c20bd-8161-0790-36de-108c6dae65df@windriver.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KNCgUYi5nbcYDioWOboF1X/nYU4WzAyzj0bjapBrUvXjfgzBYVG
 AoYQWi76yXd1ftYwtxI0kgBdYNruCxT4fX68vcQsWWDuJ6qvKKw171bS+kJWaqwTYf3sOie
 FI6r/VnViDMwxUzzOoryPHkUvtbboMQOVBs2rcRJtxsko8wT6kkhyjtzC3K78BIeIk8n/FO
 V0xL0/cdF//ktdNelNm4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oF6noQlMybA=:fLm0TS0eCvdhZ96RfB6cnW
 QaCqz+8qGnazsNi9DQQ+utv7CdxnFp/PHK8wyUDDQYkLBzVNbJvUCwQ07CaOXzeIcxKjsQKBY
 o8hIEvAQcYC+S2GjLlraDcwveN8FzMedEseA3V2eTRS0ldFWBUeX8s7Bd0S72LK7hjusPSv3M
 Fw+yh4TUCIbSv+gOTTLny79aWPZCqQLOH+sixieBuf+kC2tBJrgvYFljXzQLqDs2BH/02O4Ed
 y+fXwpXHchGI6tE85mPOC6RffNUxEyCYrUorY2nvV897kY/MVW89GjOppZgQhovxu8rNj5sGr
 huUFC+e/P4dXMEQ7XYvW/HjkYaSvExcH2rqs1swsudXGYIVmJpbrHYD9iqFswLSXQbAbAMwXi
 W1sjEgDAOu45HEu/V7v7foh/fmurL2IaTVoJoknHBxKz1TvcRYNBglGSPvzfrP5OD2uyfjiNw
 638KwxA9GCrEpWFwVgoFJ1z3XltxAdAdBhM7fEI0CxdSD3keBKCSLNiJdD06nB346YXqFanYJ
 KpBD8Qv4TBk677iggD/vjul0gpvu2+8LyqFOWDZmFp0RLPkPEiHFlyy3x5WyqUZEBGaiXeWDS
 CYiylb4wrN/Z6pLw2O342Os5khzcUtyqUpfRJBX4Ig9Psa46WHyswELGWVkd/Jf7zY8zu3JPm
 +BCuqUj3w9LF75Lct+LJN0elfpEkOUCRMke+207NrSiKEj8lau0fbJdMFRLXuiElmweOICyXO
 nRNrgT+OzA3HBmZvNnU4ZvKPAi6EPPWNXibNjewKDwydFcneZkNBSgnwARZb9/2jIAcU9VvIN
 8A+kTg5hgqtbPwn6ZB2jAV7DYI0sAcLBB6SgHi9+vNT0e8RqJ9Kve1SW9AIuZzdQoXELv6BwF
 kBp2nvLYP9wf/nqJ9u0eeVtt4OvoItasy3qVBqSUTATOuqa0CSn/1yRqQcg9X1I6gq4km24sN
 9jTg4RuTgg3MsLCQIMOs8+qs2gFSBuyBX0s6hMiuXmZ6QvP1tRNpDI59m+lz7R3zIv0H69Rcg
 7YM57bXpSK1xXyc6YapSMXSv5h9+aigdkQnF6hQ3Pyy788omAX/MGXQsZIS4/PI6Nj2D5kua8
 RdfoXUsZloqN9ytExvrN2jDLHaa1Wq6IX8za+EDpEcboNcy7z1+9dpBt8SjS5tZh6ATFeAevt
 IHM7WxkZB0ddzQORfut/dnAso5B5dONMcsjflt8HTf5DtPtAxVNAjtfOflJfG9kenco/m2WQ/
 Lf85TWEhofO6VqTRD
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> There is something wrong with my description.  is it feasible to describ=
e as follows:
>
> The resucer is already free in "destroy_workqueue" and
>     "wq->rescuer =3D NULL" was executed, but in "rcu_free_wq"
>     it's release again (equivalent to kfree(NULL)), this is
>     unnecessary, so should remove.

I find that this suggestion indicates further wording challenges.
Please try another variant.

Regards,
Markus
