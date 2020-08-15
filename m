Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FA1C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4041620675
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gx4HoX1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgHOWqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbgHOWqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:46:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D3EC061786
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 15:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=8j59QoVgxn7AeLQsvt9osW/bSNvwDNB+K9GtNkz8aLw=; b=Gx4HoX1fXhOZERTdy5VbWiM2cD
        8Wlka2LyCpagmbkzIwtBJ1H69nPisDvme87DS6DUWXrLWvj/AjsqIkdACRt3WE2Fwr4gSLovrL2HV
        V8+y2BpGWshUtR0JZPu+gx1LECyOE6uv/0Jqhh9usJMXOimNI0E0k0+i6Rqy7dJ1pxcNY6SK6JQYD
        rQpLpeEwLthH4ztQYPyMblZvyJFj+jpn1/ISHHTKhK1iDF06hNNOJiy+zdpxQLv4haBsy9VJjZbcz
        f6hznsAJ43n1iH//TSC6wneCv9SPgnQHDfBDzHjgXvjc4tnPglhr/BSvMeC1F2a7o7+xk4tsT3f3M
        5Th+grlw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k74wj-0002kL-FR; Sat, 15 Aug 2020 22:46:44 +0000
Subject: Re: [PATCH] genksyms: keywords: Use __restrict not _restrict
To:     Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <15f52e9b0e50296aba35871bc1575a684c4a258a.camel@perches.com>
 <CAKwvOd=8C94K-9VCqdCn9FXiyfDhKxMu=4AGem1bGgp8m6z0fw@mail.gmail.com>
 <CAHk-=wjjHN32BXdqu1iP8WSZoqdGPDDiqVLUbBgYG+=JO3MJCw@mail.gmail.com>
 <bc2ca9785cb7cf86c59c8922269d2dfc077ec3cc.camel@perches.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e5737af8-f38c-659a-9c10-9a106edf81a3@infradead.org>
Date:   Sat, 15 Aug 2020 15:46:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bc2ca9785cb7cf86c59c8922269d2dfc077ec3cc.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/20 8:17 PM, Joe Perches wrote:
> On Fri, 2020-08-14 at 20:05 -0700, Linus Torvalds wrote:
>> On Fri, Aug 14, 2020 at 7:14 PM Nick Desaulniers
>> <ndesaulniers@google.com> wrote:
>>> What's KAO? Urban dictionary has no entry. :^P
>>
>> It goes back to 2003 and the original keywords.gperf file, see
>>
>>    https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=46bd1da672d66ccd8a639d3c1f8a166048cca608
>>
>> from the BK history conversion.
>>
>> It might be Kai Germaschewski's tagger name?
> 
> I think it was Keith Owens.

Probably.  A.K.A. kaos.

-- 
~Randy

