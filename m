Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E907C32771
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 08:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B2B920848
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 08:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732484AbgALIm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 03:42:26 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:40672 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732471AbgALIm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 03:42:26 -0500
X-IronPort-AV: E=Sophos;i="5.69,424,1571695200"; 
   d="scan'208";a="430949202"
Received: from abo-154-110-68.mrs.modulonet.fr (HELO hadrien) ([85.68.110.154])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jan 2020 09:42:13 +0100
Date:   Sun, 12 Jan 2020 09:42:12 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Wen Yang <wenyang@linux.alibaba.com>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        =?ISO-8859-15?Q?Matthias_M=E4nnich?= <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3] coccinelle: semantic patch to check for inappropriate
 do_div() calls
In-Reply-To: <6cc0c851-7a32-d82a-1c0c-51a08538b445@web.de>
Message-ID: <alpine.DEB.2.21.2001120941270.2552@hadrien>
References: <20200110131526.60180-1-wenyang@linux.alibaba.com> <6cc0c851-7a32-d82a-1c0c-51a08538b445@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1467652441-1578818533=:2552"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1467652441-1578818533=:2552
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT


On Sun, 12 Jan 2020, Markus Elfring wrote:

> > This semantic patch is inspired by Mateusz Guzik's patch:
>
> Does such a wording mean also that you would like to support the operation mode “patch”
> by this SmPL script?

I see no reason why such a wording would imply such a thing.

julia
--8323329-1467652441-1578818533=:2552--
