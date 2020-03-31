Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E67C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166A920BED
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbgCaPLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 11:11:08 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:58099 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730604AbgCaPLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 11:11:07 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MQ67s-1jfD9G0UK0-00Lzx3 for <linux-kernel@vger.kernel.org>; Tue, 31 Mar
 2020 17:11:06 +0200
Received: by mail-qt1-f176.google.com with SMTP id t9so18555123qto.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 08:11:05 -0700 (PDT)
X-Gm-Message-State: ANhLgQ25r8UOBZp4Tn4OwgYetpy4+yVoCu4SylEKZ1hvKXV9jcBXY8Ap
        sUzzTmbzN2cQYFdMJkMZFATeWIKGlkksfmqOlo8=
X-Google-Smtp-Source: ADFU+vtZ2zLOYYG8mPGO4xtOd0Agn3IhRIKTv3VEKU5LkySIMsz/04fpbSZYf9ebnWdL3CYGkto3CcXF9ZJ8LJmGa44=
X-Received: by 2002:ac8:16b8:: with SMTP id r53mr5640923qtj.7.1585667464993;
 Tue, 31 Mar 2020 08:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <698e9a42a06eb856eef4501c3c0a182c034a5d8c.1585640941.git.christophe.leroy@c-s.fr>
 <38de0c6caceb052a23e039378dc491fe66cea371.1585640942.git.christophe.leroy@c-s.fr>
In-Reply-To: <38de0c6caceb052a23e039378dc491fe66cea371.1585640942.git.christophe.leroy@c-s.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 31 Mar 2020 17:10:47 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Q5gmcyjo03QoDMNO-xEWXDjhW8ScUsGGRWVKgVXj5_g@mail.gmail.com>
Message-ID: <CAK8P3a2Q5gmcyjo03QoDMNO-xEWXDjhW8ScUsGGRWVKgVXj5_g@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] powerpc/xmon: Remove PPC403 and PPC405
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <michal.simek@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:CayPLkaO4YQyZV0Jv0mwwUNlJUSTsqIUOsuXyJiFb8qBBYU5DSG
 QUxhAGL2dTL9k/N7adqTWOWUzGw5ZEuRunH532wIMTjEJRVcJ6CGnszmp0yz1n1nx30BgaO
 ljIffCE5eK0OySTfszNH375ZePSZh9wq0k/ok8VM0LBqBAk0Kv1Fg1cDixMWyTNV9YD8O7b
 /ixwj/AeTGkX+BCazGgNg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+upDTnzYOaY=:2OzVzAE0ue52aV5EkNOg+r
 jIcOQtlKYky78m/HQG4ljzIUv4KL+1pJIdS8QRXZDpEVjLCjCzeBRV8zBhatZOaYgm/cXa2gK
 YowY0+o9kc57/V0fUCW2nrMK9FNoTI/JklDr8geBFQ8btYfD2u0CO9lhjcgCDpulijnXn8g1a
 AZ2qrk1pW3sTiQXR9ofShJv0VUEwqvQWt3NvaeFzow3fUWMjSw4uqpdLg0MwlRhntF23MqAJ7
 LII94rUcGL1cjJwwyZSxNSgg/1Rm35FiIqgJ2enrWMyIogBK09T+Qy3pZuQdWPmbSDRdFjuXc
 MEbXyrBftsqL4LCTs4A0NknHQD3h9zYAxXwtyzO/vuESwcGhhyHrz+Bs73rH8S/+gwlUKiaVs
 cb1sWYpvAK8Acpb1fGYiveEKH/UjvxPLMY+71trx/rf/A4sJUIm+nxqtAmPPk0DMuQYPa2DRR
 xkmURg+GQgbubVyrACxtrAD3Zxc9k5xvQcqkkD4yL5ZjclcTIlX2DIEB8E9zyAcJUeiIb3ZU2
 RyUXEC71X3pWrA7pObNDVz0shfs0stJSRp7XxGkiEBCJ7NUSv+X5keyMguSze05Gmd+wA2z7T
 B42LW+vrHli59kHZA4oaH2+isnAiB7kemZzXHLu7/jTZQ7+o7wrYk8MKcgWptqTRt79cJ+6I8
 U/pRxSB4dlcSJHJXbvcG7G24bDsaHKqoUUmFohLI7Un76Y6KjHRV9Z8irip2HeBFd8IAwyoqg
 1Cc2TWKwOciUwKw8eXSfGxZGGSYH4em97FCWzkKEdJCDTNTmU76pLAMs8EeNt/d2fuLuFJ5FA
 s13TKO6xZB5QPwlCFszNrikJrdwROz7nps/5PYGwM479+wHREo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 9:49 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
> xmon has special support for PPC403 and PPC405 which were part
> of 40x platforms.
>
> 40x platforms are gone, remove support of PPC403 and PPC405 in xmon.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/xmon/ppc-opc.c | 277 +++++++-----------------------------
>  arch/powerpc/xmon/ppc.h     |   6 -

These files are from binutils, and may get synchronized with changes there
in the future. I'd suggest leaving the code in here for now and instead removing
it from the binutils version first, if they are ready to drop it, too.

         Arnd
