Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDF3C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD90020870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FYcQwAuX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgCERst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:48:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59762 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgCERst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=Df+Ig0PmkHN63sTvEob8OOMDLzhpt9pB/wVBSuAD08A=; b=FYcQwAuXpfAk4AjiPu8FznYBor
        IxyzqmH5D44FR8ZLhaDF/85SOnKAqv1Hh5leH1eFRZ276OIFQtX3upoMz/ISSD9x2I1TJqbYsslkI
        8l+h/HHV88hpFJBhVBT+8iXqNQUzYDATQR+N0zIUhO4SLyWGmhFRysiS/qgjVvYOnKzd8sNALWFEb
        TVkRzAMWjfGnx7YURGJewlS5V+v53yZolCpOqPMnuuHKh6300JyrcQqmC0IzTbOVWiwlFY4x7nwSi
        N2q8WoxbB2fKWT1ATAw+oAU6mkXbkkbWxKbqUhKw352ENOE4MX5CloLrVxq6VM8+pMypHmvoIze4h
        Cp+TRhJQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9uc4-0000dn-4v; Thu, 05 Mar 2020 17:48:48 +0000
Subject: Re: [v5] Documentation: bootconfig: Update boot configuration
 documentation
To:     Markus Elfring <Markus.Elfring@web.de>, linux-doc@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <158339065180.26602.26457588086834858.stgit@devnote2>
 <158339066140.26602.7533299987467005089.stgit@devnote2>
 <ef820445-25c5-a312-57d4-25ff3b4d08cf@infradead.org>
 <3fb124a6-07d2-7a40-8981-07561aeb3c1e@web.de>
 <f823204d-dcd1-2159-a525-02f15562e1af@infradead.org>
 <29c599ef-991d-a253-9f27-5999fb55b228@web.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <997f73af-dc6c-bc8b-12ba-69270ee4b95d@infradead.org>
Date:   Thu, 5 Mar 2020 09:48:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <29c599ef-991d-a253-9f27-5999fb55b228@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/20 9:30 AM, Markus Elfring wrote:
>>> How does this feedback fit to known concerns around the discussed wordings?
>>
>> As far as I am concerned, it means that the documentation is
>> sufficiently good enough to be useful and not difficult to read.
> 
> Would you like to add anything to my previous review comments
> (besides simple typo adjustments)?

If you would (could) be more concrete (or discrete) in your suggestions,
I would be glad to comment on them.

> 
> 
>> It does not mean that it's perfect. Patches can still be made to it.
> 
> I hope that corresponding agreements will be achieved for
> further improvements.


-- 
~Randy

