Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18609C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 21:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFC4D206D4
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 21:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgICVdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 17:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgICVdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 17:33:18 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5991C061244;
        Thu,  3 Sep 2020 14:33:18 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E184E7DA;
        Thu,  3 Sep 2020 21:33:17 +0000 (UTC)
Date:   Thu, 3 Sep 2020 15:33:16 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "=?UTF-8?B?TsOtY29sYXM=?= F. R. A. Prado" <nfraprado@protonmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
Subject: Re: [PATCH 0/2] docs: Add automatic cross-reference for C types
Message-ID: <20200903153316.2f31f4d6@lwn.net>
In-Reply-To: <20200903005747.3900333-1-nfraprado@protonmail.com>
References: <20200903005747.3900333-1-nfraprado@protonmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Sep 2020 00:58:09 +0000
Nícolas F. R. A. Prado <nfraprado@protonmail.com> wrote:

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

So I've looked this over, applied it, looked at how the output changes,
and generally put an untoward amount of effort into finding something to
grumble about.

I failed.

This is a great change - thanks for stepping up and doing it!

> When testing this, I did find an edge-case from the output of
> Documentation/output/scsi/scsi_mid_low_api.rst on the "typedef struct scsi_cmnd
> Scsi_Cmnd;", where 'typedef struct' is being identified as a reference, but
> there isn't any named 'struct', so it renders bold.
> I thought of adding an ignore_names list just like there is one for functions,
> with 'struct' in it, to workaround this edge case, but since it was the only
> one I found, and also because it was unclear what the desired output was
> (cross-reference 'struct scsi_cmnd' or leave the whole expression as plain text)
> I wanted to get some feedback beforehand.

As Randy pointed out, the documentation in question is obsolete and
incorrect anyway; there's really not much that can be done in the docs
build system to fix *that*.  I'm not going to worry about this particular
glitch.  If you felt so inspired, a patch to the SCSI maintainers just
removing that paragraph might be well received.

I'm going to go ahead and push this out to linux-next; we'll see if
anything explodes from there.

Thanks,

jon
