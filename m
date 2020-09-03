Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B55BC43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 00:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CE1D204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 00:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="VYcYe5cZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgICA6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 20:58:44 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:34392 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbgICA6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 20:58:42 -0400
Date:   Thu, 03 Sep 2020 00:58:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1599094717;
        bh=sxkfd9M+J+VnTvKc2zZAdsjPkj714FI/Gz/2E9nJ6sE=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=VYcYe5cZA2QLJ09KxWIwaXY92qd/0Zsq1e9zVY8O3u/PF4jh9sWIZbCLPYenV7PbW
         L9ZafTa14VNRYsbrCJ9CZrNEry6pk+tjclg5439qPYN/uHXTPLgwg+iUHMhdQ0AMzW
         A1SNe3p8SvQog0d4e/Cmbi0meK4tHiXn5taUn+CI=
To:     Jonathan Corbet <corbet@lwn.net>
From:   =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@protonmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
Reply-To: =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
          <nfraprado@protonmail.com>
Subject: [PATCH 2/2] kernel-doc: Update "cross-referencing from rST" section to use automarkup
Message-ID: <20200903005747.3900333-3-nfraprado@protonmail.com>
In-Reply-To: <20200903005747.3900333-1-nfraprado@protonmail.com>
References: <20200903005747.3900333-1-nfraprado@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update text and examples in the "Cross-referencing from
reStructuredText" section to reflect that no additional syntax is needed
anymore.

Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@protonmail.com>
---
 Documentation/doc-guide/kernel-doc.rst | 33 +++++++++++++-------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-gui=
de/kernel-doc.rst
index fff6604631ea..4fd86c21397b 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -387,22 +387,23 @@ Domain`_ references.
 Cross-referencing from reStructuredText
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
=20
-To cross-reference the functions and types defined in the kernel-doc comme=
nts
-from reStructuredText documents, please use the `Sphinx C Domain`_
-references. For example::
-
-  See function :c:func:`foo` and struct/union/enum/typedef :c:type:`bar`.
-
-While the type reference works with just the type name, without the
-struct/union/enum/typedef part in front, you may want to use::
-
-  See :c:type:`struct foo <foo>`.
-  See :c:type:`union bar <bar>`.
-  See :c:type:`enum baz <baz>`.
-  See :c:type:`typedef meh <meh>`.
-
-This will produce prettier links, and is in line with how kernel-doc does =
the
-cross-references.
+No additional syntax is needed to cross-reference the functions and types
+defined in the kernel-doc comments from reStructuredText documents.
+Just end function names with ``()`` and write ``struct``, ``union``, ``enu=
m``
+or ``typedef`` before types.
+For example::
+
+  See foo().
+  See struct foo.
+  See union bar.
+  See enum baz.
+  See typedef meh.
+
+However, if you want custom text in the cross-reference link, that can be =
done
+through the following syntax::
+
+  See :c:func:`my custom link text for function foo <foo>`.
+  See :c:type:`my custom link text for struct bar <bar>`.
=20
 For further details, please refer to the `Sphinx C Domain`_ documentation.
=20
--=20
2.28.0


