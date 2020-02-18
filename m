Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7824BC3403F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 14:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E7F2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 14:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="iK2JeY/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgBRO7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 09:59:34 -0500
Received: from mout.gmx.net ([212.227.15.15]:40963 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbgBRO7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 09:59:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582037943;
        bh=UXlknQDro/udguwE6ObkTpdlZWy6WBrioO4tLb79DHI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iK2JeY/wV/WEgxv2SJoHPwLRCgHj3KNEp1VO75g19Sd6mL+nwzej2srDKQg6d9unA
         PXqpor9HOfJ747C/fSyRA9WPHqqQeXWtnk2hh8tLkYIlnzFllI4+H7xwzRlP8nMXFD
         KKARmafPSzSkZINeDDWy+XKnqSrxmaV70krsjGMc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.223]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeU0k-1jeEV90ZWu-00aXm7; Tue, 18
 Feb 2020 15:59:03 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] docs: x86: Drop reference to intel_mpx.rst
Date:   Tue, 18 Feb 2020 15:58:19 +0100
Message-Id: <20200218145819.17314-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218145819.17314-1-j.neuschaefer@gmx.net>
References: <20200218145819.17314-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Heby1t2ziQ+R8K30D3JtEa6VwwO3olhNFWYIKAthKjmTtJYUpac
 RMuAvNa9KYT9fO3URVAi7FdnrLXOTwYDxg1ev/iczmdl+PCUVdNNS+MS0RPK3nUcJXkCRiW
 IqNNci9OibQMg7YlesbH+lg179XclULJ4nwDVKeWAV/WV1oDjx1z5J6xmsFXNfHxbYG9P7V
 yRdabV20COrZgAxg1lxRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kwmDnSI3dz4=:/avBR9LRpc6y9NAX3NiAmq
 nbTZ9ALDISd3KzPlsFeq4tXXcRMRB8OaRnlt5iCREe/wDD0P4P91fXUBA9j/Zlvonf2EAeeJu
 GR87zaiYDiZOx1mRc6SpY2ywJ5WaALqMLBMFU68WFMVx2YA3KujYnQpdzlkqPhkU51QiTZlgf
 Kk8JG7ZfnN5EASBYfbOUugpopRvY1wzQqYd5Ni3UGNFhviDSt+tJuG2fOirD+oLB1G2zZs0CF
 hnOkz8unTS2LxA3de14SiCcDuRxcr14ZCPnb8hDcwY1cmY1pULLlDXoG1SJeC0X4q323+ba6D
 pSK9KyCm+RvtRxqd06zGd9T/xE83nJ48RSu8D6zC6pzqtDr6MeYfWIw2zDVYp/b2ayegY8SFv
 2oMJoMxChmCsbaCneZ9FMqTplXovO2VRsC0Yjfa3CGdrZ/T6J7xUnQRX7sMzuWmIxj/7pvAQs
 RdrhZnzcP2MgDxQnXvJKH7k90J0SQFFBzcUAW8JwHMd4RpXNc87/i5X+Oo+u9+wscCOcfl42U
 HfWaRr/bdKTI7ZsF+ulh2l7LhpJJUL+wtXIxvre9Eh5blL6nuQctf2KuPjiEiOi1A3+wOb5Nd
 lV2TkwByo+7ZYCCoG7ns/b0bo8jK7TUd2VL6sQgPv8CwGedB/+dzN0ULCVPYlevqGLA1nqmJ+
 jKGeZNVHCtGjR4ML8Tc4VlLMGPfwGndS3fhx4U/Hde18UtDI5nUUFkFQ16pes18zRN30Bpdb3
 TuDXg4KEkkKrzWE3sHamqDZiAv0qAweFQZbrVH8Zp6qyhufApfLWqPMcq12o821i29uQlU/4K
 aNxuTr0XSUnSPsphrnAn9BorMeFAoO5lK40+3ulqr5EuqZE0PuDpBzPUl93n43vvHDaiyg4jv
 rOdvGulNMtffXd2G3pYrzl8Hr+dYThTGhSUGQEN37MOsItPXQib9vD5/54dMznYbsOZQrraRq
 oUXT8MHit8Ur0+Ct0//echRqMLlGUh50vB/kWEGiVFvGA87C8ERdJ8mXGjKXv2XXdysIbNKtp
 VUc4WrKE1QhMujBdVwZyxZBw25LU34rVcwTeV75cW9/QeuSQvOv+oCGYOqreAB8eH9rIzfR9V
 H1YNA76/V8ZMOi34BKOtSSrNSgj+7bF2aI5cejHmsysNCvIOeuLWAMzPZrwK5hhAbKLoVVJhI
 dm/DAZezmBpdr0SX9IqWvITq8LgKal+OYrcZGQnpHSqJaY2h7tR9XXB8dHSiViBms+kmnwLo5
 jZZEoCVzxFo5QT7/E
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel MPX support and its documentation have been removed from the
kernel.

Fixes: 45fc24e89b7c ("x86/mpx: remove MPX from arch/x86")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/x86/index.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index a8de2fbc1caa..265d9e9a093b 100644
=2D-- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -19,7 +19,6 @@ x86-specific Documentation
    tlb
    mtrr
    pat
-   intel_mpx
    intel-iommu
    intel_txt
    amd-memory-encryption
=2D-
2.20.1

