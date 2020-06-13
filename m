Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2E6C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 16:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C80D7207BC
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 16:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgFMQOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 12:14:07 -0400
Received: from smtprelay0168.hostedemail.com ([216.40.44.168]:40384 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726335AbgFMQOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 12:14:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 9D01E182CED34;
        Sat, 13 Jun 2020 16:14:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: snake37_150538726de6
X-Filterd-Recvd-Size: 1563
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sat, 13 Jun 2020 16:14:04 +0000 (UTC)
Message-ID: <030bb11d193d13a2d1c161a133bb7b88093a1fe9.camel@perches.com>
Subject: Re: [PATCH v2 09/24] dyndbg: add maybe(str,"") macro to reduce code
From:   Joe Perches <joe@perches.com>
To:     Jim Cromie <jim.cromie@gmail.com>, jbaron@akamai.com,
        linux-kernel@vger.kernel.org, akpm@linuxfoundation.org,
        gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk
Date:   Sat, 13 Jun 2020 09:14:02 -0700
In-Reply-To: <20200613155738.2249399-10-jim.cromie@gmail.com>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
         <20200613155738.2249399-10-jim.cromie@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-06-13 at 09:57 -0600, Jim Cromie wrote:
> reduce word count via macro, no actual object change.
> 
> OTOH, maybe() could be scrubbed if printk's default printing (iirc) of
> "(null)" pointers is deemed appropriate for the log-msg.
[]
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
[]
> @@ -114,6 +114,7 @@ do {								\
>  #define vpr_info(fmt, ...)	vnpr_info(1, fmt, ##__VA_ARGS__)
>  #define v2pr_info(fmt, ...)	vnpr_info(2, fmt, ##__VA_ARGS__)
>  
> +#define maybe(str, empty)	( str ? str : empty )

This macro is unnecessary.

An even shorter very commonly used gcc extension would be

	str ?: empty


