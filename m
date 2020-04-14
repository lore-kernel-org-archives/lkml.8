Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77322C352BE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5690A20767
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ov9Px5z+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505205AbgDNTsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2505166AbgDNTpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:45:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8DAC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=qiGDdgrymzs3lmhrk9O/Fh6Zpf8KL3+mfXiGBIdA72Q=; b=Ov9Px5z+q5KNIHq3yt1v5Jr77j
        VtNf1+7arPv5fEqoCFrBblJej1Iu0OwmZx8BrX3g6RhaCxcZaCRy3M/Wb4qcs+GeB7yiazICcuJF0
        QGKZBYe1990B9qvV6u2HhBT2WAYl5sIA8n+eFAwr5HmSGe44S01dQHLXfHE97ydbtsB4tVU+xFuHU
        oyDG8w709Ik4IGQJ16q0pEtD7ZEdQ1y5tKoBJm5my8m/PsVlqU2L9NfDr5XFdlqOMr1GchEsDqhQj
        i2sB8Ku/gyqPAGiDmFkTP539x2v9JsaoaMidiAP09BfH03YV/2jyHJav9KXlsH8ZetqbzF7dpQNlL
        gmUO/AKQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jORVH-0002f3-9V; Tue, 14 Apr 2020 19:45:51 +0000
Subject: Re: [PATCH] staging: tools: string.c doc fix
To:     Daniel Bovensiepen <daniel@bovensiepen.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20200414185430.GA14496@daboVM>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <266382a3-a5f4-5934-8130-aead5eeec264@infradead.org>
Date:   Tue, 14 Apr 2020 12:45:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200414185430.GA14496@daboVM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/20 11:54 AM, Daniel Bovensiepen wrote:
> Fix spelling error in the comment.

Nope, that's math-speak for "if and only if."

> Signed-off-by: Daniel Bovensiepen <daniel@bovensiepen.net>
> ---
>  tools/lib/string.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/string.c b/tools/lib/string.c
> index f645343815de..f73a1020fad9 100644
> --- a/tools/lib/string.c
> +++ b/tools/lib/string.c
> @@ -41,7 +41,7 @@ void *memdup(const void *src, size_t len)
>   * @s: input string
>   * @res: result
>   *
> - * This routine returns 0 iff the first character is one of 'Yy1Nn0', or
> + * This routine returns 0 if the first character is one of 'Yy1Nn0', or
>   * [oO][NnFf] for "on" and "off". Otherwise it will return -EINVAL.  Value
>   * pointed to by res is updated upon finding a match.
>   */
> 

-- 
~Randy

