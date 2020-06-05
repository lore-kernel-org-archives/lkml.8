Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA7CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 03:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 099F620738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 03:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bA+S4VqQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgFEDEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 23:04:20 -0400
Received: from mout.gmx.net ([212.227.15.15]:34103 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgFEDET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 23:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591326251;
        bh=mpINj1KwByMO1KKdJlJWvUCeORzynM/wkwVpAy35eLs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=bA+S4VqQyF6mNzBW0YJXISEUnOIxkhwh3vM8LKMl/YMG+UUnGornrcoFzu4lCAzz8
         S9xnfmmCg2EbtH0JsQ4UGfO0Fac/OyzX7L0YvrwZAPapAbmHFWfDreYl49tW6urlRt
         AfPVCBmgYUP4zM1D3klz2cWkO45ZqTM+K0D15Yjo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from LT02.fritz.box ([88.152.145.75]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M72oH-1jbnrI0NaB-008dDL; Fri, 05
 Jun 2020 05:04:11 +0200
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Jonathan Corbet <corbet@lwn.net>, cocci@systeme.lip6.fr,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] docs: dev-tools: coccinelle: underlines
Date:   Fri,  5 Jun 2020 05:04:05 +0200
Message-Id: <20200605030405.6479-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3s5T/IQAmPGdmmYoPPG2S6A5XKsqSFM9bCF4a56hyILj+j8BqJS
 2Y3ctYhXEEt5igjR37mJJGoO0+c8Cih/Nht790x9PLsOx+iKsp45l7qLv1CdO2xT/Rw1PwT
 E71x2sv8e2aKqkGFDc8Uj4nZ9Xz2x5WL7GyNM+pB2e4hA/HLes6NymiHiu1FZZby/DHIZ4m
 v2Y2eF6vE5dWmVrurTvpw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hue4DUo+I+o=:7EVRn8VLxVI1G2RxIaVtsL
 caBxYP4LqlINeokpHjvu6/efpn6CbLBWQgskGfQAv6lqLZDZZUQOMiLGowZHZaWfBza5UwgjN
 fFfCGOInMKe+I82EV1KVtmaTDBl2NER+dvDD0iXdutZKvysmRVpF+6AS4WG8BD18F4W8GIF4J
 hHFF3UtFMSp1C8JCd6aLI0FFBUR9t9i3UE6I1qnTDEN5JcfPFuaIPPhK4C3A+yA0JLR7Oisx/
 gIx0EmwoInhd7zcvGPRp3P0/jUrIkHttxa3s7gH1IBqzsKLVbILohg8LfFrkQv0JSvCA06TP4
 ZEP5s+MdQxEa/X9/vjg+/rn9P2BPKW8SmLCKwO06oZA5jOsHZM4XvP4zYsTHjPlKkJhBkFgAW
 hGkZGBSXCkqPYlOzByd7XShxKCNyMSb/q2e823mGTip3su9/UKI+KzkxXFTIi7Y0paXWZ/fQD
 v1IxMOnm1VZmbG5Z2YUZe0l1ick57/AiZuXiDAiwSKMLHfI07unajIZoWXIkMPd4hq/LJlAQO
 RMMxA8jm8cAS6Tl+Ne1OFiiHceQ+jToZZ4dmtd0Gnafv4vqx3EVEfCnY+wOlXnSCBlkotif8l
 SzIJ4SBHzMc12MoI29SQtzHjTEf3N7xNrFjUN1ISmycY8mVxLE4PqzNU+Rm3RQGmPnuuZS3uM
 C176H/Bb8G+oSJ11xjsALLxxUbUgEG98j+x7S/XcDpXrMxJ1kKHzu6d9r2Zg2XEgijliz70Eh
 eUM2opu8wAfEXaTzsTsAgxtnyP1rYm3U+aZLyDat65RDVnv/pt79gC0XFtD58Ptmcyrfb1kIh
 pavHjJ8tQR5ava0Cg/P8wERkjn9KVg2ESMU1a0mDG+Z3GGQF99PXaQOWSlT2ncoh5smC9nN1L
 jJXuQ7caqjlwJZavCFGOzeOSZMWq+FS+uowqBWGuktLtI66R+jk3ZSGJSIijnmu2iFqc9n+eR
 fhAh0nC8MD1bfC2dRWTiqSjV5dQLehdDgifr+umYl6R4lHIq46sE80gcIoS4L+Gb4CsesxUy9
 0rHtv7hxlOElPrHfIbZkKl9JxbioMQ2gkvFwr+iYzDu/g+s3oX12hNO2VaC/S05s4Kvp+CpKV
 ydW1yzxoE7VKYht8koap9dgxx71up/8f0Jk0xFg/jAoFwXwts33JQa76UKmTCbLOwqx/Q9PZJ
 2HcncrKIZK1GaJ2ZKBQs0rU3h2sPZ0VraL/q92i2lfB3YcL0dd0qBxiAGwgq0j8799nAlMEF9
 gzFq2nNVqQxj/+F0X
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Underline lengths should match the lengths of headings to avoid build
warnings with Sphinx.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 Documentation/dev-tools/coccinelle.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-to=
ols/coccinelle.rst
index 00a3409b0c28..70274c3f5f5a 100644
=2D-- a/Documentation/dev-tools/coccinelle.rst
+++ b/Documentation/dev-tools/coccinelle.rst
@@ -14,7 +14,7 @@ many uses in kernel development, including the applicati=
on of complex,
 tree-wide patches and detection of problematic programming patterns.

 Getting Coccinelle
=2D-------------------
+------------------

 The semantic patches included in the kernel use features and options
 which are provided by Coccinelle version 1.0.0-rc11 and above.
@@ -56,7 +56,7 @@ found at:
 https://github.com/coccinelle/coccinelle/blob/master/install.txt

 Supplemental documentation
=2D---------------------------
+--------------------------

 For supplemental documentation refer to the wiki:

@@ -128,7 +128,7 @@ To enable verbose messages set the V=3D variable, for =
example::
    make coccicheck MODE=3Dreport V=3D1

 Coccinelle parallelization
=2D---------------------------
+--------------------------

 By default, coccicheck tries to run as parallel as possible. To change
 the parallelism, set the J=3D variable. For example, to run across 4 CPUs=
::
@@ -333,7 +333,7 @@ as an example if requiring at least Coccinelle >=3D 1.=
0.5::
 	// Requires: 1.0.5

 Proposing new semantic patches
=2D-------------------------------
+------------------------------

 New semantic patches can be proposed and submitted by kernel
 developers. For sake of clarity, they should be organized in the
=2D-
2.26.2

