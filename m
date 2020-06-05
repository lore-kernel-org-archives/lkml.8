Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F42C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8029D2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591373799;
	bh=u4vNXlvIttpUyWdzC4Wb34JSjU+zkePyE/jsafOj3I4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Em+x8Gizx0k3huMJbQNoiT/EvpgeTzkZPnPeZVos4csgLbEHVeAyB55Bamx9Ctm5I
	 2GkX+aq9WY0f8mvagj4qkqxNG7BgAsM0Un9YsGJndo/k3c1G0cOPDeVZvJYxACVesM
	 jJnsIxeipxQc7kr5YPj6l1xsv4Y0AvxBfhWpBeoY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgFEQQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 12:16:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgFEQQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 12:16:38 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A5DE206DB;
        Fri,  5 Jun 2020 16:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591373797;
        bh=u4vNXlvIttpUyWdzC4Wb34JSjU+zkePyE/jsafOj3I4=;
        h=Date:From:To:Cc:Subject:From;
        b=GcLy723DEess98mUgahMXgm/bWTMAG5DXkxBb2W8MLL8ZO32t8JQq87sZm1O19YzR
         HLO33O5SuSkQaxCzDkKttk7oqvjwpfMRfLL6ciO7p0+B2WcvJOVrYglDUOzlLz2dHl
         sLzTBfLrgz2bmgF2mtxacnzMz0iYKsYTPhit6Kjg=
Date:   Fri, 5 Jun 2020 11:21:42 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2] docs: deprecated.rst: Add zero-length and one-element
 arrays
Message-ID: <20200605162142.GA1617@embeddedor>
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

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Adjust some markup links for readability.

 Documentation/process/deprecated.rst | 83 ++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
index 652e2aa02a66c..042c21c968e19 100644
--- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -85,6 +85,11 @@ Instead, use the helper::
 
 	header = kzalloc(struct_size(header, item, count), GFP_KERNEL);
 
+NOTE: If you are using struct_size() on a structure containing a zero-length
+or a one-element array as a trailing array member, stop using such arrays
+and switch to `flexible arrays <#zero-length-and-one-element-arrays>`_
+instead.
+
 See array_size(), array3_size(), and struct_size(),
 for more details as well as the related check_add_overflow() and
 check_mul_overflow() family of functions.
@@ -200,3 +205,81 @@ All switch/case blocks must end in one of:
 * continue;
 * goto <label>;
 * return [expression];
+
+Zero-length and one-element arrays
+----------------------------------
+Old code in the kernel uses the zero-length and one-element array extensions
+to the C90 standard, but the `preferred mechanism to declare variable-length
+types
+<https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html>`_
+such as these ones is a `flexible array member`, introduced in C99::
+
+        struct something {
+                int length;
+                char data[];
+        };
+
+        struct something *instance;
+
+        instance = kmalloc(struct_size(instance, data, size), GFP_KERNEL);
+        instance->length = size;
+        memcpy(instance->data, source, size);
+
+By making use of the mechanism above, we get a compiler error in case the
+flexible array does not occur last in the structure, which helps to prevent
+some kind of `undefined behavior
+<https://git.kernel.org/linus/76497732932f15e7323dc805e8ea8dc11bb587cf>`_
+bugs from being inadvertently introduced to the codebase.
+
+It is also important to notice that zero-length and one-element arrays pose
+confusion for things like sizeof() and `CONFIG_FORTIFY_SOURCE`. For instance,
+there is no mechanism that warns us that the following application of the
+sizeof() operator to a zero-length array always results in zero::
+
+        struct something {
+                int length;
+                char data[0];
+        };
+
+        struct something *instance;
+
+        instance = kmalloc(struct_size(instance, data, size), GFP_KERNEL);
+        instance->length = size;
+        memcpy(instance->data, source, size);
+        ...
+        size = sizeof(instance->data);
+
+At the last line of code above, ``size`` turns out to be zero --when one might have
+thought differently. Here are a couple examples of this issue: `link 1
+<https://git.kernel.org/linus/f2cd32a443da694ac4e28fbf4ac6f9d5cc63a539>`_,
+`link 2
+<https://git.kernel.org/linus/ab91c2a89f86be2898cee208d492816ec238b2cf>`_.
+On the other hand, `flexible array members have incomplete type, and so the sizeof()
+operator may not be applied <https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html>`_,
+so any  misuse of such  operator will be immediately noticed at build time.
+
+
+With respect to one-element arrays, one has to be acutely aware that `such arrays
+occupy at least as much space as a single object of the type
+<https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html>`_,
+hence they contribute to the size of the enclosing structure. This is prone
+to error every time people want to calculate the total size of dynamic memory
+to allocate for a structure containing an array of this kind as a member::
+
+        struct something {
+                int length;
+                char data[1];
+        };
+
+        struct something *instance;
+
+        instance = kmalloc(struct_size(instance, data, size - 1), GFP_KERNEL);
+        instance->length = size;
+        memcpy(instance->data, source, size);
+
+In the example above, we had to remember to calculate ``size - 1`` when using
+the struct_size() helper, otherwise we would have --unintentionally-- allocated
+memory for one too many ``data`` objects. The cleanest and least error-prone way
+to implement this is through the use of a `flexible array member`, which is
+exemplified at the `beginning <#zero-length-and-one-element-arrays>`_ of this
+section.
-- 
2.27.0

