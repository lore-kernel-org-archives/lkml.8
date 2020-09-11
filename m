Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54615C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0529A214F1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgIKHgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:36:42 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:22784 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgIKHgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:36:38 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 097E67D9;
        Fri, 11 Sep 2020 09:36:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        message-id:references:in-reply-to:subject:subject:from:from:date
        :date:content-transfer-encoding:content-type:content-type
        :mime-version:received:received:received; s=dkim20160331; t=
        1599809793; x=1601624194; bh=mtsY/efb3YkRpbQwaFau5WmK/FqJxpWP2if
        z6gSHWTo=; b=Ghk+BFvvWpwfy/R7OfT3s7+ven4yZfd9wm/WM9JkNqlRxYsAd3l
        m65ryVpZpMyhvRojtsoCtMcbCFGnyGl3ncdVkKXuQGiMZ6hAFAopPMqZh1Swy1y8
        BEBmsT8DCEp0RCREkrR3vHj4pV9jKUpqAeDOodhlDLeu98bAtfAsv7UU3Sc2BVb1
        zyu57hHxZtfUz+sn+ARcWR1/V0X0zyYJmtLpmyhLSEEojcqjhtnCU098dzFOxzjx
        pnJbB4CzYuGOlZKqZ7ZoBu1YGEDGyQCtQdR6TaTomO3ZuvQhLDkjfpr2EkmcDdZa
        16hc3Z1SRDRD8JeNdzB6j5P8Ppd3l6wPTcxdfvlZtc4bYDSzDltgewRPLD6NQ5Gc
        0PCW5bkEOAYdSG/s3xd9zkkz32A3Q2fOrANYxc4mcqmTs9xiqdmB6glEhNSLqPp1
        Pfewu8O47TAQtxaWmJ2USOcnHHX1r3zlF1HL9vXNG+ZMGR0hDDEx8i02PuYSKAB2
        KdbmbqNV/k4YmFoNaGGVPRuiEDvhKo73otRCuW6M98fALrcQ3RSjlvuWW7iKBSI0
        SK2IQsF72K2bkroo6bb5nO/PTwi1d4zbwZxyYzrpSAr7aMK92MeBhk8L4uPEn0xf
        RvdUUUm7hx7P2w2C3sl3aUKcvvXNc+tVrPwU0VqCp8Lc5gOEWZJR4Y7g=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5-14YGw8QWMa; Fri, 11 Sep 2020 09:36:33 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 41C2E614;
        Fri, 11 Sep 2020 09:36:33 +0200 (CEST)
Received: from int-subm001.mykolab.com (unknown [10.9.37.1])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id B2008A72;
        Fri, 11 Sep 2020 09:36:32 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 11 Sep 2020 09:36:31 +0200
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc:it_IT: align Italian documentation
In-Reply-To: <20200910105811.0aea6a65@lwn.net>
References: <20200909223839.9000-1-federico.vaga@vaga.pv.it>
 <20200910105811.0aea6a65@lwn.net>
Message-ID: <81d39ba2d36720c9dc76a3b783799b77@vaga.pv.it>
X-Sender: federico.vaga@vaga.pv.it
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sure, no problem

On 2020-09-10 18:58, Jonathan Corbet wrote:
> On Thu, 10 Sep 2020 00:38:39 +0200
> Federico Vaga <federico.vaga@vaga.pv.it> wrote:
> 
>> Translation for the following patches
>> 
>> commit 68e4cd17e218 ("docs: deprecated.rst: Add zero-length and 
>> one-element arrays")
>> commit 5429ef62bcf3 ("compiler/gcc: Raise minimum GCC version for 
>> kernel builds to 4.8")
>> commit 5b5bbb8cc51b ("docs: process: Add an example for creating a 
>> fixes tag")
>> commit 858e6845654d ("docs: dt: convert submitting-patches.txt to ReST 
>> format")
>> commit bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column 
>> warning")
>> commit cca73e4946c4 ("docs: Correct the release date of 5.2 stable")
>> 
>> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> 
> So this doesn't apply to current docs-next...care to respin?
> 
> Thanks,
> 
> jon

-- 
Federico Vaga
http://www.federicovaga.it/
