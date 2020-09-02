Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215A9C433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 054362078B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgIBHB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 03:01:59 -0400
Received: from smtprelay0015.hostedemail.com ([216.40.44.15]:47256 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726130AbgIBHB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 03:01:59 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 621328007616
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 07:01:58 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 859B5100E7B46;
        Wed,  2 Sep 2020 07:01:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fowl93_5c072b42709f
X-Filterd-Recvd-Size: 1483
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed,  2 Sep 2020 07:01:56 +0000 (UTC)
Message-ID: <7a1a2f554c567577a63d5658e8f48d5b4b103df8.camel@perches.com>
Subject: Re: [PATCH] staging: gdm724x: gdm_tty: replaced macro with a
 function
From:   Joe Perches <joe@perches.com>
To:     Antoni Przybylik <antoni.przybylik@wp.pl>,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Wed, 02 Sep 2020 00:01:55 -0700
In-Reply-To: <20200901201626.75405-1-antoni.przybylik@wp.pl>
References: <20200901201626.75405-1-antoni.przybylik@wp.pl>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-09-01 at 22:16 +0200, Antoni Przybylik wrote:
> This approach is more elegant and prevents some problems related to
> macros such as operator precedence in expanded expression.
[]
> diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
[]
> @@ -36,6 +34,11 @@ static DEFINE_MUTEX(gdm_table_lock);
>  static const char *DRIVER_STRING[TTY_MAX_COUNT] = {"GCTATC", "GCTDM"};
>  static char *DEVICE_STRING[TTY_MAX_COUNT] = {"GCT-ATC", "GCT-DM"};
>  
> +static int gdm_tty_ready(struct gdm *gdm)
> +{
> +	return (gdm && gdm->tty_dev && gdm->port.count);
> +}

static bool  gdm_tty_ready might be better.


