Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987D3C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B0C7205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgD0QCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:02:39 -0400
Received: from smtprelay0059.hostedemail.com ([216.40.44.59]:48288 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726539AbgD0QCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:02:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id CE7BD18029587;
        Mon, 27 Apr 2020 16:02:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ship96_33c1d1869b436
X-Filterd-Recvd-Size: 5476
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Mon, 27 Apr 2020 16:02:35 +0000 (UTC)
Message-ID: <0c487ba493f4b4c0f68b3dfd23f14a080e4fb0c2.camel@perches.com>
Subject: Re: [RESEND PATCH v3 1/1] lib/vsprintf: Add support for printing
 V4L2 and DRM fourccs
From:   Joe Perches <joe@perches.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-media@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com,
        mchehab@kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
Date:   Mon, 27 Apr 2020 09:02:34 -0700
In-Reply-To: <20200427145303.29943-1-sakari.ailus@linux.intel.com>
References: <20200427145303.29943-1-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-27 at 17:53 +0300, Sakari Ailus wrote:
> Add a printk modifier %p4cc (for pixel format) for printing V4L2 and DRM
> pixel formats denoted by fourccs. The fourcc encoding is the same for both
> so the same implementation can be used.
[]
> - Added WARN_ON_ONCE() sanity checks. Comments on these are welcome; I'd
>   expect them mostly be covered by the tests.

All the WARN_ON_ONCE uses are not necessary.

> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
[]
> @@ -1721,6 +1721,89 @@ char *netdev_bits(char *buf, char *end, const void *addr,
>  	return special_hex_number(buf, end, num, size);
>  }
>  
> +static noinline_for_stack
> +char *fourcc_string(char *buf, char *end, const u32 *__fourcc,
> +		    struct printf_spec spec, const char *fmt)

There's no reason to use __ prefixed argument names here.

> +{
> +#define FOURCC_HEX_CHAR_STR		"(xx)"
> +#define FOURCC_BIG_ENDIAN_STR		" big-endian"
> +#define FOURCC_LITTLE_ENDIAN_STR	" little-endian"

I don't believe used-once macro defines are useful.

> +#define FOURCC_HEX_NUMBER		" (0x01234567)"

> +#define FOURCC_STRING_MAX						\
> +	FOURCC_HEX_CHAR_STR FOURCC_HEX_CHAR_STR FOURCC_HEX_CHAR_STR	\
> +	FOURCC_HEX_CHAR_STR FOURCC_LITTLE_ENDIAN_STR FOURCC_HEX_NUMBER

This is very difficult to read and is size dependent on
the size of little-endian > big_endian

I'd write it out

	FOURCC_STRING_MAX	sizeof("(xx)(xx)(xx)(xx) little-endian (0x01234567)")

and then not have the define at all but use
the written out string in the declaration.

> +	struct printf_spec my_spec = {
> +		.type = FORMAT_TYPE_UINT,
> +		.field_width = 2,
> +		.flags = SMALL,
> +		.base = 16,
> +		.precision = -1,
> +	};

my_spec isn't usefully named, likely not necessary at all,
and if really necessary, it should be static const

> +	char __s[sizeof(FOURCC_STRING_MAX)];

I'd declare the buffer

	char fourcc[sizeof("(xx)(xx)(xx)(xx) little-endian (0x01234567)"];

like all the other specialty functions do.

> +	char *s = __s;

There's no reason to use __ prefixed variable names here either.
All the other specialty function use:

	char *p = <output_buffer_name>;

> +	unsigned int i;

just int i; is typical

> +	/*
> +	 * The 31st bit defines the endianness of the data, so save its printing
> +	 * for later.
> +	 */
> +	u32 fourcc = *__fourcc & ~BIT(31);

	bool be = fourcc & BIT(31);

> +	int ret;
> +
> +	if (check_pointer(&buf, end, __fourcc, spec))
> +		return buf;
> +
> +	if (fmt[1] != 'c' || fmt[2] != 'c')
> +		return error_string(buf, end, "(%p4?)", spec);
> +
> +	for (i = 0; i < sizeof(fourcc); i++, fourcc >>= 8) {
> +		unsigned char c = fourcc >> (i*8);

Please remove the fourcc >>= 8 from the loop and use

		unsigned char c = fourcc >> (i*8);

If I understand this correctly, I think this is simpler:

		if (isascii(c) && isprint(c)) {
			*s++ = c;
		} else {
			*s++ = '(';
			s = hex_byte_pack(s, c);
			*s++ = ')';
		}

> +
> +		/* Weed out spaces */
> +		if (c == ' ')
> +			continue;
> +
> +		/* Print non-control characters as-is */
> +		if (c > ' ') {
> +			*s = c;
> +			s++;
> +			continue;
> +		}
> +
> +		if (WARN_ON_ONCE(sizeof(__s) <
> +				 (s - __s) + sizeof(FOURCC_HEX_CHAR_STR)))
> +			break;
> +
> +		*s = '(';
> +		s++;
> +		s = number(s, s + 2, c, my_spec);
> +		*s = ')';
> +		s++;
> +	}
> +
> +	ret = strscpy(s, *__fourcc & BIT(31) ? FOURCC_BIG_ENDIAN_STR
> +					     : FOURCC_LITTLE_ENDIAN_STR,
> +		      sizeof(__s) - (s - __s));

If you size the initial buffer correctly, strscpy is unnecessary.

	strcpy(s, <bit31> ? "big endian" : "little endian");
	s += strlen(s);

> +	if (!WARN_ON_ONCE(ret < 0))
> +		s += ret;
> +
> +	if (!WARN_ON_ONCE(sizeof(__s) <
> +			  (s - __s) + sizeof(FOURCC_HEX_NUMBER))) {
> +		*s = ' ';
> +		s++;
> +		*s = '(';
> +		s++;

		*s++ = ' ';
		*s++ = '(';

+		/* subtract parentheses and the space from the size */
> +		special_hex_number(s, s + sizeof(FOURCC_HEX_NUMBER) - 3,
> +				   *__fourcc, sizeof(u32));
> +		s += sizeof(u32) * 2 + 2 /* 0x */;
> +		*s = ')';
> +		s++;
		*s++ = ')';

> +		*s = '\0';
> +	}
> +
> +	return string(buf, end, __s, spec);
> +}
> 

