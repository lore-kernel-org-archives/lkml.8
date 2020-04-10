Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA61C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 17:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72CCE2078E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 17:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nj+6torI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgDJRg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:36:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54596 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgDJRg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 13:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=TqxD4FVZo4dOcfqQaPBh6DPHt90KV13UBnTYi1QMeq4=; b=Nj+6torIbwq6yRqoFXRerdFJUA
        KUL6OCi5Q4gRMD0EFQOkWXjGQP11KGfNw3pMS9DAQHCBv3l3CiD6/XTAXo+dmz3suojqHG11+nDYG
        l6Q9P/qeP+PAuRGVyd3OKWj5Ab5y40eH8dgaJn1qmUp6oN5Aks4p9UNLu+2OoLAIXhVVAWzIfI/Ri
        Qn8+WRm8AAZoQ170YeOMcK5lyoZT1UBOhCc+DK+3brjMgiLFktuZBmYZmPOOl5UWv0rbg+yyXer0T
        EfS6n/BaJ/yaoFbExrvF4Zx9OoGbn6mBQxkyLRxtcn9nHVCDuxYrC5iklfnIYyee0yBdhsw0B7UHh
        cKig3aHQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMxZs-0005zK-IY; Fri, 10 Apr 2020 17:36:28 +0000
Subject: Re: [PATCH] scripts/config: allow colons in option strings for sed
To:     "Jeremie Francois (on alpha)" <jeremie.francois@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <20200410165741.27078-1-jeremie.francois@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1b824b27-aa2d-91ca-5540-15695994ef9a@infradead.org>
Date:   Fri, 10 Apr 2020 10:36:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200410165741.27078-1-jeremie.francois@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding Cc's]

On 4/10/20 9:57 AM, Jeremie Francois (on alpha) wrote:
> Sed broke on some strings as it used colon as a separator.
> I made it more robust by using \001, which is legit POSIX AFAIK.
> 
> E.g. ./config --set-str CONFIG_USBNET_DEVADDR "de:ad:be:ef:00:01"
> failed with: sed: -e expression #1, char 55: unknown option to `s'
> 
> Signed-off-by: Jeremie Francois (on alpha) <jeremie.francois@gmail.com>
> ---
>  scripts/config | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/config b/scripts/config
> index e0e39826dae9..d365081b60b2 100755
> --- a/scripts/config
> +++ b/scripts/config
> @@ -7,6 +7,9 @@ myname=${0##*/}
>  # If no prefix forced, use the default CONFIG_
>  CONFIG_="${CONFIG_-CONFIG_}"
>  
> +# We use an uncommon delimiter for sed substitutions
> +SED_DELIM=$(echo -en "\001")
> +
>  usage() {
>  	cat >&2 <<EOL
>  Manipulate options in a .config file from the command line.
> @@ -83,7 +86,7 @@ txt_subst() {
>  	local infile="$3"
>  	local tmpfile="$infile.swp"
>  
> -	sed -e "s:$before:$after:" "$infile" >"$tmpfile"
> +	sed -e "s$SED_DELIM$before$SED_DELIM$after$SED_DELIM" "$infile" >"$tmpfile"
>  	# replace original file with the edited one
>  	mv "$tmpfile" "$infile"
>  }
> 


-- 
~Randy

