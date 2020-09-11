Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9946BC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBE77206CA
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="uE0t+iaG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgIKQGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:06:07 -0400
Received: from mail-41103.protonmail.ch ([185.70.41.103]:19890 "EHLO
        mail-41103.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgIKQDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 12:03:50 -0400
Received: from mail-03.mail-europe.com (mail-03.mail-europe.com [91.134.188.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41103.protonmail.ch (Postfix) with ESMTPS id 3D145200BEBF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 13:36:43 +0000 (UTC)
Authentication-Results: mail-41103.protonmail.ch;
        dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="uE0t+iaG"
Date:   Fri, 11 Sep 2020 13:34:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1599831274;
        bh=i1YSY0XyxQ3SaC8ZJ4PtKWoRmK1OW12T7faRuAJSgLY=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=uE0t+iaGURnDMbw/jWB2/rKtG+/t5YOF50uKPjidH1p8qUskaIDjCqT8+5nFqhqtb
         GCrkrjGxKH+/W80ODPbrO7Lc89E6eWtHknGyZvx2eYmCzaibIiMC0gt9ol14Y1uT7/
         CzUBAu/y3JcvuYwLO1F/h8MY0d9u+rKIZqFIc6PA=
To:     Jonathan Corbet <corbet@lwn.net>
From:   =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@protonmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
Reply-To: =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
          <nfraprado@protonmail.com>
Subject: [PATCH 0/3] docs: Add automatic cross-reference for documentation pages
Message-ID: <20200911133339.327721-1-nfraprado@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cross-referencing from a documentation page to another can be done using th=
e
:doc:`doc-file` directive from Sphinx.
This however introduces markup that could be avoided to increase readabilit=
y in
plain text.
This patch series adds automatic markup for cross-referencing between
documentation pages.

This patch series depends on [1].

The first patch refactors the automarkup script to split regex matching and
iteration into one function and text markup substitution into another.
This enables each regex to have its own function that substitutes its match=
es'
text for the appropriate markup and is necessary for the automatic markup o=
f
documentation pages since it requires slightly different logic from marking=
 up
C references.

The second patch adds automatic markup for cross-referencing documentation
pages by adding an appropriate regex and function to do the markup.
This enables a text like "See Documentation/doc-guide/sphinx.rst." to be
substituted by a cross-reference to that document without any additional ma=
rkup.
Since this automarkup doesn't work with relative paths (they always need to
start at Documentation/), it will almost always require more typing than th=
e
equivalent :doc:`sphinx`, but it's purpose is to avoid the markup, making i=
t
more readable in plain text.
The .rst extension was left as optional in the regex matching, even though =
it
only makes sense for .rst documents, because I thought not specifying the
extension, like "See Documentation/doc-guide/sphinx." also made sense as a
cross-reference.

The third patch adds a section about cross-referencing in the "Writing
Documentation" chapter since there was none (other than the one regarding
kernel-doc).
The section describes how to use the new automatic cross-referencing for
documentation pages, and also how to use the already in place Sphinx doc
directive.
It also points to the kernel-doc document for information on cross-referenc=
ing
kernel-doc functions and types (using the new automarkup, so it also serves=
 as a
testcase for it).

Thanks,
N=C3=ADcolas

[1]: https://lore.kernel.org/linux-doc/20200903005747.3900333-1-nfraprado@p=
rotonmail.com/

N=C3=ADcolas F. R. A. Prado (3):
  docs: Allow multiple automarkup functions
  docs: Add automatic cross-reference for documentation pages
  docs: Document cross-referencing between documentation pages

 Documentation/doc-guide/sphinx.rst |  17 ++++
 Documentation/sphinx/automarkup.py | 134 ++++++++++++++++++++---------
 2 files changed, 109 insertions(+), 42 deletions(-)

--=20
2.28.0


