Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4F8C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 02:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83C9E2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 02:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q0d/Y/mg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgICCnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 22:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgICCnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 22:43:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89FCC061244;
        Wed,  2 Sep 2020 19:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=R9wsgh5OhpmeQRbKxOY/dzd+1XG9pkbfv3w+MHt05O0=; b=Q0d/Y/mgV4RO/6ooAH/2LXQB85
        ZikQYl7DEhJw0JBCVSjXGIcMbVl6zsAqiApPOSzVrO1y8bK3bKKyj9OTWEA+5qMAYhsU3JZXS2eK5
        9a7hRAU2SIdQMGbq9DDRom0iyJUHoYGUhZXS/YeZca/sFcJ73/1tB8KnKA+zc3rpv8y4UMgXfcnBK
        jvx39XdFtkReY7yBDOHTu6qi5cjTUROqvV3hq6TweDxWDjVMfByghE+0yJm/Vyw0iKbPXUGwXR6FK
        Bugf06xfP81L7EWL2gpauc3So1OuivWqjC4vIEy8FaELOqdfi3+mqrqmLR+WmxnGW+45sGf2H3t+I
        m5W0id0g==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDfDT-0007N5-CZ; Thu, 03 Sep 2020 02:43:11 +0000
Subject: Re: [PATCH 0/2] docs: Add automatic cross-reference for C types
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@protonmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
References: <20200903005747.3900333-1-nfraprado@protonmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1a03c65e-6fbc-25f9-e553-61259a310f29@infradead.org>
Date:   Wed, 2 Sep 2020 19:43:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903005747.3900333-1-nfraprado@protonmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/20 5:58 PM, Nícolas F. R. A. Prado wrote:
> In order to cross-reference C types in the documentation, Sphinx
> requires the syntax :c:type:`type_name`, or even :c:type:`struct
> type_name <type_name>` in order to have the link text different from the
> target text.
> This patch series removes the need for that markup.
> 
> The first commit extends the automarkup script to enable automatic
> cross-reference of C types by matching any "struct|union|enum|typedef type_name"
> expression.
> This makes the documentation's plain text cleaner and adds cross-reference to
> types without any additional effort by the author.
> 
> The second commit updates the "Cross-referencing from
> reStructuredText" section in Documentation/doc-guide/kernel-doc.rst
> to reflect that no additional syntax is needed when cross-referencing both types
> and functions anymore.
> 
> When testing this, I did find an edge-case from the output of
> Documentation/output/scsi/scsi_mid_low_api.rst on the "typedef struct scsi_cmnd
> Scsi_Cmnd;", where 'typedef struct' is being identified as a reference, but
> there isn't any named 'struct', so it renders bold.

There also isn't any file name scsi_typedefs.h any longer,
so maybe we can update scsi_mid_low_api.rst as well.

Thanks.

> I thought of adding an ignore_names list just like there is one for functions,
> with 'struct' in it, to workaround this edge case, but since it was the only
> one I found, and also because it was unclear what the desired output was
> (cross-reference 'struct scsi_cmnd' or leave the whole expression as plain text)
> I wanted to get some feedback beforehand.
> 
> After getting this merged I intend to start removing the occurrences of :c:type.
> 
> Thanks,
> Nícolas
> 
> Nícolas F. R. A. Prado (2):
>   docs: Add automatic cross-reference for C types
>   kernel-doc: Update "cross-referencing from rST" section to use
>     automarkup
> 
>  Documentation/doc-guide/kernel-doc.rst | 33 ++++++++++++-----------
>  Documentation/sphinx/automarkup.py     | 37 +++++++++++++++++---------
>  2 files changed, 41 insertions(+), 29 deletions(-)
> 


-- 
~Randy

