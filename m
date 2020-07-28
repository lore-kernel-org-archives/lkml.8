Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D5CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 00:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B2B220809
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 00:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cd4cAP3h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgG1ADK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 20:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgG1ADK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 20:03:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2247EC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 17:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=bqzMdiPLEFKP5bfRsIjeQSwN8431aYJ/2kMLDMmcsxc=; b=Cd4cAP3hjP4gld3KlmBfDKmXF/
        VkrRKTHigqOfyB5N+pvfppZjJRK4WsrA/7v84rp75l2/FunfHoRfg5mofkb170WaehH/mL557ErzC
        wIHojNJRbjaUgxhTk/0rOJf/D1dePhyHt4Jbj5fLvN6/cREPGtaav1h46qGf5/TE79bopJfKOboX/
        Lj462KKuw6cUwkqh6gy9Zsv+fdFIU9fPAAOX+WmN+7pqN+C5g9d4uFYUtMIC6PgNlRUBPdCjRJNoW
        gHY7ApWu5SGctQwjsSU8yDu8FlgdYgHP5BYrsEAc7vJkL4LfWgdqKLnp5eUeltfYkClQABveUch90
        77Yy/y1w==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0D5H-0002Ef-C3; Tue, 28 Jul 2020 00:03:08 +0000
Subject: Re: [PATCH] checkpatch: Add test for repeated words
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20200726162902.Horde.TCqHYaODbkzEpM-rFzDd8A2@messagerie.si.c-s.fr>
 <b796e912-e945-3cb1-03f8-0f38009634a4@infradead.org>
 <add7c13b1ca24c8cb6f243b99d61c19287020efd.camel@perches.com>
 <4e505c35-8428-89bb-7f9b-bc819382c3cd@infradead.org>
 <16aa5f86f2f899a9156305ead4b7042449278eea.camel@perches.com>
 <cda9b566ad67976e1acd62b053de50ee44a57250.camel@perches.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e8cae8c6-84b8-0f1c-d94f-3ef5804a31e0@infradead.org>
Date:   Mon, 27 Jul 2020 17:03:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cda9b566ad67976e1acd62b053de50ee44a57250.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/20 12:33 AM, Joe Perches wrote:
> Try to avoid adding repeated words either on the
> same line or consecutive comment lines in a block
> 
> e.g.:
> 
> duplicated word in comment block
> 
> 	/*
> 	 * this is a comment block where the last word of the previous
> 	 * previous line is also the first word of the next line
> 	 */
> 
> and simple duplication
> 
> 	/* test this this again */
> 
> Inspired-by: Randy Dunlap (rdunlap@infradead.org>
> Signed-off-by: Joe Perches <joe@perches.com>

Thanks for adding this check, Joe.

> ---
>  scripts/checkpatch.pl | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)


-- 
~Randy

