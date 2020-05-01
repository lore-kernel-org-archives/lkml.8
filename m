Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2F1C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F95C20857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="aAgYhZE/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbgEAPv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 11:51:56 -0400
Received: from mout.gmx.net ([212.227.15.19]:42903 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728495AbgEAPvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588348311;
        bh=Wz8oCljjf+pGcIWMlf9OE38JXdnBDknY5RaRZdi4y3M=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=aAgYhZE/u8eCnWJu13ATjbpppodgnZ+/Z3F4Q0sh0SKym7hVKig8aErdWKx2mGJ7r
         y9KiuDU+vv6yeULkseT/EG1os/wcfIOoeqatAlCWW0bbTtiaCCPRHNkgH61cLe33Xt
         joskGnjnbNM0V0FS8VNvnozVfZ2sfeB/BxLZDuw4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MKbkM-1jimWA30l2-00Kz05; Fri, 01 May 2020 17:51:50 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>, Richard Yeh <rcy@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Simon Que <sque@chromium.org>,
        John Joseph <jnjoseph@google.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Oscar Carter <oscar.carter@gmx.com>
Subject: [PATCH] staging: gasket: Check the return value of gasket_get_bar_index()
Date:   Fri,  1 May 2020 17:51:18 +0200
Message-Id: <20200501155118.13380-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PsVbLqj2wDQXQ4FP2WgMRm537F1O/5A8A6KmP7hLmsmwUIi4XSL
 BRVl9Zl9T/K4QhTVHcSHdte4gUOszm2Iw6wxWU8DNJet3QDFDE7hH/kP7icksifqTWUbzUD
 uwkY47MjR3JyZKbm+yi8UGlLUA+vi+gOloDKzYeaVyLBNecrGMouFK5w48+yEFSA+vFKOQ5
 iyfNxmGpZemueyxJ0PQaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HtdhmCohi4s=:c+sgk2e0yTPS4N8MCQ4s/o
 CjXhDYuRTkDhQZJ0ucJKHdcsN4Drm8A+4ebGEQaroZ26W6gR3T0JCERmrPSwr2mT6oTKx+HYt
 5yvAHqEXAFyAg6lROIQ+a3T5vbhR6vTksdGp+fu+Ruqbh9QUbWA2tRPi93pEscv9YJhPZdKif
 dThgXqUl2hwu9MtiM9ycgFL3Cb+ziaQJox/qLh20QLpvlWZ2LjkVATFh9N2w9WavqpZlmWaZe
 4coogMWQiTFpoCkKr7iS+KM7jdEv5SrS6u3CgB/vZklNWwIHIGKIVInYBxEskkWWaVN9oRVl1
 lBhZwRf7TKKw4ZCWmNxj+hRjW4IAFxnPsbjBwwXOx90I8PZKe9oduuonqJYVoqRp2p1gPg7/J
 YK0QF/8Y5QqewoFNOFfUETwbbeqF+JxzKUmlg4xkpHxDUbiWmdwZt1mhfNRK4yuBTe/mPvJJz
 9Vs+A6rgpBjahR/DqEy07qz8+6mN/uiSVw/NhlFhoS03ETQB577MgiFHnHYYq5OWWvhCHOVA+
 U8/y8ZInRZ+RouyA0+9g1zXuIkXBP6Xikj1pIMy5TbnJGFU+v5+R5Gi/QUQZMhb51Gxy63Il2
 dhVewivWbVrtPcZxCE3T+Pxsjgs4kqrgpoyCLnEKp9DnGL3d9qKnfZgXwO6L/NMQiqkgnd6GE
 uTZa2y7qsHr0Pu0zVPEUFn/lilp18zTQQvYzsdMJsMEj/dVoY3BFFXwO+3KGor+uQlBCOxZpX
 cT9loL9HmW8VHTWLZ+jcRStYxFvsNiBfcX5wTMvC6rUTQMB1lKMua9ud9xxJ2Z9dhUNxqu9dM
 D1wL96n/R00OAVKwIUz3gQXcv14L8CBcftYQX/7cvndjZ3gqXOqQ8Gixqh98JR416BNBf4ih3
 bQ5PvywclY3fLxv+AuCj9v+39mCk9fz4CS6T/rw3q17feNqUHUq49phIlzl3Iz9Tcc8266TIT
 T/KQq0Ikn5JfRaRreJaQW5oeXldiTyPUs5HqO/YLfvmFW/zbR7frqJ3X4jkKLhbyEToEG53gF
 rb7kQBtypv08oo87j9UNuGrUG6jXMS7zoVMml1cl2BMBkn0LyAFjcLb3ktLNAIWTQpjfydN+4
 FLTImjYPXsfay52GiHXTfbBt7GvnJByG9xKGY/HuKeifl9fgw4FWmwVzJyrUkqVrdVBXwJMaA
 b56YpU1avPWSyusYLzWmxy26fgiiFIiCQkxWG9Vmhu/TRwsgPicsExBJPi/gs/05qKwloZNBo
 qcRye2FBqYWemqsRr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check the return value of gasket_get_bar_index function as it can return
a negative one (-EINVAL). If this happens, a negative index is used in
the "gasket_dev->bar_data" array.

Addresses-Coverity-ID: 1438542 ("Negative array index read")
Fixes: 9a69f5087ccc2 ("drivers/staging: Gasket driver framework + Apex dri=
ver")
Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/staging/gasket/gasket_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket=
/gasket_core.c
index 8e0575fcb4c8..67325fbaf760 100644
=2D-- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -925,6 +925,10 @@ do_map_region(const struct gasket_dev *gasket_dev, st=
ruct vm_area_struct *vma,
 		gasket_get_bar_index(gasket_dev,
 				     (vma->vm_pgoff << PAGE_SHIFT) +
 				     driver_desc->legacy_mmap_address_offset);
+
+	if (bar_index < 0)
+		return DO_MAP_REGION_INVALID;
+
 	phys_base =3D gasket_dev->bar_data[bar_index].phys_base + phys_offset;
 	while (mapped_bytes < map_length) {
 		/*
=2D-
2.20.1

