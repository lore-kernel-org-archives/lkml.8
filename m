Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154BFC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C86FA2075A
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="cwOhTSGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgIJQZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 12:25:05 -0400
Received: from mout.gmx.net ([212.227.17.21]:48765 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgIJQVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599754831;
        bh=NbW0cwlVTptfiRCTVkmRdPqGiB8hKc7GXoxgdPOoYcE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=cwOhTSGavDrdH3L+s9heE7IXMtrHkarayM8P9VN+ttl1dlpXh7kpzgLz4TNuUjj4y
         DGi6CkJnQ44wjzssi4VfNPylu3RBTgB/SB51Vpe6SXjtW8/iaZffo4DB3IeVn+DmUF
         7t20qGGtlZMfYGgHyX7xhQH7ltdMv8LEZKdyqBj4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from LT02.fritz.box ([178.202.41.107]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MuDXp-1kXGR13oGz-00ucxq; Thu, 10
 Sep 2020 18:20:31 +0200
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Grant Likely <grant.likely@arm.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] of: properties of reserved-memory nodes
Date:   Thu, 10 Sep 2020 18:20:20 +0200
Message-Id: <20200910162020.3927-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DOgYbhvSJCp25Kh7HDVu9hQRp552LHwiNou/oQcYVi3lJGfF+Qm
 27rJ0h5ayaBP+Be6QK7+Mp2ghPs+lLsgeg1qnm6Mbz3nxLCug0ak6hk8viG+K+d1j1VdhAN
 IY1VIgLHnOtKUFVjYKgo8ZNkAKmhcck5Hx+TlFhD2fFh91qSc+m/rmjrTpwU1rikcdqvaqH
 3ZSlufLo9rP/Zl24Gid5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FNKs8fnwmMk=:hKfF1w90R6Kr6H4LGRMYjZ
 ZQQGhzeeystWBgjOeVRiU/ZP1H0gZREYohf493dErswDUXAhI2fcMvyB2zcHWCq3+3qxSD6Ds
 knVQJe6HDHeaBhrQhI5KhIC8MNHsHykB8zEa631GzJj7Mire2vhCCNfgbeTFkbcY/fDd8Nj/c
 qWzH9lrjNqcIuUgBI6jfXOrkg4qM3cnoxCBqQwp6YJS5u5NbMYRuG/gbBtQteg063hpCinW4a
 PcBhggAC8+aZOSJ9gXEtaQYLa7Wz8DP7w5VgEemZGMTG+5OJgc32D0mNGiKykBlTQiankw7NY
 b3a7FjKsADtEzshVFOyHNL+SB3Egz8gscgKYgCuU8JykfRHCTAqJte94Smt3J0pbvOl/nCVyV
 VpEW8y5SbirHSCySD1KcK9MiZ6eAluZLzzvQoSd1Cp5MbImyKYleXyWyCzMXys8NT8CD9YfSW
 7cbL6LM4/2h7YLG7RP7kj9UVE+Wy9vY5Gvbg9YKP6Qn9a1CcUkkUZT7RfmlBOHiCQ/zEscb1S
 /tUtJvlgO+KV0vOTo6nxSHB77G6qXXrlBAdYcBqoo/fJu9WOeHaTZS9MTgSBGZ2lsKcztMym6
 zWxvHBck0Kis3HM1iJOOU/f1Z1HrYKP2c3nT6mBjjGSYUrOYIZd+P9o9ZUITeK+hI88dZfcZ2
 ZFBZQJMZE5yXCDqqBFw9qm4fOH0abCxJBV/yL806jJu0wIXXjCqV26K9FUan2yBeXe1nF67m2
 A+mACEHZDBWhqT1E63dYq3TXVl2sl93gWNtH8Z4QpfmmHn+9yqa5wcw59Y6BllXv0xsyC+dLe
 ylj0TGfDp7SOnPG6LOe2AfxO88/hONeonGDo6URpeTb1qbuXx5KdqzKSgEUYSqRRaDOlqmWyY
 Fvsuo+yqfNSWBU/MCRPfMdCpAgxkZMBIKdBNhgixGItiYs7Kl7PzgrcBI4JgWI35CVPMA41QI
 AwrJSbDmDIu9BKrP/cCS8ho23Zueab4Dk6Yh0XZgrTKpM7GMuSOqnJ4ILzrYunC9w2FNFqgL0
 rkzFXGV//pvJCq967qxXeX7m6B9r+JZzdL/OzxyOpOBOo6viR9DVMFio2m8pAYyAI6AB5FyNw
 WDbttHmsVgM6z/32UxdPNBG9AeztXxMioAUW1R0XmNqmtyS5d05rCWBPxjiSrObmEzWKgzmri
 URI8BbvFJgpo4kziEIr5F+AHnn9EjGSk9PwpB1SeMa7bpL9o8WrB9ScTzHxf2jX7ucj2rhFL3
 QJEF47nlpbtjnmem3StIB/z851dpzNep0em1kgQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reusable and the no-map property are mutually exclusive.
Clarify this in the documentation.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 .../devicetree/bindings/reserved-memory/reserved-memory.txt    | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-me=
mory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memo=
ry.txt
index bac4afa3b197..eb987203548f 100644
=2D-- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.=
txt
+++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.tx=
t
@@ -64,6 +64,9 @@ reusable (optional) - empty property
       system can use that region to store volatile or cached data that
       can be otherwise regenerated or migrated elsewhere.

+A node must not carry both the no-map and the reusable property as these =
are
+logically contradictory.
+
 Linux implementation note:
 - If a "linux,cma-default" property is present, then Linux will use the
   region for the default pool of the contiguous memory allocator.
=2D-
2.28.0

