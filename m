Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57394C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 01:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3033820720
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 01:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Ttq3IBsM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgHUBJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 21:09:13 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:54152 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgHUBJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 21:09:09 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 799AB891B1;
        Fri, 21 Aug 2020 13:09:05 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1597972145;
        bh=rsUODlvA0YOXJkjz4/tP8gjm9p6+UFGO3jk1qm8nCmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Ttq3IBsMgSZzfuQfbwOf2K9oOxjDBKA9Q6zYWBEfJoCNb4XZwW0XdXiLjEuduIVbQ
         ltKI427JOeY3q4eUAZsTDL7rFaKlMhHp/pqX4j8wWyPvAMngXD/9HyXN3qEq1jtuey
         UZvoY8l1c0kJCs92pZygGbUDvveMUmbVbCelsj5J4Br5HTrJ/NGpj2nkaEuiwnFrdz
         f38X+6ewJfM5oaDW6CxG8k5y4mAaLj4fz6hxrZFGZ4I5fSA0GVlEZdeaCyafhn9MjJ
         qHdrDXIloCijGWH4RZYDuylLXVsxBKIWZTtAvTM9fxVKMZJmUqWdocmmULY6S3tWmr
         OQ6n9CWl/H3rA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f3f1eb10001>; Fri, 21 Aug 2020 13:09:05 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 473D513ED33;
        Fri, 21 Aug 2020 13:09:04 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 62884283B16; Fri, 21 Aug 2020 13:09:05 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH 1/2] docs: deprecated.rst: Remove stray ()
Date:   Fri, 21 Aug 2020 13:08:59 +1200
Message-Id: <20200821010900.6362-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821010900.6362-1-chris.packham@alliedtelesis.co.nz>
References: <20200821010900.6362-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A reference to strncpy() had an extra (), remove it.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 Documentation/process/deprecated.rst                    | 2 +-
 Documentation/translations/it_IT/process/deprecated.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/deprecated.rst b/Documentation/process=
/deprecated.rst
index 4a9aa4f0681e..918e32d76fc4 100644
--- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -142,7 +142,7 @@ only NUL-terminated strings. The safe replacement is =
strscpy().
 (Users of strscpy() still needing NUL-padding should instead
 use strscpy_pad().)
=20
-If a caller is using non-NUL-terminated strings, strncpy()() can
+If a caller is using non-NUL-terminated strings, strncpy() can
 still be used, but destinations should be marked with the `__nonstring
 <https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html>`_
 attribute to avoid future compiler warnings.
diff --git a/Documentation/translations/it_IT/process/deprecated.rst b/Do=
cumentation/translations/it_IT/process/deprecated.rst
index e108eaf82cf6..a642ff3fdc8b 100644
--- a/Documentation/translations/it_IT/process/deprecated.rst
+++ b/Documentation/translations/it_IT/process/deprecated.rst
@@ -130,7 +130,7 @@ chi usa solo stringe terminate. La versione sicura da=
 usare =C3=A8
 strscpy(). (chi usa strscpy() e necessita di estendere la
 terminazione con NUL deve aggiungere una chiamata a memset())
=20
-Se il chiamate no usa stringhe terminate con NUL, allore strncpy()()
+Se il chiamate no usa stringhe terminate con NUL, allore strncpy()
 pu=C3=B2 continuare ad essere usata, ma i buffer di destinazione devono =
essere
 marchiati con l'attributo `__nonstring <https://gcc.gnu.org/onlinedocs/g=
cc/Common-Variable-Attributes.html>`_
 per evitare avvisi durante la compilazione.
--=20
2.28.0

