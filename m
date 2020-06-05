Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A628C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 21:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BEA2206DB
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 21:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="pAygzpH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgFEVbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 17:31:45 -0400
Received: from gateway33.websitewelcome.com ([192.185.146.82]:28881 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728227AbgFEVbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 17:31:44 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 1C6B26EE12
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 16:31:42 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id hJwEjPXy9VQh0hJwEjOBoA; Fri, 05 Jun 2020 16:31:42 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jzldobqzyEY9CG4+/dYurMhSlMxCrk7cTixVidR+Ebo=; b=pAygzpH/EDzZLOHiMVltyBLfhW
        S/K9nSiF0vnXMJEJvSlnP1Mmj8+WIVT9swiSuPExT1LcDlHw4xRYE4wEfPUlBTteg5FcRTdNBfTBJ
        TTc/32miWROxfeGWGb4ISeYMFXYOatlFhjErl42B7NgBNT3nHSGTVUbgY03H+SkcMeuqXEQ7R1s0g
        ovmvseqQ+FD42y+yQkb1ECJUTA9XM3dHhTeHy1WpCUyWql8LrtFkx4aTn33nidYkaY9Z3dT40raQo
        aEwWsBxfmToDXQY3fNjR8FUHW9Y3Ri08gHCasXa+WHw4J6wiDZxwlEBDoQJ9ZokaDGu4IvPIhBps5
        fn0YGVcA==;
Received: from [189.207.59.248] (port=38642 helo=[192.168.15.5])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jhJwD-00127g-PK; Fri, 05 Jun 2020 16:31:41 -0500
Subject: Re: [PATCH v2] docs: deprecated.rst: Add zero-length and one-element
 arrays
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200605162142.GA1617@embeddedor>
 <202006051150.B30EE1104D@keescook>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 AP7RWS474w==
Message-ID: <51a3c0da-4307-1816-996b-4732ad1f937d@embeddedor.com>
Date:   Fri, 5 Jun 2020 16:36:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <202006051150.B30EE1104D@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.207.59.248
X-Source-L: No
X-Exim-ID: 1jhJwD-00127g-PK
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [189.207.59.248]:38642
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/20 14:30, Kees Cook wrote:
> On Fri, Jun 05, 2020 at 11:21:42AM -0500, Gustavo A. R. Silva wrote:
>> Add zero-length and one-element arrays to the list.
>>
>> While I continue replacing zero-length and one-element arrays with
>> flexible-array members, I need a reference to point people to, so
>> they don't introduce more instances of such arrays. And while here,
>> add a note to the "open-coded arithmetic in allocator arguments"
>> section, on the use of struct_size() and the arrays-to-deprecate
>> mentioned here.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>> Changes in v2:
>>  - Adjust some markup links for readability.
>>
>>  Documentation/process/deprecated.rst | 83 ++++++++++++++++++++++++++++
>>  1 file changed, 83 insertions(+)
>>
>> diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
>> index 652e2aa02a66c..042c21c968e19 100644
>> --- a/Documentation/process/deprecated.rst
>> +++ b/Documentation/process/deprecated.rst
>> @@ -85,6 +85,11 @@ Instead, use the helper::
>>  
>>  	header = kzalloc(struct_size(header, item, count), GFP_KERNEL);
>>  
>> +NOTE: If you are using struct_size() on a structure containing a zero-length
> 
> Please use:
> 
> .. note::
> 

OK.

> for this kind of "NOTE:"
> 
>> +or a one-element array as a trailing array member, stop using such arrays
> 
> And I think it was likely my language suggestion to say "stop using", but
> probably this should be more friendly. How about "please refactor such
> arrays ..."
> 
>> +and switch to `flexible arrays <#zero-length-and-one-element-arrays>`_
> 
> ... to a `flexible array member <#...
> 
>> +instead.
>> +
> 
>>  See array_size(), array3_size(), and struct_size(),
>>  for more details as well as the related check_add_overflow() and
>>  check_mul_overflow() family of functions.
>> @@ -200,3 +205,81 @@ All switch/case blocks must end in one of:
>>  * continue;
>>  * goto <label>;
>>  * return [expression];
>> +
>> +Zero-length and one-element arrays
>> +----------------------------------
>> +Old code in the kernel uses the zero-length and one-element array extensions
>> +to the C90 standard, but the `preferred mechanism to declare variable-length
> 
> I'd like to reword this to make an immediate statement about what _should_
> be done, and then move into the details on an as accurate as possible
> review of the history of these work-arounds. How about this, which I
> mixed some of your earlier paragraphs into:
> 
> 
> 
> There is a regular need in the kernel to provide a way to declare having
> a dynamically sized set of trailing elements in a structure. Kernel code
> should always use `"flexible array members" <https://en.wikipedia.org/wiki/Flexible_array_member>`_
> for these cases. The older style of one-element or zero-length arrays should
> no longer be used.
> 
> In older C code, dynamically sized trailing elements were done by specifying
> a one-element array at the end of a structure::
> 
>         struct something {
>                 int count;
>                 struct items[1];
>         };
> 
> This led to fragile size calculations via sizeof() (which would need to
> remove the size of the single trailing element to get a correct size of
> the "header"). A `GNU C extension <https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html>`_
> was introduced to allow for zero-length arrays, to avoid these kinds of
> size problems::
> 
>         struct something {
>                 int count;
>                 struct items[0];
>         };
> 
> But this led to other problems, and didn't solve some problems shared by
> both styles, like not being to able to detect when such an array is
> accidentally being used _not_ at the end of a structure (which could happen
> directly, or when such a struct was in unions, structs of structs, etc).
> 
> C99 introduced "flexible array members", which lacks a numeric size for
> the array declaration entirely::
> 
>         struct something {
>                 int count;
>                 struct items[];
>         };
> 
> This is the way the kernel expects dynamically sized trailing elements
> to be declared. It allows the compiler to generate errors when the
> flexible array does not occur last in the structure, which helps to prevent
> some kind of `undefined behavior
> <https://git.kernel.org/linus/76497732932f15e7323dc805e8ea8dc11bb587cf>`_
> bugs from being inadvertently introduced to the codebase. It also allows
> the compiler to correctly analyze array sizes (via sizeof(),
> `CONFIG_FORTIFY_SOURCE`, and `CONFIG_UBSAN_BOUNDS`). For instance,
> there is no mechanism that warns us that the following application of the
> sizeof() operator to a zero-length array always results in zero::
> 
>         struct something {
>                 int count;
>                 struct items[0];
>         };
> 
>         struct something *instance;
> 
>         instance = kmalloc(struct_size(instance, items, size), GFP_KERNEL);
>         instance->length = size;
>         memcpy(instance->items, source, size);
>         ...
>         size = sizeof(instance->items);
> 
> 
> [and then continue with the rest of the details you wrote below...]
> 
>> +
>> +At the last line of code above, ``size`` turns out to be zero --when one might have
>> +thought differently. Here are a couple examples of this issue: `link 1
>> +<https://git.kernel.org/linus/f2cd32a443da694ac4e28fbf4ac6f9d5cc63a539>`_,
>> +`link 2
>> +<https://git.kernel.org/linus/ab91c2a89f86be2898cee208d492816ec238b2cf>`_.
>> +On the other hand, `flexible array members have incomplete type, and so the sizeof()
>> +operator may not be applied <https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html>`_,
>> +so any  misuse of such  operator will be immediately noticed at build time.
>> +
>> +With respect to one-element arrays, one has to be acutely aware that `such arrays
>> +occupy at least as much space as a single object of the type
>> +<https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html>`_,
>> +hence they contribute to the size of the enclosing structure. This is prone
>> +to error every time people want to calculate the total size of dynamic memory
>> +to allocate for a structure containing an array of this kind as a member::
>> +
>> +        struct something {
>> +                int length;
>> +                char data[1];
>> +        };
> 
> And for all of these examples, I'd like to avoid using "char" as the type
> for the flex array member, since it doesn't drive home the idea of
> having a multiplier (i.e. "length" matches the size of "data") And
> similarly, "length" should, I think, be called "count". That way the
> bytes is separate from count, but is the result of sizeof(*items) *
> count.
> 
>> +
>> +        struct something *instance;
>> +
>> +        instance = kmalloc(struct_size(instance, data, size - 1), GFP_KERNEL);
>> +        instance->length = size;
>> +        memcpy(instance->data, source, size);
>> +
>> +In the example above, we had to remember to calculate ``size - 1`` when using
> 
> I don't want to get people confused between "size" (in bytes) vs "count"
> (of trailing elements).
> 

Yep. I'll change that to avoid confusion.

>> +the struct_size() helper, otherwise we would have --unintentionally-- allocated
>> +memory for one too many ``data`` objects. The cleanest and least error-prone way
>> +to implement this is through the use of a `flexible array member`, which is
>> +exemplified at the `beginning <#zero-length-and-one-element-arrays>`_ of this
>> +section.
>> -- 
>> 2.27.0
>>
> 
> How does that look?
> 

Got it. Working on the changes right now...

Thanks for the feedback!
--
Gustavo
