Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCD6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 02:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1042620775
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 02:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="J3BlXMnI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RDAITSwL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgGPCqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 22:46:02 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:33125 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726996AbgGPCqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 22:46:01 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 80C59EC2;
        Wed, 15 Jul 2020 22:46:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 15 Jul 2020 22:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        RK6X2jS67N6+KCtzTA8njDUA4e35g7s8yrXJmhHU/FI=; b=J3BlXMnIIL+TSLgF
        nH+atEKDOjZuUSq91An9c3SdEhta/0ejPupNmujChgartH1L7wzWv4jgKJwvGbxX
        tKSMcmes5XL9tgZz5Ht5D83eR+B17fCfB0zYvkBR46/5u+FRC/NwF9eJDmJ6DQ51
        Kh9llvfFBtI/h0Qzc+poc6fgt4j8ca2R1EmSnpJTnM+9vKfSY5CcHlzCOKXUDiL3
        AR0jNHIT3fS3B2vlvcHvNM5Jc8XOYOK6ttsHgIRvXjuhrtdGHjAsGi3h7lwGIprY
        YvdFSNhR/A7Bcjh5Kp7mY94w4REZsrIFWT7omFFoB+OI5y9dPQ/SQZ/lYZx5ze06
        13We8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=RK6X2jS67N6+KCtzTA8njDUA4e35g7s8yrXJmhHU/
        FI=; b=RDAITSwL/AHinOHUg1RZrw/MBawTOOhNDKw+wsZ22JFCmqTGErjSNy/7b
        aAK2+S9eo2kQ67fsqC8gZCDf84XNk4o4bjaPayKTNozdkBtJj8Wx5DHVitFCZaPC
        L0egYKEs2monxOCKISTRf15CW0hZxPjug+PULRdtuOWAgNm0r6Krb2aEG3XRJGUZ
        1LLg0QEvrJXwC3HTypTiB5rTfcmW/yAzWgA8KHPqh5v+/Ubd1zbMVpGd+piWIJxu
        n7bsjevrOXa1U+Dkh03zxrYoQ0rJXOCUFlENWMD0/cOiBdnOgfGU0ktxT1ifcl0H
        R7Q7afvJFtBt9gP1845tDwqYUPprw==
X-ME-Sender: <xms:Z78PX-D_ENQneUQ6DuYAYCvjuIOMeHMTnFN0pziwzxf7AKgNizDeNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrfeefgdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    efteetvdeguddvveefveeftedtffduudehueeihfeuvefgveehffeludeggfejnecukfhp
    peduudekrddvtdekrdehkedrledunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:Z78PX4hOlvvGDzt5FRraOPw3nJCoverLh5zZDum7nSegNs0ut2o9fg>
    <xmx:Z78PXxn4TXZouCnVThr8A5a9SoGaGKTcQrJJMp3vEn2-VZOPoh7VnA>
    <xmx:Z78PX8yECBYeO2IYuhmFeI8_lJThPAvqi7cf6uDxkB-9ZrTtaXTyGA>
    <xmx:aL8PX2PKkgpSHezX33mcHhepQwypFAaLiB4OIH-BZgOx5ebKXjkHdQ>
Received: from mickey.themaw.net (unknown [118.208.58.91])
        by mail.messagingengine.com (Postfix) with ESMTPA id D8E803280066;
        Wed, 15 Jul 2020 22:45:57 -0400 (EDT)
Message-ID: <0b503a7ffb1d80b5f54bb73f360836ce326957b7.camel@themaw.net>
Subject: Re: [PATCH] autofs: fix doubled word
From:   Ian Kent <raven@themaw.net>
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Thu, 16 Jul 2020 10:45:54 +0800
In-Reply-To: <5a82befd-40f8-8dc0-3498-cbc0436cad9b@infradead.org>
References: <5a82befd-40f8-8dc0-3498-cbc0436cad9b@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-07-15 at 18:28 -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Change doubled word "is" to "it is".
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Ian Kent <raven@themaw.net>
> Cc: autofs@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Ian Kent <raven@themaw.net>

> ---
>  include/uapi/linux/auto_dev-ioctl.h |    2 +-Acked-by: Ian Kent <
> raven@themaw.net>
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20200714.orig/include/uapi/linux/auto_dev-ioctl.h
> +++ linux-next-20200714/include/uapi/linux/auto_dev-ioctl.h
> @@ -82,7 +82,7 @@ struct args_ismountpoint {
>  /*
>   * All the ioctls use this structure.
>   * When sending a path size must account for the total length
> - * of the chunk of memory otherwise is is the size of the
> + * of the chunk of memory otherwise it is the size of the
>   * structure.
>   */
>  
> 

