Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2946C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 00:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C144720760
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 00:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgGOAv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 20:51:59 -0400
Received: from smtprelay0224.hostedemail.com ([216.40.44.224]:44132 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726356AbgGOAv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 20:51:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 8823718224D61;
        Wed, 15 Jul 2020 00:51:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: plane42_08149f426ef5
X-Filterd-Recvd-Size: 2039
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Wed, 15 Jul 2020 00:51:56 +0000 (UTC)
Message-ID: <c3dc7c1dd56a3a677e6d72b05313b2a61962885e.camel@perches.com>
Subject: Re: [PATCH 3/5] media/dvbdev.h: fix duplicated word in comment
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Date:   Tue, 14 Jul 2020 17:51:55 -0700
In-Reply-To: <20200714220553.20294-3-rdunlap@infradead.org>
References: <20200714220553.20294-1-rdunlap@infradead.org>
         <20200714220553.20294-3-rdunlap@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-14 at 15:05 -0700, Randy Dunlap wrote:
> Change the doubled word "the" in a comment to "to the".

Hey 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-media@vger.kernel.org
> ---
>  include/media/dvbdev.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20200714.orig/include/media/dvbdev.h
> +++ linux-next-20200714/include/media/dvbdev.h
> @@ -385,7 +385,7 @@ struct i2c_client;
>   * with dvb_module_probe() should use dvb_module_release() to unbind.
>   *
>   * Return:
> - *	On success, return an &struct i2c_client, pointing the the bound
> + *	On success, return an &struct i2c_client, pointing to the bound

an &struct reads OK as text, but does not as rst/html

Perhaps this should be:

   return the address of the bound &struct i2c_client device
or
   return a pointer to the bound &struct i2c_client device

otherwise the html output is

   Return

   On success, return an struct i2c_client, pointing to the bound
   I2C device. NULL otherwise.

and there seem to be too many commas used as well.



