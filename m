Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27950C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 06:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07AE520773
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 06:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390034AbgFYGtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 02:49:33 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:23324 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389540AbgFYGtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 02:49:32 -0400
X-IronPort-AV: E=Sophos;i="5.75,278,1589234400"; 
   d="scan'208";a="456572887"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 08:49:19 +0200
Date:   Thu, 25 Jun 2020 08:49:19 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     joe@perches.com
cc:     Kris Borer <kborer@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: cocci script from 2016 - assignment in if ?
In-Reply-To: <3af82c36a9e7477566bf3c2e6ce013cd@perches.com>
Message-ID: <alpine.DEB.2.22.394.2006250848260.3692@hadrien>
References: <3af82c36a9e7477566bf3c2e6ce013cd@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 24 Jun 2020, joe@perches.com wrote:

> https://lore.kernel.org/patchwork/patch/649705/
>
> Any particular reason this wasn't applied?
>
> I ask because I added something similar recently to checkpatch.

It probably slipped through the cracks at the time the Coccinelle
scripts maintainer disappeared.  I can check and see if it does anything
more than your script.

julia
