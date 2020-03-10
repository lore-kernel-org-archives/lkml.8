Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E570EC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11DF208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYZCYaLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgCJV3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 17:29:42 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45830 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgCJV3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 17:29:42 -0400
Received: by mail-ot1-f66.google.com with SMTP id f21so14665754otp.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 14:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CEjakKbxcet/QjTx5fHoFiyU3iQYuza0EWe3kr1h4e0=;
        b=SYZCYaLZxT2MyGWkDC0qPguRCWU3g1Cf72YdnE9j8J5AvlSCBtckDOVSz/W8ffC8sl
         SF9PCSOmJllbHml7ajUFVS+Jsv7Oj7ScdHlzkuZzd/cFFHBSqsR/4SZwOUZCC4VzU6aa
         tt2jnIHzgD6KwxOjzKl2PqWfBAW85Xxzs5ZGXPJm/FDeOxVYixIdhOHkAZoXd8avooB4
         CdKTikX86qNOcfJp5MSq/DMl/BeP9XWPxw47JWHPmQxUmHOznaPqw5XVyYtEJJlnl3Sq
         KqhZ9LsTzJHmysW+8oL35LTMfp3g6r8JwPNxnYsNKS/xHgxd8C5Y+sreTUoe7+Zn5S32
         znzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CEjakKbxcet/QjTx5fHoFiyU3iQYuza0EWe3kr1h4e0=;
        b=ZcpOcVsDfDqQWlY9q7a/tLhghruASjVx1Sc7ekE5RMq+xqFCSxa43NANG4WY+N/s0K
         5feb7xY57rDO+WOJfhk3Q1KNUR4V2StDJOZaJAaeE9ZhBqyxSf2+vEx8TpAPOl1gUwk2
         RVnnF1XGif11sG4a1RCoElJln1ILsWyYe7x8RBFfRpf86W5RnKsQGRkadBgyiJqIVu0v
         S1SGlFaiazSE/wubRy7+FrFvwcqVKPvnR0Tbt5AIgunUXFjHRarFJiU9qpi1uRAVLUgG
         FHHByF4bIlfTBOmOASkVspFIqLDws8EvN9g9K7rvvxWQm+YyMx9aLkDqf5zAMfpquTwD
         c5xQ==
X-Gm-Message-State: ANhLgQ059h8+1ompX2EpuZFSxjqEI6BR6hacexuErAYd7kA5QOKax158
        /kZc9hORoJw+wo6zPa7sLZY=
X-Google-Smtp-Source: ADFU+vvH6bzax45zBkz2psHqwEan7hlHzzwphY1kFodWW9Bpk7ZtP1H3Ia1x3ZBIqEOpdxiCPFS8kA==
X-Received: by 2002:a9d:69d7:: with SMTP id v23mr18744958oto.40.1583875779755;
        Tue, 10 Mar 2020 14:29:39 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id l20sm2331853oih.40.2020.03.10.14.29.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Mar 2020 14:29:39 -0700 (PDT)
Date:   Tue, 10 Mar 2020 14:29:38 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Alex Elder <elder@linaro.org>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] bitfield.h: add FIELD_MAX() and field_max()
Message-ID: <20200310212938.GA17565@ubuntu-m2-xlarge-x86>
References: <20200306042302.17602-1-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306042302.17602-1-elder@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 10:23:02PM -0600, Alex Elder wrote:
> Define FIELD_MAX(), which supplies the maximum value that can be
> represented by a bitfield.  Define field_max() as well, to go
> along with the lower-case forms of the field mask functions.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2: Added Acked-by from Jakub.
> 
> David, I added you to this because it's probably easiest to take
> this change in through your tree with the rest of the IPA code
> (which uses field_max(), defined here).
> 
> 					-Alex
> 
>  include/linux/bitfield.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index 4bbb5f1c8b5b..48ea093ff04c 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -55,6 +55,19 @@
>  					      (1ULL << __bf_shf(_mask))); \
>  	})
>  
> +/**
> + * FIELD_MAX() - produce the maximum value representable by a field
> + * @_mask: shifted mask defining the field's length and position
> + *
> + * FIELD_MAX() returns the maximum value that can be held in the field
> + * specified by @_mask.
> + */
> +#define FIELD_MAX(_mask)						\
> +	({								\
> +		__BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_MAX: ");	\
> +		(typeof(_mask))((_mask) >> __bf_shf(_mask));		\
> +	})
> +
>  /**
>   * FIELD_FIT() - check if value fits in the field
>   * @_mask: shifted mask defining the field's length and position
> @@ -110,6 +123,7 @@ static __always_inline u64 field_mask(u64 field)
>  {
>  	return field / field_multiplier(field);
>  }
> +#define field_max(field)	((typeof(field))field_mask(field))
>  #define ____MAKE_OP(type,base,to,from)					\
>  static __always_inline __##type type##_encode_bits(base v, base field)	\
>  {									\
> -- 
> 2.20.1
> 

Without this patch, the IPA driver that was picked up a couple of days
ago does not build...

$ make -j$(nproc) -s ARCH=arm64 CC=clang CROSS_COMPILE=aarch64-linux-gnu- O=out.arm32 distclean allyesconfig drivers/net/ipa/
../drivers/net/ipa/ipa_cmd.c:182:28: error: implicit declaration of function 'field_max' [-Werror,-Wimplicit-function-declaration]
        BUILD_BUG_ON(TABLE_SIZE > field_max(IP_FLTRT_FLAGS_HASH_SIZE_FMASK));
                                  ^
../drivers/net/ipa/ipa_cmd.c:182:28: note: did you mean 'field_mask'?
../include/linux/bitfield.h:109:28: note: 'field_mask' declared here
static __always_inline u64 field_mask(u64 field)
                           ^
../drivers/net/ipa/ipa_cmd.c:183:28: error: implicit declaration of function 'field_max' [-Werror,-Wimplicit-function-declaration]
        BUILD_BUG_ON(TABLE_SIZE > field_max(IP_FLTRT_FLAGS_NHASH_SIZE_FMASK));
                                  ^
../drivers/net/ipa/gsi.c:220:39: error: implicit declaration of function 'field_max' [-Werror,-Wimplicit-function-declaration]
        BUILD_BUG_ON(GSI_RING_ELEMENT_SIZE > field_max(ELEMENT_SIZE_FMASK));
                                             ^
2 errors generated.
../drivers/net/ipa/gsi.c:220:39: note: did you mean 'field_mask'?
../include/linux/bitfield.h:109:28: note: 'field_mask' declared here
static __always_inline u64 field_mask(u64 field)
                           ^
../drivers/net/ipa/gsi.c:223:39: error: implicit declaration of function 'field_max' [-Werror,-Wimplicit-function-declaration]
        BUILD_BUG_ON(GSI_RING_ELEMENT_SIZE > field_max(EV_ELEMENT_SIZE_FMASK));
                                             ^
make[5]: *** [../scripts/Makefile.build:267: drivers/net/ipa/ipa_cmd.o] Error 1
make[5]: *** Waiting for unfinished jobs....
../drivers/net/ipa/gsi.c:710:16: error: implicit declaration of function 'field_max' [-Werror,-Wimplicit-function-declaration]
                wrr_weight = field_max(WRR_WEIGHT_FMASK);
                             ^
3 errors generated.
make[5]: *** [../scripts/Makefile.build:267: drivers/net/ipa/gsi.o] Error 1
../drivers/net/ipa/ipa_endpoint.c:584:14: error: implicit declaration of function 'field_max' [-Werror,-Wimplicit-function-declaration]
        if (scale > field_max(SCALE_FMASK))
                    ^
../drivers/net/ipa/ipa_endpoint.c:584:14: note: did you mean 'field_mask'?
../include/linux/bitfield.h:109:28: note: 'field_mask' declared here
static __always_inline u64 field_mask(u64 field)
                           ^
../drivers/net/ipa/ipa_endpoint.c:965:16: error: implicit declaration of function 'field_max' [-Werror,-Wimplicit-function-declaration]
        return val == field_max(IPA_STATUS_FLAGS1_RT_RULE_ID_FMASK);
                      ^
2 errors generated.

This probably should go through the net-next tree to avoid that build
breakage.

Cheers,
Nathan
