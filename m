Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63271C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3778220774
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Etb1j/JI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438057AbgDOU1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 16:27:50 -0400
Received: from mout.web.de ([212.227.17.11]:56887 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437627AbgDOU0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 16:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586982402;
        bh=dY1a1QdTZC3DvwTEn+o7mKH7MojuylEv4+z6kEGa9hc=;
        h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
        b=Etb1j/JI51hl7nMA71Hhsh7pcWGn9rxbWfHxcXpIasuQ9gmYKjCK03ZnjsXKNLhlq
         /vDM3RRz4kFhWbFkvu1E5WrFOFr+rCHjzIJ/3wm8qaxIi0V6f/fPK8kXh8FHz/4gk5
         QTcNTiVDINUD3l1o1K3joBHhz6CkeK0j+Dmv79FY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.133.192]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LrK0u-1jH8dq0lbw-0132ID; Wed, 15
 Apr 2020 22:26:42 +0200
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/34] docs: filesystems: convert cifs/cifsroot.txt to
 ReST
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <37635811-80e1-2bcf-c1da-0d8045b2cf8e@web.de>
Date:   Wed, 15 Apr 2020 22:26:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QWUPvImFmL7BNbnm3jgHHXK8J+NtNYmrp/0bEhtpUfcqE4YnDBF
 h284a318koDthiHxmNxcEJTHDDhMSiwgwqoj/XpqC1REFdINNWNzpjgLGL7EwwijSxIFOaT
 0d4mxG9ph6NEq1jHzmfTh8txGvjZBv53KNOb7nBruhPUNrd0A8/vBYB1Ryr+YSIPxbpzfvl
 sfUbQFypeZk15AmTZTV9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IAOqqowLqms=:KiF6OqLuOvg6iMAJDqAdQ6
 oWNbH3FJZ5c/FusflMYvm+1t82cnoOHLqGC5JiJZsKcL0rtioaIKpuE5U7DwDAwO1KYq65lmS
 iICnS5JmZGN5P0I6z27PLttoVJzSzWeMZAB/VhcVtgJRxJIuMblMjSpLSpgJflkUL/54kDyjU
 CrjfDT33psKrwoM73FFbSEj6grxwr2Smt1T7nvBdiK2uqnuiXugPNJjkBAoOjWUbqvgUMmO+g
 dS1t7SexUiGjDK2wVMRY/0y+cMpJj0NJsyuDOn+QFcxYPSmkmYRQ2vrOS7L4lqUYFgkP2a7sq
 E/5lemkzkUQZSJ8AH8upxPeG3Yl4bbW4WmV6Fv+ZQsFHFiZu4hxQe2fPyndION7Y3IO1PhD0D
 BUYWuM3MTPwh25UMXZVQJheHB7d+uP2D+dJ+T7NvQ+RhxuQPPa9+S0qIHhtWo1umYp4sWc4c4
 xAEDAYxvUtTUdRM7amnlxVnE+k1E5wmGR8GXlYsNWqAFWoNnnprqzMcHYAfZgE03n5mfhyFY7
 yvWgGdIsem3q26yRL/lrnmtB9GbpuOTqU0tvfcx4UnNHHegFhxW5WyqHH6rVLoSFEg3YXB60A
 HA+FZZV9GrHMSVoBfX21eMCY/Wg3GHNYMT2DNpvX96wwrclBf72k21GyTyN3gubUuSM6geqnR
 AofIunTjV0W9qNLgw2mn0Hhrq3Fe+RvZDlhnYME/nzjMyiSoo73Strxe0lLDJ51kgZT1uRhAj
 H9z2myBe+mB6/vEmvVDgnyHo7jmXURKdVO7NaOBjwZHE7N/6PTDv+iPI6/7udE2uMUZp+GoaE
 Us7YMgS6vktKTsmXJe2+jjIhvGRNDRB/3XF82ZUn3NXnl8VteXhxoQPKGDlxlcs5XkEVzuoU/
 ptpywnYl0Yn/EDRjiIEyNJ7vR+WWiQ1UkxAhwpej6sia0NeNA6vExtDouHKhtVo2EFEAaLS2K
 /7X0olA5m94cFTAubwO+uzvVJDMz9OzOtK+m2YPG2KOTWmCLG/GmzOEp4Sb1zkV8gd3dQNe0p
 HuaiN5rpzdrG74WDL1UWDaSARy65O/dqspbGK1YkBJKKoD23Qh/ZAyvFfWXElGQ4Pz1/nF64I
 qjLj2YMV10HvbEGVURX/anTE00GxVSPMLczpIen6thgI/SFDdQYLXdW5FXWD/2xRPDkCGGUku
 z2/psrVTjXSbkYvJU9FwuFEA07Aw85pUwuOGqfb92veh7NDgHhgGkpq5f4TIRtnNDsIkqrq9V
 UOcNQbRwpZPWJ+wQs
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  .../cifs/{cifsroot.txt =3D> cifsroot.rst}       | 56 +++++++++++-------=
-

I guess that you would like to refer to the file extension =E2=80=9Ctxt=E2=
=80=9D
in the final commit subject.

Regards,
Markus
