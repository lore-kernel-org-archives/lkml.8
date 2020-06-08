Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E0FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 21:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2423720760
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 21:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591651924;
	bh=iGJ/S85SGw3PjfMmtAFIqmA+qqnezwwkvYQUyMOy1Sw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=GLwATxGSKEyYxZ4piGVdyBdcfFNWrCDuA6LZBHGhVg66YNg2UfoWDvGX1t36ijkQF
	 PmXQ1BcYkWdQENldC3FgxveQediosSuKE2q/Dok6q1wGg9QgCimtUA07oEPpgAnXdn
	 M2tq8S2FNtENPaUnC9RvIIQY6TNJDEFkAG+8OPWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgFHVcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 17:32:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:44680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbgFHVcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 17:32:02 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6C91206D5;
        Mon,  8 Jun 2020 21:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591651921;
        bh=iGJ/S85SGw3PjfMmtAFIqmA+qqnezwwkvYQUyMOy1Sw=;
        h=Date:From:To:Cc:Subject:From;
        b=1AnJXR2EkjQSi8iIsA5aD0FJDk7uxo3n2xHI5pkz2MWUT8buGdP02LiZv/+1csY3q
         4oqdq6NhOiCiRzM8qBg2jzbG7KRDPmZYjCrgT3SemeqUSuqleF3IU+wUitrEvnQVPc
         ljMS7xhdGhK912rvW8x/vDpXWGWY8O9DZIVBEC/M=
Date:   Mon, 8 Jun 2020 16:37:11 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v3] docs: deprecated.rst: Add zero-length and one-element
 arrays
Message-ID: <20200608213711.GA22271@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add zero-length and one-element arrays to the list.

While I continue replacing zero-length and one-element arrays with
flexible-array members, I need a reference to point people to, so
they don't introduce more instances of such arrays. And while here,
add a note to the "open-coded arithmetic in allocator arguments"
section, on the use of struct_size() and the arrays-to-deprecate
mentioned here.

Co-developed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v3:
 - Add changes written by Kees.
 - Add Co-developed-by tag to include Kees in the changelog text.

Changes in v2:
 - Adjust some markup links for readability.

 Documentation/process/deprecated.rst | 118 +++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
index 652e2aa02a66c..bd4c92244de31 100644
--- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -85,6 +85,11 @@ Instead, use the helper::
 
 	header = kzalloc(struct_size(header, item, count), GFP_KERNEL);
 
+.. note:: If you are using struct_size() on a structure containing a zero-length
+        or a one-element array as a trailing array member, please refactor such
+        array usage and switch to a `flexible array member
+        <#zero-length-and-one-element-arrays>`_ instead.
+
 See array_size(), array3_size(), and struct_size(),
 for more details as well as the related check_add_overflow() and
 check_mul_overflow() family of functions.
@@ -200,3 +205,116 @@ All switch/case blocks must end in one of:
 * continue;
 * goto <label>;
 * return [expression];
+
+Zero-length and one-element arrays
+----------------------------------
+There is a regular need in the kernel to provide a way to declare having
+a dynamically sized set of trailing elements in a structure. Kernel code
+should always use `"flexible array members" <https://en.wikipedia.org/wiki/Flexible_array_member>`_
+for these cases. The older style of one-element or zero-length arrays should
+no longer be used.
+
+In older C code, dynamically sized trailing elements were done by specifying
+a one-element array at the end of a structure::
+
+        struct something {
+                size_t count;
+                struct foo items[1];
+        };
+
+This led to fragile size calculations via sizeof() (which would need to
+remove the size of the single trailing element to get a correct size of
+the "header"). A `GNU C extension <https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html>`_
+was introduced to allow for zero-length arrays, to avoid these kinds of
+size problems::
+
+        struct something {
+                size_t count;
+                struct foo items[0];
+        };
+
+But this led to other problems, and didn't solve some problems shared by
+both styles, like not being able to detect when such an array is accidentally
+being used _not_ at the end of a structure (which could happen directly, or
+when such a struct was in unions, structs of structs, etc).
+
+C99 introduced "flexible array members", which lacks a numeric size for
+the array declaration entirely::
+
+        struct something {
+                size_t count;
+                struct foo items[];
+        };
+
+This is the way the kernel expects dynamically sized trailing elements
+to be declared. It allows the compiler to generate errors when the
+flexible array does not occur last in the structure, which helps to prevent
+some kind of `undefined behavior
+<https://git.kernel.org/linus/76497732932f15e7323dc805e8ea8dc11bb587cf>`_
+bugs from being inadvertently introduced to the codebase. It also allows
+the compiler to correctly analyze array sizes (via sizeof(),
+`CONFIG_FORTIFY_SOURCE`, and `CONFIG_UBSAN_BOUNDS`). For instance,
+there is no mechanism that warns us that the following application of the
+sizeof() operator to a zero-length array always results in zero::
+
+        struct something {
+                size_t count;
+                struct foo items[0];
+        };
+
+        struct something *instance;
+
+        instance = kmalloc(struct_size(instance, items, count), GFP_KERNEL);
+        instance->count = count;
+
+        size = sizeof(instance->items) * instance->count;
+        memcpy(instance->items, source, size);
+
+At the last line of code above, ``size`` turns out to be ``zero``, when one might
+have thought it represents the total size in bytes of the dynamic memory recently
+allocated for the trailing array ``items``. Here are a couple examples of this
+issue: `link 1
+<https://git.kernel.org/linus/f2cd32a443da694ac4e28fbf4ac6f9d5cc63a539>`_,
+`link 2
+<https://git.kernel.org/linus/ab91c2a89f86be2898cee208d492816ec238b2cf>`_.
+Instead, `flexible array members have incomplete type, and so the sizeof()
+operator may not be applied <https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html>`_,
+so any misuse of such operators will be immediately noticed at build time.
+
+With respect to one-element arrays, one has to be acutely aware that `such arrays
+occupy at least as much space as a single object of the type
+<https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html>`_,
+hence they contribute to the size of the enclosing structure. This is prone
+to error every time people want to calculate the total size of dynamic memory
+to allocate for a structure containing an array of this kind as a member::
+
+        struct something {
+                size_t count;
+                struct foo items[1];
+        };
+
+        struct something *instance;
+
+        instance = kmalloc(struct_size(instance, items, count - 1), GFP_KERNEL);
+        instance->count = count;
+
+        size = sizeof(instance->items) * instance->count;
+        memcpy(instance->items, source, size);
+
+In the example above, we had to remember to calculate ``count - 1`` when using
+the struct_size() helper, otherwise we would have --unintentionally-- allocated
+memory for one too many ``items`` objects. The cleanest and least error-prone way
+to implement this is through the use of a `flexible array member`::
+
+        struct something {
+                size_t count;
+                struct foo items[];
+        };
+
+        struct something *instance;
+
+        instance = kmalloc(struct_size(instance, items, count), GFP_KERNEL);
+        instance->count = count;
+
+        size = sizeof(instance->items[0]) * instance->count;
+        memcpy(instance->items, source, size);
-- 
2.27.0

