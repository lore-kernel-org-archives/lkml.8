Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9F7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A36AF2068F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbgFVLXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 07:23:10 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:28826 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728918AbgFVLWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 07:22:36 -0400
X-IronPort-AV: E=Sophos;i="5.75,266,1589234400"; 
   d="scan'208";a="455981487"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 13:22:33 +0200
Date:   Mon, 22 Jun 2020 13:22:33 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [v3] coccinelle: misc: add array_size_dup script to detect missed
 overflow checks
In-Reply-To: <5f91ec99-5c21-78c2-f484-76a0b5bd3e71@web.de>
Message-ID: <alpine.DEB.2.22.394.2006221321180.2531@hadrien>
References: <5f91ec99-5c21-78c2-f484-76a0b5bd3e71@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-558735236-1592824953=:2531"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-558735236-1592824953=:2531
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

> I suggest to take another look at information from the section
> “2.4.3. Formatted string literals”.
> https://docs.python.org/3/reference/lexical_analysis.html#f-strings
>
> This software documentation provides the information “New in version 3.6”.
> Will such a detail trigger any more software development consequences?

Thanks foor this information.  Denis, would it be possible to express the
code in a more portable way?

thanks,
julia
--8323329-558735236-1592824953=:2531--
