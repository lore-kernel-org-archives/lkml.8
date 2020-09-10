Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24046C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D10B5214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gJMu+pWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725616AbgIJWwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 18:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgIJWwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 18:52:49 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A82C061573;
        Thu, 10 Sep 2020 15:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=mcAyKZgcggUBfWFmqvvShivn9FlQq08qmAzFXu/vQNM=; b=gJMu+pWxULloQHpAz7Qby//ART
        37wQ1cjCvyjw0WhWdZwUDEvpcAJ+BVx2kkijnurP3CRdAP8y9L/eWnSwqRDVUE0hQ8hYmslKYPLXA
        gY5n6AXTmFcgw7H2ZcVk5Jy3MP7rvyLa5cdaf+kKtI8gJZTTr5FtQPjLsCZJT68f3PfGL6V1L8Pag
        pPZDrHTu7E1XMGFXuzXdhAEOqmUymFHSJpURWeod/uskUpYR13LeZ1C28M+TL211al15ul2jZ6mMe
        mdXx+4ZbqGPzlGte24ygwox9U5Y/KoJ4XeI9U0TM8OLv6YOJ9cSipG7BcfyjxfWxGL2s+FUJYyNN0
        1fO3GVow==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGVQr-0008Bv-U5; Thu, 10 Sep 2020 22:52:46 +0000
Subject: Re: [PATCH] scripts : config : Added example use when run without
 argument,extend help
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, masahiroy@kernel.org
Cc:     jeremie.francois@gmail.com, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
References: <20200910110713.12782-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <13084d55-6b9a-5c6b-0ce0-84739b3e1072@infradead.org>
Date:   Thu, 10 Sep 2020 15:52:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200910110713.12782-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please be more careful. There are many errors here. (see below)


On 9/10/20 4:07 AM, Bhaskar Chowdhury wrote:
> This patch extends the help section by adding an explicit example of use.
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  scripts/config | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/scripts/config b/scripts/config
> index eee5b7f3a092..b75a5aab2453 100755
> --- a/scripts/config
> +++ b/scripts/config
> @@ -45,6 +45,25 @@ make time.
>  By default, $myname will upper-case the given symbol. Use --keep-case to keep
>  the case of all following symbols unchanged.
>  
> +The concerete example, say, you want to change any particular config ,like

       concrete                                                  config, like

> +GKOV for profiling , you can simply use this command

   GCOV

> +
> +To enable :

      enable:

> +
> +#scripts/config --enable GKOV_KERNEL  && grep GKOV .config

                            GCOV_KERNEL          GCOV

> +
> + and the output will be like this :

                                this:

> +
> +  CONFIG_GKOV_KERNEL=y

            GCOV

> +
> +To disable :

      disable:

> +
> +#scripts/config --disable GKOV_KERNEL  && grep GKOV .config

                             GCOV                 GCOV

> +
> +  and the output will be like this :

                                 this:

> +
> +# CONFIG_GKOV_KERNEL is not set

            GCOV

> +
>  $myname uses 'CONFIG_' as the default symbol prefix. Set the environment
>  variable CONFIG_ to the prefix to use. Eg.: CONFIG_="FOO_" $myname ...
>  EOL
> 


-- 
~Randy

