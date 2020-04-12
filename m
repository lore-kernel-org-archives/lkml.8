Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954EFC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 17:05:08 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DEEE20673
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 17:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DEEE20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbgDLRFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 13:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbgDLRFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 13:05:06 -0400
Received: from smtprelay.hostedemail.com (smtprelay0242.hostedemail.com [216.40.44.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B81C0A3BF1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 09:58:53 -0700 (PDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 71D88100E7B40;
        Sun, 12 Apr 2020 16:58:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bag70_6a529ded9e51b
X-Filterd-Recvd-Size: 1544
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sun, 12 Apr 2020 16:58:50 +0000 (UTC)
Message-ID: <ac67c70345464efd347d56267d6748064131f7e2.camel@perches.com>
Subject: Re: [PATCH] Staging: comedi: drivers: jr3_pci: fixed two warnings
From:   Joe Perches <joe@perches.com>
To:     carlosteniswarrior@gmail.com, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Sun, 12 Apr 2020 09:56:44 -0700
In-Reply-To: <20200412142508.327-1-carlosteniswarrior@gmail.com>
References: <20200412142508.327-1-carlosteniswarrior@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-04-12 at 16:25 +0200, carlosteniswarrior@gmail.com wrote:
> Fixed two checkpatch warnings.

by introducing compiler errors.

> diff --git a/drivers/staging/comedi/drivers/jr3_pci.c b/drivers/staging/comedi/drivers/jr3_pci.c
[]
> @@ -91,8 +91,8 @@ struct jr3_pci_dev_private {
>  };
 
>  union jr3_pci_single_range {
> -	struct comedi_lrange l;
> -	char _reserved[offsetof(struct comedi_lrange, range[1])];
> +	const comedi_lrange l;
> +	char _reserved[offsetof(const comedi_lrange, range[1])];
>  };

try this:

$ make allyesconfig
$ make drivers/staging/comedi/drivers/jr3_pci.o

_always_ compile the files modified by your patch before
you post it to a mailing list or submit it to a maintainer.


