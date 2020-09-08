Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502DDC2BC11
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E96E921741
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ewY5sQDe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731232AbgIHUOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:14:50 -0400
Received: from mout.gmx.net ([212.227.17.22]:45743 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730082AbgIHPLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599577786;
        bh=8DuJAfVQSI5mi44z7RncHDbEJKd6gWOvbmvHlAkeqYs=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=ewY5sQDeH5NP2Kb6Z+dNppd51WawKmbMzqeAqLCA91ab0Wc5akfRnqVlDmU0FDFXL
         APINUpF50Mn2n0VUha3wu0LObhMhjJWHmgkam+jPL7dLHJaeSaIfSYpnr0b4h4xKiA
         oBHZox7xlv/hu4jxmQVoAhzuKMT1frYGla9V75XI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.191.217.72]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Ygt-1kH1Yc0IeJ-0034pj; Tue, 08
 Sep 2020 16:56:21 +0200
Message-ID: <3471761a379062a474ba32f9d0157eb3020244cf.camel@gmx.de>
Subject: Re: v5.9-rc3-rt3 boot time networking lockdep splat
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Tue, 08 Sep 2020 16:56:20 +0200
In-Reply-To: <20200908121902.zlfd3balosnu7ies@linutronix.de>
References: <20200902155557.h2wl2qpfn2rwsofw@linutronix.de>
         <46a2b89ec8d953a4be18c7389c7d8c66310a7ff0.camel@gmx.de>
         <20200908121902.zlfd3balosnu7ies@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M5FgYO2QJDW20nMv2t3ujKxQ22Mo1eRsB9uGCSrp6bT05KUNWqQ
 azozruWZ/7L98+6Rzkm0wb6thLQOgqZTIU1vyqLhMVhbyrdAwwf4RqvILSAd8RH/m/B+a6x
 4HdMXpZACnGm6sel6EYk8yFGjUDyHs3kbh38nHev9UVQLZJyh7Svui44XND6pSYuUbVYd/O
 p2Txib4+PDP1lVKScYedA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:f4YHUmgAPCQ=:1tXqXP0A0FJr80IyDLmYMN
 HKn7gtNtIljtNzkT00RGYtqzUd7Hk0qRTjcmdf2S2L0D02d2HUfL9ptnLKVNve2GrJiAHXyit
 8FTcrw/FKgaKH8qN9KbOM4HoYdj7rsubcq8Nu+PgE9jw9PtzBXlXqrvya8arH7wJqpfxoEii6
 KC5Ao/1JTU4IDBVRqf9DOMjoREz3trgrMWXj5CwAOT546iSsuEmgpJ2LUf3MbF6ofegxAxJz8
 dyx5RuZkWxttp3AVtns5OyiTsovva/9KyUZz/NnYlaTC4a1qxZI+kIgIlIDHZCN6xzzzRzwWA
 O42yh4PCKIKUNOXZF9C9NqD9albXLl2lnNjVy/j7AYbzNy3yfXCNOjRhox79gB72AcFWFkoAN
 xP9Oq4c0Mq5yiZUGmxPToVnjBakh8XMJGKJZuNEuX0jyIVG5XoPqQzVdl1curzslgW7CXP/Qw
 1wZBNXCP3TPnfSkt5dZCXVoSvlaNV0IWoRBygNFy4KEP3pov9dIFp17rPckTazCs1c3qDJTjE
 OgV/qFFBCWjh+Iy8dwCYWkzEyPGl1/NLUF0rXdnDHIfK62RJwoRLo7RV10dlwyozQu/qdls9s
 7WRkMGzLKXdBv4pjHJzZxgpIbnWcZWnNk2yR5Z8PbLRpsk/vw6Y18uWjifZxc5AHdTtAa10dD
 wEgDdyVvdkjDWjLzrInM7QcTb3S5siGJY4dNXrYc0YPy21ep8+BnwmtHG+hdWs2ObE90I2xM1
 6P/wtrfRnlUx0xMI2GskMyo5iKTJVYT3THgmsITIENWuJkUazPowzAymQ3inlM3/9XJAa3flj
 chf4igdljJ5uSodsObNqWIIl68+IGYIexETpXSzOQ3WgVQfFPJdh+PXqHSmy3tJ3Kt8kIJMrf
 F1Qs3gaKFTYtfwIGIsuqzU4s9Ce3zbLpvQm2iKKK/HTkUPCF8PAeJk0MMlA3uxM2ryf0ZDwaw
 m3oBvlZ2u1UQ0pWm41ao+T2cPnJPEZwrUnFFYMvxSCHsdOLXhxSNOhVz1m3b0WQLiDF6x9Gpw
 dLLTbWWc73IK5hI8aduQPZyXAiQx86xdg1nL0cXdmSc/R8jTQWWDFmXzrQEr7COpv0k9f8txP
 fzar3byLonBxIZLZPpxFtsXD9CeniLKzX408/CYpR4HcCMyMHSZTmRHyqXe/qBN/UcYGn4QY8
 3uqLrGUqKxl9JpeWrcqs0HWsdAOgofkWYJJgqY67/swwtDhTc1jEOeLxiT9D3l3OvlGs6bodN
 OZe6tVtp4TzSKXHcP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-09-08 at 14:19 +0200, Sebastian Andrzej Siewior wrote:
>
> This has nothing to do with the bridge but with the fact that you use a
> non standard queue class (something else than pfifo_fast).

That must be SUSE, I don't muck about in network land.  I downloaded a
whole library of RFCs decades ago, but turns out that one of those is
all the bedtime story you'll ever need.  Huge waste of bandwidth :)

	-Mike

