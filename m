Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A92C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 19:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4C22206FA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 19:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CM7S9hzo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgFETa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 15:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgFETa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 15:30:28 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84400C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 12:30:27 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id m1so5692525pgk.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 12:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AbyBZikI3hqgXmsHBOfV75n7XdKr0G/JAWMAPeCKaVM=;
        b=CM7S9hzo9pTl7u6+baQLjXQEAeN1JeKl7OKM3VOg/W5H7eiQwaxhARGEUpluvm5OZE
         qn/79lkDeXfzIlQH7fGekrn/YUFxJZfRMp48Jp6lvtniA5VWnvNqjkqPyX6dbDM8ytgq
         FlAykxq3HNcAX2dQtka5uiu3J/ZrW3Ii+QuAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AbyBZikI3hqgXmsHBOfV75n7XdKr0G/JAWMAPeCKaVM=;
        b=ho9kLjBmamJwpmsabhfpB+QeCaMUvTbvmRvL/CwQKeYAn+Dowmj2QLUf6o5ggj2TK+
         8AMWrLsFfhBPKYo49uBoDuWNEx9Usx4WoGVi55eLonLnW46uVQNZ7R3C4a5N6U7HFMkM
         7zxp9cNWuqoyt+cfzj6JOz8UNSGLN2G2kAzjG142Xc9z5Mr9Q90zql0qo8Owbev0DdQ7
         vqKXvJq22790txDd1pJy+knPxvXy3KmjsEIPWyAQ0V6FzFoZmaX0rgKruPNYpEv5k7kp
         K0rtZxqJrZ+sW7pHYVkRFIRH4pYjzqB36ERNBxETNAeTANYF+RWwMy9WENS85Qn8tDdH
         8Juw==
X-Gm-Message-State: AOAM531/F8t+KL1dNnEb8LH56+bu57Lo7BP2zJMEbljRHQpd27stvqd1
        LsXHldC2N8S2wpHb1ZHky+jDxg==
X-Google-Smtp-Source: ABdhPJwF7iSAohqEGKNsj8WMqTwy2PzH6/8uc+MdsDrlJtOWrk3aZlMTtCIbbLzwQ7WIMzePkNkM+Q==
X-Received: by 2002:a63:454c:: with SMTP id u12mr10994700pgk.153.1591385426987;
        Fri, 05 Jun 2020 12:30:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x11sm332239pfq.169.2020.06.05.12.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 12:30:26 -0700 (PDT)
Date:   Fri, 5 Jun 2020 12:30:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH v2] docs: deprecated.rst: Add zero-length and one-element
 arrays
Message-ID: <202006051150.B30EE1104D@keescook>
References: <20200605162142.GA1617@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605162142.GA1617@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 11:21:42AM -0500, Gustavo A. R. Silva wrote:
> Add zero-length and one-element arrays to the list.
> 
> While I continue replacing zero-length and one-element arrays with
> flexible-array members, I need a reference to point people to, so
> they don't introduce more instances of such arrays. And while here,
> add a note to the "open-coded arithmetic in allocator arguments"
> section, on the use of struct_size() and the arrays-to-deprecate
> mentioned here.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - Adjust some markup links for readability.
> 
>  Documentation/process/deprecated.rst | 83 ++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
> 
> diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
> index 652e2aa02a66c..042c21c968e19 100644
> --- a/Documentation/process/deprecated.rst
> +++ b/Documentation/process/deprecated.rst
> @@ -85,6 +85,11 @@ Instead, use the helper::
>  
>  	header = kzalloc(struct_size(header, item, count), GFP_KERNEL);
>  
> +NOTE: If you are using struct_size() on a structure containing a zero-length

Please use:

.. note::

for this kind of "NOTE:"

> +or a one-element array as a trailing array member, stop using such arrays

And I think it was likely my language suggestion to say "stop using", but
probably this should be more friendly. How about "please refactor such
arrays ..."

> +and switch to `flexible arrays <#zero-length-and-one-element-arrays>`_

... to a `flexible array member <#...

> +instead.
> +

>  See array_size(), array3_size(), and struct_size(),
>  for more details as well as the related check_add_overflow() and
>  check_mul_overflow() family of functions.
> @@ -200,3 +205,81 @@ All switch/case blocks must end in one of:
>  * continue;
>  * goto <label>;
>  * return [expression];
> +
> +Zero-length and one-element arrays
> +----------------------------------
> +Old code in the kernel uses the zero-length and one-element array extensions
> +to the C90 standard, but the `preferred mechanism to declare variable-length

I'd like to reword this to make an immediate statement about what _should_
be done, and then move into the details on an as accurate as possible
review of the history of these work-arounds. How about this, which I
mixed some of your earlier paragraphs into:



There is a regular need in the kernel to provide a way to declare having
a dynamically sized set of trailing elements in a structure. Kernel code
should always use `"flexible array members" <https://en.wikipedia.org/wiki/Flexible_array_member>`_
for these cases. The older style of one-element or zero-length arrays should
no longer be used.

In older C code, dynamically sized trailing elements were done by specifying
a one-element array at the end of a structure::

        struct something {
                int count;
                struct items[1];
        };

This led to fragile size calculations via sizeof() (which would need to
remove the size of the single trailing element to get a correct size of
the "header"). A `GNU C extension <https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html>`_
was introduced to allow for zero-length arrays, to avoid these kinds of
size problems::

        struct something {
                int count;
                struct items[0];
        };

But this led to other problems, and didn't solve some problems shared by
both styles, like not being to able to detect when such an array is
accidentally being used _not_ at the end of a structure (which could happen
directly, or when such a struct was in unions, structs of structs, etc).

C99 introduced "flexible array members", which lacks a numeric size for
the array declaration entirely::

        struct something {
                int count;
                struct items[];
        };

This is the way the kernel expects dynamically sized trailing elements
to be declared. It allows the compiler to generate errors when the
flexible array does not occur last in the structure, which helps to prevent
some kind of `undefined behavior
<https://git.kernel.org/linus/76497732932f15e7323dc805e8ea8dc11bb587cf>`_
bugs from being inadvertently introduced to the codebase. It also allows
the compiler to correctly analyze array sizes (via sizeof(),
`CONFIG_FORTIFY_SOURCE`, and `CONFIG_UBSAN_BOUNDS`). For instance,
there is no mechanism that warns us that the following application of the
sizeof() operator to a zero-length array always results in zero::

        struct something {
                int count;
                struct items[0];
        };

        struct something *instance;

        instance = kmalloc(struct_size(instance, items, size), GFP_KERNEL);
        instance->length = size;
        memcpy(instance->items, source, size);
        ...
        size = sizeof(instance->items);


[and then continue with the rest of the details you wrote below...]

> +
> +At the last line of code above, ``size`` turns out to be zero --when one might have
> +thought differently. Here are a couple examples of this issue: `link 1
> +<https://git.kernel.org/linus/f2cd32a443da694ac4e28fbf4ac6f9d5cc63a539>`_,
> +`link 2
> +<https://git.kernel.org/linus/ab91c2a89f86be2898cee208d492816ec238b2cf>`_.
> +On the other hand, `flexible array members have incomplete type, and so the sizeof()
> +operator may not be applied <https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html>`_,
> +so any  misuse of such  operator will be immediately noticed at build time.
> +
> +With respect to one-element arrays, one has to be acutely aware that `such arrays
> +occupy at least as much space as a single object of the type
> +<https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html>`_,
> +hence they contribute to the size of the enclosing structure. This is prone
> +to error every time people want to calculate the total size of dynamic memory
> +to allocate for a structure containing an array of this kind as a member::
> +
> +        struct something {
> +                int length;
> +                char data[1];
> +        };

And for all of these examples, I'd like to avoid using "char" as the type
for the flex array member, since it doesn't drive home the idea of
having a multiplier (i.e. "length" matches the size of "data") And
similarly, "length" should, I think, be called "count". That way the
bytes is separate from count, but is the result of sizeof(*items) *
count.

> +
> +        struct something *instance;
> +
> +        instance = kmalloc(struct_size(instance, data, size - 1), GFP_KERNEL);
> +        instance->length = size;
> +        memcpy(instance->data, source, size);
> +
> +In the example above, we had to remember to calculate ``size - 1`` when using

I don't want to get people confused between "size" (in bytes) vs "count"
(of trailing elements).

> +the struct_size() helper, otherwise we would have --unintentionally-- allocated
> +memory for one too many ``data`` objects. The cleanest and least error-prone way
> +to implement this is through the use of a `flexible array member`, which is
> +exemplified at the `beginning <#zero-length-and-one-element-arrays>`_ of this
> +section.
> -- 
> 2.27.0
> 

How does that look?

-- 
Kees Cook
